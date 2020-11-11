Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA345C388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 02:46:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F0620759
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 02:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="br1HCdaJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ph9dz+a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F0620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42E971729;
	Wed, 11 Nov 2020 03:45:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42E971729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605062799;
	bh=IcCu3+Zc2n3kYPQu033Mn4Z4XaeAhwPBlnreV28pxOQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=br1HCdaJtKzeF8ytLa19dJRRkW//QpJH7YyvWgXagOLXJEtcJ4naVALhu+pM5sKBY
	 m34bzKi83iQ0apc4l8rugdoG3KXQQSFhtUMIuUJ2Tr05cwzQVndsP1B7W/lcjuQdjD
	 lQEYKr6VbVyyymIE0yXxZzK/cNC11r7iVgQR8ZB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1F6EF801F5;
	Wed, 11 Nov 2020 03:45:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE35FF8020C; Wed, 11 Nov 2020 03:45:41 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id 6EF68F8007E
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 03:45:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EF68F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="Ph9dz+a2"
X-UUID: 35bbd99d68cf4914a39cba7b28e5385a-20201111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=IcCu3+Zc2n3kYPQu033Mn4Z4XaeAhwPBlnreV28pxOQ=; 
 b=Ph9dz+a2wcPaenoN1rUt8b/zc8I9AdPs08WA7iVq95BA+XmUSDv//oiiATFYxRT7nSJ52qVYo9OD1w5uYw5L8bHUKRmox2OdeE1V+vpGV//XkBHhqHee3/4sH25FN+JjuLS0Kn3NeLk/9lEnJmRNcUk742/Ly6jv05FBWFuWzpw=;
X-UUID: 35bbd99d68cf4914a39cba7b28e5385a-20201111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1493458854; Wed, 11 Nov 2020 10:45:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 10:45:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 10:45:23 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
 <tzungbi@google.com>, <alsa-devel@alsa-project.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] ASoC: mediatek: mt8192: skip first time data at the
 beginning of DMIC recording
Date: Wed, 11 Nov 2020 10:45:22 +0800
Message-ID: <1605062722-8711-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Content-Transfer-Encoding: base64
Cc: shane.chien@mediatek.com, Trevor.Wu@mediatek.com,
 Jiaxin Yu <jiaxin.yu@mediatek.com>
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

