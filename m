From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: compress: avoid integer overflow for
 long duration offload playback
Date: Tue, 18 Jun 2019 10:02:59 +0200
Message-ID: <18a6f0ec-d34c-e45b-9db8-2950f4ab95d6@linux.intel.com>
References: <1560843846-4631-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57B3DF89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 10:03:02 +0200 (CEST)
In-Reply-To: <1560843846-4631-1-git-send-email-bgoswami@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: bgoswami@codeaurora.org, vkoul@kernel.org
Cc: Dhananjay Kumar <dhakumar@codeaurora.org>, alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, plai@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 6/18/19 9:44 AM, bgoswami@codeaurora.org wrote:
> From: Banajit Goswami <bgoswami@codeaurora.org>
> 
> Currently a 32 bit variable is used for storing number of bytes
> copied to DSP, which can overflow when playback continues for a long
> duration.
> Change data type for this variable to __u64 to prevent overflow.

This clearly looks like a bug, the number of bytes transferred is stored 
as u64 in the runtime. I have no memories of this being intentional.

That said, it seems odd to me that you have an overflow on the number of 
bytes but not on the number of PCM frames. Shouldn't both the pcm_frames 
and pcm_io_frames fields also be changed to u64 while we are at it?

And the second issue is that this may impact apps. This is a ABI change, 
isn't it?

> 
> Signed-off-by: Dhananjay Kumar <dhakumar@codeaurora.org>
> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
>   include/uapi/sound/compress_offload.h | 2 +-
>   sound/core/compress_offload.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
> index 56d9567..db5edf3 100644
> --- a/include/uapi/sound/compress_offload.h
> +++ b/include/uapi/sound/compress_offload.h
> @@ -67,7 +67,7 @@ struct snd_compr_params {
>    */
>   struct snd_compr_tstamp {
>   	__u32 byte_offset;
> -	__u32 copied_total;
> +	__u64 copied_total;
>   	__u32 pcm_frames;
>   	__u32 pcm_io_frames;
>   	__u32 sampling_rate;
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index a1a6fd7..2d0a709 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -184,7 +184,7 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
>   	if (!stream->ops->pointer)
>   		return -ENOTSUPP;
>   	stream->ops->pointer(stream, tstamp);
> -	pr_debug("dsp consumed till %d total %d bytes\n",
> +	pr_debug("dsp consumed till %d total %llu bytes\n",
>   		tstamp->byte_offset, tstamp->copied_total);
>   	if (stream->direction == SND_COMPRESS_PLAYBACK)
>   		stream->runtime->total_bytes_transferred = tstamp->copied_total;
> 
