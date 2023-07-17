Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3C4C001B0
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jul 2023 09:01:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A72B2BC0;
	Mon, 17 Jul 2023 11:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A72B2BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689584457;
	bh=MIQsfvTw4oOvBjKeV9uCHAAFUV2b7hguZgQ09HK/cF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BhIvnFPdiknyR+7EVCZ28WShLEVV2Tqab6OR9jCVeR8XMrFv+OrT2Vx5/nU0hneuH
	 d+ofOnpdlNgV9goYw8pwmyAlt7Tx/sf6Nb22jQY18M2TenI9mJXmQYQk3LTyAh20Q/
	 mCLjj2M7KVpf/ueBdPQBMWUdeCk1EYwEP/6O8X7w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 172BEF8032D; Mon, 17 Jul 2023 10:59:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA60EF8047D;
	Mon, 17 Jul 2023 10:59:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22901F8047D; Mon, 17 Jul 2023 10:59:36 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 175A3F8007E
	for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2023 10:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 175A3F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=XKEPOH1U
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-78358268d1bso220977039f.3
        for <alsa-devel@alsa-project.org>;
 Mon, 17 Jul 2023 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689584367; x=1692176367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FidUuCc90iKxWP9xmktGfbcetSq0w1DH2NjPyFBcWd0=;
        b=XKEPOH1UFavLPMoQFyejnLHCl6ZqZEAVw1UqvO8bkWjZkW2UxOjNaIoPDdYpqsC+z7
         3+GS/ipoLO7eS4MJ9iQ9hrkpgPxIPg9sIIXP6c0lZgxAKGuWOMKAEJDhRs+K6HnEogWO
         NFcDoGesET6FTJ3KUmrNGxBrYAzh3fzBaeZA4iDR7PpRrvv1XJjpZVzGio077NWTG1ud
         0scKqezrIT/4WmR6oSIP6ngCBrkDn/LbTtgnThRr6Jw00tRg/kHe2Us8Po0g8Nt5zJqV
         O7QMrkhJP8lXvsLJhs0it5J9daqxMi9UxS7CO3Lx4fODzlCAz/3me0cm3ZivRBjTYfTs
         ro9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584367; x=1692176367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FidUuCc90iKxWP9xmktGfbcetSq0w1DH2NjPyFBcWd0=;
        b=UKCLYpgDB/kWkid5noUSi3Aex0hvuFzjgLUIMjrpjRB7wNUt/5OT3rZ5LQCyHnvU4m
         n5Y4Er3E80feK1lCOg6X/kFe/PRRaYJTREVUnO28ZjEkSwDyxytOb4Pc2iMTN8/uBfGC
         UzTBSBS6GNWJ7wxD4ZRLZNFHhYJmtwTa4Y1cfASuQZnxrPAvcgSHr9vSGnfGrACvDz2n
         zCzSiHHYEGOIKyM2uKuZ/aM+e9Vgc7RmkaYA6U0Etz1AmaQlLVCtp6/Koyzf/hPZDjxq
         Esxr5/44KUA50kmPDSj5XRc8lXgTvc84UDiKQznBVAdhbNsIEusngc71RxQEjIpQ/v8u
         KRfg==
X-Gm-Message-State: ABy/qLbIPNja2xdVJC7fcpb3St5L2QH2F+YCd3KrNx30MEltwceimBHZ
	C8lmEPnZcbgqBYdzqc+OBTQqBwiXkx7Vn85ktOk=
X-Google-Smtp-Source: 
 APBJJlE8hJ5Bd69MBMPbGVDFfJuymqw2mD4Tj4Qdbk79jgg3c5ylwt86wy+Uj8QR0+Yo3N+3FncId7gCaIWHeeX8gi8=
X-Received: by 2002:a92:d782:0:b0:346:7329:8e8d with SMTP id
 d2-20020a92d782000000b0034673298e8dmr10148628iln.8.1689584367563; Mon, 17 Jul
 2023 01:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230714092913.1591195-1-chancel.liu@nxp.com>
 <20230714092913.1591195-3-chancel.liu@nxp.com>
