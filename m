From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/7] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Mon, 15 Apr 2013 21:43:54 +0530
Message-ID: <20130415161354.GD12436@intel.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1365703245-20738-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A962F2651DC
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 18:45:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1365703245-20738-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 11, 2013 at 07:00:39PM +0100, Charles Keepax wrote:
> The app_pointer is managed locally by the compress core for memory
> mapped DSPs but for DSPs that are not memory mapped this would have to
> be manually updated from within the DSP driver itself, which is hardly
> very idiomatic.
> 
> This patch switches to using the cumulative values to calculate the
> available buffer space because these are already gracefully passed out
> of the DSP driver to the compress core and otherwise should be
> functionally equivalent.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/core/compress_offload.c |   23 +++++------------------
>  1 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index c84abc8..27bd81a 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -160,8 +160,6 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
>  static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
>  		struct snd_compr_avail *avail)
>  {
> -	long avail_calc; /*this needs to be signed variable */
> -
>  	memset(avail, 0, sizeof(*avail));
>  	snd_compr_update_tstamp(stream, &avail->tstamp);
>  	/* Still need to return avail even if tstamp can't be filled in */
> @@ -184,22 +182,11 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
>  		return stream->runtime->buffer_size;
>  	}
>  
> -	/* FIXME: this routine isn't consistent, in one test we use
> -	 * cumulative values and in the other byte offsets. Do we
> -	 * really need the byte offsets if the cumulative values have
> -	 * been updated? In the PCM interface app_ptr and hw_ptr are
> -	 * already cumulative */
As I said last time these doesn't seem to generated against either Takashi's or
Mark's public tree. This comment is as below on all the public trees I have seen
	/* FIXME: This needs to be different for capture stream,
	   available is # of compressed data, for playback it's remainder of buffer */

As a result I am unable to apply & test this on any of the trees I work with :(
Pls clone either of these and regenerate..

> -
> -	avail_calc = stream->runtime->buffer_size -
> -		(stream->runtime->app_pointer - stream->runtime->hw_pointer);
> -	pr_debug("calc avail as %ld, app_ptr %lld, hw+ptr %lld\n", avail_calc,
> -			stream->runtime->app_pointer,
> -			stream->runtime->hw_pointer);
> -	if (avail_calc >= stream->runtime->buffer_size)
> -		avail_calc -= stream->runtime->buffer_size;
> -	pr_debug("ret avail as %ld\n", avail_calc);
> -	avail->avail = avail_calc;
> -	return avail_calc;
> +	avail->avail = stream->runtime->buffer_size -
> +		(stream->runtime->total_bytes_available -
> +		 stream->runtime->total_bytes_transferred);
> +	pr_debug("ret avail as %lld\n", avail->avail);
> +	return avail->avail;
>  }
>  
>  static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
> -- 
> 1.7.2.5
> 
