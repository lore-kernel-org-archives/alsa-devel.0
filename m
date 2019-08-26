From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/1] ASoC: topology: Fix variable overflow
 in split_format
Date: Mon, 26 Aug 2019 11:59:16 -0500
Message-ID: <1b994f3b-6fae-27ca-8248-5847f6733e86@linux.intel.com>
References: <1566820301-18671-1-git-send-email-marcin.pietraszko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99427F805E2
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 20:55:27 +0200 (CEST)
In-Reply-To: <1566820301-18671-1-git-send-email-marcin.pietraszko@linux.intel.com>
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
To: Marcin Pietraszko <marcin.pietraszko@linux.intel.com>, perex@perex.cz
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

CC: Takashi and Mark.

On 8/26/19 6:51 AM, Marcin Pietraszko wrote:
> The 1 which was 32-bit long, when left-shifted by more than 31 caused
> an overflow, which resulted in some of the formats being not supported.

Looks like an alsa-lib patch?

> 
> Signed-off-by: Marcin Pietraszko <marcin.pietraszko@linux.intel.com>
> ---
>   src/topology/pcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/topology/pcm.c b/src/topology/pcm.c
> index 5f586dc..00a35b9 100644
> --- a/src/topology/pcm.c
> +++ b/src/topology/pcm.c
> @@ -321,7 +321,7 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
>   			return -EINVAL;
>   		}
>   
> -		caps->formats |= 1 << format;
> +		caps->formats |= 1ull << format;
>   		s = strtok(NULL, ", ");
>   		i++;
>   	}
> 