In-Reply-To: <20230714092913.1591195-3-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 17 Jul 2023 16:59:15 +0800
Message-ID: 
 <CAA+D8ANZdEKUskTNfh=24vcMLjQM===PA061Z2MvNxTNsOT+Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_rpmsg: Add support for i.MX93 platform
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, Xiubo.Lee@gmail.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Message-ID-Hash: PBNBWCVH4ZTINOJAAN2XVRIZLXQKGHX2
X-Message-ID-Hash: PBNBWCVH4ZTINOJAAN2XVRIZLXQKGHX2
X-MailFrom: shengjiu.wang@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PBNBWCVH4ZTINOJAAN2XVRIZLXQKGHX2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

T24gRnJpLCBKdWwgMTQsIDIwMjMgYXQgNTozMOKAr1BNIENoYW5jZWwgTGl1IDxjaGFuY2VsLmxp
dUBueHAuY29tPiB3cm90ZToNCg0KPiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgYW5kIHNwZWNpZmlj
IHNvYyBkYXRhIHRvIHN1cHBvcnQgcnBtc2cgc291bmQgY2FyZA0KPiBvbiBpLk1YOTMgcGxhdGZv
cm0uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW5jZWwgTGl1IDxjaGFuY2VsLmxpdUBueHAuY29t
Pg0KPg0KDQpBY2tlZC1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BnbWFpbC5jb20+
DQoNCkJlc3QgcmVnYXJkcw0Kd2FuZyBzaGVuZ2ppdQ0KDQo+IC0tLQ0KPiAgc291bmQvc29jL2Zz
bC9mc2xfcnBtc2cuYyB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX3JwbXNnLmMgYi9zb3Vu
ZC9zb2MvZnNsL2ZzbF9ycG1zZy5jDQo+IGluZGV4IDE1YjQ4YjVlYTg1Ni4uYWJlMTlhOGE3YWE3
IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9ycG1zZy5jDQo+ICsrKyBiL3NvdW5k
L3NvYy9mc2wvZnNsX3JwbXNnLmMNCj4gQEAgLTE3MCwxMiArMTcwLDIwIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZnNsX3JwbXNnX3NvY19kYXRhIGlteDhtcF9kYXRhID0NCj4gew0KPiAgICAgICAg
ICAgICAgICAgICAgU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUsDQo+ICB9Ow0KPg0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBmc2xfcnBtc2dfc29jX2RhdGEgaW14OTNfZGF0YSA9IHsNCj4gKyAgICAg
ICAucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV8xNjAwMCB8IFNORFJWX1BDTV9SQVRFXzMyMDAwIHwN
Cj4gKyAgICAgICAgICAgICAgICBTTkRSVl9QQ01fUkFURV80ODAwMCB8IFNORFJWX1BDTV9SQVRF
Xzk2MDAwLA0KPiArICAgICAgIC5mb3JtYXRzID0gU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUgfCBT
TkRSVl9QQ01fRk1UQklUX1MyNF9MRSB8DQo+ICsgICAgICAgICAgICAgICAgICBTTkRSVl9QQ01f
Rk1UQklUX1MzMl9MRSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIGZzbF9ycG1zZ19pZHNbXSA9IHsNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gImZz
bCxpbXg3dWxwLXJwbXNnLWF1ZGlvIiwgLmRhdGEgPSAmaW14N3VscF9kYXRhfSwNCj4gICAgICAg
ICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tcnBtc2ctYXVkaW8iLCAuZGF0YSA9ICZpbXg4
bW1fZGF0YX0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1uLXJwbXNnLWF1
ZGlvIiwgLmRhdGEgPSAmaW14OG1uX2RhdGF9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtcC1ycG1zZy1hdWRpbyIsIC5kYXRhID0gJmlteDhtcF9kYXRhfSwNCj4gICAgICAg
ICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4dWxwLXJwbXNnLWF1ZGlvIiwgLmRhdGEgPSAmaW14
N3VscF9kYXRhfSwNCj4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg5My1ycG1zZy1h
dWRpbyIsIC5kYXRhID0gJmlteDkzX2RhdGF9LA0KPiAgICAgICAgIHsgLyogc2VudGluZWwgKi8g
fQ0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGZzbF9ycG1zZ19pZHMpOw0KPiAt
LQ0KPiAyLjI1LjENCj4NCj4NCg==
