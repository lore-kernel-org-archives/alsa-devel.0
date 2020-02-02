Return-Path: <SRS0=WHla=3W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD6C35249
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 23:51:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B282067C
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 23:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nZV8hmtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B282067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=larkos.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F6EB1682;
	Mon,  3 Feb 2020 00:50:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F6EB1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580687486;
	bh=rntWv8C0b6dvLdO64a2pQ0SVNaIeh6cKCQwDLDZYZwY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZV8hmtSSjSzcury5aX8Sy9x+4zB3wSy4FliIecnmqbm5JuyaW30sDPzt7F0pZl2o
	 NTSNa1rd3IICpNQsg8KZXjgIAlGsWZj2lkuUxNuKcRQlQOBknX4mVpIdkhyHS6OVNM
	 6hwFiwLpxFNyk2aaFr0/jUXGw1Xc+0agrQQkUU8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECF2CF800B8;
	Mon,  3 Feb 2020 00:50:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B49BF80162; Mon,  3 Feb 2020 00:50:32 +0100 (CET)
Received: from larkos.de (larkos.de [188.68.52.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B83BF800B8
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2020 00:50:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B83BF800B8
Received: from a89-182-228-91.net-htp.de ([89.182.228.91]
 helo=[192.168.178.12])
 by larkos.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <martin@larkos.de>)
 id 1iyP0P-0005ci-Qc; Mon, 03 Feb 2020 00:50:22 +0100
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
References: <20191119084710.29267-5-nmahale@nvidia.com>
 <0b827293-cc8b-3c3e-9160-565037ff172b@larkos.de>
 <s5hmua18jvr.wl-tiwai@suse.de>
 <3a15996e-1b8f-b5f0-77da-2fcfa8334bcb@larkos.de>
 <cbf24d05-9bff-4aba-0f7a-601a949e98a5@perex.cz>
From: Martin Regner <martin@larkos.de>
Message-ID: <1ba208d8-4a65-c7ab-283e-ba9850edd94f@larkos.de>
Date: Mon, 3 Feb 2020 00:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <cbf24d05-9bff-4aba-0f7a-601a949e98a5@perex.cz>
Content-Language: en-GB
Cc: nmahale@nvidia.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 aplattner@nvidia.com
Subject: Re: [alsa-devel] [PATCH v3 4/4] ALSA: hda - Add DP-MST support for
 NVIDIA codecs
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

SGkgSmFyb3NsYXYsCgp0aGFua3MgZm9yIHRoZSB0aXAuIEkgdHJpZWQgdGhpcyAoaW4gbXkgY2Fz
ZSBlY2hvIG9uwqAgPiAKL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMFw6MDlcOjAwLjEvcG93ZXIv
Y29udHJvbCkgYnV0IHRoYXQgZGlkbid0IGhlbHAuCgpJZiBpIGNvbW1lbnQgb3V0IHRoZSBsaW5l
CgpzcGVjLT5keW5fcGNtX2Fzc2lnbiA9IHRydWU7CgppbiBwYXRjaF9udmhkbWkgc291bmQgaXMg
d29ya2luZyBhZ2Fpbi4KCkN1cmlvdXNseSBub2JvZHkgZWxzZSBzZWVtcyB0byBoYXZlIHRoaXMg
cHJvYmxlbS4gVGhpcyBtYWtlcyBtZSB0aGluayAKdGhlIHByb2JsZW0gbGllcyBlbHNld2hlcmUg
YnV0IGkgaGF2ZSBubyBtb3JlIGlkZWFzIGF0IHRoZSBtb21lbnQuCgpPbiAwMy4wMi4yMCAwMDow
MCwgSmFyb3NsYXYgS3lzZWxhIHdyb3RlOgo+IERuZSAwMi4gMDIuIDIwIHYgMTU6MTggTWFydGlu
IFJlZ25lciBuYXBzYWwoYSk6Cj4+IEhpIFRha2FzaGksCj4+Cj4+IHRoYW5rcyBmb3IgeW91ciBy
ZXBseS4gSSB0cmllZCB0aGF0IHdpdGgKPj4KPj4gY2F0IC9wcm9jL2Fzb3VuZC9jYXJkMC9jb2Rl
YyMwCj4+Cj4+IGJ1dCB0aGF0IGRvZXNuJ3QgaGVscC4gSSdtIGRpZ2dpbmcgbWUgdGhyb3VnaCB0
aGUga2VybmVsIGNvbmZpZyByaWdodAo+PiBub3cuIE1heSBoYXZlIHRvIGNoYW5nZSBzb21ldGhp
bmcgZWxzZS4KPj4KPj4gSSBzaW1wbHkgY291bGQgY3JlYXRlIGEgcGF0Y2ggb24gbXkgZ2VudG9v
IHN5c3RlbSBzd2l0Y2hpbmcgZnJvbQo+PiBwYXRjaF9udmhkbWkgdG8gcGF0Y2hfbnZoZG1pX2xl
Z2FjeSBmb3IgZXZlcnkgbmV3IGtlcm5lbCwgYnV0IHRoYXQgd29uJ3QKPj4gd29yayBmb3JldmVy
Lgo+Pgo+PiBJZiB5b3UgaGF2ZSBvdGhlciB0aGlua3MgaSBjb3VsZCB0cnkgaSdkIGFwcHJlY2lh
dGUgdG8gaGVhciB0aGVtLgo+Cj4gWW91IG1heSB0cnkgdG8gZGlzYWJsZSBQTToKPgo+IGVjaG8g
b24gPiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwXDowMVw6MDAuMS9wb3dlci9jb250cm9sCj4K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSmFyb3NsYXYKPgo+Cj4+Cj4+IGtpbmQg
cmVnYXJkcwo+PiBNYXJ0aW4KPj4KPj4gT24gMDIuMDIuMjAgMDk6MzcsIFRha2FzaGkgSXdhaSB3
cm90ZToKPj4+IE9uIFNhdCwgMDEgRmViIDIwMjAgMTY6Mjg6MDggKzAxMDAsCj4+PiBNYXJ0aW4g
UmVnbmVyIHdyb3RlOgo+Pj4+IEhpIHRoZXJlLAo+Pj4+Cj4+Pj4gc2luY2UgaSB1cGRhdGVkIHRv
IGtlcm5lbCA1LjUgaSBoYXZlIG5vIHNvdW5kIG92ZXIgaGRtaSBhbnltb3JlIAo+Pj4+IChHZUZv
cmNlIFJUWAo+Pj4+IDIwNzApLgo+Pj4+Cj4+Pj4gV2l0aCB0aGUgcHJldmlvdXMga2VybmVsIDUu
NC4xNCBldmVyeXRoaW5nIGlzIGZpbmUuCj4+Pj4KPj4+PiBBbHRob3VnaCBpIGdvdCBzb3VuZCB3
aXRoIHNwZWFrZXItdGVzdCAtRCBoZG1pOkNBUkQ9TlZpZGlhLERFVj0yIC1jIAo+Pj4+IDIgLXIK
Pj4+PiA0NDEwMCwgcGF2dWNvbnRyb2wgc2hvd3MgYWxsIGhkbWkgc291bmQgZGV2aWNlcyBhcyB1
bnBsdWdnZWQuCj4+Pj4KPj4+PiBJIGJpc2VjdGVkIGl0IGRvd24gdG8gdGhpcyBjb21taXQgCj4+
Pj4gKDUzOThlOTRmYjc1M2QwMjIzMDE4MjVlYmZhNWY3Y2Y4YTY2MGQ4ZWIpCj4+Pj4gYW5kIGNo
YW5nZWQgdGhlIGxpbmUKPj4+Pgo+Pj4+IEhEQV9DT0RFQ19FTlRSWSgweDEwZGUwMDkzLCAiR1BV
IDkzIEhETUkvRFAiLMKgIHBhdGNoX252aGRtaSkKPj4+Pgo+Pj4+IHRvCj4+Pj4KPj4+PiBIREFf
Q09ERUNfRU5UUlkoMHgxMGRlMDA5MywgIkdQVSA5MyBIRE1JL0RQIiwgcGF0Y2hfbnZoZG1pX2xl
Z2FjeSkKPj4+Pgo+Pj4+IE5vdyBpdCdzIHdvcmtpbmcgYWdhaW4uIEknbSBub3Qgc3VyZSBpZiB0
aGlzIGlzIGEgcHJvYmxlbSB3aXRoIAo+Pj4+IHB1bHNlYXVkaW8gb3IKPj4+PiBpZiB0aGUgUlRY
IDIwNzAgZG9lcyBub3Qgc3VwcG9ydCB0aGUgbWVudGlvbmVkIGNvZGVjLgo+Pj4gVGhlIHJ1bnRp
bWUgUE0gdHVybnMgb2ZmIHRoZSBsaW5rLCBzbyB0aGUgaG90cGx1ZyBub3RpZmljYXRpb24gd29u
J3QKPj4+IGJlIGRlbGl2ZXJlZCBhcyBkZWZhdWx0LsKgIFBsZWFzZSB0cnkgcmVhZGluZyB0aGUg
Y29ycmVzcG9uZGluZyBwcm9jCj4+PiBmaWxlLCAvcHJvYy9hc291bmQvY2FyZCovY29kZWMqIGZp
bGUuwqAgVGhpcyBtYXkgcG93ZXIgdXAgdGhlIGNvZGVjIGFuZAo+Pj4gdHJpZ2dlciB0aGUgaG90
cGx1ZyBkZXRlY3Rpb24gaWYgdGhhdCdzIHRoZSBjYXVzZS4KPj4+Cj4+Pgo+Pj4gVGFrYXNoaQo+
Pgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+PiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
Pj4gaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCj4+Cj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
