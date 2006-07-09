From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001714]: Intel HDA (AD1986A) no sound
Date: Sun, 9 Jul 2006 12:19:59 +0200
Message-ID: <41df087c37048d81f698359cd8335784@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAB6C26E
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 12:19:59 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UNset as DUPLICATE OF issue 0001841.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1714> 
======================================================================
Reported By:                kratz00
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1714
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               LFS
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-04-2006 18:04 CET
Last Modified:              07-09-2006 12:19 CEST
======================================================================
Summary:                    Intel HDA (AD1986A) no sound
Description: 
It's a Samsung M50 Notebook.
I also tried Alsa 1.0.10 but the problem is the same.
There are no specific module options for the AD1986A chip, right?

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Unknown device c01e
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

loaded modules:
snd_pcm_oss            47136  0 
snd_mixer_oss          16512  1 snd_pcm_oss
snd_hda_intel          14224  0 
snd_hda_codec         122624  1 snd_hda_intel
snd_pcm                75912  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              19844  1 snd_pcm
snd                    46144  6
snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          8328  2 snd_hda_intel,snd_pcm

======================================================================

----------------------------------------------------------------------
 kratz00 - 01-30-06 13:40 
----------------------------------------------------------------------
tried alsa-driver-1.0.11rc3 and still no luck :/

----------------------------------------------------------------------
 tiwai - 03-10-06 18:26 
----------------------------------------------------------------------
The patch is in #1841.

----------------------------------------------------------------------
 kratz00 - 03-15-06 21:49 
----------------------------------------------------------------------
sorry that i have to reopen this bug again

if I use your attached patch from #1841 line out works but after you
checked it in and changed something in current cvs it dosen't work anymore
:(

----------------------------------------------------------------------
 tiwai - 03-23-06 17:45 
----------------------------------------------------------------------
Could you try 1.0.11rc4?

----------------------------------------------------------------------
 kratz00 - 03-25-06 15:31 
----------------------------------------------------------------------
i did, still the same :(

i will attach asound.state

----------------------------------------------------------------------
 tiwai - 03-26-06 01:39 
----------------------------------------------------------------------
Try "model=laptop" module optoin.  It should work.

Show the output of "lspci -nv" for class 0403 device.

----------------------------------------------------------------------
 kratz00 - 03-26-06 12:11 
----------------------------------------------------------------------
tried model=laptop but still the same

00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 144d:c01e
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 kratz00 - 04-15-06 14:43 
----------------------------------------------------------------------
still existent for rc5

----------------------------------------------------------------------
 tiwai - 04-20-06 14:48 
----------------------------------------------------------------------
How about model=laptop-eapd ?

----------------------------------------------------------------------
 kratz00 - 04-20-06 23:14 
----------------------------------------------------------------------
upgraded to 1.0.11

still the same problem with model=laptop
then i tried model=laptop-eapd and i got sound from the speakers and from
the headphone but not i don't have a mixer setting for line in anymore

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 18:04 kratz00        New Issue                                    
01-04-06 18:04 kratz00        Distribution              => LFS             
01-04-06 18:04 kratz00        Kernel Version            => 2.6.15          
01-30-06 13:40 kratz00        Note Added: 0007837                          
02-07-06 00:48 gerick         Issue Monitored: gerick                      
02-08-06 13:13 simonckenyon   Issue Monitored: simonckenyon                    
03-10-06 18:26 tiwai          Relationship added       duplicate of 0001841
03-10-06 18:26 tiwai          Duplicate ID             0 => 1841           
03-10-06 18:26 tiwai          Status                   new => resolved     
03-10-06 18:26 tiwai          Resolution               open => duplicate   
03-10-06 18:26 tiwai          Assigned To               => tiwai           
03-10-06 18:26 tiwai          Note Added: 0008408                          
03-15-06 21:49 kratz00        Status                   resolved => feedback
03-15-06 21:49 kratz00        Resolution               duplicate => reopened
03-15-06 21:49 kratz00        Note Added: 0008574                          
03-23-06 17:45 tiwai          Note Added: 0008896                          
03-25-06 15:31 kratz00        Note Added: 0008948                          
03-25-06 15:31 kratz00        File Added: asound.state                     
03-26-06 01:39 tiwai          Note Added: 0008959                          
03-26-06 12:11 kratz00        Note Added: 0008969                          
04-15-06 14:43 kratz00        Note Added: 0009296                          
04-20-06 14:48 tiwai          Note Added: 0009378                          
04-20-06 23:14 kratz00        Note Added: 0009401                          
06-08-06 02:49 rbenech        Issue Monitored: rbenech                     
07-09-06 12:19 Adrian Bunk    Status                   feedback => assigned
07-09-06 12:19 Adrian Bunk    Category                 1_OTHERS => PCI -
hda-intel
07-09-06 12:19 Adrian Bunk    Relationship deleted     duplicate of 0001841
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
