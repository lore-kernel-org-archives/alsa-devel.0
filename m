From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][PATCH] compress: compress_wait()
 must return error if timed out
Date: Tue, 12 Nov 2013 10:31:14 +0530
Message-ID: <20131112050114.GJ8834@intel.com>
References: <20131022105158.GA12320@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C5618261685
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 06:56:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131022105158.GA12320@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 22, 2013 at 11:51:58AM +0100, Richard Fitzgerald wrote:
> The caller must be certain that a return of 0 really means
> that compress is ready for more data, so when poll() returns
> 0 for a timeout we must report that as an error.
Applied, thanks

--
~Vinod
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  compress.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/compress.c b/compress.c
> index 5cd0966..d1a2283 100644
> --- a/compress.c
> +++ b/compress.c
> @@ -616,15 +616,17 @@ int compress_wait(struct compress *compress, int timeout_ms)
>  	fds.events = POLLOUT | POLLIN;
>  
>  	ret = poll(&fds, 1, timeout_ms);
> -	if (fds.revents & POLLERR) {
> -		return oops(compress, EIO, "poll returned error!");
> +	if (ret > 0) {
> +		if (fds.revents & POLLERR)
> +			return oops(compress, EIO, "poll returned error!");
> +		if (fds.revents & (POLLOUT | POLLIN))
> +			return 0;
>  	}
> -	/* A pause will cause -EBADFD or zero. */
> -	if ((ret < 0) && (ret != -EBADFD))
> +	if (ret == 0)
> +		return oops(compress, ETIME, "poll timed out");
> +	if (ret < 0)
>  		return oops(compress, errno, "poll error");
> -	if (fds.revents & (POLLOUT | POLLIN)) {
> -		return 0;
> -	}
> -	return ret;
> +
> +	return oops(compress, EIO, "poll signalled unhandled event");
>  }
>  
> -- 
> 1.7.2.5
> 

-- 
