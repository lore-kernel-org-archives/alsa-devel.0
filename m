Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB3C2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:02:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBB621D40
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PPcbNWbS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XHjZTwak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBB621D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4025917F0;
	Tue,  3 Nov 2020 09:01:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4025917F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604390526;
	bh=3AjCwyELXJsAF7KDdOI9+UHESz6oEunbkSh/sKmq2DQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PPcbNWbSIV8hfNU8B7O5rjKbSh7kDMtRUKJ5bZwpbHGevUzr32fsR2YFs50LmGCJb
	 DzwjtDdyMSA8Tb1kHwFOxtvPaJf6/gZy786O6Tnm6DExk7fi7uELpfIHvzngN9/LaR
	 8Vwdx2jocZ0WGS2FC1y9zm/ufts/OT8oUQvrb1dM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28359F8056F;
	Tue,  3 Nov 2020 09:00:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1DEEF804E4; Tue,  3 Nov 2020 09:00:10 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id DFE63F80279
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 08:59:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFE63F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="XHjZTwak"
X-UUID: b49463b3748547fb9ab577f9d8370c87-20201103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=3AjCwyELXJsAF7KDdOI9+UHESz6oEunbkSh/sKmq2DQ=; 
 b=XHjZTwakj15FEalg7d7rD3uLi0JUIxFv/WdWqmjKj1Ef4mxFoJJrrt0Axuq2OvQtf/AVeglMFAbCd2dcXKPbSxAGw3CKgwKVccrGh8i9PmV3gIr/ltKDCr2bjdkyAGl+7/SKeAgNKwuV9UBj3gSHs4+YEtkSs4lgkuB+QyGMPgo=;
X-UUID: b49463b3748547fb9ab577f9d8370c87-20201103
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1619352867; Tue, 03 Nov 2020 15:59:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Nov 2020 15:59:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 15:59:48 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
 <robh+dt@kernel.org>, <p.zabel@pengutronix.de>, <tzungbi@google.com>,
 <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 7/9] dt-bindings: mediatek: mt8192: add audio afe document
Date: Tue, 3 Nov 2020 15:59:36 +0800
Message-ID: <1604390378-23993-8-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Content-Transfer-Encoding: base64
Cc: shane.chien@mediatek.com, Bicycle.Tsai@mediatek.com,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Trevor.Wu@mediatek.com,
 kuninori.morimoto.gx@renesas.com
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

