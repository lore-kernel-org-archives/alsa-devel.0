From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Wed, 7 Dec 2005 23:10:42 +0100
Message-ID: <4e5e94bcfb0421814fce127133838441@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 546C111B
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 23:10:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              12-07-2005 23:10 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-05 14:59 
----------------------------------------------------------------------
How about the attached additional patch?  Please build with
--with-debug=full configure option for debugging.

----------------------------------------------------------------------
 robertw - 12-07-05 23:10 
----------------------------------------------------------------------
I tried again the cvs-version of ~ 20:00 CET. This time the module behaves
fine. This time two cards showed up, one analog and one digital. Alsamixer
changed a bit:

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Front Left: Playback 64 [100%] [on]
  Front Right: Playback 64 [100%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Front Left: Playback 255 [100%]
  Front Right: Playback 255 [100%]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Front Left: Playback 65 [100%] [on]
  Front Right: Playback 65 [100%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Front Left: Playback 24 [37%] [on]
  Front Right: Playback 24 [37%] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 35 [100%] [on]
  Front Right: Capture 35 [100%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Input Source',0
  Capabilities:
  Mono:
Simple mixer control 'Input Source',1
  Capabilities:
  Mono:

aplay can play a file, but no output. With your second patch applied
against this cvs-version, everything is the same, but aplay couldn't play
anything:

$ aplay test.wav
ALSA lib pcm_dmix.c:802:(snd_pcm_dmix_open) unable to open slave
aplay: main:533: audio open error: Invalid argument

dmesg says:

Dec  7 23:04:23 localhost kernel: [4334412.498000] ALSA
/home/robert/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:3024:
hda_codec: Unknown model for ALC260
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536786703/1069872128] snd_pcm_hw_constraints_complete+0x2af/0x3a0
[snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536787479/1069872128] snd_pcm_open_file+0xd7/0x190 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536788024/1069872128] snd_pcm_open+0xe8/0x160 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[default_wake_function+0/18] default_wake_function+0x0/0x12
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [cdev_get+43/92]
cdev_get+0x2b/0x5c
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536787718/1069872128] snd_pcm_playback_open+0x36/0x40 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536564094/1069872128] snd_open+0x7e/0x1a0 [snd]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536563968/1069872128] snd_open+0x0/0x1a0 [snd]
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [chrdev_open+141/326]
chrdev_open+0x8d/0x146
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [dentry_open+411/511]
dentry_open+0x19b/0x1ff
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [filp_open+92/97]
filp_open+0x5c/0x61
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [get_unused_fd+35/176]
get_unused_fd+0x23/0xb0
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [sys_open+91/255]
sys_open+0x5b/0xff
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75

The first line is also present with the plain cvs-version

You could also contact me more directly: robert@xenim.de (mail & jabber)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
12-06-05 15:52 tiwai          Note Added: 0006925                          
12-06-05 18:10 robertw        Note Added: 0006930                          
12-06-05 20:07 tiwai          Note Added: 0006934                          
12-06-05 20:08 tiwai          File Added: alc-cvs-fix.diff                    
12-06-05 20:09 tiwai          Note Added: 0006935                          
12-06-05 22:51 robertw        Note Added: 0006938                          
12-07-05 14:59 tiwai          Note Added: 0006941                          
12-07-05 15:00 tiwai          File Added: alc-cvs-fix2.diff                    
12-07-05 23:10 robertw        Note Added: 0006952                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
