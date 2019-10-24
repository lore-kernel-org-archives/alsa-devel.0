Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C3CA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:31:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EC8205C9
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ucT/Uyy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EC8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D9B91697;
	Thu, 24 Oct 2019 13:31:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D9B91697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571916714;
	bh=jBplJ3krw4D7zXYowWf09t1hwkOxEXop5vZiOQJqDPg=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucT/Uyy8AFrKbSAInS6PxgbuCbSrSXdRUC1ZI1/a59iK+a5k3CarKEtYoQ2ClpkyS
	 /0EFN64iYBWt6HELAfbVEVCiPO3pRBNibCKC7PKse3n+QtUA9hoJlI2fbywsQBU2bR
	 rNSQbYwiLNQ36gGA0dWCyYa9A+r+jwZkeUFYIx84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2306BF80390;
	Thu, 24 Oct 2019 13:30:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E2F0F803D1; Thu, 24 Oct 2019 13:30:35 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBCBEF8036E
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 13:30:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBCBEF8036E
Received: from [113.5.8.176] (helo=[192.168.43.4])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1iNbK3-0002ko-9X; Thu, 24 Oct 2019 11:30:31 +0000
To: Aaron Ma <aaron.ma@canonical.com>, perex@perex.cz, tiwai@suse.com,
 kailang@realtek.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20191022153855.14368-1-aaron.ma@canonical.com>
 <20191024111850.31137-1-aaron.ma@canonical.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <24766a9d-3328-b70b-abd1-1a88470b08c0@canonical.com>
Date: Thu, 24 Oct 2019 19:30:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024111850.31137-1-aaron.ma@canonical.com>
Content-Language: en-US
Subject: Re: [alsa-devel] [PATCH v2] ALSA: hda/realtek - Fix 2 front mics of
	codec 0x623
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Ck9uIDIwMTkvMTAvMjQg5LiL5Y2INzoxOCwgQWFyb24gTWEgd3JvdGU6Cj4gVGhlc2UgMiBUaGlu
a0NlbnRyZXMgaW5zdGFsbGVkIGEgbmV3IHJlYWx0ZWsgY29kZWMgSUQgMHg2MjMsCj4gaXQgaGFz
IDIgZnJvbnQgbWljcyB3aXRoIHRoZSBzYW1lIGxvY2F0aW9uIG9uIHBpbiAweDE4IGFuZCAweDE5
Lgo+Cj4gQXBwbHkgZml4dXAgQUxDMjgzX0ZJWFVQX0hFQURTRVRfTUlDIHRvIGNoYW5nZSAxIGZy
b250IG1pYwo+IGxvY2F0aW9uIHRvIHJpZ2h0LCB0aGVuIHB1bHNlYXVkaW8gY2FuIGhhbmRsZSB0
aGVtLgo+IE9uZSAiRnJvbnQgTWljIiBhbmQgb25lICJNaWMiIHdpbGwgYmUgc2hvd24sIGFuZCBh
dWRpbyBvdXRwdXQgd29ya3MKPiBmaW5lLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTWEgPGFh
cm9uLm1hQGNhbm9uaWNhbC5jb20+Cj4gLS0tCj4gICBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jCj4gaW5kZXggYTBjMjM3Y2MxM2Q0Li4xNzNhNzg2N2JiNDUgMTAwNjQ0Cj4g
LS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKPiArKysgYi9zb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYwo+IEBAIC03MjIxLDYgKzcyMjEsOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewo+ICAgCVNORF9QQ0lfUVVJ
UksoMHgxN2FhLCAweDMxMmYsICJUaGlua0NlbnRyZSBTdGF0aW9uIiwgQUxDMjk0X0ZJWFVQX0xF
Tk9WT19NSUNfTE9DQVRJT04pLAo+ICAgCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDMxM2MsICJU
aGlua0NlbnRyZSBTdGF0aW9uIiwgQUxDMjk0X0ZJWFVQX0xFTk9WT19NSUNfTE9DQVRJT04pLAo+
ICAgCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDMxNTEsICJUaGlua0NlbnRyZSBTdGF0aW9uIiwg
QUxDMjgzX0ZJWFVQX0hFQURTRVRfTUlDKSwKPiArCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDMx
NzgsICJUaGlua0NlbnRyZSBTdGF0aW9uIiwgQUxDMjgzX0ZJWFVQX0hFQURTRVRfTUlDKSwKPiAr
CVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDMxNzYsICJUaGlua0NlbnRyZSBTdGF0aW9uIiwgQUxD
MjgzX0ZJWFVQX0hFQURTRVRfTUlDKSwKClBsZWFzZSBzb3J0IHRoZW0gaW4gbnVtZXJpY2FsIG9y
ZGVyLCAweDMxNzYgaXMgYWhlYWQgb2YgMHgzMTc4LgoKdGhhbmtzCgo+ICAgCVNORF9QQ0lfUVVJ
UksoMHgxN2FhLCAweDM5MDIsICJMZW5vdm8gRTUwLTgwIiwgQUxDMjY5X0ZJWFVQX0RNSUNfVEhJ
TktQQURfQUNQSSksCj4gICAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4Mzk3NywgIklkZWFQYWQg
UzIxMCIsIEFMQzI4M19GSVhVUF9JTlRfTUlDKSwKPiAgIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwg
MHgzOTc4LCAiTGVub3ZvIEI1MC03MCIsIEFMQzI2OV9GSVhVUF9ETUlDX1RISU5LUEFEX0FDUEkp
LApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