VGhpcyBwYXRjaCBhZGRzIG10ODE5MiBhdWRpbyBhZmUgZG9jdW1lbnQuDQoNClNpZ25lZC1vZmYt
Ynk6IEppYXhpbiBZdSA8amlheGluLnl1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KVGhpcyBwYXRjaCBk
ZXBlbmRzIG9uIGZvbGxvd2luZyBzZXJpZXMgdGhhdCBoYXMgbm90IGJlZW4gYWNjZXB0ZWQ6DQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExNzUyMjMxDQooZHQtYmluZGluZ3Mv
Y2xvY2svbXQ4MTkyLWNsay5oIGlzIGluY2x1ZGVkIGluIGl0LikNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTE3NTU4OTUNCihkdC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93
ZXIuaCBpcyBpbmNsdWRlZCBpbiBpdC4pDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdv
cmsvcGF0Y2gvMTMyMTExOA0KKGR0LWJpbmRpbmdzL3Jlc2V0LWNvbnRyb2xsZXIvbXQ4MTkyLXJl
c2V0cy5oIGlzIGluY2x1ZGVkIGluIGl0LikNCg0KIC4uLi9iaW5kaW5ncy9zb3VuZC9tdDgxOTIt
YWZlLXBjbS55YW1sICAgICAgICB8IDEwMCArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMTAwIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE5Mi1hZmUtcGNtLnlhbWwNCg0KZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxOTItYWZl
LXBjbS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE5
Mi1hZmUtcGNtLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAw
Li4wMTcwYzkzODAyZDI5DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4MTkyLWFmZS1wY20ueWFtbA0KQEAgLTAsMCArMSwxMDAg
QEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL3NvdW5kL210ODE5Mi1hZmUtcGNtLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhdGVrIEFGRSBQ
Q00gY29udHJvbGxlciBmb3IgbXQ4MTkyDQorDQorbWFpbnRhaW5lcnM6DQorICAgLSBKaWF4aW4g
WXUgPGppYXhpbi55dUBtZWRpYXRlay5jb20+DQorICAgLSBTaGFuZSBDaGllbiA8c2hhbmUuY2hp
ZW5AbWVkaWF0ZWsuY29tPg0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICAg
IGNvbnN0OiBtZWRpYXRlayxtdDgxOTItYXVkaW8NCisNCisgIGludGVycnVwdHM6DQorICAgIG1h
eEl0ZW1zOiAxDQorDQorICByZXNldHM6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICByZXNldC1u
YW1lczoNCisgICAgY29uc3Q6IGF1ZGlvc3lzDQorDQorICBtZWRpYXRlayxhcG1peGVkc3lzOg0K
KyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSINCisg
ICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9mIHRoZSBtZWRpYXRlayBhcG1peGVkc3lzIGNv
bnRyb2xsZXINCisNCisgIG1lZGlhdGVrLGluZnJhY2ZnOg0KKyAgICAkcmVmOiAiL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSINCisgICAgZGVzY3JpcHRpb246IFRoZSBw
aGFuZGxlIG9mIHRoZSBtZWRpYXRlayBpbmZyYWNmZyBjb250cm9sbGVyDQorDQorICBtZWRpYXRl
ayx0b3Bja2dlbjoNCisgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3BoYW5kbGUiDQorICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUgbWVkaWF0ZWsg
dG9wY2tnZW4gY29udHJvbGxlcg0KKw0KKyAgcG93ZXItZG9tYWluczoNCisgICAgbWF4SXRlbXM6
IDENCisNCisgIGNsb2NrczoNCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogQUZF
IGNsb2NrDQorICAgICAgLSBkZXNjcmlwdGlvbjogQUREQSBEQUMgY2xvY2sNCisgICAgICAtIGRl
c2NyaXB0aW9uOiBBRERBIERBQyBwcmUtZGlzdG9ydGlvbiBjbG9jaw0KKyAgICAgIC0gZGVzY3Jp
cHRpb246IGF1ZGlvIGluZnJhIHN5cyBjbG9jaw0KKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlv
IGluZnJhIDI2TSBjbG9jaw0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAg
IC0gY29uc3Q6IGF1ZF9hZmVfY2xrDQorICAgICAgLSBjb25zdDogYXVkX2RhY19jbGsNCisgICAg
ICAtIGNvbnN0OiBhdWRfZGFjX3ByZWRpc19jbGsNCisgICAgICAtIGNvbnN0OiBhdWRfaW5mcmFf
Y2xrDQorICAgICAgLSBjb25zdDogYXVkX2luZnJhXzI2bV9jbGsNCisNCityZXF1aXJlZDoNCisg
IC0gY29tcGF0aWJsZQ0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIHJlc2V0cw0KKyAgLSByZXNldC1u
YW1lcw0KKyAgLSBtZWRpYXRlayxhcG1peGVkc3lzDQorICAtIG1lZGlhdGVrLGluZnJhY2ZnDQor
ICAtIG1lZGlhdGVrLHRvcGNrZ2VuDQorICAtIHBvd2VyLWRvbWFpbnMNCisgIC0gY2xvY2tzDQor
ICAtIGNsb2NrLW5hbWVzDQorDQorYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhh
bXBsZXM6DQorICAtIHwNCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210ODE5Mi1j
bGsuaD4NCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fy
bS1naWMuaD4NCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2lycS5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmg+
DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC1jb250cm9sbGVyL210ODE5Mi1yZXNl
dHMuaD4NCisNCisgICAgYWZlOiBtdDgxOTItYWZlLXBjbSB7DQorICAgICAgICBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Mi1hdWRpbyI7DQorICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgMjAyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKyAgICAgICAgcmVzZXRzID0gPCZ3YXRjaGRv
ZyBNVDgxOTJfVE9QUkdVX0FVRElPX1NXX1JTVD47DQorICAgICAgICByZXNldC1uYW1lcyA9ICJh
dWRpb3N5cyI7DQorICAgICAgICBtZWRpYXRlayxhcG1peGVkc3lzID0gPCZhcG1peGVkc3lzPjsN
CisgICAgICAgIG1lZGlhdGVrLGluZnJhY2ZnID0gPCZpbmZyYWNmZz47DQorICAgICAgICBtZWRp
YXRlayx0b3Bja2dlbiA9IDwmdG9wY2tnZW4+Ow0KKyAgICAgICAgcG93ZXItZG9tYWlucyA9IDwm
c2Nwc3lzIE1UODE5Ml9QT1dFUl9ET01BSU5fQVVESU8+Ow0KKyAgICAgICAgY2xvY2tzID0gPCZh
dWRzeXMgQ0xLX0FVRF9BRkU+LA0KKyAgICAgICAgICAgICAgICAgPCZhdWRzeXMgQ0xLX0FVRF9E
QUM+LA0KKyAgICAgICAgICAgICAgICAgPCZhdWRzeXMgQ0xLX0FVRF9EQUNfUFJFRElTPiwNCisg
ICAgICAgICAgICAgICAgIDwmaW5mcmFjZmcgQ0xLX0lORlJBX0FVRElPPiwNCisgICAgICAgICAg
ICAgICAgIDwmaW5mcmFjZmcgQ0xLX0lORlJBX0FVRElPXzI2TV9CPjsNCisgICAgICAgIGNsb2Nr
LW5hbWVzID0gImF1ZF9hZmVfY2xrIiwNCisgICAgICAgICAgICAgICAgICAgICAgImF1ZF9kYWNf
Y2xrIiwNCisgICAgICAgICAgICAgICAgICAgICAgImF1ZF9kYWNfcHJlZGlzX2NsayIsDQorICAg
ICAgICAgICAgICAgICAgICAgICJhdWRfaW5mcmFfY2xrIiwNCisgICAgICAgICAgICAgICAgICAg
ICAgImF1ZF9pbmZyYV8yNm1fY2xrIjsNCisgICAgfTsNCisNCisuLi4NCi0tIA0KMi4xOC4wDQo=

