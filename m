Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D271C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Apr 2022 08:39:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C631116F9;
	Thu, 14 Apr 2022 10:38:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C631116F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649925544;
	bh=5K5PBCjw++wR7vZ/ZFFzD2BNbcB1Pi8tfcNLTFjOH2o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g//HW7O95lRr5+DS39gNfx4c/zXI6NfAJUwDDinD35i27Sz2tklZH4N+c5KVveAv8
	 8BSEYrmBF9BD2zVaedQ2of91O723UsUDfftnQOv4R7srUouo473PEKeOw9lkwzsjlf
	 OEt7VAKAbuGCcTTkwZUd575zTmWP2dngrKYCin1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46068F8012E;
	Thu, 14 Apr 2022 10:38:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CE75F80162; Thu, 14 Apr 2022 10:38:12 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F617F80124
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 10:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F617F80124
X-UUID: 8cce995ca1594bbd84835c6af7d68581-20220414
X-UUID: 8cce995ca1594bbd84835c6af7d68581-20220414
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 956665497; Thu, 14 Apr 2022 16:37:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 14 Apr 2022 16:37:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 14 Apr 2022 16:37:58 +0800
From: Miles Chen <miles.chen@mediatek.com>
To: <tiwai@suse.de>
Subject: Re: [PATCH -next] sound/oss/dmasound: fix 'dmasound_setup' defined
 but not used
Date: Thu, 14 Apr 2022 16:37:58 +0800
Message-ID: <20220414083758.32396-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <s5hzgko3wh5.wl-tiwai@suse.de>
References: <s5hzgko3wh5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: alsa-devel@alsa-project.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, miles.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, tiwai@suse.com,
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

Hi Takashi,

> This must be a side-effect of the recent fix 9dd7c46346ca
> ("sound/oss/dmasound: fix build when drivers are mixed =y/=m").
> Adding Randy to Cc.
> 
> IMO, a less uglier way would be to add __maybe_unused to that
> function.  But it's a matter of taste.

thanks, I will use __maybe_unused and the fix tag in v2.

Thanks,
Miles

> 
> 
> thanks,
> 
> Takashi
