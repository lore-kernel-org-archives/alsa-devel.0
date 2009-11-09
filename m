From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix
 to s3c_dma
Date: Mon, 9 Nov 2009 12:05:18 +0000
Message-ID: <20091109120517.GA22520@rakim.wolfsonmicro.main>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
	<4AF24321.7070303@samsung.com>
	<1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
	<4AF25C8C.3020001@samsung.com>
	<20091106162322.GD4938@sirena.org.uk>
	<1b68c6790911061946w6cf04e4cv30f790470c20cba4@mail.gmail.com>
	<4AF7A528.3080602@samsung.com>
	<1b68c6790911082131v21a5f0d4q542ba3496b60456b@mail.gmail.com>
	<4AF7B47C.40508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C31E4103828
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 13:05:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AF7B47C.40508@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi brar <jassisinghbrar@gmail.com>, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 03:19:40PM +0900, Joonyoung Shim wrote:

> I don't know why Ben doesn't use the DMA subsystem at s3c64xx
> CPU(PL080). I just think because the PL080 chip of s3c64xx has some
> customized parts or for the DMA interface compatibility of s3c24xx.

I suspect it's the latter; using the DMA API would mean updating all the
existing DMA drivers.

For audio use we'd probably also want to extend the DMA API to support
circular operation which I don't think it did last time I looked at it,
but that was when it was very shiny and new.  Ideally we'd be able to
have an ASoC DMA engine API client which would work over multiple
platforms which would be very nice.