V2UgY2FuIGNob29zZSB0byBkcm9wIGF3YXkgYW55IGxlbmd0aCBvZiBkYXRhIGZyb20gdGhlIGJl
Z2lubmluZyBhY2NvcmRpbmcNCnRvIHByb2plY3QgbmVlZHMuIFNvbWUgcHJvamVjdHMgZG9uJ3Qg
d2FudCB0byB0aHJvdyBhd2F5IGFueSBkYXRhLCBiZWNhdXNlDQp0aGV5IHdhbnQgdG8gdXNlIHJl
Y29yZGVkIGRhdGEgdG8gZG8gZWNobyBjYW5jZWxsYXRpb24sIHNvIHRoZXkgaGF2ZSB0bw0KbWFr
ZSBzdXJlIHRoYXQgdGhleSBhcmUgYWxpZ25lZCB3aXRoIHRoZSByZWZlcmVuY2UgZGF0YSBhcyBt
dWNoIGFzDQpwb3NzaWJsZS4gT3IgdGhlcmUgYXJlIG90aGVyIGFsZ29yaXRobXMgaW4gdGhlIHVw
cGVyIGxheWVyIHRvIGVsaW1pbmF0ZQ0KdGhpcyBub2lzZS4gT3Igc29tZSBwcm9qZWN0cyB3YW50
IHRvIGVsaW1pbmF0ZSB0aGlzIG5vaXNlIGZvcm0gdGhlIGtlcm5lbA0KbGF5ZXIuIEhvd2V2ZXIs
IHRoZSBtaW5pbXVtIHJlY29tbWVuZGVkIHZhbHVlIGlzIDUwbXMgdG8gc2tpcCBwb3Agbm9pc2Uu
DQoNClNpZ25lZC1vZmYtYnk6IEppYXhpbiBZdSA8amlheGluLnl1QG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIFRoaXMgc2VlbXMgbGlrZSBzb21ldGhpbmcgdGhhdCB3b3VsZCBhcHBseSBlcXVhbGx5IHRv
IGFsbCBETUlDcyBzbyBzaG91bGQNCiBiZSBkb25lIGF0IGEgbW9yZSBnZW5lcmFsIGxldmVsLCBz
byB3ZSBpbXBsZW1lbnQgaXQgaW4gdGhlIERNSUMgZHJpdmVyLg0KDQogc291bmQvc29jL21lZGlh
dGVrL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKw0KIHNvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLW10NjM1OS1ydDEwMTUtcnQ1NjgyLmMgfCA0ICsrKy0N
CiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL0tjb25maWcgYi9zb3VuZC9zb2MvbWVkaWF0ZWsv
S2NvbmZpZw0KaW5kZXggZGM2MjhmYjZjMTAyNS4uMzFmMTQzMWJmNTc5MiAxMDA2NDQNCi0tLSBh
L3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQorKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvS2Nv
bmZpZw0KQEAgLTE3NSw2ICsxNzUsNyBAQCBjb25maWcgU05EX1NPQ19NVDgxOTJfTVQ2MzU5X1JU
MTAxNV9SVDU2ODINCiAJc2VsZWN0IFNORF9TT0NfTVQ2MzU5DQogCXNlbGVjdCBTTkRfU09DX1JU
MTAxNQ0KIAlzZWxlY3QgU05EX1NPQ19SVDU2ODJfSTJDDQorCXNlbGVjdCBTTkRfU09DX0RNSUMN
CiAJaGVscA0KIAkgIFRoaXMgYWRkcyBBU29DIGRyaXZlciBmb3IgTWVkaWF0ZWsgTVQ4MTkyIGJv
YXJkcw0KIAkgIHdpdGggdGhlIE1UNjM1OSBSVDEwMTUgUlQ1NjgyIGF1ZGlvIGNvZGVjLg0KZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLW10NjM1OS1ydDEwMTUt
cnQ1NjgyLmMgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1tdDYzNTktcnQxMDE1
LXJ0NTY4Mi5jDQppbmRleCA0MWQ4YTg1NjdiYjM4Li5iN2Y0MmE1MzBkMDY5IDEwMDY0NA0KLS0t
IGEvc291bmQvc29jL21lZGlhdGVrL210ODE5Mi9tdDgxOTItbXQ2MzU5LXJ0MTAxNS1ydDU2ODIu
Yw0KKysrIGIvc291bmQvc29jL21lZGlhdGVrL210ODE5Mi9tdDgxOTItbXQ2MzU5LXJ0MTAxNS1y
dDU2ODIuYw0KQEAgLTU0MCw3ICs1NDAsOSBAQCBTTkRfU09DX0RBSUxJTktfREVGUyhwbGF5YmFj
a19oZG1pLA0KIFNORF9TT0NfREFJTElOS19ERUZTKHByaW1hcnlfY29kZWMsDQogCQkgICAgIERB
SUxJTktfQ09NUF9BUlJBWShDT01QX0NQVSgiQUREQSIpKSwNCiAJCSAgICAgREFJTElOS19DT01Q
X0FSUkFZKENPTVBfQ09ERUMoIm10NjM1OS1zb3VuZCIsDQotCQkJCQkJICAgIm10NjM1OS1zbmQt
Y29kZWMtYWlmMSIpKSwNCisJCQkJCQkgICAibXQ2MzU5LXNuZC1jb2RlYy1haWYxIiksDQorCQkJ
CQlDT01QX0NPREVDKCJkbWljLWNvZGVjIiwNCisJCQkJCQkgICAiZG1pYy1oaWZpIikpLA0KIAkJ
ICAgICBEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9FTVBUWSgpKSk7DQogDQogU05EX1NPQ19EQUlM
SU5LX0RFRlMocHJpbWFyeV9jb2RlY19jaDM0LA0KLS0gDQoyLjE4LjANCg==

