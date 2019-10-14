Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC696ECE587
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66517217D9
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="axC4xbbj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZDvHX/Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66517217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC5A61616;
	Mon, 14 Oct 2019 17:45:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC5A61616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571068005;
	bh=vEnF7QUIYLiE2r5Z1XACZEF4jTHmizNVtFLETBIj6w8=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=axC4xbbjzDR0TSzFs/enuPHkHs3ehgKoq2CNJNAi/hDWB9yRF7Q3STwdZ74lJRpvr
	 e47hHcW9UqUxhFKGcXefrMG6wedGPcVYANfuOn5ahmPip+qdUmmKTWySOzmsM3NgSv
	 /vKRGb+1z0Up+2XNML0ON8Yv5xDs6/6RzqER1J4M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC61F80376;
	Mon, 14 Oct 2019 17:45:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D69B6F80377; Mon, 14 Oct 2019 17:45:17 +0200 (CEST)
Received: from sonic307-54.consmr.mail.ir2.yahoo.com
 (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26CEEF80212
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 17:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26CEEF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.b="ZDvHX/Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1571067913; bh=wxBNcJTJFjRsDmN3jKjPSIWyJPB7cqYATR4k87ZsJrg=;
 h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject;
 b=ZDvHX/Vb94fm0GNbmQylESDl42Wr+mzU3OFT03D9uDP3486bOUWbuNVRcLpifJvqVs/KBhu2LSd+lp9LEvzYG1auRGiIwJoOshvtdUJqtuhzbJsp37fbxgoH2IB/7rCxL5qxbv5Ubt3MpYCqFJ5WDVIWM17A73ixReGnKyxDNKIsZx24SKwdeHxL/dp6bt0SDO8dcCSsLXvnvWsM/3MldW+MXGtqRAyq1+bNrdQQxJlZkiHblsUscdfM72QzD1pnuYZGaO52S5zIH9PcCdjJOtJHoxBIYnsxPd/lpfPmwNoNRlI6V/SQ1SOsTRcQVCt9C0TOhXIk6RgQKfIhj1Zd3w==
X-YMail-OSG: wtpL8pgVM1k7ztMsgrAXcUbGWKdIV5Jpz.PduVX0GV6X_dayTa0X2EJI94FZG7Z
 tmOB8YoSkGdI3qcieYLAoB0T1rwlNovk8KwGpWQakY1PconU4m_HODz4WNaoiPW8.9AUMuiotfoR
 9kiMOF00WyQkRwUJkSMLPUZncnLeE6E6SMe8lWt2x7CDEYyrJvFXkqOeJi95wsWRcPl7vzq4jrTG
 0bsFkQ1x7va5mksyRhW8i6d8CzY83kQfRB.QZ8TzF_ZGd3odXBWrOTHBW3WZEP6vL6_pmpCZ4Ty_
 g.3XPcFZmLhp53rTgDLV6qsrWNF7LEHe703OVrXusHOw5yp4bSMLQnEJ0jULU.qMBWm2epBEcrs2
 MWq83IqwauHXiZZ55LjRbw4y5RB7_JMjq_EBHn_E_nkKDuDeHD3G1sNuIAJAagu3hn_kLcKIgGr9
 BwvixyPao3xngZRwY6yk5LbdOY0tmYuqZHYZyvYYxy.80bIwwtazXTaW64mkQG8VGHQeDcNdYscf
 8wqgLuoEY6OFWgbdqaaRFLtsoZxPX5GyVC91YuD3x0AXSMk6ryYeZeZoS35pxIxTbFEKwSvSTsyc
 RomccqbB94pigODwzAzLhvO3XwEWfDNgGlZKHEi6WVF0cZ7dPGeoqZ2pNvEnQ_Z5kFZXVxK3ejXP
 7I0T778RQT869iQbpuoivVRzK8XD9aCKaOFoQFkEDNcH9.WNSn9O..Q__DKyEg6bk3kkHsxQvI.Y
 uGClVXmSrkX8U2Of671lHRwo167xmWsa4VP0z.daZag7Ryd3lo1hqC0K.bOQT4VpsJ8_BdCVGHYW
 uDx7G0KZpFYk_hrOHyfHmmRW9q5os6peCjUYQxFotjxHLBo1NAs81L4tipifBW0oVUNd.cdR39D9
 tVpDnuG2eRAExznlkbWlRQ0oBoaNW8vneA3skk7m4KDN_hkP71SjzBrkkQ1Z3G8DrCt5Fp9lUTyr
 LaJuiIuLYxluaZkInbi2i9gbxpcWCfaZ.5Rn9FWSgAam263SnRhmzJAx98lrbIJgJIiFzQ6UUf8C
 c4R2xZmeUbp03UrtKQQSPUCa8Y.UnvhH1ToA27BfGE32PyYKeNhJTCCzcUI2q2xUi98NQm9IEzbs
 IK4t69jJ.WElZ4p0RZSpfHkYAkj.W2_qPdNid_hNgPDvkHreTJyTlAOwsW6NoJ8B94W.4sRvmO9G
 JstydToL.lkD_7.g43ifymRQa.yHt8KssNGMtSmk2odgJVTxS2dcRNKDrn3yFYocAuvbB9cLF4U4
 YEgX1rR2YkkZXw6eiPHpW4UlPC9mQAGkGtS..lV6tDgxinhwm9Cx_srEyWNzPVaaX8ObqluV00Wk
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.ir2.yahoo.com with HTTP; Mon, 14 Oct 2019 15:45:13 +0000
Date: Mon, 14 Oct 2019 15:45:09 +0000 (UTC)
From: Hin-Tak Leung <htl10@users.sourceforge.net>
To: alsa-devel@alsa-project.org, wwp <subscript@free.fr>, 
 "Geoffrey D. Bennett" <g@b4.vu>
Message-ID: <1795449400.2217618.1571067909254@mail.yahoo.com>
In-Reply-To: <mailman.1096.1571065442.5591.alsa-devel@alsa-project.org>
References: <mailman.1096.1571065442.5591.alsa-devel@alsa-project.org>
MIME-Version: 1.0
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: Re: [alsa-devel] Focusrite Scarlett 18i8 3rd Gen audio interface
 (Re: Alsa-devel Digest, Vol 152, Issue 150)
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
Reply-To: htl10@users.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

IAo+IERhdGU6IFR1ZSwgMTUgT2N0IDIwMTkgMDA6MTA6MjggKzEwMzAKPiBGcm9tOiAiR2VvZmZy
ZXkgRC4gQmVubmV0dCIgPGdAYjQudnU+Cj4gVG86IHd3cCA8c3Vic2NyaXB0QGZyZWUuZnI+Cj4g
Q2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IFN1YmplY3Q6IFJlOiBbYWxzYS1kZXZl
bF0gRm9jdXNyaXRlIFNjYXJsZXR0IDE4aTggM3JkIEdlbiBhdWRpbwo+wqDCoMKgIGludGVyZmFj
ZQo+IE1lc3NhZ2UtSUQ6IDwyMDE5MTAxNDEzNDAyOC5HQTExMDE4QGI0LnZ1Pgo+IENvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD11cy1hc2NpaQoKPiBIaSB3d3AsCgo+IE9uIFN1biwg
T2N0IDEzLCAyMDE5IGF0IDEwOjIwOjMwQU0gKzAyMDAsIHd3cCB3cm90ZToKPiA+IEhlbGxvLAo+
ID4KPiA+IEkndmUgcmVjZW50bHkgYm91Z2h0IGEgRm9jdXNyaXRlIFNjYXJsZXR0IDE4aTggM3Jk
IEdlbiBhdWRpbyBpbnRlcmZhY2UsCj4gPiBncmVhdCBkZXZpY2UsIGJ1dCBpbiBDZW50T1MgNywg
d2l0aCBlaXRoZXIgdGhlIGF2YWlsYWJsZSAzLnggb3IgNC54Cj4gPiBrZXJuZWxzLCAKPiAuLi4K
Cj4gPiBPZiBjb3Vyc2UsIGFkZGluZyB0aGUgMHgxMjM1OjgyMTQgVVNCIElEIHRvIHRoZSBxdWly
a3MganVzdCBkb2Vzbid0Cj4gPiB3b3JrLiBJIHByZXN1bWUgdGhlcmUncyBtb3JlIHdvcmsgbGlr
ZSB0aGUgcGF0Y2ggc3VibWl0dGVkIGhlcmUgKEkgc2F3Cj4gPiB0aGUgYXJjaGl2ZXMpIGluIHRo
ZSAiW1BBVENIIFJGQyBWMl0gQUxTQTogdXNiLWF1ZGlvOiBTY2FybGV0dCBHZW4gMgo+ID4gbWl4
ZXIgaW50ZXJmYWNlIiBtYWlsIHRocmVhZD8KCkhhdmUgeW91IHRyaWVkIHRyZWF0aW5nIGl0IGFz
IGEgMThpOCAybmQgR2VuIGRldmljZSBmaXJzdCwgYXQgbGVhc3Q/CgpGV0lXLCBJIGhhZCBhZGFw
dGVkIEdlb2ZmcmV5J3Mgd29yayBhcyBhIERLTVMgbW9kdWxlOgoKaHR0cHM6Ly9naXRodWIuY29t
L0hpblRhay9zb3VuZC11c2ItZGttcwoKQnV0IHlvdSdsbCBzdGlsbCBuZWVkIHRvIGJlIHJ1bm5p
bmcgYXMgcmVjZW50IGFzIGEgNS4yLnggcmVsZWFzZSBrZXJuZWwgdG8gdXNlIGl0LiBJdCBqdXN0
IG1ha2VzIGl0IGVhc2llciB0byBwbGF5IHdpdGggdGhlIGNvZGUgd2l0aG91dCByZWNvbXBpbGlu
ZyB0aGUgd2hvbGUga2VybmVsLiBIVEguIDMueCBhbmQgNC54IGlzIGRlZmluaXRlbHkgd2F5IHRv
byBvbGQhCgoKCiAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
