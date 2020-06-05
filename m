Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234AAC433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:37:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9987B2075B
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CenjzdKr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZziRepXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9987B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F00E51658;
	Fri,  5 Jun 2020 12:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F00E51658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591353418;
	bh=nsUntpG+2ZTGK4HrWe8pIq15nHkMfEaQcUq9M+NOtWk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CenjzdKrBfH05bMsrKYZLhRpvyHACT78a0jZNp+iSMf2c3OF4C5PkcfV/p6mpbTc7
	 xBdZ3nCbNdq9t/MaVtyFeMRdarLQGaqDJvptFO5pDw+XzBUFzYu3djq0FmRSSr47C8
	 7YkKvCg81hClLuPhGhNI6UvXIn1PRidUxBTDWe7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AA02F801EC;
	Fri,  5 Jun 2020 12:36:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E43AF801ED; Fri,  5 Jun 2020 12:36:02 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by alsa1.perex.cz (Postfix) with ESMTP id 6E890F80132
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 12:35:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E890F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="ZziRepXD"
X-UUID: 1a82d9ddb32f49f8a64f95d3434ca921-20200605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=nsUntpG+2ZTGK4HrWe8pIq15nHkMfEaQcUq9M+NOtWk=; 
 b=ZziRepXD1Tc2tvW8UgCB9U8mMFj8HAhFyvII54fN0S5EPTBx0ntD9TZ9Jxgc6oMQi+wii8CRsxB8x9POeeJox6t0LZCwazYx5uJYvCREmw543rnnsapfKScKefLEbGZ793KXzKseHNCQ4P3zNQbhhoO7AsDOMFNjqEJ40LFE7XM=;
X-UUID: 1a82d9ddb32f49f8a64f95d3434ca921-20200605
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 158510851; Fri, 05 Jun 2020 18:35:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Jun 2020 18:35:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Jun 2020 18:35:45 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <matthias.bgg@gmail.com>, <hariprasad.kelam@gmail.com>
Subject: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
Date: Fri, 5 Jun 2020 18:33:40 +0800
Message-ID: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8183516B6E5D2C2436F93EBC972FC14D6494A6210300ACC0EE968670B2FED9B22000:8
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, howie.huang@mediatek.com,
 linux-kernel@vger.kernel.org, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 tzungbi@google.com, linux-mediatek@lists.infradead.org,
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

djIgY2hhbmdlczoNCgkxLiBVc2VzIGEgRFQgcHJvcGVydHkgdG8gc2VsZWN0IERNSUMgbW9kZSBp
bnN0ZWFkIG9mIGEgbWl4ZXIgY29udHJvbC4NCg0KdjEgY2hhbmdlczoNCgkxLiBVc2VzIGEgbWl4
ZXIgY29udHJvbCB0byBzZWxlY3QgRE1JQyBtb2RlLg0KCTIuIHBhdGNod29yayBsaXN0Og0KCQlo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNTc4MzA5DQoNCkppYXhpbiBZdSAo
Mik6DQogIEFTb0M6IG1lZGlhdGVrOiBtdDYzNTg6IHN1cHBvcnQgRE1JQyBvbmUtd2lyZSBtb2Rl
DQogIEFTb0M6IGR0LWJpbmRpbmdzOiBtZWRpYXRlazogbXQ2MzU4OiBhZGQgZG1pYy1tb2RlIHBy
b3BlcnR5DQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU4
LnR4dCB8ICA2ICsrKysrKw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU4LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQotLSANCjEuOC4xLjEuZGlydHkN
Cg==

