From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: ASoC: pxa: remove pxa2xx-pcm driver,
	which caused regression
Date: Sat, 18 Aug 2018 21:10:40 +0200
Message-ID: <87mutjbidr.fsf@belgarion.home>
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DEB267692
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2018 21:10:44 +0200 (CEST)
In-Reply-To: <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com> (Petr Cvek's
 message of "Sat, 18 Aug 2018 15:00:29 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: alsa-devel@alsa-project.org, dbaryshkov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, dirk@opfer-online.de, marek.vasut@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Petr Cvek <petrcvekcz@gmail.com> writes:

> My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
> SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
> fixed patch in [1].
Still NAK.

You must realise that as long as you will delete sound/soc/pxa/pxa2xx-pcm.c,
I'll block the patch, as it is being used for music playback on several pxa
platforms, at least the AC97 based ones.

> BTW can you try insmod-aplay-stop-rmmod with the current -next on your
> board?
Insmod/rmmod which module exactly ?
	regmap-ac97.ko
	ac97.ko
	snd-pcm-dmaengine.ko
	snd-pxa2xx-lib.ko
	snd-soc-wm9713.ko
	snd-soc-pxa2xx.ko
	snd-soc-pxa2xx-ac97.ko
	snd-soc-mioa701.ko

> OK I can do that, (I can speak only for I2S and SSP) but if fixed patch
> work it should be fine.
Nope, it still impacts the AC97 based boards.

Cheers.

--
Robert
