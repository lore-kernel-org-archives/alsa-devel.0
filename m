From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ALSA: compress: Add
 SND_AUDIOCODEC_BESPOKE
Date: Tue, 20 Oct 2015 12:47:58 -0500
Message-ID: <56267E4E.8010609@linux.intel.com>
References: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A8C6266610
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 19:48:01 +0200 (CEST)
In-Reply-To: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/20/15 8:39 AM, Charles Keepax wrote:
> When working with the compressed framework occasionally vendors will
> use esoteric internal audio formats. For such formats it doesn't really
> make sense to add an new define to the kernel as their use is not
> sufficiently general.
>
> This patch adds a new define SND_AUDIOCODEC_BESPOKE that vendors can use
> in such situations.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>   include/uapi/sound/compress_params.h |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> index d9bd9ca..e284380 100644
> --- a/include/uapi/sound/compress_params.h
> +++ b/include/uapi/sound/compress_params.h
> @@ -73,7 +73,8 @@
>   #define SND_AUDIOCODEC_IEC61937              ((__u32) 0x0000000B)
>   #define SND_AUDIOCODEC_G723_1                ((__u32) 0x0000000C)
>   #define SND_AUDIOCODEC_G729                  ((__u32) 0x0000000D)
> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_G729
> +#define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)

No real objections from me, this is better than overloading PCM for this 
purpose...
Since this is clearly an escape mechanism for a non-standard codec, 
maybe we should use an ID that's not in sequence, eg 0x00001000.
If you need to set parameters maybe we should also change the definition 
of snd_enc_generic so that the reserved fields can be used for custom 
parameters, or document that their use is permitted for this sort of ID.

> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_BESPOKE
>
>   /*
>    * Profile and modes are listed with bit masks. This allows for a
>
