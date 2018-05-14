From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 4/4] ALSA: isight: use position offset
 macro of TLV data
Date: Mon, 14 May 2018 08:32:30 +0200
Message-ID: <d48600a6-2a2a-ca9e-9cb8-8f1f8171270f@ladisch.de>
References: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
 <20180513220953.15118-5-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id B88F0266DF0
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 08:31:40 +0200 (CEST)
In-Reply-To: <20180513220953.15118-5-o-takashi@sakamocchi.jp>
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
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
> of TLV data. This commit applies a code optimization.
>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/firewire/isight.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
> index 46092fa3ff9b..3919e186a30b 100644
> --- a/sound/firewire/isight.c
> +++ b/sound/firewire/isight.c
> @@ -569,18 +569,20 @@ static int isight_create_mixer(struct isight *isight)
>  		return err;
>  	isight->gain_max = be32_to_cpu(value);
>
> -	isight->gain_tlv[0] = SNDRV_CTL_TLVT_DB_MINMAX;
> -	isight->gain_tlv[1] = 2 * sizeof(unsigned int);
> +	isight->gain_tlv[SNDRV_CTL_TLVO_TYPE] = SNDRV_CTL_TLVT_DB_MINMAX;
> +	isight->gain_tlv[SNDRV_CTL_TLVO_LEN] = 2 * sizeof(unsigned int);
>
>  	err = reg_read(isight, REG_GAIN_DB_START, &value);
>  	if (err < 0)
>  		return err;
> -	isight->gain_tlv[2] = (s32)be32_to_cpu(value) * 100;
> +	isight->gain_tlv[SNDRV_CTL_TLVO_DB_MINMAX_MIN] =
> +						(s32)be32_to_cpu(value) * 100;
>
>  	err = reg_read(isight, REG_GAIN_DB_END, &value);
>  	if (err < 0)
>  		return err;
> -	isight->gain_tlv[3] = (s32)be32_to_cpu(value) * 100;
> +	isight->gain_tlv[SNDRV_CTL_TLVO_DB_MINMAX_MAX] =
> +						(s32)be32_to_cpu(value) * 100;
>
>  	ctl = snd_ctl_new1(&gain_control, isight);
>  	if (ctl)
