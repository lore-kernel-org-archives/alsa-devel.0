Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04408C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:19:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C0821A49
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oaPce2mI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o3Dr56KL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C0821A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A20D1612;
	Tue, 12 Nov 2019 11:18:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A20D1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573553975;
	bh=Xz+yO5JIHEY4ZD4e5s3/RJO9YivUxvXcvmttp+rtkxM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oaPce2mITaJScZpE7SscWEaBedyiruI0ByukkVHW3Fu0vlLgcfbx861N+k0aC7UBe
	 eWVDp0xdk6graZ2qazuVcpRl+hQm0roCZIcYL+AapIMLHRLz64ss9FyOdcNXVEe0S8
	 Cr0P9R53aWYTw+i8FFPqjXR03P0bX+ItH3z7nWfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53C10F8063E;
	Tue, 12 Nov 2019 11:14:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0E64F80483; Tue, 12 Nov 2019 05:23:01 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id 897F8F80144
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 05:22:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 897F8F80144
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="o3Dr56KL"
X-UUID: 02744c1f0caf4b458bfb0b32426e76e4-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=65dsjVyoWWKKp4LA3tMC7lHvYCV21xP5fvkzEV7aJhg=; 
 b=o3Dr56KLmVoNp3hPF+9UTwbqX3MhT3+qsfJ5B8ZL/znUPgU48cLxke99ss5Bsj0RPaVj5tkv6riGNWR2Pn+hDD7S67GhiVXuDTYIWbbLj8c4GtQo6NmcUzjFtUc+Ii5cQK3ewNX6qngq9Ves+6mUAFU4NRJR9g7YlAsuvyTF7lg=;
X-UUID: 02744c1f0caf4b458bfb0b32426e76e4-20191112
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <eason.yen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 876937893; Tue, 12 Nov 2019 12:22:49 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 12:22:46 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 12 Nov 2019 12:22:46 +0800
From: Eason Yen <eason.yen@mediatek.com>
To: <broonie@kernel.org>
Date: Tue, 12 Nov 2019 12:22:17 +0800
Message-ID: <1573532538-30602-1-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F54BED13F5A676793D2E35517C57E14F3977D14BD1A72343755095833BA93382000:8
X-MTK: N
X-Mailman-Approved-At: Tue, 12 Nov 2019 11:14:25 +0100
Cc: alsa-devel@alsa-project.org, chipeng.chang@mediatek.com,
 jiaxin.yu@mediatek.com, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, matthias.bgg@gmail.com
Subject: [alsa-devel] [PATCH v1] ASoC: mediatek: common: refine
	mtk_afe_fe_hw_params
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch is to refine mtk_afe_fe_hw_params by the following
export functions:
- mtk_memif_set_enable
- mtk_memif_set_disable
- mtk_memif_set_addr
- mtk_memif_set_channel
- mtk_memif_set_rate
- mtk_memif_set_rate_substream
- mtk_memif_set_format
- mtk_memif_set_pbuf_size

By the way, extend mtk_base_memif_data and mtk_base_afe_memif struct
to support mtk new platform(mt6779)
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
