From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000573]: no SPDIF output with vt82xx/ICEnsemble VT1616i
Date: Tue, 12 Oct 2004 14:31:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012123129.43DFE18009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ACE832A2
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:31:29 +0200 (MEST)
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
Last Modified:              10-12-2004 14:31 CEST
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
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
