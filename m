Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D5C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:27:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2893820838
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q/fgVHhZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="If5zr7ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2893820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80B3E15F8;
	Mon, 10 Feb 2020 16:27:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80B3E15F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581348476;
	bh=S1f60uO84uHC5x69jobW6uaz1tMRyJ9lg2lzSKR96YU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/fgVHhZg++TkGEw4C8XNru8qHccmJKcR75GKnyo+di6aAFXKNR1f/EEaPqhgfowY
	 cgBOPiiuCs22FwoR1VWpShsDwWsXB4gXvfOVK/33lT4V+wTiWGCQ6ThOeVsUPYDq4V
	 mi60DhXuY1BET3WH1jiz2LKFJHFW7FjFdatvWnIo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBEAAF8014F;
	Mon, 10 Feb 2020 16:27:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 508E4F80157; Mon, 10 Feb 2020 16:27:03 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DC32F80118
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 16:26:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DC32F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="If5zr7ng"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AFQtd0029300;
 Mon, 10 Feb 2020 09:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1581348415;
 bh=PE0/niZ0NJN+ktbHMsqTxiXJMvJZVgZpeLZrw49S0gA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=If5zr7ng27VO4qW11rsYUoXwaWY8sxlS9ywIycau1SdqM86om6cEz+EukdwsCtBEW
 JPznHvE/BwJCWjPBMPaz77OLMoPqS3cQkXS+MQAKPOsqaUEMaXEp+Fc8dScKwMcfhZ
 lU0tH87xBxL5vB1pgV7r81ul5HVOl46lTQ9c8bYE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AFQtiG084574
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2020 09:26:55 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 09:26:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 09:26:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AFQqr0041110;
 Mon, 10 Feb 2020 09:26:52 -0600
To: Takashi Iwai <tiwai@suse.de>
References: <20200210151402.29634-1-peter.ujfalusi@ti.com>
 <s5ha75qfoum.wl-tiwai@suse.de>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7b2014d6-3c85-0f2b-c01f-3bfd8112dca1@ti.com>
Date: Mon, 10 Feb 2020 17:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <s5ha75qfoum.wl-tiwai@suse.de>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH v2] ALSA: dmaengine_pcm: Consider DMA cache
 caused delay in pointer callback
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

