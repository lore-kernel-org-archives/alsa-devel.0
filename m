From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 21:24:09 +0500
Message-ID: <478F8129.5030408@gmail.com>
References: <12005823754197-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id D795D2441F
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 17:24:50 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so716132fgb.44
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 08:24:50 -0800 (PST)
In-Reply-To: <12005823754197-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Enable mmap support in the MPC8610 ASoC driver.  The driver can use ALSA's
> default mmap functionality, it was just not enabled previously.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

[sorry, I may be completely wrong below about the .page callback purpose - in 
this case, just confirm that the testcase works]

Hm, the "struct snd_pcm_ops fsl_dma_ops" doesn't contain the .page callback. 
With saa7134-alsa, this led to the "device claims to support mmap but actually 
doesn't work" bug, see the following subthread:

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-October/003773.html

IOW: have you actually tested that the following commands work (X,Y refer to the 
FSL chip)?

aplay -M -D hw:X,Y sample.wav
arecord -f cd -M -D:X,Y capture.wav

> ---
>  sound/soc/fsl/fsl_dma.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 2173203..652514f 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -136,7 +136,9 @@ struct fsl_dma_private {
>   */
>  static const struct snd_pcm_hardware fsl_dma_hardware = {
>  
> -	.info   		= SNDRV_PCM_INFO_INTERLEAVED,
> +	.info   		= SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID,
>  	.formats		= FSLDMA_PCM_FORMATS,
>  	.rates  		= FSLDMA_PCM_RATES,
>  	.rate_min       	= 5512,

-- 
Alexander E. Patrakov
