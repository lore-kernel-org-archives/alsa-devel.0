From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] tinycompress: cplay: Correct a couple of
 small message	typos
Date: Tue, 16 Apr 2013 19:31:20 +0530
Message-ID: <20130416140120.GN12436@intel.com>
References: <20130415163724.GA28342@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E219D26109C
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:31:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130415163724.GA28342@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 15, 2013 at 05:39:39PM +0100, Richard Fitzgerald wrote:
> 
> Change-Id: I2b25d006328f1a9458f232f77c61e509c9b54d3c
You need to strip these
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
and add s-o-b by the author

I have fixed it up and applied, thanks

--
~Vinod
> ---
>  cplay.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cplay.c b/cplay.c
> index 60995a4..d9364f4 100644
> --- a/cplay.c
> +++ b/cplay.c
> @@ -337,7 +337,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  				goto BUF_EXIT;
>  			}
>  			if (wrote != num_read) {
> -				/* TODO: Buufer pointer needs to be set here */
> +				/* TODO: Buffer pointer needs to be set here */
>  				fprintf(stderr, "We wrote %d, DSP accepted %d\n", num_read, wrote);
>  			}
>  			if (verbose) {
> @@ -348,7 +348,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  	} while (num_read > 0);
>  
>  	if (verbose)
> -		printf("%s: exit sucess\n", __func__);
> +		printf("%s: exit success\n", __func__);
>  	/* issue drain if it supports */
>  	compress_drain(compress);
>  	free(buffer);
> -- 
> 1.7.2.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
