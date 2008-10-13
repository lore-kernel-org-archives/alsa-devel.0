From: "Norbert Piotrowski" <piotrowskinorbert@gmail.com>
Subject: Re: Support for ALC1200
Date: Mon, 13 Oct 2008 17:52:40 +0200
Message-ID: <059c01c92d4b$ba00edf0$bb20147e@polpak.local>
References: <dfeb90390810130539k425caa6ep9cc03d75b49d7433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 363CD24536
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 17:53:02 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so536753ugs.24
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 08:52:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello

I have a bit more information. I've got newer kernel and alsa build from 
last snapshot (10.13.2008), ALC1200 is recognized as ALC888. Still no light 
at spdif output.

Results of alsa-info.sh 
http://www.alsa-project.org/db/?f=caa27b0a7c7a18b1350e96ee8e872dc72b808e0d

[root@nelson ~]# dmesg | grep -i alsa
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2130: 
chipset global capabilities = 0x4401
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:771: 
codec_mask = 0x1
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:3285: 
autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:3289: 
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:3293: 
hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:3294: 
mono: mono_out=0x0
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:3302: 
inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x0, aux=0x0
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Headphone Playback Volume, skipped
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Speaker Playback Volume, skipped
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Mono Playback Volume, skipped
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Line-Out Playback Volume, skipped
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Speaker Playback Switch, skipped
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:1213: 
Cannot find slave Mono Playback Switch, skipped
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1434: 
azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1434: 
azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1434: 
azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA 
/home/norbert/alsa-git/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1434: 
azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:780: 
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x8
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x8
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x2
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x3
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x4
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x5
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x6
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x2
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x3
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x4
ALSA /home/norbert/alsa-git/alsa-driver-unstable/pci/hda/hda_codec.c:792: 
hda_codec_cleanup_stream: NID=0x5


Best regards,
Norbert 
