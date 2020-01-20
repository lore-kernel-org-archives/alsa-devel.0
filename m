Return-Path: <SRS0=II5U=3J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FEC33CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:23:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798A2073D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YqkPsA6G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="hLd/2oa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD21A1668;
	Mon, 20 Jan 2020 09:22:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD21A1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579508601;
	bh=f3t1lb1Js5+6OXFJzMp0gqZuL1HhhUzVtJ7hwEQPsho=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqkPsA6GlbO1HJ+0r0NN38+Pm7nj/QJh7vV2L3XyMha3YBG8aMz1Y4NHMFlAVgUcA
	 wsPh9h9VFJyY502qQQM1PHua3AiKA/uz5TIJkeZHhMrzYhHrgQbHIOoqCq3hYxSp0l
	 8/58G79is2MItkEeDjLivoTyk909iRJyTxW23/Tg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 557C5F801D8;
	Mon, 20 Jan 2020 09:22:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D06FFF8020C; Mon, 20 Jan 2020 09:22:28 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61865F8013E
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2020 09:22:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61865F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="hLd/2oa3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0C4c8A0G7HnDVRI7NqynliifzkCP6nJ1HC7nsoRORRk=; b=hLd/2oa3OINwrX/fNEE7AE5EIc
 HoyUYLKES5IvscM8yuOIKsp5YMO1ZvDUTF5HXI+0rkl22PNT50dSd7IkTd7vX/cG32ksxuv+8KqCC
 gMmv5BicrLnZcl5DyjRB3Tv4W9XyPfZnNbj1A/f5E+xa/s2/YkIFPso5WkZAOsqtfMc8=;
Received: from [10.8.10.223] (helo=work)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1itSKB-0009aU-Dc; Mon, 20 Jan 2020 11:22:19 +0300
Message-ID: <697208e751dcbcc70cf00af7b625a4109b9c66cb.camel@tsoy.me>
From: Alexander Tsoy <alexander@tsoy.me>
To: Tobias <toszlanyi@yahoo.de>, alsa-devel@alsa-project.org
Date: Mon, 20 Jan 2020 11:22:18 +0300
In-Reply-To: <9457db14-4084-c0dd-5c89-821b35c3db66@yahoo.de>
References: <9457db14-4084-c0dd-5c89-821b35c3db66.ref@yahoo.de>
 <9457db14-4084-c0dd-5c89-821b35c3db66@yahoo.de>
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Subject: Re: [alsa-devel] USB Audio Interface / Denon MC7000 and MC8000
 controller
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

0JIg0KHQsSwgMTQvMTIvMjAxOSDQsiAwOToyNCArMDEwMCwgVG9iaWFzINC/0LjRiNC10YI6Cj4g
SGVsbG8gZGVhciBBTFNBIGRldmVsb3BlcnMuCj4gCj4gSSBoYXZlIHB1cmNoYXNlZCBhIE1DNzAw
MCBjb250cm9sbGVyIGluIG9yZGVyIHRvIGNvbnRyb2wgTUlYWFggb24KPiBVYnVudHUgCj4gMTYu
MDQuIEFjY29yZGluZyB0byB0aGUgRGVub24gc3BlY2lmaWNhdGlvbiB0aGUgY29udHJvbGxlciBz
aG91bGQKPiBoYXZlIAo+IGJlZW4gY2xhc3MgY29tcGxpYW50IGJ1dCB0aGVyZSBpcyBhbiBpc3N1
ZSB3aXRoIHRoZSBBdWRpbyBpbnRlcmZhY2UKPiB0byAKPiB3b3JrIHByb3Blcmx5IGdpdmluZyBm
b2xsb3dpbmcgbWVzc2FnZSAuLi4KPiAKPiAkIGRtZXNnCj4gLi4uCj4gPiBbICAgNzQuNTIyODMx
XSB1c2IgMS0xLjM6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDYgdXNpbmcKPiA+
IHhoY2lfaGNkCj4gWyAgIDc0LjYyMzc4NF0gdXNiIDEtMS4zOiBOZXcgVVNCIGRldmljZSBmb3Vu
ZCwgaWRWZW5kb3I9MTVlNCwgCj4gaWRQcm9kdWN0PTgwMDQKPiBbICAgNzQuNjIzNzg5XSB1c2Ig
MS0xLjM6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIAo+IFNlcmlh
bE51bWJlcj0zCj4gWyAgIDc0LjYyMzc5M10gdXNiIDEtMS4zOiBQcm9kdWN0OiBERU5PTiBESiBN
QzcwMDAKPiBbICAgNzQuNjIzNzk2XSB1c2IgMS0xLjM6IE1hbnVmYWN0dXJlcjogREVOT04gREoK
PiBbICAgNzQuNjIzNzk4XSB1c2IgMS0xLjM6IFNlcmlhbE51bWJlcjogMjAxNjAzCj4gWyAgIDc0
LjYyNTEzNF0gdXNiIDEtMS4zOiBjbG9jayBzb3VyY2UgNjUgaXMgbm90IHZhbGlkLCBjYW5ub3Qg
dXNlCj4gCj4gInx8fGNsb2NrIHNvdXJjZSA2NSBpcyBub3QgdmFsaWQsIGNhbm5vdCB1c2UiIGlz
IHJlcGVhdGVkCj4gdW5jb3VudGFibGUgCj4gdGltZXMgdGhlbgo+IAoKUGxlYXNlIHRyeSB0byBh
ZGQgZGVsYXkgYWZ0ZXIgZWFjaCBjbGFzcyBjb250cm9sIHJlcXVlc3QgaW4Kc25kX3VzYl9jdGxf
bXNnX3F1aXJrKCk6CgogICAgaWYgKGNoaXAtPnVzYl9pZCA9PSBVU0JfSUQoMHgxNWU0LCAweDgw
MDQpICYmCiAgICAgICAgKHJlcXVlc3R0eXBlICYgVVNCX1RZUEVfTUFTSykgPT0gVVNCX1RZUEVf
Q0xBU1MpCiAgICAgICAgbXNsZWVwKDIwKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
