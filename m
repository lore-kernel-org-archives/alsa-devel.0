From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: ASoC: pxa: remove pxa2xx-pcm driver,
	which caused regression
Date: Sat, 18 Aug 2018 11:42:45 +0200
Message-ID: <87r2iwau3u.fsf@belgarion.home>
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 053A526779C
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2018 11:42:52 +0200 (CEST)
In-Reply-To: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 (petrcvekcz@gmail.com's message of "Fri, 17 Aug 2018 21:48:11 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: petrcvekcz@gmail.com, daniel@zonque.org
Cc: alsa-devel@alsa-project.org, spyro@f2s.com, dbaryshkov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, dirk@opfer-online.de, marek.vasut@gmail.com, broonie@kernel.org, philipp.zabel@gmail.com, lost.distance@yahoo.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

petrcvekcz@gmail.com writes:

> From: Petr Cvek <petrcvekcz@gmail.com>
>
> The switch of PXA to dmaengine caused a regression for devices which are
> using SSP/I2S and probably AC97. The problem is in multiple allocation
> of DMA by function pxa2xx_soc_pcm_new() called by pxa-pcm-audio and
> (SSP/I2S/AC97). The regression was found on HTC Magician and after playback
> kernel generates an oops:
With AC97, this is still continuously tested and works fine, and the pcm part is
what makes aplay happy for playing music. This is used both in a devicetree and
non devicetree build, which makes me thing the AC97 part is fine, and the
SSP/I2S needs some love.

With your patch, a compilation of mioa701 fails with [1].

Therefore, I'll NAK this patch, as removing SND_PAX2XX_SOC config is a bad idea.

As a way forward, please submit a patch for magician only, which makes it work
again (by work I mean you can play and hear a song with aplay or equivalent).

Then hopefully Daniel can interpolate to all the SSP/I2S platforms. And maybe
Daniel can test on his platform too so that we're safe on both pxa2xx and pxa3xx
side.

Cheers.

--
Robert

[1] Fail message
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_dev_resume':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:275: undefined reference to `pxa2xx_ac97_hw_resume'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_dev_suspend':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:270: undefined reference to `pxa2xx_ac97_hw_suspend'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_dev_remove':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:263: undefined reference to `pxa2xx_ac97_hw_remove'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_read_actrl':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:48: undefined reference to `pxa2xx_ac97_read'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_write_actrl':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:54: undefined reference to `pxa2xx_ac97_write'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_warm_reset':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:33: undefined reference to `pxa2xx_ac97_try_warm_reset'
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:35: undefined reference to `pxa2xx_ac97_finish_reset'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_cold_reset':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:40: undefined reference to `pxa2xx_ac97_try_cold_reset'
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:42: undefined reference to `pxa2xx_ac97_finish_reset'
sound/soc/pxa/pxa2xx-ac97.o: In function `pxa2xx_ac97_dev_probe':
/home/rj/mio_linux/kernel/sound/soc/pxa/pxa2xx-ac97.c:235: undefined reference to `pxa2xx_ac97_hw_probe'
Makefile:1015: recipe for target 'vmlinux' failed
