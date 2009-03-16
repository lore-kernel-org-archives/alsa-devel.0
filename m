From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Re: My PC has 6GB memory but the limitation of the
 alsa-driver is 4GB.
Date: Tue, 17 Mar 2009 00:15:49 +0900
Message-ID: <1237216549.29020.13.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
	<1237093356.3501.45.camel@localhost.localdomain>
	<s5hocw2rl9y.wl%tiwai@suse.de>
	<1237197183.3501.64.camel@localhost.localdomain>
	<s5hocw1rdoq.wl%tiwai@suse.de>
	<1237209483.13649.3.camel@localhost.localdomain>
	<s5hiqm9r44x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DB71103853
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:15:53 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so1001121tia.8
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 08:15:51 -0700 (PDT)
In-Reply-To: <s5hiqm9r44x.wl%tiwai@suse.de>
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

When I did
tar xvf Softwares/alsa-driver-snapshot.tar.gz
cd alsa-driver

I couldn't patch again... I modified my hands, though. I tried the
modification. I couldn't listen any sounds.
--(About patch problem)
[emmanuel@star1 alsa-driver]$ patch -p1 <
patch-Takashi_Iwai_0903162.diff
patching file sound/pci/hda/hda_intel.c
Hunk #1 FAILED at 2136.
Hunk #2 FAILED at 2218.
Hunk #3 FAILED at 2323.
3 out of 3 hunks FAILED -- saving rejects to file
sound/pci/hda/hda_intel.c.rej
-- The soundcard is detected on alsa but it doesn't output sound.
[root@star1 ~]# cat /proc/asound/cards
0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe024000 irq 16
--
-- About the test /var/log/messages
[root@star1 ~]# ls /proc/asound/card0/
codec#3  id  oss_mixer  pcm0c  pcm0p  pcm1c  pcm1p  pcm2c
[root@star1 ~]# grep 'Mar 17 00:0' /var/log/messages
Mar 17 00:00:02 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A disabled
Mar 17 00:01:13 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A -> GSI
16 (level, low) -> IRQ 16
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2228: chipset global capabilities = 0x4401
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:786: codec_mask = 0x8
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1214: hda_intel: codec #3 probed OK
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:2962: hda_codec: model '6stack-dig' is selected for config 1458:a002 (Gigabyte P35 DS3R)
Mar 17 00:01:13 star1 kernel: input: HDA Digital PCBeep
as /devices/pci0000:00/0000:00:14.2/input/input8
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Headphone Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Line-Out Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave PCM Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Switch, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Switch, skipped
Mar 17 00:02:04 star1 acpid: client connected from 27093[0:0]
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: Called SUID root and
real-time and/or high-priority scheduling was requested in the
configuration. However, we lack the necessary privileges:
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: We are not in group
'pulse-rt', PolicyKit refuse to grant us the requested privileges and we
have no increase RLIMIT_NICE/RLIMIT_RTPRIO resource limits.
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: For enabling
real-time/high-priority scheduling please acquire the appropriate
PolicyKit privileges, or become a member of 'pulse-rt', or increase the
RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Mar 17 00:02:14 star1 kernel: hda-intel: Invalid position buffer, using
LPIB read method instead.
Mar 17 00:02:14 star1 pulseaudio[28931]: pid.c: Daemon already running.
Mar 17 00:02:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 00:02:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x5000, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0xc000, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
[root@star1 ~]# grep 'Mar 17 00:0' /var/log/messages
Mar 17 00:00:02 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A disabled
Mar 17 00:01:13 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A -> GSI
16 (level, low) -> IRQ 16
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2228: chipset global capabilities = 0x4401
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:786: codec_mask = 0x8
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1214: hda_intel: codec #3 probed OK
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:2962: hda_codec: model '6stack-dig' is selected for config 1458:a002 (Gigabyte P35 DS3R)
Mar 17 00:01:13 star1 kernel: input: HDA Digital PCBeep
as /devices/pci0000:00/0000:00:14.2/input/input8
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Headphone Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Line-Out Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave PCM Playback Volume, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Speaker Playback Switch, skipped
Mar 17 00:01:13 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1569: Cannot find slave Mono Playback Switch, skipped
Mar 17 00:02:04 star1 acpid: client connected from 27093[0:0]
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x7, stream=0x1, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: Called SUID root and
real-time and/or high-priority scheduling was requested in the
configuration. However, we lack the necessary privileges:
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: We are not in group
'pulse-rt', PolicyKit refuse to grant us the requested privileges and we
have no increase RLIMIT_NICE/RLIMIT_RTPRIO resource limits.
Mar 17 00:02:14 star1 pulseaudio[28904]: main.c: For enabling
real-time/high-priority scheduling please acquire the appropriate
PolicyKit privileges, or become a member of 'pulse-rt', or increase the
RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Mar 17 00:02:14 star1 kernel: hda-intel: Invalid position buffer, using
LPIB read method instead.
Mar 17 00:02:14 star1 pulseaudio[28931]: pid.c: Daemon already running.
Mar 17 00:02:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 00:02:19 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x7
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:24 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:29 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:35 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x10000, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4031
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:36 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0x5000, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:38 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1473: azx_pcm_prepare: bufsize=0xc000, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1027: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x2
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x3
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x4
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x5
Mar 17 00:02:39 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:1040: hda_codec_cleanup_stream: NID=0x6

--


2009-03-16 (Mon) 14:25 +0100 Takashi Iwai wrote: 
> At Mon, 16 Mar 2009 22:18:03 +0900,
> Emmanuel Chanel wrote:
> > 
> > ok. I could patch.
> > I did 
> > $ ./configure --with-debug=verbose
> > $ make
> > $ su -c 'make install'
> > 
> > The result is below and it's not detected on alsa. Pulse's Volume
> > Control says no hardware devices but "Null Sound Output".
> 
> Hm, how about the patch below then?
> 
> 
> thanks,
> 
> Takashi
-- 
Emmanuel Chanel <emmanuelchanel@gmail.com>
