From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH tinycompress] cplay: Stop playback stream
 at the end
Date: Wed, 27 Jun 2018 15:54:24 +0530
Message-ID: <20180627102424.GH22377@vkoul-mobl>
References: <1530085691-27736-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id AADD8267610
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 12:33:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1530085691-27736-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com
List-Id: alsa-devel@alsa-project.org

On 27-06-18, 10:48, Daniel Baluta wrote:
> Each compress_start should have a corresponding compress_stop
> at the end.
> 
> Also, this gives user a change to cleanup resources that might
> have been allocated in compress_start.

I think the assumptions are not quite correct here, resources should be
allocated in .open and cleanup in .free for driver callback.

> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> I'm implementing codec library dynamic loading at runtime and I'm exploring
> using:
> 	* SNDRV_COMPRESS_START -> to load the library
> 	* SNDRV_COMPRESS_STOP  -> to unload the library
> 
> This might not be the best idea becasue for example loading
> the library might introduce some delays, anyhow i still think
> this that compress_stop is correct thing to add at the end of
> playback.

I think you should tie the library load to much earlier in path. Not in
start.

Also, we invoke drain and hence there is no need of stop

> 
> 
>  src/utils/cplay.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/utils/cplay.c b/src/utils/cplay.c
> index 87863a3..3c48d15 100644
> --- a/src/utils/cplay.c
> +++ b/src/utils/cplay.c
> @@ -403,6 +403,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  		printf("%s: exit success\n", __func__);
>  	/* issue drain if it supports */
>  	compress_drain(compress);
> +	compress_stop(compress);
>  	free(buffer);
>  	fclose(file);
>  	compress_close(compress);
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