CgpPbiAxMC8wMi8yMDIwIDE3LjIzLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gT24gTW9uLCAxMCBG
ZWIgMjAyMCAxNjoxNDowMiArMDEwMCwKPiBQZXRlciBVamZhbHVzaSB3cm90ZToKPj4KPj4gU29t
ZSBETUEgZW5naW5lcyBjYW4gaGF2ZSBiaWcgRklGT3Mgd2hpY2ggYWRkcyB0byB0aGUgbGF0ZW5j
eS4KPj4gVGhlIERNQWVuZ2luZSBmcmFtZXdvcmsgY2FuIHJlcG9ydCB0aGUgRklGTyB1dGlsaXph
dGlvbiBpbiBieXRlcy4gVXNlIHRoaXMKPj4gaW5mb3JtYXRpb24gZm9yIHRoZSBkZWxheSByZXBv
cnRpbmcuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVz
aUB0aS5jb20+Cj4+IC0tLQo+PiBIaSwKPj4KPj4gQ2hhbmdlcyBzaW5jZSB2MToKPj4gLSB1c2Ug
Ynl0ZXNfdG9fZnJhbWVzKCkgZm9yIHRoZSBETUEgZGVsYXkgY2FsY3VsYXRpb24KPj4gLSBEcm9w
IGNoYW5nZXMgdG8gc29jLXBjbQo+Pgo+PiA1LjYtcmMxIG5vdyBoYXZlIHN1cHBvcnQgZm9yIHJl
cG9ydGluZyB0aGUgRE1BIGNhY2hlZCBkYXRhLgo+PiBXaXRoIHRoaXMgcGF0Y2ggd2UgY2FuIGlu
Y2x1ZGUgaXQgdG8gdGhlIGRlbGF5IGNhbGN1bGF0aW9uLgo+PiBUaGUgZmlyc3QgRE1BIGRyaXZl
ciB3aGljaCByZXBvcnRzIHRoaXMgaXMgdGhlIFRJIEszIFVETUEgZHJpdmVyLgo+Pgo+PiBSZWdh
cmRzLAo+PiBQZXRlcgo+Pgo+PiAgc291bmQvY29yZS9wY21fZG1hZW5naW5lLmMgfCA1ICsrKysr
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9z
b3VuZC9jb3JlL3BjbV9kbWFlbmdpbmUuYyBiL3NvdW5kL2NvcmUvcGNtX2RtYWVuZ2luZS5jCj4+
IGluZGV4IDU3NDlhOGE0OTc4NC4uZDhiZTdiNDg4MTYyIDEwMDY0NAo+PiAtLS0gYS9zb3VuZC9j
b3JlL3BjbV9kbWFlbmdpbmUuYwo+PiArKysgYi9zb3VuZC9jb3JlL3BjbV9kbWFlbmdpbmUuYwo+
PiBAQCAtMjQ3LDkgKzI0NywxNCBAQCBzbmRfcGNtX3VmcmFtZXNfdCBzbmRfZG1hZW5naW5lX3Bj
bV9wb2ludGVyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQo+PiAgCj4+ICAJ
c3RhdHVzID0gZG1hZW5naW5lX3R4X3N0YXR1cyhwcnRkLT5kbWFfY2hhbiwgcHJ0ZC0+Y29va2ll
LCAmc3RhdGUpOwo+PiAgCWlmIChzdGF0dXMgPT0gRE1BX0lOX1BST0dSRVNTIHx8IHN0YXR1cyA9
PSBETUFfUEFVU0VEKSB7Cj4+ICsJCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBz
dWJzdHJlYW0tPnJ1bnRpbWU7Cj4+ICsKPj4gIAkJYnVmX3NpemUgPSBzbmRfcGNtX2xpYl9idWZm
ZXJfYnl0ZXMoc3Vic3RyZWFtKTsKPj4gIAkJaWYgKHN0YXRlLnJlc2lkdWUgPiAwICYmIHN0YXRl
LnJlc2lkdWUgPD0gYnVmX3NpemUpCj4+ICAJCQlwb3MgPSBidWZfc2l6ZSAtIHN0YXRlLnJlc2lk
dWU7Cj4+ICsKPj4gKwkJcnVudGltZS0+ZGVsYXkgPSBieXRlc190b19mcmFtZXMocnVudGltZSwK
Pj4gKwkJCQkJCSBzdGF0ZS5pbl9mbGlnaHRfYnl0ZXMpOwo+IAo+IEFub3RoZXIgY2FsbCBvZiBi
eXRlc190b19mcmFtZXMoKSBiZWxvdy4uLgo+IAo+PiAgCX0KPj4gIAo+PiAgCXJldHVybiBieXRl
c190b19mcmFtZXMoc3Vic3RyZWFtLT5ydW50aW1lLCBwb3MpOwo+IAo+IC4uLiByZWZlcnMgdG8g
c3Vic3RyZWFtLT5ydW50aW1lLgo+IEJldHRlciB0byBhbGlnbiBib3RoIHBsYWNlcywgZWl0aGVy
IHJ1bnRpbWUgb3Igc3Vic3RyZWFtLT5ydW50aW1lLgoKU3VyZSwgSSdsbCB1c2UgdGhlIHJ1bnRp
bWUgYXMgd2l0aCBzdWJzdHJlYW0tPnJ1bnRpbWUgdGhlIGRlbGF5IHBhcnQgaXMKbm90IG5pY2Vs
eSB3cmFwcGluZy4KCj4gV2l0aCB0aGF0IG1pbm9yIG5pdHBpY2ssIHRoZSBjaGFuZ2UgbG9va3Mg
Z29vZDoKPiBSZXZpZXdlZC1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgo+IAo+IAo+
IHRoYW5rcywKPiAKPiBUYWthc2hpCj4gCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlu
bGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2lu
ZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
