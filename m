Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D58C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:40:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678D622448
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ytgmzdmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678D622448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A82E168D;
	Tue, 19 Nov 2019 20:39:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A82E168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574192441;
	bh=vpvNFs0cVYZ3B12efiVwsPc6xwU00w26zvfoD2JxVmk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YtgmzdmrtmqMw3BYutj54C7D8v266/lULKC7zGoj8fTxyoU8mtkLJu29hy1mxF5Pk
	 /tUqY0DKhhU6JGc6lNk9ggH5/I7tAiBgjaTPSNup/Jbm0iUwBJwUL5XAStlCVuKlcn
	 F4/Uze2iS7YgIVpt9agnm2zufRzJEaMVpylFQv/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90751F80137;
	Tue, 19 Nov 2019 20:39:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AE77F80138; Tue, 19 Nov 2019 20:39:49 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFCC9F800F4
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 20:39:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFCC9F800F4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 11:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; d="scan'208";a="200467945"
Received: from pbossart-mobl3.an.intel.com (HELO [10.122.138.49])
 ([10.122.138.49])
 by orsmga008.jf.intel.com with ESMTP; 19 Nov 2019 11:39:42 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191119174933.25526-1-perex@perex.cz>
 <20191119174933.25526-2-perex@perex.cz>
 <72dfc285-70e8-706d-3018-535bda1e8630@linux.intel.com>
 <f2de9597-c9c2-7696-622b-a2bbc2c32bb7@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fb07b326-4c5d-43a7-4525-9d5fa71db95d@linux.intel.com>
Date: Tue, 19 Nov 2019 13:39:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f2de9597-c9c2-7696-622b-a2bbc2c32bb7@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel - use control components
 to describe card config
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

Cj4+PiArY29uZmlnIFNORF9TT0NfSU5URUxfVVNFX0NUTF9DT01QT05FTlRTCj4+PiArwqDCoMKg
IGJvb2wgIlVzZSBDVEwgY29tcG9uZW50cyBmb3IgSS9PIGNvbmZpZ3VyYXRpb24iCj4+PiArwqDC
oMKgIGhlbHAKPj4+ICvCoMKgwqDCoMKgIFNvbWUgZHJpdmVycyBtaWdodCBwYXNzIHRoZSBJL08g
Y29uZmlndXJhdGlvbiB0aHJvdWdoIHRoZQo+Pj4gK8KgwqDCoMKgwqAgc291bmRjYXJkJ3MgZHJp
dmVyIG5hbWUgaW4gdGhlIGNvbnRyb2wgdXNlciBzcGFjZSBBUEkuCj4+PiArwqDCoMKgwqDCoCBU
aGUgbmV3IHNjaGVtZSBpcyB0byBwdXQgdGhpcyBpbmZvcm1hdGlvbiB0byB0aGUgY29tcG9uZW50
cwo+Pj4gK8KgwqDCoMKgwqAgZmllbGQgaW4gdGhlIEFMU0EncyBjYXJkIGluZm8gc3RydWN0dXJl
LiBTYXkgWSwgaWYgeW91Cj4+PiArwqDCoMKgwqDCoCBoYXZlIEFMU0EgdXNlciBzcGFjZSB2ZXJz
aW9uIDEuMi4yKy4KPj4+ICsKPj4KPj4gSWYgdGhpcyBpcyBhdCB0aGUgYm9hcmQgbGV2ZWwsIHRo
ZW4gbWF5YmUgbW92ZSB0aGlzIHRvCj4+IHNvdW5kL3NvYy9pbnRlbC9ib2FyZHMvS2NvbmZpZwo+
Pgo+PiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBhbHNhLWxpYiBkZXBlbmRlbmN5LCBpdCdzIGEg
Yml0IG9kZCwgaXNuJ3QgaXQ/Cj4+IHNob3VsZG4ndCB0aGlzIGJlIGhhbmRsZWQgdmlhIHByb3Rv
Y29sIHZlcnNpb25zPyBvciBhIGNvbmZpZ3VyYXRpb24KPj4gcHJvdmlkZWQgYnkgYWxzYS1saWIg
c29tZWhvdz8KPiAKPiBJdCdzIG5vdCBhYm91dCB0aGUgcHJvdG9jb2wuIEl0J3MgYWJvdXQgdG8g
bW92ZSB0aGlzIHR5cGUgb2YgaW5mb3JtYXRpb24gCj4gdG8gYW5vdGhlciBwbGFjZS4gSSBjYW4g
cmVtb3ZlIHRoZSBBTFNBIHZlcnNpb24gc2VudGVuY2UgZnJvbSB0aGUgaGVscCwgCj4gYmVjYXVz
ZSBpdCdzIGp1c3QgYSBoaW50LiBJIHdvdWxkIGxpa2UgdG8gY3JlYXRlIHVjbTIgY29uZmlndXJh
dGlvbnMgCj4gYmFzZWQgb24gdGhpcyByYXRoZXIgdGhhbiB0aGUgbWlzdXNlZCBsb25nIGNhcmQg
bmFtZXMuCgpJIGFtIHdpdGggeW91IG9uIHRoZSBpZGVhLCBpdCdzIHRoZSB0cmFuc2l0aW9uIHRo
YXQgd29ycmllcyBtZS4gSSBndWVzcyAKZm9yIGEgZGlzdHJvIHRoYXQgd291bGQgYmUgZmluZSwg
b25lIHdvdWxkIGhvcGUgdGhhdCB0aGVyZSBpcyBhIApjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhl
IGFsc2EtbGliIGFuZCB0aGUga2VybmVsIGNvbmZpZ3VyYXRpb25zIHBhcnRzLCAKYnV0IGZvciBh
IHJhbmRvbSB1c2VyIHRoZXJlJ3MgYSBjaGFuY2UgdGhhdCB0aGV5IHdvdWxkIG5vdCBzZWxlY3Qg
dGhpcyAKYW5kIG5vdCB1c2UgdWNtMiBhbmQgdmljZSB2ZXJzYS4KCml0J3MgYWxzbyBwYWluZnVs
IGZvciBrZXJuZWwgZGV2ZWxvcGVycyB0byByZWx5IG9uIHRvLWJlLXJlbGVhc2VkIAphbHNhLWxp
YiBjaGFuZ2VzLCB3ZSd2ZSBiZWVuIHRoZXJlIHdpdGggU09GIGFuZCBJIGRvbid0IGtub3cgaG93
IG1hbnkgCnRpbWVzIHdlIGhhZCByZXBvcnRzIG9mIGlzc3VlcyByZWxhdGVkIHRvIGFsc2EtbGli
IHNldHVwIHByb2JsZW1zLiBIZXJlIAppdCdkIGJlIHdvcnNlIHNpbmNlIGFsc2EtbGliIHVwZGF0
ZXMgd291bGQgbmVlZCB0byBiZSBkZXBsb3llZCBvbiB0YXJnZXQgCmRldmljZXMuCgpBZ2FpbiBJ
IGFtIG5vdCBhZ2FpbnN0IHRoZSBpZGVhLCBidXQgYW55dGhpbmcgd2UgY2FuIGRvIHRvIHJldXNl
IApmcmljdGlvbiBkdXJpbmcgdGhlIHRyYW5zaXRpb24gd2lsbCBoZWxwIGEgZ3JlYXQgZGVhbC4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
