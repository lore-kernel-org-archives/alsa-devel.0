From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
 depop
Date: Mon, 05 Aug 2013 19:19:32 +0200
Message-ID: <51FFDEA4.2020606@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E3AA265186
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:18:31 +0200 (CEST)
In-Reply-To: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/05/2013 06:19 AM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> Add mute/unmute control in widget event and modify the power on/off sequence to avoid pop noise.
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
> Please ignore the previous patch.
> I have tested speaker and headphone playback on this patch.
> ---
>  sound/soc/codecs/rt5640.c | 389 +++++++++++++++++++++++++++++++++++++++-------
>  sound/soc/codecs/rt5640.h |  15 ++
>  2 files changed, 352 insertions(+), 52 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index 4db7314..cae3f46 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -50,8 +50,6 @@ static const struct regmap_range_cfg rt5640_ranges[] = {
>  
>  static struct reg_default init_list[] = {
>  	{RT5640_PR_BASE + 0x3d,	0x3600},
> -	{RT5640_PR_BASE + 0x1c,	0x0D21},
> -	{RT5640_PR_BASE + 0x1b,	0x0000},
>  	{RT5640_PR_BASE + 0x12,	0x0aa8},
>  	{RT5640_PR_BASE + 0x14,	0x0aaa},
>  	{RT5640_PR_BASE + 0x20,	0x6110},
> @@ -378,21 +376,119 @@ static const SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
>  static const char * const rt5640_clsd_spk_ratio[] = {"1.66x", "1.83x", "1.94x",
>  	"2x", "2.11x", "2.22x", "2.33x", "2.44x", "2.55x", "2.66x", "2.77x"};
>  
> +static const char * const rt5640_mute_mode[] = {"mute", "unmute"};
> +
> +static const SOC_ENUM_SINGLE_DECL(rt5640_hp_enum, 0, 0, rt5640_mute_mode);
> +static const SOC_ENUM_SINGLE_DECL(rt5640_spo_enum, 0, 0, rt5640_mute_mode);
> +

These enums seem to be unused. (And switches should be used for mutes and enums)

- Lars
