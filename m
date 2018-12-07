From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] tinycompress: Fix missing '}' around
 extern C
Date: Fri, 7 Dec 2018 10:40:31 +0530
Message-ID: <20181207051031.GC2847@vkoul-mobl>
References: <20181206100427.18472-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C7CC267CC0
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 06:10:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181206100427.18472-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06-12-18, 10:04, Charles Keepax wrote:
> From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>

Applied, thanks.

Charles please do fix you address book though!

> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  include/tinycompress/tinycompress.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
> index 780dce6..f0fae30 100644
> --- a/include/tinycompress/tinycompress.h
> +++ b/include/tinycompress/tinycompress.h
> @@ -276,4 +276,8 @@ int is_compress_ready(struct compress *compress);
>  /* Returns a human readable reason for the last error */
>  const char *compress_get_error(struct compress *compress);
>  
> +#if defined(__cplusplus)
> +} // extern "C"
> +#endif
> +
>  #endif
> -- 
> 2.11.0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
