Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A802AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 11:34:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E2C18E1;
	Wed, 16 Feb 2022 12:34:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E2C18E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645011296;
	bh=NqYUlv+/KEC/cexTSYYGlePKiUbKwhwSh3Fh+CTXszs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FyvCXCGo0jpQprMmGw1ZRBoihsdoeMwjf3xmZGFxtRaMjyhiCRAp0vWPQud+sm17d
	 Ux0uA2z3oALptQgjKrhBP94yueS6N27NzUhbt43EN7S9S9YPofiJFrIZNqRp7znjT6
	 cEEveFavJ97rxAydJn6bqrIwco15UBLeytmumDxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABED1F8011C;
	Wed, 16 Feb 2022 12:34:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A857F80128; Wed, 16 Feb 2022 12:34:03 +0100 (CET)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9967DF800D8
 for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2022 12:33:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9967DF800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="udTSNTVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645011241; x=1676547241;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=pmRMfrAsDFhdvjzY4uN2DGJiavIZ2kryDsFQYGeBUyQ=;
 b=udTSNTVhzSuDYy52Np6jmibChtzBGdxncRjoXdASiXTcNtHJxB7tFWIK
 HMUHD4eKahQ17xwJhqX8iS1blyK71U1uBNQyc7a8gKnbQd+vPFx6ro2lt
 CrKYc+i+cNKLK47AkHvsyAkLshWQL7ohy/IzYsQJquAsXNIQFBYjDrfSr 4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
 by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 03:33:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 03:33:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 03:33:53 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 03:33:50 -0800
Subject: Re: [PATCH -next] ASoC: codec: wcd938x: Fix NULL but dereferenced
 coccicheck error
To: Yang Li <yang.lee@linux.alibaba.com>, <perex@perex.cz>
References: <20220216021116.94384-1-yang.lee@linux.alibaba.com>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <6c021509-e29f-2946-b411-64242535a370@quicinc.com>
Date: Wed, 16 Feb 2022 17:03:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220216021116.94384-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 tiwai@suse.com, broonie@kernel.org
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


On 2/16/2022 7:41 AM, Yang Li wrote:
Thanks for Fix Yang!!!
We are going to post complete cleaned patch. Shall we ignore this patch 
for now?
> Eliminate the following coccicheck warning:
> ./sound/soc/codecs/wcd938x.c:4210:21-24: ERROR: component is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   sound/soc/codecs/wcd938x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index 2663fe0bf64f..c46c4bfd84f2 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4207,7 +4207,7 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
>   	struct wcd938x_priv *wcd938x;
>   
>   	if (!component) {
> -		dev_err(component->dev, "%s component is NULL\n", __func__);
> +		pr_err("The snd_soc_component is NULL\n");
>   		return false;
>   	}
>   
