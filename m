Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A5C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:31:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BB924676
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hLC9qyNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BB924676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED64284F;
	Fri, 20 Dec 2019 02:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED64284F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576805485;
	bh=HjQNG1BfktIDFB8TGz5YQ0F6wlTxBYu7Olnyb4S5soM=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hLC9qyNBwVwbrSAlGc4C07oKameUeBV3FavT71UMBN3vueekWnEdumulF3TotDZe1
	 7Qk+jq3b7mxM95jV8x1B5Lyx6EqLLbACubDUuLA37qHDOCi74VN7U9rkGx1VDvD3lb
	 XUXKlyuEvbGkQaPLkF2ZH41kNrdc/ecSV6LwUCzI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FA56F80218;
	Fri, 20 Dec 2019 02:30:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FB9BF80234; Fri, 20 Dec 2019 02:30:30 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A85F0F8013E
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 02:30:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A85F0F8013E
Received: from [123.112.71.136] (helo=[192.168.1.106])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1ii77W-0007xh-L8; Fri, 20 Dec 2019 01:30:22 +0000
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
References: <20191216125136.6709-1-hui.wang@canonical.com>
 <084ab279-3eef-e1bb-070b-1e4f1c8f26c7@perex.cz>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <5cf4dc70-9128-5981-d722-c4bde2e5b790@canonical.com>
Date: Fri, 20 Dec 2019 09:30:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <084ab279-3eef-e1bb-070b-1e4f1c8f26c7@perex.cz>
Content-Language: en-US
Subject: Re: [alsa-devel] [alsa-lib][PATCH] conf: SOF-Intel: map pcm device
	for sof driver
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

