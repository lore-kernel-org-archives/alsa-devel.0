Return-Path: <SRS0=zq5f=2U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A3C2D0C2
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:02:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC2D20718
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZKkqa5TI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="Moiet6hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC2D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 429E116DD;
	Mon, 30 Dec 2019 19:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 429E116DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577728972;
	bh=UCOiTXAlpzgIComtWuQIQLA4Qt/eCDemPHRBDzoHAp8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKkqa5TIzJ+AlITx2hXmEEczHFIx4mSzECHdxQaPch5WZqc9r0PoCLr4gIZBPC+AG
	 giZ+aTedEpBMcEoLd63o6pjiDtVTgNnh7/owUPLa+8L/SBQyfru3KbEtElTf6EzULo
	 H1m2qevoUUcAJvsc9X5RPoJotGKMhy4aCtDVusJ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFBDFF8015C;
	Mon, 30 Dec 2019 19:02:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2277F8015D; Mon, 30 Dec 2019 19:01:59 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47773F80126
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2019 19:01:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47773F80126
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="Moiet6hS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LC2mls3iJph4ndFcsxZTDLUO5zSiFYEQvxPzyVLXwSc=; b=Moiet6hS3ptiuxyXcjD6pPcWy8
 m48ZGJyD5KIGoLiiFN4rbWAsO3MmjekG/S4Qo0YyrR2eVAzPTFvBRNBUhR15rdTDg0kPS5LTtqJA0
 7C1sjgne8fVQBM/iKRH3QmucqGYqbmlTDin19UVl4VeBuAXFqg06ouICfVcZPVaTMPRo=;
Received: from [10.8.10.223] (helo=work)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1ilzMV-0004oY-Ri; Mon, 30 Dec 2019 21:01:51 +0300
Message-ID: <ad092f498c57ef0524f6dff887fb0d2305e99c71.camel@tsoy.me>
From: Alexander Tsoy <alexander@tsoy.me>
To: Tanu Kaskinen <tanuk@iki.fi>, Takashi Iwai <tiwai@suse.de>, 
 alsa-devel@alsa-project.org
Date: Mon, 30 Dec 2019 21:01:43 +0300
In-Reply-To: <f79b0618c66223e2df58e2fde619e0dcaadc549c.camel@iki.fi>
References: <20190727093006.9870-1-tiwai@suse.de>
 <f79b0618c66223e2df58e2fde619e0dcaadc549c.camel@iki.fi>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Subject: Re: [alsa-devel] [PATCH v2 0/2] ALSA: usb-audio: fix PCM device
 order
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

0JIg0JLRgSwgMjgvMDcvMjAxOSDQsiAxMjo1NiArMDMwMCwgVGFudSBLYXNraW5lbiDQv9C40YjQ
tdGCOgo+IE9uIFNhdCwgMjAxOS0wNy0yNyBhdCAxMTozMCArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+ID4gSGksCj4gPiAKPiA+IHRoaXMgaXMgYSByZXdyaXRlIG9mIHRoZSBvbGQgVVNCLWF1
ZGlvIGZpeCBwYXRjaCBJIG9idmlvdXNseQo+ID4gb3Zlcmxvb2tlZCB0byBhZGFwdCB0byA1LjMg
a2VybmVsIHdpdGggYSBwcmVsaW1pbmFyeSBjbGVhbnVwIHBhdGNoLgo+ID4gCj4gPiBUb3RhbGx5
IHVudGVzdGVkLCBzbyBhbnkgdGVzdCAvIGZlZWRiYWNrIHdvdWxkIGJlIGFwcHJlY2lhdGVkLgo+
IAo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoZXMhIFVuZm9ydHVuYXRlbHkgSSBjYW4ndCB0ZXN0IHRo
ZW0sIGFuZCB0aGUKPiByZXBvcnRlciB3aG8gcHJvbXB0ZWQgbWUgdG8gcGluZyBhcHBhcmVudGx5
IGlzbid0IGdvaW5nIHRvIHRlc3QgdGhlbQo+IGVpdGhlci4gSG9wZWZ1bGx5IHRoZSBwYXRjaGVz
IGFyZSBzdGlsbCByZWxldmFudCB0byBBbGV4YW5kZXIgc28KPiBtYXliZQo+IGhlIGNvdWxkIHRl
c3QgdGhlbS4KClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSwgSSBtZXNzZWQgdXAgbXkgbWFpbCBm
aWx0ZXJzLiBIVUQtbXgyIG5vdwp3b3JrcyBhcyBleHBlY3RlZCB3aXRob3V0IHdvcmthcm91bmRz
IGluIGFsc2Egb3IgcHVsc2UuIFRlc3RlZCB3aXRoCjUuNC54LiBUaGFua3MhCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
