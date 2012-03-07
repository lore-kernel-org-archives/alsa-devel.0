From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Regression] Loss of OPL3 FM Synth in
	alsa-driver-1.0.25
Date: Wed, 7 Mar 2012 08:23:21 +0800
Message-ID: <CAN8cciYOZ5VL9v-j_vCV9xHA3craiCPryS8J6TNN1Xh7A0E3=g@mail.gmail.com>
References: <CAN8cciazpgRcUVp2W9C9KYBY13CW4ZpyMmQdWiHEqQJ1Pd8PPw@mail.gmail.com>
	<s5hlineoy8s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 77665103CEF
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 01:23:23 +0100 (CET)
Received: by wiax18 with SMTP id x18so2698890wia.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 16:23:21 -0800 (PST)
In-Reply-To: <s5hlineoy8s.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

2012/3/6, Takashi Iwai <tiwai@suse.de>:
> At Sun, 4 Mar 2012 10:47:29 +0800,
> Raymond Yau wrote:
>>
>> alsa-tools/seq/sbiload still work but Loss of OPL3 FM synth for
>> ymf724f in alsa-driver-1.0.25
>>
>> The OPL3 FM Synth works In alsa-driver-1.0.24
>
> Fixed now in alsa-driver-build.git tree.
>

The commit  	74f464d2f9f0a5ee6567d1f276c5de4087279e0e

Resolve the dependency more recursively in mod-deps

fix the build of snd-seq-midi.ko and snd-opl3-synth.ko

It work when alsa-driver  is configured with oss kernel emulation

./configure --with-sequencer=yes --with-oss=yes

and fail when alsa-driver is configured without oss

./configure --with-sequencer=yes --with-oss=no


aplaymidi -l
ALSA lib seq_hw.c:457:(snd_seq_hw_open) open /dev/snd/seq failed: No
such file or directory
Cannot open sequencer - No such file or directory


does it mean that 03cfe6f57dc5c13ccdd235c23c80e3fa170f03d1

ALSA: support module on-demand loading for seq and timer

require systemd to load the sequencer

As CONFIG_SND_DYNAMIC_MINORS is used on Kernel 2.6.27 but there is no systemd
