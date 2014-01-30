From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 14:48:07 +0100
Message-ID: <20140130144807.5b102b28@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id EFD23265378
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:48:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Brian, Liam, Mark,

I am currently bringing up audio support on the Marvell Armada 370 ARM
SoC, for which the development board uses the CS42L51 audio codec.

It turns out that the commit 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40
("ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV") causes
a problem here, and reverting this commit gets things back to normal.

Basically, when this commit is applied, the "PCM", "Analog" and "ADC
Mixer" volume controls in alsamixer cannot be changed to any other
value than 60 or 61. The volume control doesn't allow to go above 61
and below 60. If I remember correctly, at the codec level, the values
configured for PCM in registers 0x10 and 0x11 are either 0x0 or 0x1
depending on whether you select 60 or 61 in alsamixer.

Reverting the commit mentioned above makes alsamixer behave normally:
the volume can be adjusted between 0 and 100 as expected, the values in
register 0x10 and 0x11 are meaningful, and the behavior is as expected:
with a volume to 0, I hear nothing in my headphones, with a volume set
to 100, the volume is maximum, with a nice progressive volume increase
in-between.

Therefore, I believe that the commit has a problem. I haven't yet
investigated where the problem is, maybe just the values passed to
SOC_DOUBLE_R_SX_TLV(), or maybe in the implementation of the volume
control functions themselves. I can certainly start investigating, but
maybe the author of the commit will immediately realize where the
problem could be.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
