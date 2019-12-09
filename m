Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D60C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1A3205C9
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FZG5GfZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1A3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C64E1663;
	Mon,  9 Dec 2019 19:37:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C64E1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575916729;
	bh=v+72pmE7V+zFPv63kxvrGYi1FSf08ltTqydWQwBxAlU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZG5GfZUrANFr5/irI++aHaLPalh9FyRNPlVT7FZ91rnD2+pMiPe/xSHqJ/pV93lo
	 l0uUqYfM+DkqXMGLVDMyOhIGyAJGM4JqOjklRpfU1V30P3r+3kAigR4Sw0DrJsJt0v
	 Ul/ySvmzw66EZBFab7r2o/c/aVsaTv8ldzb1c17Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 074FBF80273;
	Mon,  9 Dec 2019 19:35:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D806F80259; Mon,  9 Dec 2019 19:35:32 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
 by alsa1.perex.cz (Postfix) with ESMTP id 16122F800C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:35:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16122F800C4
Received: from zenbar.fritz.box (pD95EF75D.dip0.t-ipconnect.de [217.94.247.93])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 710322E5CDD;
 Mon,  9 Dec 2019 18:29:04 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Date: Mon,  9 Dec 2019 19:35:02 +0100
Message-Id: <20191209183511.3576038-3-daniel@zonque.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209183511.3576038-1-daniel@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
MIME-Version: 1.0
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com,
 robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com,
 lee.jones@linaro.org, Daniel Mack <daniel@zonque.org>
Subject: [alsa-devel] [PATCH 02/10] dt-bindings: i2c: Add documentation for
	ad242x i2c controllers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

VGhpcyBkZXZpY2UgbXVzdCBiZSBwbGFjZWQgYXMgYSBzdWItZGV2aWNlIG9mIGFuIEFEMjQyeCBN
RkQgbm9kZS4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBNYWNrIDxkYW5pZWxAem9ucXVlLm9yZz4K
LS0tCiAuLi4vYmluZGluZ3MvaTJjL2FkaSxhZDI0MngtaTJjLnlhbWwgICAgICAgICAgfCAzMSAr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvYWRp
LGFkMjQyeC1pMmMueWFtbAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pMmMvYWRpLGFkMjQyeC1pMmMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pMmMvYWRpLGFkMjQyeC1pMmMueWFtbApuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwMDAwMDAuLmRlZDkyZjhhNzkxYgotLS0gL2Rldi9udWxsCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvYWRpLGFkMjQyeC1pMmMueWFtbApAQCAt
MCwwICsxLDMxIEBACisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0Qt
Mi1DbGF1c2UpCislWUFNTCAxLjIKKy0tLQorJGlkOiAiaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvaTJjL2FkaSxhZDI0MngtaTJjLnlhbWwjIgorJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyIKKwordGl0bGU6IEFuYWxvZyBEZXZpY2Vz
IEFEMjQyeCBJMkMgY29udHJvbGxlcgorCittYWludGFpbmVyczoKKyAgLSBEYW5pZWwgTWFjayA8
ZGFuaWVsQHpvbnF1ZS5vcmc+CisKK2FsbE9mOgorICAtICRyZWY6IC9zY2hlbWFzL2kyYy9pMmMt
Y29udHJvbGxlci55YW1sIworCitkZXNjcmlwdGlvbjogfAorICBUaGlzIG1vZHVsZSBpcyBwYXJ0
IG9mIHRoZSBBRDI0MnggTUZEIGRldmljZS4gRm9yIG1vcmUgZGV0YWlscyBhbmQgYW4gZXhhbXBs
ZQorICByZWZlciB0byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FkMjQy
eC55YW1sLgorCitwcm9wZXJ0aWVzOgorICBjb21wYXRpYmxlOgorICAgIGVudW06CisgICAgICAt
IGFkaSxhZDI0Mjh3LWkyYworCisgIGNsb2NrLWZyZXF1ZW5jeToKKyAgICAkcmVmOiAnL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyJworICAgIGRlZmF1bHQ6IDEwMDAwMAor
ICAgIGVudW06IFsxMDAwMDAsIDQwMDAwMF0KKyAgICBkZXNjcmlwdGlvbjogU3BlY2lmaWVzIHRo
ZSBJwrJDIGNsb2NrIGZyZXF1ZW5jeSBpbiBIei4KKworcmVxdWlyZWQ6CisgIC0gY29tcGF0aWJs
ZQotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
