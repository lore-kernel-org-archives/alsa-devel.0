From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Re: My PC has 6GB memory but the limitation of the
 alsa-driver is 4GB.
Date: Tue, 17 Mar 2009 01:56:26 +0900
Message-ID: <1237222586.30978.5.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
	<1237093356.3501.45.camel@localhost.localdomain>
	<s5hocw2rl9y.wl%tiwai@suse.de>
	<1237197183.3501.64.camel@localhost.localdomain>
	<s5hocw1rdoq.wl%tiwai@suse.de>
	<1237209483.13649.3.camel@localhost.localdomain>
	<s5hiqm9r44x.wl%tiwai@suse.de>
	<1237216549.29020.13.camel@localhost.localdomain>
	<s5h3addqy4b.wl%tiwai@suse.de>  <s5hzlflpje2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iebAiP/FpClhPRMFnGQe"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C87A71037E3
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 17:56:32 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so1020920tia.8
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 09:56:30 -0700 (PDT)
In-Reply-To: <s5hzlflpje2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-iebAiP/FpClhPRMFnGQe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Failed to listen by your 2nd patch.(I couldn't succeed by patch -p2 <
YourPatch again. So I modified by hand, again.) And soon later, I'll
test the Daniel Koukola's change(What you call "your original change").
Picked from /var/log/messages

Mar 17 01:44:25 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A -> GSI
16 (level, low) -> IRQ 16
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2228: chipset global capabilities = 0x4401
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:786: codec_mask = 0x8
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1214: hda_intel: codec #3 probed OK
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:2962: hda_codec: model '6stack-dig' is selected for config 1458:a002 (Gigabyte P35 DS3R)
Mar 17 01:44:25 star1 kernel: input: HDA Digital PCBeep
as /devices/pci0000:00/0000:00:14.2/input/input11
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Headphone Playback Volume, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Volume, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Volume, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Line-Out Playback Volume, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave PCM Playback Volume, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Switch, skipped
Mar 17 01:44:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Switch, skipped
Mar 17 01:44:31 star1 acpid: client connected from 29185[0:0]
Mar 17 01:44:44 star1 pulseaudio[30244]: pid.c: Stale PID file,
overwriting.
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:44 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 01:44:45 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:44:45 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 01:44:45 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:44:45 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 01:44:45 star1 pulseaudio[30272]: main.c: Called SUID root and
real-time and/or high-priority scheduling was requested in the
configuration. However, we lack the necessary privileges:
Mar 17 01:44:45 star1 pulseaudio[30272]: main.c: We are not in group
'pulse-rt', PolicyKit refuse to grant us the requested privileges and we
have no increase RLIMIT_NICE/RLIMIT_RTPRIO resource limits.
Mar 17 01:44:45 star1 pulseaudio[30272]: main.c: For enabling
real-time/high-priority scheduling please acquire the appropriate
PolicyKit privileges, or become a member of 'pulse-rt', or increase the
RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Mar 17 01:44:45 star1 pulseaudio[30276]: pid.c: Daemon already running.
Mar 17 01:44:45 star1 kernel: hda-intel: Invalid position buffer, using
LPIB read method instead.
Mar 17 01:44:50 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 01:44:50 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 01:44:54 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 01:44:59 star1 scim-bridge: Cleanup, done. Exitting...
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 01:46:58 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x6, channel=0, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x6, channel=0, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x6, channel=0, format=0x4031
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:47:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:47:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x5000, format=0x4011
Mar 17 01:47:25 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x6, channel=0, format=0x4011
Mar 17 01:47:27 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:47:27 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0xc000, format=0x11
Mar 17 01:47:27 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x6, channel=0, format=0x11
Mar 17 01:47:27 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 01:47:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver-090317/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6


