Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7825C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:09:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5527120758
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="csHXJx5E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WU8s/2Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5527120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C984683E;
	Mon, 17 Aug 2020 08:09:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C984683E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597644594;
	bh=Lu1pMyst1Tuly33CctInw4/3ftqcqaHDiJCV73RnmxQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=csHXJx5EWEOANCAYGVZ83XNJ7ZE4p9IEnXWEB54p98OW/Zil8aEZS6Lad7MDihvGw
	 5c+RBVpDzKKUImJhPrdUNrsYGsS4q2rCqzIeJAeYlsUZvUvnNsRtXXPEcuwoAHuSps
	 knssMlBO3ERu4YRD1v14R5Ocg2EyTWDU3plvYXiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6033AF80216;
	Mon, 17 Aug 2020 08:09:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 939C2F800EF; Mon, 17 Aug 2020 08:09:02 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id D1358F800EF
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 08:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1358F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="WU8s/2Df"
X-UUID: 9b12133b8c1b4633a50d50bb56699ca5-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=Lu1pMyst1Tuly33CctInw4/3ftqcqaHDiJCV73RnmxQ=; 
 b=WU8s/2DfsA7RlJAnD3vnJD8QMhLS0UrNUK3J5OYVawl5IfkcEvJGGr5ZzGlUZDLWdA+CMBli6Nzx/8PjH+mHQcs6fjBY0gAeI87Flfc9J1w7OEuku5puGAt0CC02dDDMHRUWHanhJCI3ecyuByUkJ+I4LXmCryP5SzNPN6ZQn0M=;
X-UUID: 9b12133b8c1b4633a50d50bb56699ca5-20200817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1270104413; Mon, 17 Aug 2020 14:08:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 14:08:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 14:08:40 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] Add mediatek codec mt6359 driver
Date: Mon, 17 Aug 2020 14:07:33 +0800
Message-ID: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, shane.chien@mediatek.com,
 howie.huang@mediatek.com, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 tzungbi@google.com, linux-mediatek@lists.infradead.org, eason.yen@mediatek.com,
 bicycle.tsai@mediatek.com, linux-arm-kernel@lists.infradead.org
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

QWRkIG1lZGlhdGVrIGNvZGVjIChNVDYzNTkpIGRyaXZlcg0KDQpNVDYzNTkgc3VwcG9ydCBwbGF5
YmFjayBhbmQgY2FwdHVyZSBmZWF0dXJlLg0KDQpPbiBkb3dubGluayBwYXRoLCBpdCBpbmNsdWRl
cyB0aHJlZSBEQUNzIGZvciBoYW5kc2V0LCBoZWFkc2V0LA0KYW5kIGxpbmVvdXQgcGF0aC4gT24g
dW5saW5rIHBhdGgsIGl0IGluY2x1ZGVkcyB0aHJlZSBBRENzIGZvcg0KbWFpbiBtaWMsIHNlY29u
ZCBtaWMsIDNyZCBtaWMsIGFuZCBoZWFkc2V0IG1pYy4NCg0KQnkgc2NlbmFyaW8sIHNlbGVjdCAq
X01VWCB3aWRnZXQgdG8gY3JlYXRlIGRhbXAgcGF0aC4NCkFuZCBieSBzZWxlY3QgbWljX3R5cGVf
bXV4IHRvIGNob29zZSBETUlDL0FNSUMvLi4uLg0KDQpGb3IgZXhhbXBsZSwgc2VsZWN0IHRoZXNl
IE1VWCB3aWRnZXQgdG8gY3JlYXRlIGhlYWRzZXQgcGF0aA0KKDEpIERBQyBJbiBNdXggLS0+ICJO
b3JtYWwgUGF0aCINCigyKSBIUCBNdXggLS0+ICJBdWRpbyBQbGF5YmFjayINCg0KdjUgY2hhbmdl
czoNCgkxLiBEb24ndCBuZWVkIHRvIHVucmVnaXN0ZXIgdGhlIGNvbXBvbmVudCB3aGljaCBpcyBh
bHJlYWR5IHJlbGVnYXRlZCB0byBkZXZtLg0KDQp2NCBjaGFuZ2VzOg0KCTEuIEFkZCBhIHJlbW92
ZSgpIGZ1bmN0aW9uIHRvIHVuZG8gcmVndWxhdG9yX2VuYWJsZSgpLg0KCTIuIFJlbW92ZWQgdW5u
ZWNlc3NhcnkgbG9ncy4NCgkzLiBwYXRjaHdvcmsgbGluazoNCgkJaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9jb3Zlci8xMTcxNTU1My8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMTcxNjAxNS8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MTcxNTU1Ny8NCnYzIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MTQyOTEvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MTQyOTUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cGF0Y2gvMTE3MTQzMzkvDQoNCnYyIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MDY5MzUvDQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MDg4NjUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MDY5MzcvDQoNCnYxIGNoYW5nZXM6DQoJMS5sa21sIGxpbms6DQoJ
CWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMvNS8xMjU3DQoNCkppYXhpbiBZdSAoMik6DQog
IEFTb0M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkcml2ZXINCiAgZHQtYmluZGluZ3M6
IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkb2N1bWVudA0KDQogLi4uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgICAgICAgfCAgIDY4ICsNCiBzb3VuZC9zb2Mv
Y29kZWNzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDggKw0KIHNvdW5k
L3NvYy9jb2RlY3MvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQog
c291bmQvc29jL2NvZGVjcy9tdDYzNTkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyNzUz
ICsrKysrKysrKysrKysrKysrKysrDQogc291bmQvc29jL2NvZGVjcy9tdDYzNTkuaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyNjQwICsrKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNo
YW5nZWQsIDU0NzEgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgc291bmQvc29jL2NvZGVjcy9tdDYzNTkuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3Vu
ZC9zb2MvY29kZWNzL210NjM1OS5oDQoNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

