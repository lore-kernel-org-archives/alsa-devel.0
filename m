Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C35C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Mar 2022 16:13:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09AB217DD;
	Thu, 24 Mar 2022 17:12:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09AB217DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648138417;
	bh=WCk4dzdn3DtFOiWPLHNJq946UphbiJkQG7+kTAtMZdM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JYRVJgFq7VGr003NlydZ2u+Y4lh6RrJ6T1gft5nwu2U4rWtT9pif/xIJ+I0W3V81t
	 OJ+bJKh1TLctR1ZN5Jn1wBYuiWKpwpVIn/EU4AYt59oufqjrZ3atL0Wfq+WzJn2qqy
	 06nLBKLdev28RV8NejMHmJHkIanuW5DnxMhEptV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D8EF801EC;
	Thu, 24 Mar 2022 17:12:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AE77F801EC; Thu, 24 Mar 2022 17:12:44 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 735B0F80515
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2022 17:12:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 735B0F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="H2r7TNfT"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 912651F457D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1648138354;
 bh=WCk4dzdn3DtFOiWPLHNJq946UphbiJkQG7+kTAtMZdM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H2r7TNfTDpxaKSzjPVT4jB1Mv1PmRu810K99bdcoKktnGfjSaQNsCuuOOiOrROAv2
 WAZjuaXdyr6MVvqBpeXb/Ppm5sc66G6BdQIgo65vRbdfRxZB5j3/tkddMZi80SRGGf
 rSV+rwV3ON6wXU68DHcxIf0Mq/9JRaakWy9QRs2K97VEcX0abxRre8f5bGWrdMfZ96
 rCu+B3ki5EreP4yUybGMhb7+JhNQlM3+UOzXFGhjRSLtbAXe2SCKfwf7c/qzTD9sAn
 g3Bq+0E63Ezc0ptia0pnrXKKCceZk041QssxkgEIZw2Ow00o/vAqrwzfIOXCFAmfOr
 IXBAtp09bIaZw==
Message-ID: <d49177c6-651d-e445-4421-1078ba11efb8@collabora.com>
Date: Thu, 24 Mar 2022 17:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, matthias.bgg@gmail.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-6-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tzungbi@google.com, miles.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org
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

Il 24/03/22 06:38, Trevor Wu ha scritto:
> This patch adds support for mt8195 board with mt6359, max98390 and
> rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


