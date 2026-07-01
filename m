Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE57C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:43:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAE3C601F1;
	Thu,  2 Jul 2026 18:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAE3C601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783010577;
	bh=Zf7F3Xv9aMEAjldGIjcTDaazS5BgoGAYyGJFdcM7QVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LcVjLDtErrJRkX99j90Cpy8I4ZtwoQg2QiYEgt0JoIk1/ENtnoF/BI6Zki3cPq3N8
	 M5ea+Zniq5bv3ZVCsh1OeWhuZzJDrKLQx7CHnLPpEd8kB5GxcIu21CQGjX6+967s42
	 oRC+gB6lJ6oV1p/w8Qb8kP9yqyfV9k6uDvsUtCxM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7ACC5F805ED; Thu,  2 Jul 2026 18:42:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99200F805FA;
	Thu,  2 Jul 2026 18:42:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0811F8051F; Wed,  1 Jul 2026 10:48:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782895685;
	b=JWXj14+z1ZrtD7gsioRTPzna1ekfOrkMzGDj14RSKthFoGGnVG5xf1c72Q/piL6LWq0y
	 adZQWbpHMSKJB4R8aE241/foZ5LO/+hvVKxOlTrpvyEJfmqHNGLMR23Fsb6/ANL+kaUa9
	 fZ2h2/mT2RXroUuqb1pNP6kMEcEs1rxKhUgQaruV0ziRCXIryREneG6vLyhr7vRVc+XXq
	 Vzq+HREZeo9Hc0rzdQ6vvynr0HMWKwKP7Zzcg12Tyf/7fnjsvOV+rO8S9Ts/Zli8qdRD2
	 M9LqBeUfA6Qxt5KG+DopTNyLmxClgqUctGNEc8npmXGMQPhJ3w/6pFxK5UOgBIiKVNg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782895685;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=bs3qeWQIqAKa5Syey0l7rVFbDFDO/6ETH4WEIZyWYNE=;
	b=fka76iyLIhuMHSyCuEyHpvHCWFAJzXkKnCSInUC4A2B5P2JN0V/SZDuMFNDphxfgFT/x
	 amo1M/lyf4ER1YlVrp04G+xKPKNZQu+It3TVynpGI91AYcPqSHQPu23/JDLHfcxg9fG61
	 t6uIkIumI0oK9EtjbvrN/SGS4Fup8431FUTAoBU0t5fx9+w80ex0aWrDb1ba0jfHC87sT
	 UqVbIbOKmClTxW1P9/G8ia8y1f1FfMBglr1oupvB/+nVByGdLF8UGAmAAgIjO5sUeLiFN
	 IwxccTVYBM96GMEhMRvnLU1Dy0LuEbPHhJIH/2esNFnaH8HZBX2o/9Ta+4EEd/JCc9Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=pZxH7QXB;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A743F80152
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 10:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A743F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=pZxH7QXB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bs3qeWQIqAKa5Syey0l7rVFbDFDO/6ETH4WEIZyWYNE=; b=p
	ZxH7QXBvQ/o2IojxARgX5jshppUeqBHLtgnCu+hUZpI3saO7toPcD3TZyCqKzFPk
	3xGjT2lC3A25H5SNQgf7J5ydFfGWhL2+juRNMmP0YJSj7QoJF/PTgULq88D29Ieq
	CqaaKoj9nzHqy+ciIBq5vStGbKdbhX3EOnnPgLsFm4=
