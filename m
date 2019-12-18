Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED7C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6071227BF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="faYw1BmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6071227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6FFF84A;
	Wed, 18 Dec 2019 10:49:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6FFF84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576662637;
	bh=k3dPHWDfYVgwzC+3H7eE/jk+5C2NhnyrB5sFsK24zJg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=faYw1BmAu18C3qB2oyUfMPpmf/qv79DrOvJkQXqbmcGHM1NVMYjvO0T6YNgcevrG8
	 OSn7+PmI32K275XFzaDrmq14/5g904KgRF4bSqWq/dme6oQhSYeJFtxjCwusSVcPQu
	 R+vEsMUyUf/60SKVW6LnjfXo7Vnn+Fa/ihvQnco4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 301D7F8015A;
	Wed, 18 Dec 2019 10:49:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C39AEF8022C; Wed, 18 Dec 2019 10:49:45 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
 by alsa1.perex.cz (Postfix) with ESMTP id 29BFEF80088
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 10:49:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29BFEF80088
Received: from [10.10.222.226] (unknown [194.162.236.226])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 056A6281DF4;
 Wed, 18 Dec 2019 09:43:13 +0000 (UTC)
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-12-daniel@zonque.org>
 <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <35e7e6e7-7c70-785c-bdf3-79089134699e@zonque.org>
Date: Wed, 18 Dec 2019 10:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
Content-Language: en-US
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com,
 robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com,
 lee.jones@linaro.org
Subject: Re: [alsa-devel] [PATCH 10/10] ASoC: Add codec component for AD242x
 nodes
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

SGksCgpPbiAxMi8xNy8xOSA4OjI4IFBNLCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPiBP
biAxMi85LzE5IDEyOjM1IFBNLCBEYW5pZWwgTWFjayB3cm90ZToKCj4+ICvCoMKgwqAgaWYgKCFh
ZDI0Mnhfbm9kZV9pc19tYXN0ZXIocHJpdi0+bm9kZSkgJiYKPj4gK8KgwqDCoMKgwqDCoCAoKGZv
cm1hdCAmIFNORF9TT0NfREFJRk1UX01BU1RFUl9NQVNLKSAhPQo+PiBTTkRfU09DX0RBSUZNVF9D
Qk1fQ0ZNKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2Vycihjb21wb25lbnQtPmRldiwgInNs
YXZlIG5vZGUgbXVzdCBiZSBjbG9jayBtYXN0ZXJcbiIpOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FSU5WQUw7Cj4+ICvCoMKgwqAgfQo+IAo+IEl0IHdhcyBteSB1bmRlcnN0YW5kaW5nIHRo
YXQgdGhlIG1hc3RlciBub2RlIHByb3ZpZGVzIHRoZSBjbG9jayB0byB0aGUKPiBidXMsIHNvIG5v
dCBzdXJlIGhvdyBpdCBjb3VsZCBiZSBhIGNsb2NrIHNsYXZlLCBhbmQgY29udmVyc2VseSBob3cg
YQo+IHNsYXZlIG5vZGUgY291bGQgcHJvdmlkZSBhIGNsb2NrIHRvIHRoZSBidXM/CgpUaGUgc2xh
dmUgbm9kZXMgcmVjZWl2ZSB0aGUgQTJCIGNsb2NrIGZyb20gdGhlIG1hc3RlciBub2RlIGFuZCB0
aGVuCnByb2R1Y2UgZGlnaXRhbCBhdWRpbyBvdXRwdXQgdGhhdCBpcyBzZW50IHRvIG90aGVyIGNv
bXBvbmVudHMgc3VjaCBhcwpjb2RlY3MuIEhlbmNlLCBpbiBBU29DIHRlcm1zLCB0aGV5IGFyZSB0
aGUgY2xvY2sgbWFzdGVyLgoKTGlrZXdpc2UsIGFzIHRoZSBtYXN0ZXIgbm9kZSBpcyByZWNlaXZp
bmcgaXRzIGNsb2NrIGZyb20gb3RoZXIKY29tcG9uZW50cywgaXQgaGFzIHRvIGJlIGEgY2xvY2sg
c2xhdmUgaW4gdGhlIGF1ZGlvIG5ldHdvcmsuCgpEb2VzIHRoYXQgbWFrZSBzZW5zZT8KCj4+ICvC
oMKgwqAgc3dpdGNoIChwYXJhbXNfZm9ybWF0KHBhcmFtcykpIHsKPj4gK8KgwqDCoCBjYXNlIFNO
RFJWX1BDTV9GT1JNQVRfUzE2X0xFOgo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHByaXYtPm5vZGUt
PnRkbV9zbG90X3NpemUgIT0gMTYpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOwo+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgY2FzZSBTTkRSVl9Q
Q01fRk9STUFUX1MzMl9MRToKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChwcml2LT5ub2RlLT50ZG1f
c2xvdF9zaXplICE9IDMyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZB
TDsKPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKgIGRlZmF1bHQ6Cj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gK8KgwqDCoCB9Cj4gCj4gaG93IGRvZXMgdGhp
cyB3b3JrIGZvciBQRE0gZGF0YT8KPiAKPiBpcyB0aGUgUERNIGRhdGEgcGFja2VkIGludG8gYSBy
ZWd1bGFyIFRETSBzbG90PwoKWWVzLiBCdXQgSSBhZG1pdCB0aGlzIG5lZWRzIHNvbWUgbW9yZSB0
ZXN0aW5nLiBXZSdyZSBzdGlsbCB3b3JraW5nIG9uCnRoZSBoYXJkd2FyZSB0aGF0IHVzZXMgdGhp
cy4gSSdsbCByZXZpc2l0IHRoaXMuCgpBbmQgSSdsbCBhbHNvIGFkZCBhIGxvdCBtb3JlIGNvbW1l
bnRzIGFsbCBvdmVyIHRoZSBwbGFjZSwgYXMgYWxzbwpyZXF1ZXN0ZWQgYnkgTGVlLgoKClRoYW5r
cywKRGFuaWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
