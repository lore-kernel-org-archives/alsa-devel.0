From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Wed, 28 Feb 2018 22:02:09 +0100
Message-ID: <2424862.oPtAVTfrB9@jernej-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kuninori.morimoto.gx@renesas.com
Cc: broonie@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

with todays linux-next (next-20180228), kernel on Allwinner H3 SoC crashes 
with dmesg like that: https://pastebin.com/raw/0D5JeaJ8

I bisected the kernel and first offending commit is:
be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: replace platform to 
component")

I know that crash message is completely unrelated to sound subsystem, but it 
turns out that if I disable CONFIG_SND_SUN4I_CODEC kernel works ok, but this 
way I lose analog audio output.

Any suggestions what can be the issue?

Best regards,
Jernej
