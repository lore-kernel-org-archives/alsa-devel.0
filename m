Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55AC010A2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:57:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11AA2190F
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OjTxCefR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WCHdBe6z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irV41/zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11AA2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 635A81709;
	Tue,  5 Nov 2019 11:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 635A81709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572951439;
	bh=PKHRw6wquSnDhyDpNhr/MTErGaGYBEV7R040qX91h6s=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OjTxCefR1ainFA9McVLjDKXMp91Lulorycs+YCD4vOGNIJ7R1tw0jcZpgIPVVwINP
	 abDZPLZnRx739qv47V2IDsqVkDaBbSdrcBwvL8DmjiJxLJQ8pkhltjLqw35TYJt/xG
	 pwVYTuRy0eUZCBztuwGx1zdSPGlU3ahnQ4juNt8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEAD2F80446;
	Tue,  5 Nov 2019 11:56:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4FBBF8049B; Tue,  5 Nov 2019 11:56:26 +0100 (CET)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B912F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 11:56:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B912F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="WCHdBe6z"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="irV41/zB"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 2BA575BEF;
 Tue,  5 Nov 2019 05:56:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 05 Nov 2019 05:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=A2GLNiSRYncUQfGy/8eawJsIIf
 W4xhhoTSPQkJ+iyzE=; b=WCHdBe6zwXnJe0lTS3koQfY0aAlGhoLLntHtZtSRsS
 iElCeWtsEz42MYDq9Yru3AcLHZ+5hLe78L+adZ5r/EP8SBwW8x189t85Ju6glo+X
 eegMvZ7FX9B8pe+a6UdlgUE71h37KuVzb0KVHxUZpQhkhBgqQvw082aSXdHcFOgn
 exZWkFGWKEkmyNKp4brmbYVlKGQe5enAykq9xYZVGmXCqnOFhn12DrbZBj3b0w4V
 RhAAI/FaozN0VclV5qaIGssCfAFgEE18lQf0Q8I7T06TNOID2+I0U13G9h3Hu4jZ
 lpGdjOxsOZOMV9qWJFIRfVqzxAKVpwRm7+QR/r6MYK3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=A2GLNi
 SRYncUQfGy/8eawJsIIfW4xhhoTSPQkJ+iyzE=; b=irV41/zB37Bip0m3fqgFgQ
 KRAYmTInfFMCx/9mvqY8QrLS3nK5ABtpCuKRXI78riwUY5HQdoYoie8Q1FeJ1wjP
 fayBoL3uUV2Q20tIxgjpcsPmxW9HefOoifnvjin8YzXMVPbKEclTvYXhpfOQg+pC
 p8q+Ab/dQHGIFM11eoIGjqWZCqS6sbShbC8MsKktkmPzdzlhIwCRH+4UciEOUeci
 p/rnwwWkL5NlLPW4ZfS1oAB+oDbXG/yUaXRiehUoYUGPF90/bJxEzo/w5A19Q+Fv
 4yqe7M/W2eeZztz0tpcmwASta4be5PhwSVUS4VmcL5UKfy72Ev1bwrPvU3iD9Y7g
 ==
X-ME-Sender: <xms:UlXBXV65nUTPq27rm1Xw0xxZMhUjU59MguRABLP9jAx_gkI7X2LCYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudduhedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
 ekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghr
 nhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:UlXBXfVWULtq82rtCNHPZrgHyQTF5A8I7Dhq10PenpQF4L5lDp4jWA>
 <xmx:UlXBXYc4dO51Az-M2kGlMx3pSVMGU46q9LJmFh7AyxJt31zzWvUEbw>
 <xmx:UlXBXfkGQhMDSMcMEEJP49xjZcipdKR_bXcxXgQonpiUoVfsCpQTBQ>
 <xmx:VFXBXdZABKSfbe-nN3slar21t22v8PVAQHzMda4WZOSE91Brq5GJzw>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9890F306005B;
 Tue,  5 Nov 2019 05:56:18 -0500 (EST)
From: Maxime Ripard <maxime@cerno.tech>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Date: Tue,  5 Nov 2019 11:56:15 +0100
Message-Id: <20191105105615.21391-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [alsa-devel] [PATCH v2] dt-bindings: sound: adau7118: Fix example
	warning
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

VGhlIEFEQVU3MTE4IGhhcyBhbiBleGFtcGxlIHdoZXJlIHRoZSBjb2RlYyBoYXMgYW4gaTJjIGFk
ZHJlc3Mgb2YgMTQsIGFuZAp0aGUgdW5pdCBhZGRyZXNzIHNldCB0byAxNCBhcyB3ZWxsLgoKSG93
ZXZlciwgd2hpbGUgdGhlIGFkZHJlc3MgaXMgZXhwcmVzc2VkIGluIGRlY2ltYWwsIHRoZSB1bml0
LWFkZHJlc3MgaXMKc3VwcG9zZWQgdG8gYmUgaW4gaGV4YWRlY2ltYWwsIHdoaWNoIGVuZHMgdXAg
d2l0aCB0d28gZGlmZmVyZW50IGFkZHJlc3Nlcwp0aGF0IHRyaWdnZXIgYSBEVEMgd2FybmluZy4g
Rml4IHRoaXMgYnkgc2V0dGluZyB0aGUgYWRkcmVzcyB0byAweDE0LgoKQ2M6IE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+CkNjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5k
ZT4KRml4ZXM6IDk2OWQ0OWIyY2RjOCAoImR0LWJpbmRpbmdzOiBhc29jOiBBZGQgQURBVTcxMTgg
ZG9jdW1lbnRhdGlvbiIpClNpZ25lZC1vZmYtYnk6IE1heGltZSBSaXBhcmQgPG1heGltZUBjZXJu
by50ZWNoPgoKLS0tCgpDaGFuZ2VzIGZyb20gdjE6CiAgLSBGaXggdGhlIGFkZHJlc3MgaW5zdGVh
ZCBvZiB0aGUgdW5pdC1hZGRyZXNzLgotLS0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9hZGksYWRhdTcxMTgueWFtbCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksYWRhdTcxMTgueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksYWRhdTcxMTgueWFtbAppbmRleCBjM2YxMGFm
YmRkNmYuLjc1ZTBjYmU2YmU3MCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL2FkaSxhZGF1NzExOC55YW1sCisrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksYWRhdTcxMTgueWFtbApAQCAtNjcsNyArNjcsNyBA
QCBleGFtcGxlczoKICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47CiAgICAgICAgIGFkYXU3MTE4
X2NvZGVjOiBhdWRpby1jb2RlY0AxNCB7CiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJh
ZGksYWRhdTcxMTgiOwotICAgICAgICAgICAgICAgIHJlZyA9IDwxND47CisgICAgICAgICAgICAg
ICAgcmVnID0gPDB4MTQ+OwogICAgICAgICAgICAgICAgICNzb3VuZC1kYWktY2VsbHMgPSA8MD47
CiAgICAgICAgICAgICAgICAgaW92ZGQtc3VwcGx5ID0gPCZzdXBwbHk+OwogICAgICAgICAgICAg
ICAgIGR2ZGQtc3VwcGx5ID0gPCZzdXBwbHk+OwotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
