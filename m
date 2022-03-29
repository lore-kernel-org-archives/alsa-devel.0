Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B03C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Mar 2022 02:35:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3417316F3;
	Tue, 29 Mar 2022 04:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3417316F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648521306;
	bh=wg3INMyNljTx9XmDkJKD9ECZHDgmQovT1An3PyqCQyk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a5pXZZhy+bGTB7TEXKsVGkAeBl9lgTOBQSXt/+AGv4uKLxCokzk0h1CRTU8IXS9Rc
	 yK2fkqHMvjydVarraZjKullgVwtGjIBjJqYJcQmCR+06RDG2dTeanRIAjBMRvTvOp8
	 G9a4jX7ExHHfMAr9NWvdr0Dd0nomFkg3jlxRakjo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3045F8014E;
	Tue, 29 Mar 2022 04:34:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 122FCF800FA; Tue, 29 Mar 2022 04:34:14 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41CD0F800FA
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2022 04:34:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41CD0F800FA
X-UUID: bf9bfe96da7f47e8a2ae7259817316b0-20220329
X-UUID: bf9bfe96da7f47e8a2ae7259817316b0-20220329
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 640139202; Tue, 29 Mar 2022 10:34:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Mar 2022 10:33:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 10:33:58 +0800
Message-ID: <eef98cc24f75f9712acd3fe5e597d49140cbc943.camel@mediatek.com>
Subject: Re: [PATCH] mediatek: mt8195: fix a missing check on list iterator
From: Trevor Wu <trevor.wu@mediatek.com>
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <matthias.bgg@gmail.com>
Date: Tue, 29 Mar 2022 10:33:58 +0800
In-Reply-To: <20220327081712.13341-1-xiam0nd.tong@gmail.com>
References: <20220327081712.13341-1-xiam0nd.tong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, rikard.falkeborn@gmail.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, jiaxin.yu@mediatek.com,
 yc.hung@mediatek.com, stable@vger.kernel.org, dan.carpenter@oracle.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sun, 2022-03-27 at 16:17 +0800, Xiaomeng Tong wrote:
> The bug is here:
>  mt8195_etdm_hw_params_fixup(runtime, params);
> 
> For the for_each_card_rtds(), just like list_for_each_entry(),
> the list iterator 'runtime' will point to a bogus position
> containing HEAD if the list is empty or no element is found.
> This case must be checked before any use of the iterator,
> otherwise it will lead to a invalid memory access.
> 
> To fix the bug, use a new variable 'iter' as the list iterator,
> while use the original variable 'runtime' as a dedicated poin
> ter
> to point to the found element.

Hi Xiaomeng,

About this bug, I think it won't happen anymore.

mt8195_dai_link_fixup() is only assigned when the corresponding
snd_soc_pcm_runtime is found
in mt8195_mt6359_rt1019_rt5682_late_probe().

On the other hand, runtime is not used in the body of
mt8195_etdm_hw_params_fixup().

That's why I think the problem doesn't exist.
If I misunderstood the problem you pointed out, please correct me.

Thanks,
Trevor
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d00d2c07f04f ("ASoC: mediatek: mt8195: add sof support on
> mt8195-mt6359-rt1019-rt5682")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  .../mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c  | 14 ++++++++--
> ----
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> index 29c2d3407cc7..dc91877e4c3c 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> @@ -814,7 +814,7 @@ static int mt8195_dai_link_fixup(struct
> snd_soc_pcm_runtime *rtd,
>  {
>  	struct snd_soc_card *card = rtd->card;
>  	struct snd_soc_dai_link *sof_dai_link = NULL;
> -	struct snd_soc_pcm_runtime *runtime;
> +	struct snd_soc_pcm_runtime *runtime = NULL, *iter;
>  	struct snd_soc_dai *cpu_dai;
>  	int i, j, ret = 0;
>  
> @@ -824,16 +824,17 @@ static int mt8195_dai_link_fixup(struct
> snd_soc_pcm_runtime *rtd,
>  		if (strcmp(rtd->dai_link->name, conn->normal_link))
>  			continue;
>  
> -		for_each_card_rtds(card, runtime) {
> -			if (strcmp(runtime->dai_link->name, conn-
> >sof_link))
> +		for_each_card_rtds(card, iter) {
> +			if (strcmp(iter->dai_link->name, conn-
> >sof_link))
>  				continue;
>  
> -			for_each_rtd_cpu_dais(runtime, j, cpu_dai) {
> +			for_each_rtd_cpu_dais(iter, j, cpu_dai) {
>  				if (cpu_dai->stream_active[conn-
> >stream_dir] > 0) {
> -					sof_dai_link = runtime-
> >dai_link;
> +					sof_dai_link = iter->dai_link;
>  					break;
>  				}
>  			}
> +			runtime = iter;
>  			break;
>  		}
>  
> @@ -845,7 +846,8 @@ static int mt8195_dai_link_fixup(struct
> snd_soc_pcm_runtime *rtd,
>  
>  	if (!strcmp(rtd->dai_link->name, "ETDM2_IN_BE") ||
>  	    !strcmp(rtd->dai_link->name, "ETDM1_OUT_BE")) {
> -		mt8195_etdm_hw_params_fixup(runtime, params);
> +		if (runtime)
> +			mt8195_etdm_hw_params_fixup(runtime, params);
>  	}
>  
>  	return ret;

