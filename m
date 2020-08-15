Return-Path: <SRS0=xC/7=BZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53033C433E1
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:21:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84D423B3D
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZugC5HT5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s2YBefC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84D423B3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46C8B1664;
	Sat, 15 Aug 2020 19:21:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46C8B1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597512117;
	bh=FFQUhOYLKuJ9Yfi7yGetNzlRsOXGteiFSi935u14Oys=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZugC5HT5tz5Yac0eiRW12tUy6BMkAgFAAfp97QiU9vrv7pzvDfOdchBSP1IZj0e/W
	 eg6UAaWO0OYXB6e2MRXcbvKJ40SWr4Z/WARCLTCzywMUTCeYsY4+xjdbVvSzfxO1oL
	 dNv6STf4iH7VehehVKRjPa2JHAzJmfrQ91pHX1IA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A91DAF80161;
	Sat, 15 Aug 2020 19:21:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CAD8F80162; Sat, 15 Aug 2020 19:21:04 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id BB9ADF8015B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2020 19:20:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB9ADF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="s2YBefC3"
X-UUID: b651d6f0dfa24d1eb154cf734daec80d-20200816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=FFQUhOYLKuJ9Yfi7yGetNzlRsOXGteiFSi935u14Oys=; 
 b=s2YBefC3dOWhC/CJHQtJwhvqCQ/Mw91K58GoYPpGpKmG9IyfkURn+EvYxDk6x2xw5qJMn9UPo5zkXu9yHG7N733M65kcNGfNtLU/bH1EmOUxk2STewwyjDQSbIAk70ksRz6SBJbcUb62mmu/M6Z1gN/D/Uj2i0DoGwpgpUigXlM=;
X-UUID: b651d6f0dfa24d1eb154cf734daec80d-20200816
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 691138335; Sun, 16 Aug 2020 01:20:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 16 Aug 2020 01:20:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 16 Aug 2020 01:20:41 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Add mediatek codec mt6359 driver
Date: Sun, 16 Aug 2020 01:19:38 +0800
Message-ID: <1597511980-16281-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, shane.chien@mediatek.com,
 howie.huang@mediatek.com, bicycle.tasi@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 eason.yen@mediatek.com, linux-arm-kernel@lists.infradead.org
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
b3JtYWwgUGF0aCINCigyKSBIUCBNdXggLS0+ICJBdWRpbyBQbGF5YmFjayINCg0KdjQgY2hhbmdl
czoNCgkxLiBBZGQgYSByZW1vdmUoKSBmdW5jdGlvbiB0byB1bmRvIHJlZ3VsYXRvcl9lbmFibGUo
KS4NCgkyLiBSZW1vdmVkIHVubmVjZXNzYXJ5IGxvZ3MuDQoNCnYzIGNoYW5nZXM6DQoJMS4gcGF0
Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MTQy
OTEvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MTQyOTUvDQoJCWh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MTQzMzkvDQoNCnYyIGNoYW5nZXM6
DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292
ZXIvMTE3MDY5MzUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MDg4
NjUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MDY5MzcvDQoNCnYx
IGNoYW5nZXM6DQoJMS5sa21sIGxpbms6DQoJCWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMv
NS8xMjU3DQoNCkppYXhpbiBZdSAoMik6DQogIEFTb0M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBj
b2RlYyBkcml2ZXINCiAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBk
b2N1bWVudA0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAg
IHwgICA2OCArDQogc291bmQvc29jL2NvZGVjcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
IHwgICAgOCArDQogc291bmQvc29jL2NvZGVjcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
IHwgICAgMiArDQogc291bmQvc29jL2NvZGVjcy9tdDYzNTkuYyAgICAgICAgICAgICAgICAgICAg
IHwgMjc1NSArKysrKysrKysrKysrKysrKw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmggICAg
ICAgICAgICAgICAgICAgICB8IDI2NDAgKysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdl
ZCwgNTQ3MyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDYzNTkueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBzb3VuZC9zb2MvY29kZWNzL210NjM1OS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3Nv
Yy9jb2RlY3MvbXQ2MzU5LmgNCg0KLS0gDQoyLjE4LjANCg==

