Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64239C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:10:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE61D20578
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aRhqGNuS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X+46Cv5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE61D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C963166F;
	Mon, 17 Aug 2020 08:09:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C963166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597644647;
	bh=OMz37gOAxaQvFwxexPGW4hcF8dck1+hS2ciqWaMRiLc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aRhqGNuScNGKKcZfsmUmpvSBmy6NXuVaLRoL5/q/zgbnvVlWmKyuK0ofpBYfE+eZi
	 meqS3eD54ZGxc03uqW0ieH/3nlkfpdBO53ASPGtHwPxwjfl3NIh+GF1cAqDvSYMGoT
	 sOdPjF1vU7aUc+0K7AAO1iHcWx/DQ6LJ7pbFSF1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 645DEF8025A;
	Mon, 17 Aug 2020 08:09:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97769F80255; Mon, 17 Aug 2020 08:09:03 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id 5D7B9F800D3
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 08:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D7B9F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="X+46Cv5t"
X-UUID: 3cb821007de94198ad367d5e91840d0f-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=OMz37gOAxaQvFwxexPGW4hcF8dck1+hS2ciqWaMRiLc=; 
 b=X+46Cv5tayRIT733QuTQ+oKbthRXNa7oNkrvmwJQgbcjJt4zAlwMFj/ubwp3te3xCTnPSDzy+5cg91biX4Qijhrvs1vqUAOUb/Q2fCQZZTXjTXxPQTeRG5FGhVVSZGs6ApWUg95cy1DikYs8yORNfZ3sEjCssk/MN9fXt9yLE5o=;
X-UUID: 3cb821007de94198ad367d5e91840d0f-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 137716927; Mon, 17 Aug 2020 14:08:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 14:08:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 14:08:43 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
Date: Mon, 17 Aug 2020 14:07:35 +0800
Message-ID: <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIE1lZGlhVGVrIE1UNjM1OSBjb2RlYyBkb2N1bWVudC4NCg0KU2lnbmVk
LW9mZi1ieTogSmlheGluIFl1IDxqaWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgICAgICAgfCA2OCArKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
NjM1OS55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc291bmQvbXQ2MzU5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbXQ2MzU5LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5h
NjY5YjQ5DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwNCkBAIC0wLDAgKzEsNjggQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tdDYzNTkueWFtbCMNCiskc2NoZW1hOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTWVkaWF0
ZWsgTVQ2MzU5IENvZGVjIERldmljZSBUcmVlIEJpbmRpbmdzDQorDQorbWFpbnRhaW5lcnM6DQor
ICAtIEVhc29uIFllbiA8ZWFzb24ueWVuQG1lZGlhdGVrLmNvbT4NCisgIC0gSmlheGluIFl1IDxq
aWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KKyAgLSBTaGFuZSBDaGllbiA8c2hhbmUuY2hpZW5AbWVk
aWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBUaGUgY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIE1UNjM1OSBhbmQgU29DIGlzIHRocm91Z2ggTWVkaWF0ZWsgUE1JQyB3cmFwcGVyLg0KKyAg
Rm9yIG1vcmUgZGV0YWlsLCBwbGVhc2UgdmlzaXQgTWVkaWF0ZWsgUE1JQyB3cmFwcGVyIGRvY3Vt
ZW50YXRpb24uDQorICBNdXN0IGJlIGEgY2hpbGQgbm9kZSBvZiBQTUlDIHdyYXBwZXIuDQorDQor
cHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBtZWRpYXRlayxtdDYzNTkt
c291bmQNCisNCisgIG1lZGlhdGVrLGRtaWMtbW9kZToNCisgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAg
SW5kaWNhdGVzIGhvdyBtYW55IGRhdGEgcGlucyBhcmUgdXNlZCB0byB0cmFuc21pdCB0d28gY2hh
bm5lbHMgb2YgUERNDQorICAgICAgc2lnbmFsLiAwIG1lYW5zIHR3byB3aXJlcywgMSBtZWFucyBv
bmUgd2lyZS4gRGVmYXVsdCB2YWx1ZSBpcyAwLg0KKyAgICBlbnVtOg0KKyAgICAgIC0gMCAjIG9u
ZSB3aXJlDQorICAgICAgLSAxICMgdHdvIHdpcmVzDQorDQorICBtZWRpYXRlayxtaWMtdHlwZS0w
Og0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCisg
ICAgZGVzY3JpcHRpb246IHwNCisgICAgICBTcGVjaWZpZXMgdGhlIHR5cGUgb2YgbWljIHR5cGUg
Y29ubmVjdGVkIHRvIGFkYzANCisNCisgICAgZW51bToNCisgICAgICAtIDAgIyBJRExFIC0gbWlj
IGluIHR1cm4tb2ZmIHN0YXR1cw0KKyAgICAgIC0gMSAjIEFDQyAtIGFuYWxvZyBtaWMgd2l0aCBh
bHRlcm5hdGluZyBjb3VwbGluZw0KKyAgICAgIC0gMiAjIERNSUMgLSBkaWdpdGFsIG1pYw0KKyAg
ICAgIC0gMyAjIERDQyAtIGFuYWxvZyBtaWMgd2l0aCBkaXJlY3QgY291cGluZw0KKyAgICAgIC0g
NCAjIERDQ19FQ01fRElGRiAtIGFuYWxvZyBlbGVjdHJldCBjb25kZW5zZXIgbWljIHdpdGggZGlm
ZmVyZW50aWFsIG1vZGUNCisgICAgICAtIDUgIyBEQ0NfRUNNX1NJTkdMRSAtIGFuYWxvZyBlbGVj
dHJldCBjb25kZW5zZXIgbWljIHdpdGggc2luZ2xlIG1vZGUNCisNCisgIG1lZGlhdGVrLG1pYy10
eXBlLTE6DQorICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQz
Mg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFNwZWNpZmllcyB0aGUgdHlwZSBvZiBtaWMg
dHlwZSBjb25uZWN0ZWQgdG8gYWRjMQ0KKw0KKyAgbWVkaWF0ZWssbWljLXR5cGUtMjoNCisgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2Ny
aXB0aW9uOiB8DQorICAgICAgU3BlY2lmaWVzIHRoZSB0eXBlIG9mIG1pYyB0eXBlIGNvbm5lY3Rl
ZCB0byBhZGMyDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisNCithZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBtdDYzNTljb2Rl
YzogbXQ2MzU5Y29kZWMgew0KKyAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzU5LXNv
dW5kIjsNCisgICAgICBtZWRpYXRlayxkbWljLW1vZGUgPSA8MD47DQorICAgICAgbWVkaWF0ZWss
bWljLXR5cGUtMCA9IDwyPjsNCisgICAgfTsNCisNCisuLi4NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

