Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4EC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:54:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C30206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qSfD2ucN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hb4rp7h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C30206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ABAE1684;
	Thu, 20 Aug 2020 10:54:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ABAE1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597913693;
	bh=j8a9SVlwQsp8owy5SXHZ0yPh88UDv3/JzrMYfl377bU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSfD2ucNpS4jaSNnjKNZhbDnielVUknp0PQymAfo3hHwqNJKMMSITAtdOKTYdWWgL
	 NdtDrQqfa7WBOI68IBUU4ARQccwvS9x0rWyclLJbKcZ+OuOuNe7ahDMd0RjuPbLfNh
	 o4APimx/Cxm5n8Ail89ZjZ7H41B4a3Om3b4FbXO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA21BF80279;
	Thu, 20 Aug 2020 10:53:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8ADFCF8023F; Thu, 20 Aug 2020 10:53:08 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id AD719F800D3
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 10:52:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD719F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="Hb4rp7h/"
X-UUID: dc3d8367abaf43aaab8be3bd47665bd5-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=j8a9SVlwQsp8owy5SXHZ0yPh88UDv3/JzrMYfl377bU=; 
 b=Hb4rp7h/vaVZO7ISl2iGdF8kYsR2JY82xan4aQCOp/99fOCGO5u4AzXJjkRp5oC71wRyppf8KmtOH65FsoVO8iEnVTilFMpsWS5UxlJlI6NNDUUBbyV1wdEIzXboa8ftbo2xbu+V1LKbFUceCNKSpPjEeQAzVCfyG4s+yYTNT7Y=;
X-UUID: dc3d8367abaf43aaab8be3bd47665bd5-20200820
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1651412918; Thu, 20 Aug 2020 16:52:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 16:52:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 16:52:45 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: mediatek: mt6359: add codec document
Date: Thu, 20 Aug 2020 16:51:33 +0800
Message-ID: <1597913493-10747-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597913493-10747-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1597913493-10747-1-git-send-email-jiaxin.yu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIE1lZGlhVGVrIE1UNjM1OSBjb2RlYyBkb2N1bWVudC4NCg0KU2lnbmVk
LW9mZi1ieTogSmlheGluIFl1IDxqaWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgIHwgNjEgKysrKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDYzNTkueWFt
bA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5k
L210NjM1OS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
NjM1OS55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwMC4uYTU0
ZjQ2NmY3NjlkNA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL210NjM1OS55YW1sDQpAQCAtMCwwICsxLDYxIEBADQorIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbXQ2MzU5LnlhbWwjDQorJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1l
ZGlhdGVrIE1UNjM1OSBDb2RlYyBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KKw0KK21haW50YWluZXJz
Og0KKyAgLSBFYXNvbiBZZW4gPGVhc29uLnllbkBtZWRpYXRlay5jb20+DQorICAtIEppYXhpbiBZ
dSA8amlheGluLnl1QG1lZGlhdGVrLmNvbT4NCisgIC0gU2hhbmUgQ2hpZW4gPHNoYW5lLmNoaWVu
QG1lZGlhdGVrLmNvbT4NCisNCitkZXNjcmlwdGlvbjogfA0KKyAgVGhlIGNvbW11bmljYXRpb24g
YmV0d2VlbiBNVDYzNTkgYW5kIFNvQyBpcyB0aHJvdWdoIE1lZGlhdGVrIFBNSUMgd3JhcHBlci4N
CisgIEZvciBtb3JlIGRldGFpbCwgcGxlYXNlIHZpc2l0IE1lZGlhdGVrIFBNSUMgd3JhcHBlciBk
b2N1bWVudGF0aW9uLg0KKyAgTXVzdCBiZSBhIGNoaWxkIG5vZGUgb2YgUE1JQyB3cmFwcGVyLg0K
Kw0KK3Byb3BlcnRpZXM6DQorICBtZWRpYXRlayxkbWljLW1vZGU6DQorICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KKyAgICBkZXNjcmlwdGlvbjogfA0K
KyAgICAgIEluZGljYXRlcyBob3cgbWFueSBkYXRhIHBpbnMgYXJlIHVzZWQgdG8gdHJhbnNtaXQg
dHdvIGNoYW5uZWxzIG9mIFBETQ0KKyAgICAgIHNpZ25hbC4gMCBtZWFucyB0d28gd2lyZXMsIDEg
bWVhbnMgb25lIHdpcmUuIERlZmF1bHQgdmFsdWUgaXMgMC4NCisgICAgZW51bToNCisgICAgICAt
IDAgIyBvbmUgd2lyZQ0KKyAgICAgIC0gMSAjIHR3byB3aXJlcw0KKw0KKyAgbWVkaWF0ZWssbWlj
LXR5cGUtMDoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgU3BlY2lmaWVzIHRoZSB0eXBlIG9mIG1p
YyB0eXBlIGNvbm5lY3RlZCB0byBhZGMwDQorDQorICAgIGVudW06DQorICAgICAgLSAwICMgSURM
RSAtIG1pYyBpbiB0dXJuLW9mZiBzdGF0dXMNCisgICAgICAtIDEgIyBBQ0MgLSBhbmFsb2cgbWlj
IHdpdGggYWx0ZXJuYXRpbmcgY291cGxpbmcNCisgICAgICAtIDIgIyBETUlDIC0gZGlnaXRhbCBt
aWMNCisgICAgICAtIDMgIyBEQ0MgLSBhbmFsb2cgbWljIHdpdGggZGlyZWN0IGNvdXBpbmcNCisg
ICAgICAtIDQgIyBEQ0NfRUNNX0RJRkYgLSBhbmFsb2cgZWxlY3RyZXQgY29uZGVuc2VyIG1pYyB3
aXRoIGRpZmZlcmVudGlhbCBtb2RlDQorICAgICAgLSA1ICMgRENDX0VDTV9TSU5HTEUgLSBhbmFs
b2cgZWxlY3RyZXQgY29uZGVuc2VyIG1pYyB3aXRoIHNpbmdsZSBtb2RlDQorDQorICBtZWRpYXRl
ayxtaWMtdHlwZS0xOg0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBTcGVjaWZpZXMgdGhlIHR5cGUg
b2YgbWljIHR5cGUgY29ubmVjdGVkIHRvIGFkYzENCisNCisgIG1lZGlhdGVrLG1pYy10eXBlLTI6
DQorICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KKyAg
ICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFNwZWNpZmllcyB0aGUgdHlwZSBvZiBtaWMgdHlwZSBj
b25uZWN0ZWQgdG8gYWRjMg0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgIG10NjM1OWNvZGVjOiBtdDYzNTljb2RlYyB7DQorICAgICAg
bWVkaWF0ZWssZG1pYy1tb2RlID0gPDA+Ow0KKyAgICAgIG1lZGlhdGVrLG1pYy10eXBlLTAgPSA8
Mj47DQorICAgIH07DQorDQorLi4uDQotLSANCjIuMTguMA0K

