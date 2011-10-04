From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Fix the no period wakeup
	implementation
Date: Tue, 04 Oct 2011 12:02:37 +0300
Message-ID: <5403460.zsrECprFQF@barack>
References: <1317715792-30279-1-git-send-email-peter.ujfalusi@ti.com>
	<4E8AC514.1030002@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id A93E52458D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 11:02:20 +0200 (CEST)
Received: by bkbzv15 with SMTP id zv15so403279bkb.4
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 02:02:16 -0700 (PDT)
In-Reply-To: <4E8AC514.1030002@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 04 October 2011 11:34:28 Jarkko Nikula wrote:
> =

> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> =

> while it would be more clear to fix this in omap dma core.

I have thought about that.. however, the only configuration, where we do no=
t =

need the BLOCK_IRQ is in audio, and only when we are running in 'no period =

wakeup' mode.
In all other cases we need to have the BLOCK_IRQ enabled.
I have looked at the other OMAP drivers, which uses the DMA and all assumes=
, =

that the BLOCK_IRQ is enabled out of box.

We can modify all OMAP drivers, and the dma core, or we can just disable th=
e =

BLOCK_IRQ at the only case, when it is not needed.

--
P=E9ter
