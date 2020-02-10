Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52011C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:48:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFEF20842
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uDItZtmo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GB+F6x/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFEF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 298F41664;
	Mon, 10 Feb 2020 11:47:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 298F41664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581331695;
	bh=e5WD7Hr6MJ0Y3+wGpTiuSGkPGSg/Ktcznjh7FzD4Opo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDItZtmoGWMaH57Kex+SwmxmRM0rGyTCciXL9giIAz92Kq5U3fR64feZ98JJ73rpD
	 I/huCzM2g8KPlYmr5gzkdT6XqjKUdq7MTcE9jyNwMilbQ3rcC7MCejDWg7GkejkkPp
	 fvusZLRlszuOktg3Cp35sM0DqIY7BLglsR76Lzq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4696AF8014F;
	Mon, 10 Feb 2020 11:47:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72BDDF80157; Mon, 10 Feb 2020 11:47:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DC27F800FD
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 11:47:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DC27F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GB+F6x/q"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AAlEEC094006;
 Mon, 10 Feb 2020 04:47:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1581331634;
 bh=B8GRA+CrLBCOGT5Ccz74+e8To+cVE5Fs8SCDmKQIwrA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=GB+F6x/qzwuL0HMOreac7zKVQQdL5DxjkgqgA0qQg5j7Qt5Y09lF3qlP4N5o27vGs
 czS7WgoKIqBr61mKS6c9z5V631fFqAN3Wnvra6b/pHcwO8b4NywFv0JzEhUE9BnO40
 NqqD8cFPsveU+/+a7yAEaBijwEnMs08Rhlw5arm4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AAlEXB076613
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2020 04:47:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 04:47:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 04:47:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AAlBTe091641;
 Mon, 10 Feb 2020 04:47:12 -0600
To: Colin King <colin.king@canonical.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 <alsa-devel@alsa-project.org>
References: <20200210092423.327499-1-colin.king@canonical.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <bc05a46a-fc38-c95f-4aa1-25034d3eb6cc@ti.com>
Date: Mon, 10 Feb 2020 12:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210092423.327499-1-colin.king@canonical.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH][V2] ASoC: ti: davinci-mcasp: remove
 redundant assignment to variable ret
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

CgpPbiAxMC8wMi8yMDIwIDExLjI0LCBDb2xpbiBLaW5nIHdyb3RlOgo+IEZyb206IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4gCj4gVGhlIGFzc2lnbm1lbnQgdG8g
cmV0IGlzIHJlZHVuZGFudCBhcyBpdCBpcyBub3QgdXNlZCBpbiB0aGUgZXJyb3IKPiByZXR1cm4g
cGF0aCBhbmQgaGVuY2UgY2FuIGJlIHJlbW92ZWQuCgpBY2tlZC1ieTogUGV0ZXIgVWpmYWx1c2kg
PHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2
YWx1ZSIpCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25p
Y2FsLmNvbT4KPiAtLS0KPiBWMjogZXhwbGljaXRseSByZXR1cm4gTlVMTCB0byBpbXByb3ZlIHJl
YWRhYmlsaXR5LiBUaGFua3MgdG8gRGFuIENhcnBlbnRlciBmb3IKPiAgICAgc3VnZ2VzdGluZyB0
aGlzIGltcHJvdmVtZW50Lgo+IC0tLQo+ICBzb3VuZC9zb2MvdGkvZGF2aW5jaS1tY2FzcC5jIHwg
NiArKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3RpL2RhdmluY2ktbWNhc3AuYyBiL3NvdW5k
L3NvYy90aS9kYXZpbmNpLW1jYXNwLmMKPiBpbmRleCBlMWU5MzdlYjFkYzEuLjZmOTc2MzljNDZj
ZCAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvdGkvZGF2aW5jaS1tY2FzcC5jCj4gKysrIGIvc291
bmQvc29jL3RpL2RhdmluY2ktbWNhc3AuYwo+IEBAIC0xNzY0LDEwICsxNzY0LDggQEAgc3RhdGlj
IHN0cnVjdCBkYXZpbmNpX21jYXNwX3BkYXRhICpkYXZpbmNpX21jYXNwX3NldF9wZGF0YV9mcm9t
X29mKAo+ICAJfSBlbHNlIGlmIChtYXRjaCkgewo+ICAJCXBkYXRhID0gZGV2bV9rbWVtZHVwKCZw
ZGV2LT5kZXYsIG1hdGNoLT5kYXRhLCBzaXplb2YoKnBkYXRhKSwKPiAgCQkJCSAgICAgR0ZQX0tF
Uk5FTCk7Cj4gLQkJaWYgKCFwZGF0YSkgewo+IC0JCQlyZXQgPSAtRU5PTUVNOwo+IC0JCQlyZXR1
cm4gcGRhdGE7Cj4gLQkJfQo+ICsJCWlmICghcGRhdGEpCj4gKwkJCXJldHVybiBOVUxMOwo+ICAJ
fSBlbHNlIHsKPiAgCQkvKiBjb250cm9sIHNob3VsZG4ndCByZWFjaCBoZXJlLiBzb21ldGhpbmcg
aXMgd3JvbmcgKi8KPiAgCQlyZXQgPSAtRUlOVkFMOwo+IAoKLSBQw6l0ZXIKClRleGFzIEluc3Ry
dW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1
bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5r
aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
