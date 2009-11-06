From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] S3C AUDIO: Rename s3c24xx_pcm
	prefix	to s3c_dma
Date: Fri, 6 Nov 2009 16:23:23 +0000
Message-ID: <20091106162322.GD4938@sirena.org.uk>
References: <1257384866-18188-1-git-send-email-jassi.brar@samsung.com>
	<4AF24321.7070303@samsung.com>
	<1b68c6790911042016s6993f314x6e2a1c169ba5d437@mail.gmail.com>
	<4AF25C8C.3020001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E3D8243F3
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 17:23:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AF25C8C.3020001@samsung.com>
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
Cc: alsa-devel@alsa-project.org, jassi brar <jassisinghbrar@gmail.com>, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 02:03:08PM +0900, Joonyoung Shim wrote:
> On 11/5/2009 1:16 PM, jassi brar wrote:

> > but if we try so, we have the following
> >  1) s3c24xx_pcm_dma_params -> s3c_dma_dma_params
> >  2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_dma_preallocate_dma_buffer
> >  3) s3c24xx_pcm_dmamask -> s3c_dma_dmamask

> > none of which seem very nice.

> You can modify the names for the consistent prefix. If you
> use s3c_dma_ prefix, for example, s3c24xx_pcm_dma_params can be to 
> s3c_dma_params.

I tend to agree with this.  The actual rename needs to happen to free up
the PCM name for the driver for the PCM hardware.

> > These patches is not about changing naming conventions. Only changes, necessary
> > to have a clean and consistent namespace after integrating PCM driver, have
> > been made.

> Agree, but you already are changing the prefix from s3c24xx to s3c.

I also agree with this - if we're renaming this driver anyway then
changing the prefix for it while we're at it seems reasonable, it means
one less change in the future.
