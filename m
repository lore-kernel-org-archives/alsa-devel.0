From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: Remove __devinit annotation
	for	pxa2xx_ac97_hw_probe to fix section mismatch warning
Date: Sun, 19 Feb 2012 18:20:08 +0000
Message-ID: <20120219182005.GA16078@opensource.wolfsonmicro.com>
References: <1329637158.4818.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E87A6103C17
	for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2012 19:20:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1329637158.4818.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 19, 2012 at 03:39:18PM +0800, Axel Lin wrote:
> This fixes below build warning:
> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
> The function pxa2xx_ac97_probe() references
> the function __devinit pxa2xx_ac97_hw_probe().
> This is often because pxa2xx_ac97_probe lacks a __devinit
> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

This seems like the wrong fix - shouldn't we be adding annotations
rather than removing them here?
