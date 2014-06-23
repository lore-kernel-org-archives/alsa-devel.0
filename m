From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l56: Fix stereo channel register
 assignment for Headphone and LineOut volume mixers
Date: Mon, 23 Jun 2014 11:25:18 -0500
Message-ID: <alpine.DEB.2.02.1406231124500.25941@heelrod>
References: <1403540273-15231-1-git-send-email-ryan.harvey@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE20265864
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:22:48 +0200 (CEST)
In-Reply-To: <1403540273-15231-1-git-send-email-ryan.harvey@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Harvey <ryan.harvey@cirrus.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2014, Ryan Harvey wrote:

> Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, LOA+LOB.
>
> Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
> ---
> sound/soc/codecs/cs42l56.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index fdc4bd2..8e68ef5 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> @@ -445,9 +445,9 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
> 	SOC_DOUBLE("ADC Boost Switch", CS42L56_GAIN_BIAS_CTL, 3, 2, 1, 1),
>
> 	SOC_DOUBLE_R_SX_TLV("Headphone Volume", CS42L56_HPA_VOLUME,
> -			      CS42L56_HPA_VOLUME, 0, 0x44, 0x55, hl_tlv),
> +			      CS42L56_HPB_VOLUME, 0, 0x44, 0x55, hl_tlv),
> 	SOC_DOUBLE_R_SX_TLV("LineOut Volume", CS42L56_LOA_VOLUME,
> -			      CS42L56_LOA_VOLUME, 0, 0x44, 0x55, hl_tlv),
> +			      CS42L56_LOB_VOLUME, 0, 0x44, 0x55, hl_tlv),
>
> 	SOC_SINGLE_TLV("Bass Shelving Volume", CS42L56_TONE_CTL,
> 			0, 0x00, 1, tone_tlv),
> -- 
> 1.7.9.5
>
>
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