--=-iebAiP/FpClhPRMFnGQe
Content-Disposition: attachment; filename="alsa-driver-090317-info.txt"
Content-Type: text/plain; name="alsa-driver-090317-info.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Mon Mar 16 16:46:48 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.19-170.2.35.fc10.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe024000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1458:a002


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC889A
Address: 3
Vendor Id: 0x10ec0885
Subsystem Id: 0x1458a002
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x1c 0x1c]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x17 0x17] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x2c 0x2c]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01014410: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01011412: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x01016411: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x01012414: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19c40: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19c50: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181344f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02214c20: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4005e601: [N/A] Line Out at Ext N/A
    Conn = Optical, Color = White
    DefAssociation = 0x0, Sequence = 0x1
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014b6130: [Jack] SPDIF Out at Ext Rear
    Conn = Comb, Color = Orange
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x00000020: IN
  Pin Default 0x01cb7160: [Jack] SPDIF In at Ext Rear
    Conn = Comb, Color = Yellow
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=17
  Processing Coefficient: 0xc128
  Coefficient Index: 0x02
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
  Volume-Knob: delta=0, steps=32, direct=0, val=0
  Unsolicited: tag=00, enabled=0
  Connection: 0
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x25 0x0b
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root root 116,  0 Mar 17 01:44 /dev/snd/controlC0
crw-rw----+ 1 root root 116,  7 Mar 17 01:44 /dev/snd/hwC0D3
crw-rw----+ 1 root root 116, 24 Mar 17 01:44 /dev/snd/pcmC0D0c
crw-rw----+ 1 root root 116, 16 Mar 17 01:44 /dev/snd/pcmC0D0p
crw-rw----+ 1 root root 116, 25 Mar 17 01:44 /dev/snd/pcmC0D1c
crw-rw----+ 1 root root 116, 17 Mar 17 01:44 /dev/snd/pcmC0D1p
crw-rw----+ 1 root root 116, 26 Mar 17 01:44 /dev/snd/pcmC0D2c
crw-rw----+ 1 root root 116,  1 Mar 17 01:44 /dev/snd/seq
crw-rw----+ 1 root root 116, 33 Mar 17 01:44 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC885 Analog [ALC885 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC885 Digital [ALC885 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC885 Analog [ALC885 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC885 Digital [ALC885 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: ALC885 Analog [ALC885 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xfe024000 irq 16'
  Mixer name	: 'Realtek ALC889A'
  Components	: 'HDA:10ec0885,1458a002,00100101'
  Controls      : 43
  Simple ctrls  : 24
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 44 [69%] [-20.00dB] [on]
  Front Right: Playback 44 [69%] [-20.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [off]
  Front Right: Playback 23 [74%] [0.00dB] [off]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [-64.00dB] [off]
  Front Right: Playback 0 [0%] [-64.00dB] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [-64.00dB] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [-64.00dB] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [-64.00dB] [off]
  Front Right: Playback 0 [0%] [-64.00dB] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [off]
  Front Right: Playback 23 [74%] [0.00dB] [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [on]
  Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [off]
  Front Right: Playback 23 [74%] [0.00dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 28 [61%] [12.00dB] [on]
  Front Right: Capture 28 [61%] [12.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [off]
  Front Right: Playback 23 [74%] [0.00dB] [off]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '6ch' '8ch'
  Item0: '6ch'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'


!!Alsactl output
!!-------------

--startcollapse--
state.SB {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 44
		value.1 44
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 0
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 0
		value.1 0
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'CD Playback Volume'
		value.0 23
		value.1 23
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 23
		value.1 23
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 23
		value.1 23
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 23
		value.1 23
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Front Mic Boost'
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '6ch'
		comment.item.1 '8ch'
		iface MIXER
		name 'Channel Mode'
		value '6ch'
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 2
		value.0 false
		value.1 false
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 46'
		comment.dbmin -1600
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 28
		value.1 28
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 46'
		comment.dbmin -1600
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 46'
		comment.dbmin -1600
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 2
		value.0 0
		value.1 0
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.31 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		index 2
		value Mic
	}
	control.32 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.38 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.39 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Beep Playback Volume'
		value.0 23
		value.1 23
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
	}
	control.41 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 64
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.43 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_codec_realtek
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ext2
fuse
nfs
lockd
nfs_acl
bridge
stp
bnep
sco
l2cap
bluetooth
sunrpc
ipv6
cpufreq_ondemand
powernow_k8
freq_table
reiserfs
dm_multipath
uinput
ata_generic
pata_acpi
usb_storage
ppdev
firewire_ohci
pata_atiixp
i2c_piix4
k8temp
firewire_core
parport_pc
parport
pcspkr
floppy
r8169
i2c_core
crc_itu_t
hwmon
mii


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D3/init_pin_configs:
0x14 0x01014410
0x15 0x01011412
0x16 0x01016411
0x17 0x01012414
0x18 0x01a19c40
0x19 0x02a19c50
0x1a 0x0181344f
0x1b 0x02214c20
0x1c 0x593301f0
0x1d 0x4005e601
0x1e 0x014b6130
0x1f 0x01cb7160

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:



--=-iebAiP/FpClhPRMFnGQe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-iebAiP/FpClhPRMFnGQe--
