From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: s3c24xx 8 bit sound fix
Date: Wed, 12 Nov 2008 14:59:53 +0000
Message-ID: <20081112145952.GA28971@rakim.wolfsonmicro.main>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
	<1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20081112141902.GA15238@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22E752447E
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 15:59:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081112141902.GA15238@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Christian Pellegrin <chripell@gmail.com>, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 02:19:02PM +0000, Ben Dooks wrote:
> On Wed, Nov 12, 2008 at 11:55:47AM +0000, Mark Brown wrote:

> >  	case SNDRV_PCM_FORMAT_S8:
> > +		iismod &= ~S3C2410_IISMOD_16BIT;
> > +		((struct s3c24xx_pcm_dma_params *)
> > +		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
> >  		break;
> >  	case SNDRV_PCM_FORMAT_S16_LE:
> >  		iismod |= S3C2410_IISMOD_16BIT;
> > +		((struct s3c24xx_pcm_dma_params *)
> > +		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
> >  		break;

> Is playing with the dma parameters like that the correct way?

It makes the DMA size match the input data size which doesn't seem
totally unreasonable.

This is all internal to the s3c24xx I2S driver - what this does is
change the parameter passed by the DMA driver to s3c2410_dma_config()
for the I2S DMA channels which is just read blindly.  This parameter is
not exposed to user space.