Received: from os_dengxiang82$126.com ( [180.167.10.98] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Wed, 1 Jul 2026 16:47:57 +0800 (CST)
X-Originating-IP: [180.167.10.98]
Date: Wed, 1 Jul 2026 16:47:57 +0800 (CST)
From: os_dengxiang82  <os_dengxiang82@126.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: tiwai@suse.com, bo.liu@senarytech.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re:Re: [PATCH] ALSA: hda/conexant: Fix microphone mute after
 power-on reboot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <87o6grun6p.wl-tiwai@suse.de>
References: <20260701065533.72517-1-os_dengxiang82@126.com>
 <87se63upn1.wl-tiwai@suse.de>
 <235d28fc.65dd.19f1cc1a68d.Coremail.os_dengxiang82@126.com>
 <87o6grun6p.wl-tiwai@suse.de>
X-NTES-SC: 
 AL_Qu2TAPSSuk4s4SaaZekckkobgOc8X8GyvPwi2YBWc88OhAvL3S8OZEZBJGLrz9KPIi2ljxmJdgdUysFkcIpdsLf99eEP22wM4hGZ20JmRA==
MIME-Version: 1.0
Message-ID: <4932c551.6ece.19f1cdd10ba.Coremail.os_dengxiang82@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dSkvCgD3xz491ERqF7UVAA--.6899W
X-CM-SenderInfo: xrvbvv5qj0xtdqjyjqqrswhudrp/xtbBrx3vp2pE1D253wAA3b
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: os_dengxiang82@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LVU6NQ6R65QBE2C4EAJAB3ZWYTM7ZYLR
X-Message-ID-Hash: LVU6NQ6R65QBE2C4EAJAB3ZWYTM7ZYLR
X-Mailman-Approved-At: Thu, 02 Jul 2026 16:42:17 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVU6NQ6R65QBE2C4EAJAB3ZWYTM7ZYLR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SSBoYXZlIGFscmVhZHkgdHJpZWQgY2FsbGluZyByZWdjYWNoZV9tYXJrX2RpcnR5KCkgYW5kIHNu
ZF9oZGFfcmVnbWFwX3N5bmMoKSBpbnNpZGUgdGhlIHJlc3VtZSBjYWxsYmFjaywgYW5kIEmhr3Zl
IGFsc28gYXR0ZW1wdGVkIHRoaXMgZHVyaW5nIHRoZSBib290dXAgcGhhc2UuIEJ1dCB0aGUgaXNz
dWUgaXMgc3RpbGwgcHJlc2VudC4KQXQgMjAyNi0wNy0wMSAxNjozMDoyMiwgIlRha2FzaGkgSXdh
aSIgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOgo+T24gV2VkLCAwMSBKdWwgMjAyNiAxMDoxODowMCAr
MDIwMCwKPm9zX2Rlbmd4aWFuZzgyIHdyb3RlOgo+PiAKPj4gCj4+IEhpIFRha2FzaGksCj4+IAo+
PiAgIFRoaXMgZmFpbHVyZSBvY2N1cnMgZHVyaW5nIGJvb3R1cCBhcyB3ZWxsIGFzIGFmdGVyIHJ1
bnRpbWUgcmVzdW1lLiBEb2VzCj4+IHJ1bnRpbWUgcmVzdW1lIGhlcmUgcmVmZXIgdG8gdGhlIHJl
c3VtZSBoYW5kbGVyLCBsaWtlIC5yZXN1bWUgPSBjeF9yZXN1bWU/IG9yCj4+IHNvbWV0aGluZyBl
bHNlPyBMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4KPgo+SXQncyBoZGFfY29kZWNfcnVu
dGltZV9yZXN1bWUoKS4gIFdlIGhhdmUgbm8gQ29uZXhhbnQtc3BlY2lmaWMgcmVzdW1lCj5jYWxs
YmFjaywgaGVuY2UgdGhlIHN0YW5kYXJkIHByb2NlZHVyZSBpcyBhcHBsaWVkLCBpLmUuCj5yZWdj
YWNoZV9tYXJrX2RpcnR5KCkgYW5kIHNuZF9oZGFfcmVnbWFwX3N5bmMoKSBtYWtlIHRoZSBjb2Rl
YyB2ZXJicwo+cmVzdW1lZCB0aGF0IGhhdmUgYmVlbiB0b3VjaGVkLiAgU28sIHlvdSdkIG5lZWQg
dG8gY2hlY2sgd2hldGhlciB0aGUKPm5lZWRlZCBhbXAgaGFzIGJlZW4gYWxyZWFkeSBhY2Nlc3Nl
ZCB2aWEgcmVnbWFwLCBhbmQgY2hlY2sgd2hldGhlciB0aGUKPnZhbHVlIGdldHMgcmVzdG9yZWQg
cHJvcGVybHkgaW4gdGhlIHByb2NlZHVyZSBhYm92ZS4KPgo+Cj5UYWthc2hpCj4KPj4gCj4+IHhp
YW5nCj4+IAo+PiBBdCAyMDI2LTA3LTAxIDE1OjM3OjIyLCAiVGFrYXNoaSBJd2FpIiA8dGl3YWlA
c3VzZS5kZT4gd3JvdGU6Cj4+ID5PbiBXZWQsIDAxIEp1bCAyMDI2IDA4OjU1OjMzICswMjAwLAo+
PiA+ZGVuZ3hpYW5nIHdyb3RlOgo+PiA+PiAKPj4gPj4gU29tZSBkZXZpY2VzIGhhdmUgbXV0ZSBz
ZXR0aW5ncyBpbiB0aGVpciBmaXJtd2FyZSBzZXQgYnkgdGhlIGZhY3RvcnkuCj4+ID4+IFRoaXMg
aXMgdG8gc3RvcCBwb3BwaW5nIG5vaXNlIHdoZW4gdGhlIGRldmljZXMgdHVybiBvbi4gQnV0IHRo
aXMgc2V0dGluZwo+PiA+PiBtYWtlcyB0aGUgbWljcm9waG9uZXMgdW5hYmxlIHRvIHJlY29yZCBz
b3VuZCBwcm9wZXJseS4gVGhpcyBwYXRjaAo+PiA+PiBzb2x2ZXMgdGhpcyBwcm9ibGVtIGFuZCBp
cyBjb21wYXRpYmxlIHdpdGggY29uZXhhbnQgY2hpcHMuCj4+ID4+IAo+PiA+PiBTaWduZWQtb2Zm
LWJ5OiBkZW5neGlhbmcgPG9zX2Rlbmd4aWFuZzgyQDEyNi5jb20+Cj4+ID4KPj4gPkhtbSwgdGhp
cyBkb2Vzbid0IGxvb2sgbGlrZSBhIHJpZ2h0IHNvbHV0aW9uLgo+PiA+Cj4+ID5JcyBpdCBvbmx5
IHRoZSBwcm9ibGVtIGFmdGVyIHRoZSBib290PyAgT3IgaXMgaXQgYW4gaXNzdWUgYWZ0ZXIgdGhl
Cj4+ID5ydW50aW1lIFBNIHN1c3BlbmQ/ICBUaGUgYW1wIHZhbHVlIG11c3QgYmUgcmVzdG9yZWQg
YnkgdGhlIHJ1bnRpbWUKPj4gPnJlc3VtZSwgYW5kIGlmIHRoaXMgZG9lc24ndCB3b3JrIGV4cGVj
dGVkLCBpdCdzIGEgdGhpbmcgdG8gYmUKPj4gPmFkZHJlc3NlZCB0aGVyZSwgbm90IGluIHRoZSBQ
Q00gaG9vayBhdCBhbGwuCj4+ID4KPj4gPgo+PiA+dGhhbmtzLAo+PiA+Cj4+ID5UYWthc2hpCj4+
ID4KPj4gPj4gLS0tCj4+ID4+ICBzb3VuZC9oZGEvY29kZWNzL2NvbmV4YW50LmMgfCAyMSArKysr
KysrKysrKysrKysrKysrKysKPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
Cj4+ID4+IAo+PiA+PiBkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9jb25leGFudC5jIGIv
c291bmQvaGRhL2NvZGVjcy9jb25leGFudC5jCj4+ID4+IGluZGV4IDNkOTIyNjI3NjNmNi4uMzIy
OWY5ZWY1OTY5IDEwMDY0NAo+PiA+PiAtLS0gYS9zb3VuZC9oZGEvY29kZWNzL2NvbmV4YW50LmMK
Pj4gPj4gKysrIGIvc291bmQvaGRhL2NvZGVjcy9jb25leGFudC5jCj4+ID4+IEBAIC0xMTg0LDYg
KzExODQsMjQgQEAgc3RhdGljIHZvaWQgYWRkX2N4NTA1MV9mYWtlX211dGVzKHN0cnVjdCBoZGFf
Y29kZWMgKmNvZGVjKQo+PiA+PiAgICAgICAgICAgICAgICAgICAgc3BlYy0+Z2VuLmRhY19taW5f
bXV0ZSA9IHRydWU7Cj4+ID4+ICB9Cj4+ID4+ICAKPj4gPj4gK3N0YXRpYyB2b2lkIGN4dF9maXhl
ZF9taWNfYm9vc3Qoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBub2RlX2lkKQo+
PiA+PiArewo+PiA+PiArICAgICAgICAgICAgICAgICAgc3RydWN0IGNvbmV4YW50X3NwZWMgKnNw
ZWMgPSBjb2RlYy0+c3BlYzsKPj4gPj4gKyAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB2
YWx1ZSA9IDA7Cj4+ID4+ICsKPj4gPj4gKyAgICAgICAgICAgICAgICAgIHZhbHVlID0gc25kX2hk
YV9jb2RlY19yZWFkKGNvZGVjLCBub2RlX2lkLCAwLCBBQ19WRVJCX0dFVF9BTVBfR0FJTl9NVVRF
LCAwKTsKPj4gPj4gKyAgICAgICAgICAgICAgICAgIHNuZF9oZGFfY29kZWNfYW1wX3N0ZXJlbyhj
b2RlYywgbm9kZV9pZCwgSERBX0lOUFVULCAwLCBIREFfQU1QX1ZPTE1BU0ssIHZhbHVlKTsKPj4g
Pj4gK30KPj4gPj4gKwo+PiA+PiArc3RhdGljIHZvaWQgY3h0X2NhcHR1cmVfaG9vayhzdHJ1Y3Qg
aGRhX3BjbV9zdHJlYW0gKmhpbmZvLCAgc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCj4+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgaW50IGFjdGlv
bikKPj4gPj4gK3sKPj4gPj4gKyAgICAgICAgICAgICAgICAgIHN0cnVjdCBjb25leGFudF9zcGVj
ICpzcGVjID0gY29kZWMtPnNwZWM7Cj4+ID4+ICsgICAgICAgICAgICAgICAgICBoZGFfbmlkX3Qg
bXV4X3BpbiA9IHNwZWMtPmdlbi5pbXV4X3BpbnNbc3BlYy0+Z2VuLmN1cl9tdXhbMF1dOwo+PiA+
PiArCj4+ID4+ICsgICAgICAgICAgICAgICAgICBjeHRfZml4ZWRfbWljX2Jvb3N0KGNvZGVjLCBt
dXhfcGluKTsKPj4gPj4gK30KPj4gPj4gKwo+PiA+PiAgc3RhdGljIGludCBjeF9wcm9iZShzdHJ1
Y3QgaGRhX2NvZGVjICpjb2RlYywgY29uc3Qgc3RydWN0IGhkYV9kZXZpY2VfaWQgKmlkKQo+PiA+
PiAgewo+PiA+PiAgICAgICAgICAgICAgICAgICAgc3RydWN0IGNvbmV4YW50X3NwZWMgKnNwZWM7
Cj4+ID4+IEBAIC0xMjcxLDYgKzEyODksOSBAQCBzdGF0aWMgaW50IGN4X3Byb2JlKHN0cnVjdCBo
ZGFfY29kZWMgKmNvZGVjLCBjb25zdCBzdHJ1Y3QgaGRhX2RldmljZV9pZCAqaWQpCj4+ID4+ICAg
ICAgICAgICAgICAgICAgICBpZiAoZXJyIDwgMCkKPj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOwo+PiA+PiAgCj4+ID4+ICsgICAgICAgICAg
ICAgICAgICBpZiAoc3BlYy0+Z2VuLnBjbV9jYXB0dXJlX2hvb2sgPT0gTlVMTCkKPj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGVjLT5nZW4ucGNtX2NhcHR1
cmVfaG9vayA9IGN4dF9jYXB0dXJlX2hvb2s7Cj4+ID4+ICsKPj4gPj4gICAgICAgICAgICAgICAg
ICAgIC8qIFNvbWUgbGFwdG9wcyB3aXRoIENvbmV4YW50IGNoaXBzIHNob3cgc3RhbGxzIGluIFMz
IHJlc3VtZSwKPj4gPj4gICAgICAgICAgICAgICAgICAgICAqIHdoaWNoIGZhbGxzIGludG8gdGhl
IHNpbmdsZS1jbWQgbW9kZS4KPj4gPj4gICAgICAgICAgICAgICAgICAgICAqIEJldHRlciB0byBt
YWtlIHJlc2V0LCB0aGVuLgo+PiA+PiAtLSAKPj4gPj4gMi4zOS41Cj4+ID4+Cj4+IAo=
