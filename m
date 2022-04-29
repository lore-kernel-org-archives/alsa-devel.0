Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43434C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 09:22:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26B3F950;
	Fri, 29 Apr 2022 11:21:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26B3F950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651224165;
	bh=XFrvkjS7rywo06boZVwrDAljau1avj28hXkFWbhs5Ms=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sS8js2sL3YmJDGPJ1qT2CWshaozBx439Bh9MKt+c5giFnytfUpzXAW/a6AAuMOkr5
	 ukavg+nRhfAP0eF4DZS+rVGVGoPFp2Pjxet2tIxe1BiDWjB5ZfRlq4tdApRNGshm6y
	 CzlckIRl/suBgAn1nk7Jcz2LrmyFsCCVByk7tcG4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B904DF80237;
	Fri, 29 Apr 2022 11:21:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10DD9F8025D; Fri, 29 Apr 2022 11:21:54 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C375FF8012B
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 11:21:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C375FF8012B
X-UUID: a683860e2ba94204b1542030cbdf980d-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:57cf52b3-97af-4ecd-bf7d-6369f6dfdad6, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-INFO: VERSION:1.1.4, REQID:57cf52b3-97af-4ecd-bf7d-6369f6dfdad6, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:45
X-CID-META: VersionHash:faefae9, CLOUDID:11a1f4c6-85ee-4ac1-ac05-bd3f1e72e732,
 C
 OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
 ,BEC:nil
X-UUID: a683860e2ba94204b1542030cbdf980d-20220429
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 830141353; Fri, 29 Apr 2022 17:21:40 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 29 Apr 2022 17:21:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 17:21:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 17:21:38 +0800
Message-ID: <990e0f5b27203d99c502d3cb2fcacc0b9767b848.camel@mediatek.com>
Subject: Re: [v4 00/18] ASoC: mediatek: Add support for MT8186 SoC
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Apr 2022 17:21:38 +0800
In-Reply-To: <YmqGXCg97X6Vqvs+@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <YmqGXCg97X6Vqvs+@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Thu, 2022-04-28 at 13:19 +0100, Mark Brown wrote:
> On Thu, Apr 28, 2022 at 05:33:37PM +0800, Jiaxin Yu wrote:
> > This series of patches adds support for Mediatek AFE of MT8186 Soc.
> > Patches are based on broonie tree "for-next" branch.
> 
> This looks mostly good from a framework point of view - I did notice
> a
> few minor issues which I commented on (some of the control things are
> repeated in other patches) but the overwhelming bulk of the code
> looks
> good.
Hi Mark,

Thank you very much for your review. I will check the codes with your
comments carefully.

Best Regards
Jiaxin.Yu

