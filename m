From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000752]: ALSA > 1.0.5a does not load, failed with error -16
Date: Sun, 20 Mar 2005 19:19:16 +0100
Message-ID: <d354e148d51e3a6b33eb1e609434b2af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AA7CD259
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 19:19:16 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=752> 
======================================================================
Reported By:                Q3Man
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   752
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r9
======================================================================
Date Submitted:             12-28-2004 05:12 CET
Last Modified:              03-20-2005 19:19 CET
======================================================================
Summary:                    ALSA > 1.0.5a does not load, failed with error -16
Description: 
I'm having some problems with alsa since 1.0.6a. Previously I just had the
later versions masked, but now various kde packages require the latest
alsa, so I'm having to tackle it now. ALSA seems to start normally,
however I get this error in dmesg: 
EMU10K1X: probe of 0000:00:09.0 failed with error -16. 

I also get this error when running alsamixer: 
alsamixer: function snd_ctl_open failed for default: No such device 

And similar ones in other alsa programs. 

Again, 1.0.5a runs fine, 1.0.6a and above do not. I've taken a look at the
code and it seems that the error is vaguely interrupt related, but I could
not find the code that produces error -16. I've swapped interrupts around
and disabled non-essential devices (usb, serial, parallel ports, removed
network cards and sound cards - although that last one proved slightly
less than helpful :) I've changed from having my bios manage irq's to
having the OS handle them with zero success. 

I've looked around for that error code in google for the last few weeks -
since the release of 1.0.6a with limited success. Nothing relevant to my
situation. 

Important configs and error messages:
$ lspci -v |grep audio -A4
0000:00:09.0 Multimedia audio controller: Creative Labs [SB Live! Value]
EMU10k1X
        Subsystem: Creative Labs: Unknown device 1003
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d000
        Capabilities: [dc] Power Management version 2
(It is an actual EMU10k1X and not the Dell bastardized version)

$ /etc/init.d/alsasound start; dmesg |tail -n1
 * Loading ALSA drivers...
 * Using ALSA OSS emulation
 * Loading: snd-mixer-oss
 * Loading: snd-pcm-oss
 * Loading: snd-seq-oss
 * Running card-dependent scripts
 * Restoring Mixer Levels                                                
[ ok ]
EMU10K1X: probe of 0000:00:09.0 failed with error -16

$ uname -a
Linux tobin1 2.6.9-gentoo-r9
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Mon Dec 27 16:06:33 PST
2004 i686 AMD
Athlon(tm) XP 2500+ AuthenticAMD GNU/Linux

If anyone needs any other config information, please let me know. Again,
it works perfectly fine in 1.0.5a, the problems only appear in later
versions.

======================================================================

----------------------------------------------------------------------
 fmoraes - 03-20-05 15:26 
----------------------------------------------------------------------
Good, progress. Do you still have those snd_printk's in the code to see
where it is failing/dieing?
-22 should EINVAL, so some argument is invalid... If that added code is
causing the problem, just comment out the third new/add ctl block and see
if the module loads. I took that chunck of code from the ca0106 driver
(_mixer.c), so that's why they weren't found. Here's their definition:

static int remove_ctl(snd_card_t *card, const char *name)
{
	snd_ctl_elem_id_t id;
	memset(&id, 0, sizeof(id));
	strcpy(id.name, name);
	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
	return snd_ctl_remove_id(card, &id);
}

static snd_kcontrol_t *ctl_find(snd_card_t *card, const char *name)
{
	snd_ctl_elem_id_t sid;
	memset(&sid, 0, sizeof(sid));
	/* FIXME: strcpy is bad. */
	strcpy(sid.name, name);
	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
	return snd_ctl_find_id(card, &sid);
}

Keep me updated.

----------------------------------------------------------------------
 Q3Man - 03-20-05 19:19 
----------------------------------------------------------------------
Success!

I commented out the offending code that was causing the error. It compiled
and loaded cleanly without any dmesg errors. Furthermore, it actually
worked! I was able to hear sound.

However, due to the mixer not actually loading properly I noticed some
oddities in alsamixer. All the sliders and mutes appeared to function
properly however the numbers at the bottom of each bar are all stuck at
00. The numbers that indicate the left/right volume (50<>50) below the
bars are accurate and adjust as I'm adjusting the volume. Furthermore, as
I'm playing a test sound adjusting the volume in alsamixer does actually
work.

It's nice to have sound on this pc after a few months :) 

Is there a way to dump the contents of card and kctl before the function
to see if they are getting a strange value from the line above it?:
if ((kctl = snd_ctl_new1(&snd_emu10k1x_spdif_control, emu)) == NULL)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 05:12 Q3Man          New Issue                                    
12-28-04 05:12 Q3Man          File Added: einfo                            
12-28-04 05:12 Q3Man          Distribution              => Gentoo          
12-28-04 05:12 Q3Man          Kernel Version            => 2.6.9-gentoo-r9 
12-28-04 05:22 Q3Man          Issue Monitored: Q3Man                       
01-03-05 12:10 tiwai          Note Added: 0003054                          
01-03-05 12:39 eradicator     Issue Monitored: eradicator                    
01-03-05 17:30 Q3Man          Note Added: 0003071                          
01-16-05 14:54 fmoraes        Note Added: 0003216                          
01-18-05 00:44 Q3Man          Note Added: 0003240                          
01-20-05 02:23 Q3Man          Note Added: 0003322                          
01-20-05 19:12 tiwai          Note Added: 0003332                          
01-21-05 05:11 Q3Man          Note Added: 0003337                          
01-21-05 11:14 tiwai          Note Added: 0003341                          
01-22-05 23:24 fmoraes        Note Added: 0003382                          
03-09-05 02:57 fmoraes        Note Added: 0003821                          
03-15-05 17:34 Q3Man          Note Added: 0003916                          
03-15-05 22:32 Q3Man          Note Added: 0003918                          
03-16-05 02:09 fmoraes        Note Added: 0003927                          
03-16-05 03:32 Q3Man          Note Added: 0003930                          
03-16-05 04:06 fmoraes        Note Added: 0003931                          
03-16-05 04:53 Q3Man          Note Added: 0003932                          
03-16-05 05:19 Q3Man          Note Added: 0003933                          
03-17-05 01:45 fmoraes        Note Added: 0003976                          
03-17-05 03:20 Q3Man          Note Added: 0003977                          
03-18-05 02:07 fmoraes        Note Added: 0003988                          
03-18-05 02:43 Q3Man          Note Added: 0003989                          
03-18-05 03:41 Q3Man          Note Added: 0003990                          
03-18-05 21:17 fmoraes        Note Added: 0004005                          
03-18-05 23:48 Q3Man          Note Added: 0004007                          
03-19-05 21:00 fmoraes        Note Added: 0004069                          
03-20-05 08:00 Q3Man          Note Added: 0004073                          
03-20-05 08:17 Q3Man          Note Added: 0004074                          
03-20-05 15:26 fmoraes        Note Added: 0004091                          
03-20-05 19:19 Q3Man          Note Added: 0004097                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
