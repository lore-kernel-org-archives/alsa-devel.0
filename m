From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: Remove __devinit annotation for
 pxa2xx_ac97_hw_probe to fix section mismatch warning
Date: Mon, 20 Feb 2012 08:03:13 +0800
Message-ID: <CAF+7xWkEb1UYFF79gnft9tCX1=9fHLpVGvieg5L4qAEytdQBeQ@mail.gmail.com>
References: <1329637158.4818.4.camel@phoenix>
	<20120219182005.GA16078@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6636D24647
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 01:03:35 +0100 (CET)
Received: by obbup6 with SMTP id up6so6493389obb.38
	for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2012 16:03:34 -0800 (PST)
In-Reply-To: <20120219182005.GA16078@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2012/2/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Feb 19, 2012 at 03:39:18PM +0800, Axel Lin wrote:
>> This fixes below build warning:
>> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
>> The function pxa2xx_ac97_probe() references
>> the function __devinit pxa2xx_ac97_hw_probe().
>> This is often because pxa2xx_ac97_probe lacks a __devinit
>> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.
>
> This seems like the wrong fix - shouldn't we be adding annotations
> rather than removing them here?
I'll send a new patch to fix it. Thanks.
The change now is in sound/soc/pxa/pxa2xx-ac97.c, so I change the subject to:
[PATCH] ASoC: Add __devinit annotation for pxa2xx_ac97_probe

Axel