Ck9uIDIwMTkvMTIvMTcg5LiK5Y2INTowMCwgSmFyb3NsYXYgS3lzZWxhIHdyb3RlOgo+IERuZSAx
Ni4gMTIuIDE5IHYgMTM6NTEgSHVpIFdhbmcgbmFwc2FsKGEpOgo+PiBPbiB0aGUgbWFjaGluZXMg
d2l0aCBIREEgY29kZWMsIHRoZSBzb2YgZHJpdmVyIHdpbGwgdXNlIHRoZSBsZWdhY3kgaGRhCj4+
IGNvZGVjIGRyaXZlciwgYXMgYSByZXN1bHQsIG1vc3QgbWl4ZXIgY29udHJvbHMgYXJlIHNhbWUg
YXMgYmVmb3JlLgo+Pgo+PiBUaGVyZSBhcmUgb25seSAyIGRpZmZlcmVuY2U6Cj4+IMKgIC0gSERN
SSBwY20gaW5kZXggaXMgMywgNCBhbmQgNSBpbnN0ZWFkIG9mIDMsIDcsIDguLi4KPj4gwqAgLSBk
bWljIGlzIG9uIGRldmljZSA2LCA3IGluc3RlYWQgb2YgMAo+Pgo+PiBBZnRlciBhcHBseWluZyB0
aGlzIHBhdGNoLCB3ZSB3aWxsIGdldCAoYXBsYXkgLUwpOgo+PiBoZG1pOkNBUkQ9c29mc2tsaGRh
Y2FyZCxERVY9MAo+PiDCoMKgwqDCoCBzb2Ytc2tsX2hkYV9jYXJkLAo+PiDCoMKgwqDCoCBIRE1J
IEF1ZGlvIE91dHB1dAo+PiBoZG1pOkNBUkQ9c29mc2tsaGRhY2FyZCxERVY9MQo+PiDCoMKgwqDC
oCBzb2Ytc2tsX2hkYV9jYXJkLAo+PiDCoMKgwqDCoCBIRE1JIEF1ZGlvIE91dHB1dAo+PiBoZG1p
OkNBUkQ9c29mc2tsaGRhY2FyZCxERVY9Mgo+PiDCoMKgwqDCoCBzb2Ytc2tsX2hkYV9jYXJkLAo+
PiDCoMKgwqDCoCBIRE1JIEF1ZGlvIE91dHB1dAo+Pgo+PiBhbmQgKGFyZWNvcmQgLUwpOgo+PiBk
bWljOkNBUkQ9c29mc2tsaGRhY2FyZCxERVY9MAo+PiDCoMKgwqDCoCBzb2Ytc2tsX2hkYV9jYXJk
LAo+PiDCoMKgwqDCoCBEaWdpdGFsIE1pYyBjb25uZWN0ZWQgdG8gdGhlIFBDSCBkaXJlY3RseQo+
PiBkbWljOkNBUkQ9c29mc2tsaGRhY2FyZCxERVY9MQo+PiDCoMKgwqDCoCBzb2Ytc2tsX2hkYV9j
YXJkLAo+PiDCoMKgwqDCoCBEaWdpdGFsIE1pYyBjb25uZWN0ZWQgdG8gdGhlIFBDSCBkaXJlY3Rs
eQo+Pgo+PiBUaGVuIHdlIGNvdWxkIGFkZCBtaW5vciBjaGFuZ2VzIGluIHRoZSBwdWxzZWF1ZGlv
IGNvbmZpZ3VyYXRpb24sIGFmdGVyCj4+IHRoYXQsIGFsbCBvdXRwdXQgYW5kIGlucHV0IGRldmlj
ZXMgd2lsbCB3b3JrIHVuZGVyIHB1bHNlYXVkaW8uCj4+Cj4+IFRoaXMgaXMgYSBzdXBwbGVtZW50
IGZvciB1Y20sIHRoZSB1Y20gZm9yIHNvZiBkcml2ZXIgaGFzIGhpZ2hlcgo+PiBwcmlvcml0eSB0
aGFuIHRoaXMgY29uZiwgaWYgdGhlcmUgaXMgbm8gdWNtIGZvciBzb2YgZHJpdmVyLCB0aGlzIGNv
bmYKPj4gd2lsbCB0YWtlIGVmZmVjdC4KPgo+IEV4YWN0bHkuIFRoZSBkbWljIGRlZmluaXRpb25z
IHNob3VsZCBub3QgYmUgYSBzdGFuZGFyZCBpbiBteSBleWVzLiBJIAo+IHdvdWxkIG5vdCBsaWtl
IHRvIGFjY2VwdCB0aGlzLiBJIGNhbiBhY2NlcHQgdGhlIHN0YW5kYXJkIGRlZmluaXRpb25zIAo+
IGZvciB0aGUgcGxheWJhY2sgZGV2aWNlcyBmb3IgdGhpcyBkcml2ZXIsIGJ1dCBVQ00gd2lsbCBy
ZXBsYWNlIAo+IGV2ZXJ5dGhpbmcuIEl0J3MgYmV0dGVyIHRvIGRlZmluZSB0aGUgc3BlY2lhbCBQ
QSBjb25maWcgZm9yIG5vdyB1bnRpbCAKPiB3ZSByZXNvbHZlIGFsbCB0aGUgVUNNIGlzc3VlcyBs
aWtlOgo+Cj4gaHR0cDovL3Blb3BsZS5yZWRoYXQuY29tL35qa3lzZWxhL3NvZi9jYXJib24teDEt
cHVsc2UudGFyLmd6Mgo+Cj4gVGhlIDJuZCBQQSBVQ00gcGF0Y2hzZXQgd2hpY2ggaXMgd29ya2lu
ZyB3aXRoIHRoZSBjdXJyZW50IFVDTSBpbiAKPiBBTFNBJ3MgcmVwb3MgZm9yIHRoaXMgaGFyZHdh
cmU6Cj4KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvcHVsc2VhdWRpby9wdWxzZWF1
ZGlvL21lcmdlX3JlcXVlc3RzLzIxNwo+Cj4gQnV0IGl0IGlzIGp1c3QgYSBzdGFydC4gVGhlcmUg
YXJlIHBsZW50eSB1bnJlc29sdmVkIGFic3RyYWN0aW9uIGlzc3VlcyAKPiB3aXRoIHRoaXMuCgpZ
ZXMsIHVjbSBpcyBtb3JlIHBvd2VyZnVsIGFuZCBzaG91bGQgYmUgdGhlIGRlZmF1bHQgY2hvaWNl
IGZvciB1c2VycyAKd2l0aCBzb2YgZHJpdmVyK2hkYSBjb2RlYy4gQnV0IHRoZXJlIGFyZSAyIGlz
c3VlczoKCiDCoMKgIDEuwqAgdG9vIGNvbXBsaWNhdGVkLCBub3QgZWFzeSB0byBiYWNrcG9ydCBh
bGwgcGF0Y2hlcyB0byBvbGQgdmVyc2lvbiAKbGludXggZGlzdHJpYnV0aW9uLCBsaWtlIHVidW50
dSAxOC4wNCBMVFMgKHdpdGggYWxzYS1saWIgMS4xLjMgYW5kIFBBIHYxMS4xKQoKIMKgwqAgMi4g
bm8gZ2VuZXJpYyB1Y20gY29uZnMgZm9yIG1vc3QgbWFjaGluZXMsIG5lZWQgdG8gd3JpdGUgdWNt
IGNvbmZzIAptYWNoaW5lIGJ5IG1hY2hpbmUgKGV4aXN0aW5nIFBBIGNhbiBydW50aW1lIGRlY2lk
ZS9idWlsZMKgIGEgbWFjaGluZSdzIApjb25mLCBubyBuZWVkIHRvIHdyaXRlIGNvbmYgbWFjaGlu
ZSBieSBtYWNoaW5lKQoKCkFmdGVyIHdlIGhhdmUgc3RoIGxpa2UgYmVsb3c6IChpZiB0aGUgbmFt
ZSBkbWljIGlzIG5vdCBnb29kLCB3ZSBjb3VsZCAKY2hhbmdlIGl0IHRvIGJlIGEgbW9yZSByZWFz
b25hYmxlIG5hbWUpCgpkbWljOkNBUkQ9c29mc2tsaGRhY2FyZCxERVY9MAogwqDCoMKgwqAgc29m
LXNrbF9oZGFfY2FyZCwKIMKgwqDCoMKgIERpZ2l0YWwgTWljIGNvbm5lY3RlZCB0byB0aGUgUENI
IGRpcmVjdGx5CmRtaWM6Q0FSRD1zb2Zza2xoZGFjYXJkLERFVj0xCiDCoMKgwqDCoCBzb2Ytc2ts
X2hkYV9jYXJkLAogwqDCoMKgwqAgRGlnaXRhbCBNaWMgY29ubmVjdGVkIHRvIHRoZSBQQ0ggZGly
ZWN0bHkKCldlIGp1c3QgbmVlZCB0byBkbyBhIHNpbXBsZSBjaGFuZ2UgaW4gdGhlIFBBJ3MgY29u
ZiwgdGhlIGF1ZGlvIGJhc2ljYWxseSAKY291bGQgd29yayAoaW5jbHVkZSB0aGUgYXVkaW8tZGV2
aWNlLXNlbGVjdGlvbi1wb3B1cC1kaWFsb2d1ZSBhbmQgCm1pYy1tdXRlIGxlZCBvbiBMZW5vdm8g
bWFjaGluZSkuIE9mIGNvdXJzZSBpdCBkb2Vzbid0IHdvcmsgcGVyZmVjdGx5IHNvIApmYXIsIGJl
Y2F1c2UgZG1pYyBpcyBub3QgY29ubmVjdGVkIHRvIHRoZSBjb2RlYywgc28gaXQgaXMgaW4gYSAK
c3RhbmRhbG9uZSBzb3VyY2UgaW4gdGhlIFBBLCB3ZSBuZWVkIHRvIHdyaXRlIHNvbWUgY29kZSB0
byBoYW5kbGUgaXQuCgpUaGlzIGlzIHRoZSBzaW1wbGUgY2hhbmdlIGluIHRoZSBQQSdzIGNvbmY6
IApodHRwczovL3Bhc3RlYmluLnVidW50dS5jb20vcC9Ubm1rcjZEMkt2LwoKClRoYW5rcywKCkh1
aS4KCgo+Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBK
YXJvc2xhdgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
