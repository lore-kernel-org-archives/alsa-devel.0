Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B8C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 12:12:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28AC018C3;
	Mon,  9 May 2022 14:12:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28AC018C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652098374;
	bh=VbPh6mRdGjQDsMFyGe0Cb6Spbdh6LVTG4V6bxyqtnPk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIJysBM+AJxgdz/MRtH6/0WIdaUNbnRL1g0kKC8wDDB40ZaCGfz66FUDWgEAJk0bZ
	 g4gRn3E+EIdH92Wa6F1NZxYyrx/1nDLJ5SZOEVZkrAe22Y0pD1QDx3l5JPh3c8rrOq
	 VhaYn50y/dRqyjbGAUYCSnVwN//nGOHvZzaCr3E8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77C67F80237;
	Mon,  9 May 2022 14:12:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BB49F80510; Mon,  9 May 2022 14:12:00 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48428F8014C
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 14:11:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48428F8014C
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kxg250Jr4zGphW;
 Mon,  9 May 2022 20:09:01 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 20:11:47 +0800
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: Fix build warning without
 CONFIG_OF
To: Mark Brown <broonie@kernel.org>
References: <20220507021424.12180-1-yuehaibing@huawei.com>
 <YnkAAx3VAXCMFOTn@sirena.org.uk>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <3ba32c96-eec3-61a0-aece-d161d8db24ac@huawei.com>
Date: Mon, 9 May 2022 20:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YnkAAx3VAXCMFOTn@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
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

On 2022/5/9 19:50, Mark Brown wrote:
> On Sat, May 07, 2022 at 10:14:24AM +0800, YueHaibing wrote:
>> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: ‘mt8195_mt6359_max98390_rt5682_card’ defined but not used [-Wunused-variable]
>>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
>>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This doesn't apply against current code, please check and resend (it
> looks like you have additional patches in your tree, am doesn't know the
> base SHA1s?).

Sorry, will rebase on next-20220509 ab
> 
