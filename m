Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B1C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 05:45:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DD261175
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 05:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DD261175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9CB3167A;
	Thu,  8 Apr 2021 07:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9CB3167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617860710;
	bh=c6Ii7OpohczAty+IXuRyPeC8Dr2Wa9waFOnnflxFtZM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCG0+FQJhk3o14qVM/+LX0g5mI7PGIz6iExlZod4c/sXROaGcUyW//5sQ74KnG5rh
	 sQqMJHkzCuJJlZtrvE+4KuZ/7ggD3R4j2LKrrMj3sFEBX3nuBQFmD/DwMNaS2Lfd6/
	 JR5QS9cezLPqVUvohBqYZRd7/6vQD0+7UZlFdbTA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C8A3F80169;
	Thu,  8 Apr 2021 07:44:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E4B3F8020B; Thu,  8 Apr 2021 07:44:18 +0200 (CEST)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id DEFB1F800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 07:44:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEFB1F800BD
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 8 Apr 2021 13:44:04
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date: Thu, 8 Apr 2021 13:44:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: dinghao.liu@zju.edu.cn
To: "Mark Brown" <broonie@kernel.org>
Subject: Re: Re: [PATCH] ASoC: codecs: Fix rumtime PM imbalance in
 tas2552_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <20210407125147.GD5510@sirena.org.uk>
References: <20210407065402.17729-1-dinghao.liu@zju.edu.cn>
 <20210407125147.GD5510@sirena.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <8ef359a.40bbb.178b0024d3e.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCH2Q0kmG5giemaAA--.34955W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoGBlZdtTQGhAAxsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>
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

PiBPbiBXZWQsIEFwciAwNywgMjAyMSBhdCAwMjo1NDowMFBNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiAKPiA+IC0JcG1fcnVudGltZV9zZXRfYWN0aXZlKCZjbGllbnQtPmRldik7Cj4gPiAt
CXBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZjbGllbnQtPmRldiwgMTAwMCk7Cj4g
PiAtCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKCZjbGllbnQtPmRldik7Cj4gPiAtCXBtX3J1
bnRpbWVfZW5hYmxlKCZjbGllbnQtPmRldik7Cj4gPiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1
c3koJmNsaWVudC0+ZGV2KTsKPiA+IC0JcG1fcnVudGltZV9wdXRfc3luY19hdXRvc3VzcGVuZCgm
Y2xpZW50LT5kZXYpOwo+ID4gLQo+ID4gIAlkZXZfc2V0X2RydmRhdGEoJmNsaWVudC0+ZGV2LCBk
YXRhKTsKPiA+ICAKPiA+ICAJcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVudCgm
Y2xpZW50LT5kZXYsCj4gPiBAQCAtNzMzLDYgKzcyNiwxMyBAQCBzdGF0aWMgaW50IHRhczI1NTJf
cHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwKPiA+ICAJaWYgKHJldCA8IDApCj4gPiAg
CQlkZXZfZXJyKCZjbGllbnQtPmRldiwgIkZhaWxlZCB0byByZWdpc3RlciBjb21wb25lbnQ6ICVk
XG4iLCByZXQpOwo+ID4gIAo+ID4gKwlwbV9ydW50aW1lX3NldF9hY3RpdmUoJmNsaWVudC0+ZGV2
KTsKPiA+ICsJcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoJmNsaWVudC0+ZGV2LCAx
MDAwKTsKPiA+ICsJcG1fcnVudGltZV91c2VfYXV0b3N1c3BlbmQoJmNsaWVudC0+ZGV2KTsKPiAK
PiBJdCdzIG5vdCBjbGVhciB0byBtZSB0aGF0IGp1c3QgbW92aW5nIHRoZSBvcGVyYXRpb25zIGFm
dGVyIHRoZQo+IHJlZ2lzdHJhdGlvbiBpcyBhIGdvb2QgZml4IC0gb25jZSB0aGUgY29tcG9uZW50
IGlzIHJlZ2lzdGVyZWQgd2UgY291bGQKPiBzdGFydCB0cnlpbmcgdG8gZG8gcnVudGltZSBQTSBv
cGVyYXRpb25zIHdpdGggaXQgd2hpY2ggQUZBSVIgd29uJ3QgY291bnQKPiByZWZlcmVuY2VzIGFu
ZCBzbyBvbiBwcm9wZXJseSBpZiBydW50aW1lIFBNIGlzbid0IGVuYWJsZWQgc28gaWYgd2UgbGF0
ZXIKPiBlbmFibGUgcnVudGltZSBQTSB3ZSBtaWdodCBoYXZlIHRoZSByZXN0IG9mIHRoZSBjb2Rl
IGluIGEgY29uZnVzZWQgc3RhdGUKPiBhYm91dCB3aGF0J3MgZ29pbmcgb24uCgpUaGFua3MgZm9y
IHlvdXIgYWR2aWNlLiBJIGNoZWNrZWQgdGhlIHVzZSBvZiBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJf
Y29tcG9uZW50KCkgCmluIHRoZSBrZXJuZWwgYW5kIGZvdW5kIHNvbWV0aW1lcyBydW50aW1lIFBN
IGlzIGVuYWJsZWQgYmVmb3JlIHJlZ2lzdHJhdGlvbiAKYW5kIHNvbWV0aW1lcyBhZnRlciByZWdp
c3RyYXRpb24uIFRvIGJlIG9uIHRoZSBzYWZlIHNpZGUsIEkgd2lsbCBzZW5kIGEgbmV3CnBhdGNo
IHRvIGZpeCB0aGlzIGluIGVycm9yIGhhbmRsaW5nIHBhdGguCgpSZWdhcmRzLApEaW5naGFvCg==

