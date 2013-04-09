From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Tue, 9 Apr 2013 16:32:30 +0530
Message-ID: <20130409110230.GE31193@intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D982E265DF5
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 13:31:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On Wed, Apr 03, 2013 at 01:13:27PM +0100, Charles Keepax wrote:
> The app_pointer is managed locally by the compress core for memory
> mapped DSPs but for DSPs that are not memory mapped this would have to
> be manually updated from within the DSP driver itself, which is hardly
> very idiomatic.
app pointer means what has been written into DSP buffer, no matter if its memory
mapped or not. This is updated after .copy returns so if you have been asked to
copy 100bytes, and return of .copy, app pointer is incremented by 100, so why is
that not true for you?

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
What is this patch based off< certainly not asoc/sound-next as I dont remember
this comment. IIRC comment was to test this for capture case!
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
Neverthless, I agree that is simpler calculation...

> +	return avail->avail;
>  }
>  
>  static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
> -- 
> 1.7.2.5
> 
