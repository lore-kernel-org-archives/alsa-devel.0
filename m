From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000573]: no SPDIF output with vt82xx/ICEnsemble VT1616i
Date: Tue, 12 Oct 2004 19:44:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012174411.A4F7B18009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E5B72E4
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 19:44:11 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000573
======================================================================
Reported By:                vladimir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     573
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3 test 2
Kernel Version:             2.6.8-1.541, as shipped with FC3t2
======================================================================
Date Submitted:             10-09-2004 00:59 CEST
Last Modified:              10-12-2004 19:44 CEST
======================================================================
Summary:                    no SPDIF output with vt82xx/ICEnsemble VT1616i
Description: 
With alsa 1.0.6 (in kernel), 1.0.7rc1, or CVS, I'm unable to reliably get
SPDIF output to work -- it might work once out of a dozen or so times. 
The attached patch improves things -- ignoring the cached values in
ac97_read_cache gives me working spdif playbac.  The values I see printed
with the printk added in ac97_read_cache by the patch are:

AC97_read_cache: register 0x002a has real value 0x01f1 cached 0x05f1 
AC97_read_cache: register 0x002a has real value 0x05f1 cached 0x01f1 

which indicates a change in the read-only SPCV bit.  Perhaps registers
with read-only status bits shouldn't be cached?  I'm not sure if that's
the fix, or if there's a deeper issue here.

======================================================================

----------------------------------------------------------------------
 vladimir - 10-11-2004 08:21 CEST 
----------------------------------------------------------------------
Note, even with the patch applied, I've had the audio cut out on occasion
(spdif only, analog always continues to work); sometimes mid stream, but
mostly at the end of a song with no sound for the beginning of the next --
this is using mplayer in shuffle mode.  Flipping through songs with
next/previous a few times usually restores audio.  I'm not sure if this
cutting out is a further driver issue, or a faulty hardware issue.

----------------------------------------------------------------------
 tiwai - 10-11-2004 12:54 CEST 
----------------------------------------------------------------------
Above all, we need to check _who_ modifies SPCV bit.  I don't see any
codes to change SPCV in ac97 related stuff...

----------------------------------------------------------------------
 vladimir - 10-11-2004 19:46 CEST 
----------------------------------------------------------------------
It shouldn't get modified; it's a read-only status bit.  More curious is
that there is no code that actually looks at the SPCV bit at all, except
for something in patch_cm9739..  I'm not yet willing to rule out faulty
hardware, though; I've been trying to find a kernel/alsa combo that does
confirmed working spdif out with someone else's me6000 to test.

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:31 CEST 
----------------------------------------------------------------------
Yes, that's why I wrote in the above.  As far as I understand from
your bug report, the SPCV bit of the cache value is changed.  That is,
some code really writes this bit.

Could you try the attached patch?
This will show the code address of the caller which changes SPCV.
You can know the caller by comparing it with /proc/kallsyms.

----------------------------------------------------------------------
 vladimir - 10-12-2004 19:44 CEST 
----------------------------------------------------------------------
I don't seem to have /proc/kallsyms (red hat seems to have disabled it?!). 
However, this is the output that I get:

ac97: SPCV changed: 05c1 -> 0181: called from ce8e07a2
AC97_read_cache: register 0x002a has real value 0x01c5 cached 0x05c5

Comparing that address with the base address in /proc/modules, I get an
offset of 0x37a2 inside snd_ac97_codec -- the disassembly here looks
like:

        /* make sure the proper powerdown bits are cleared */
        if (ac97->scaps) {
    3763:       8b 44 24 34             mov    0x34(%esp),%eax
    3767:       83 78 70 00             cmpl   $0x0,0x70(%eax)
    376b:       74 35                   je     37a2
<snd_ac97_mixer+0x912>
                reg = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
    376d:       ba 2a 00 00 00          mov    $0x2a,%edx
    3772:       e8 fc ff ff ff          call   3773
<snd_ac97_mixer+0x8e3>
                if (ac97->scaps & AC97_SCAP_SURROUND_DAC) 
    3777:       8b 4c 24 34             mov    0x34(%esp),%ecx
    377b:       8b 51 70                mov    0x70(%ecx),%edx
    377e:       0f b7 c0                movzwl %ax,%eax
    3781:       f6 c2 04                test   $0x4,%dl
    3784:       74 03                   je     3789
<snd_ac97_mixer+0x8f9>
                        reg &= ~AC97_EA_PRJ;
    3786:       80 e4 ef                and    $0xef,%ah
                if (ac97->scaps & AC97_SCAP_CENTER_LFE_DAC) 
    3789:       80 e2 08                and    $0x8,%dl
    378c:       74 03                   je     3791
<snd_ac97_mixer+0x901>
                        reg &= ~(AC97_EA_PRI | AC97_EA_PRK);
    378e:       80 e4 d7                and    $0xd7,%ah
                snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, reg);
    3791:       0f b7 c8                movzwl %ax,%ecx
    3794:       ba 2a 00 00 00          mov    $0x2a,%edx
    3799:       8b 44 24 34             mov    0x34(%esp),%eax
    379d:       e8 fc ff ff ff          call   379e
<snd_ac97_mixer+0x90e>
        }
        snd_ac97_proc_init(ac97);
    37a2:       8b 44 24 34             mov    0x34(%esp),%eax
    37a6:       e8 fc ff ff ff          call   37a7
<snd_ac97_mixer+0x917>
        if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ac97, &ops)) <
0) {
    37ab:       68 3c 01 00 00          push   $0x13c
    37b0:       8b 4c 24 38             mov    0x38(%esp),%ecx
    37b4:       8b 44 24 34             mov    0x34(%esp),%eax
    37b8:       ba 00 20 00 00          mov    $0x2000,%edx
    37bd:       e8 fc ff ff ff          call   37be
<snd_ac97_mixer+0x92e>
    37c2:       5d                      pop    %ebp
    37c3:       89 c3                   mov    %eax,%ebx
    37c5:       85 c0                   test   %eax,%eax
    37c7:       79 0d                   jns    37d6
<snd_ac97_mixer+0x946>
                snd_ac97_free(ac97);

This looks ok; ac97->regs[AC97_EXTENDED_STATUS] contains junk before this
(the 0x181 value), and the correct value is written into the cache.  (The
order of numbers in your printk had me confused for a bit, I thought it
was transitioning from 0x5c1 to 0x0181 :)  The correct value ends up in
both the cache and the register at this point (confirmed via a _read after
the _write_cache, it's 0x05c1).

Other than that, the value doesn't seem to get changed directly; the
hardware just updates that bit based on the other SPDIF configuration
settings... but even then, I don't understand why having the incorrect
SPCV value in the cached reg value is bad, since nothing seems to look at
it; unless the hardware cares if it actually got read?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 00:59 vladimir       New Bug                                      
10-09-04 00:59 vladimir       File Added: ac97_codec-no-readcache.patch                    
10-09-04 00:59 vladimir       Distribution              => Fedora Core 3 test 2
10-09-04 00:59 vladimir       Kernel Version            => 2.6.8-1.541, as shipped with FC3t2
10-11-04 08:21 vladimir       Bugnote Added: 0002070                       
10-11-04 12:54 tiwai          Bugnote Added: 0002076                       
10-11-04 19:46 vladimir       Bugnote Added: 0002083                       
10-12-04 14:31 tiwai          Bugnote Added: 0002092                       
10-12-04 14:31 tiwai          File Added: ac97-spcv-debug.diff                    
10-12-04 19:44 vladimir       Bugnote Added: 0002107                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
