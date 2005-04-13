From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000961]: No hardware mixing on SBLive 5.1 which supported OSS hardware mixing under previous OS
Date: Wed, 13 Apr 2005 22:03:21 +0200
Message-ID: <2880ff1cd7efba0f0cc411613d525c70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3B5E523B
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 22:03:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=961> 
======================================================================
Reported By:                redemption042
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   961
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 4.10
Kernel Version:             2.6.7
======================================================================
Date Submitted:             03-04-2005 01:33 CET
Last Modified:              04-13-2005 22:03 CEST
======================================================================
Summary:                    No hardware mixing on SBLive 5.1 which supported OSS
hardware mixing under previous OS
Description: 
Previously, I was running knoppix 3.1 with a 2.4 family kernel, I believe. 
Under this distro, hardware mixing on my soundcard was supported with
multiple applications being able to grab /dev/dsp (TeamSpeak and
Enemy-Territory, for example)

When I loaded up Ubuntu 4.10, I lost the hardware mixing capabilities  of
my sound card.   I have tried loading the latest version of the driver
(1.0.8) which, while providing sound, does not seem to allow hardware
mixing.

my /proc/asound/pcm:
00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
00-01: emu10k1 mic : EMU10K1 MIC : capture 1
00-02: emu10k1 efx : EMU10K1 EFX : playback 8 : capture 1

output of lsmod:

Module                  Size  Used by
usblp                  15360  0
udf                    94724  0
binfmt_misc            12424  1
md5                     7808  1
ipv6                  262880  6
af_packet              22152  2
joydev                 11968  0
usbhid                 34240  0
snd_emu10k1           108712  6
snd_rawmidi            28480  1 snd_emu10k1
snd_seq_device         12428  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         80376  1 snd_emu10k1
snd_pcm_oss            57768  0
snd_mixer_oss          24064  3 snd_pcm_oss
snd_pcm                94624  4 snd_emu10k1,snd_ac97_codec,snd_pcm_oss
snd_timer              29956  2 snd_emu10k1,snd_pcm
snd_page_alloc         13576  2 snd_emu10k1,snd_pcm
snd_util_mem            7936  1 snd_emu10k1
snd_hwdep              13984  1 snd_emu10k1
snd                    57828  18
snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_util_mem,snd_hwdep
soundcore              11872  3 snd
usb_storage            68928  0
ehci_hcd               33028  0
ohci_hcd               23428  0
usbcore               105824  7
usblp,usbhid,usb_storage,ehci_hcd,ohci_hcd
nvidia_agp             10012  1
agpgart                32172  2 nvidia_agp
evdev                  11520  0
nls_iso8859_1           7936  1
nls_cp437               9600  1
nvidia               4826100  12
ide_generic             5248  0
ide_cd                 43524  0
cdrom                  41248  1 ide_cd

/proc/asound/cards:
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.7, serial:0x80611102) at
0xc000, irq 17

/proc/asound/devices:
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer



======================================================================

----------------------------------------------------------------------
 jdthood - 04-13-05 21:48 
----------------------------------------------------------------------
> Previously, I was running knoppix 3.1 with a 2.4 family kernel,
> I believe. Under this distro, hardware mixing on my soundcard was
> supported with multiple applications being able to grab /dev/dsp
> (TeamSpeak and Enemy-Territory, for example)


Were you using the OSS or the ALSA sound system under that old OS and
kernel?

----------------------------------------------------------------------
 redemption042 - 04-13-05 22:03 
----------------------------------------------------------------------
I was using OSS.  :-) I figured that about a month ago and switched to the
OSS driver and completely forgot I posted this here.  When I tried to run
ET or TS through OSS emulation with ALSA they'd either segfault or freeze.
 I figured it was just less of a problem to switch to OSS.

A further addendum to the above stuff would be that hardware mixing WAS
working for most apps.  Just apps that tried to grab the /dev/dsp device
had problems.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 01:33 redemption042  New Issue                                    
03-04-05 01:33 redemption042  Distribution              => Ubuntu 4.10     
03-04-05 01:33 redemption042  Kernel Version            => 2.6.7           
03-04-05 01:43 redemption042  Note Added: 0003793                          
04-13-05 21:48 jdthood        Note Added: 0004476                          
04-13-05 22:03 redemption042  Note Added: 0004481                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
