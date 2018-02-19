From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ASoC: topology: Rename clock_gated to
 clock_cont in snd_soc_tplg_hw_config
Date: Mon, 19 Feb 2018 15:47:32 +0900
Message-ID: <458b66ab-da0a-8063-6555-13fb152c83a4@sakamocchi.jp>
References: <20180219060531.17276-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id AA8B0266C0E
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 07:47:36 +0100 (CET)
In-Reply-To: <20180219060531.17276-1-k.marinushkin@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 19 2018 15:05, Kirill Marinushkin wrote:
> In kernel `soc-dai.h`, DAI clock gating is defined as following:
> 
> ~~~~
> \#define SND_SOC_DAIFMT_CONT		(1 << 4) /* continuous clock */
> \#define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
> ~~~~
> 
> Therefore, the corresponding field of struct snd_soc_tplg_hw_config should
> be inverted compared to the current logic:
> 
> clock_count = 1 => SND_SOC_DAIFMT_CONT
> clock_count = 0 => SND_SOC_DAIFMT_GATED
> 
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   include/uapi/sound/asoc.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 69c37ecbff7e..10188850dede 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -312,7 +312,9 @@ struct snd_soc_tplg_hw_config {
>   	__le32 size;            /* in bytes of this structure */
>   	__le32 id;		/* unique ID - - used to match */
>   	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
> -	__u8 clock_gated;	/* 1 if clock can be gated to save power */
> +	__u8 clock_cont;	/* 1 if clock is continuous, and can not be
> +				 * gated to save power
> +				 */
>   	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
>   	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
>   	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */

This structure was added at a commit 676c6b5208f7 ('ASoC: topology: ABI 
- Update physical DAI link configuration for version 5') in a 
development period for v4.10.

This file is a part of UAPI, thus this structure has already been 
exposed to application developers. Any change can break userspace 
applications in a point of backward compatibility for this subsystem.

It's better for you to investigate another solution for your two 
patches[1][2].


[1] [alsa-devel] [PATCH 1/2] ASoC: topology: Rename clock_gated to 
clock_cont in snd_soc_tplg_hw_config
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/132258.html
[2] [alsa-devel] [PATCH 2/2] ASoC: topology: Add missing clock gating 
parameter when parsing hw_configs
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/132259.html


Regards

Takashi Sakamoto
