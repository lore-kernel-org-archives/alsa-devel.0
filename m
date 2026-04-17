Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3548F99C81
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:58:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48C2260217;
	Sat, 18 Apr 2026 21:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48C2260217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776542329;
	bh=dY6mPq5Y6MFUV4ItiXWEn3+8FAZfiQj80ME1mCLAx0U=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DsmfSVPakvViN62InphZwGqaj+PLpp6RS/kFnoBKI1bLlTrTspY36Rvpj6Dr8pxc5
	 Jx7VzUFcwV2S0ODFezJRFxwVzx+6k9jKisxhxdUNn1TBKTvF7BRhJZ0hGT2eCQJk0N
	 ys8BY1JWKXf2nRYAjS+9FfUsDF0azOBUASwwY91A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D67FEF80608; Sat, 18 Apr 2026 21:58:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ABA8F805F9;
	Sat, 18 Apr 2026 21:58:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94E4FF80528; Fri, 17 Apr 2026 23:56:11 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1AD6F8016D
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2026 23:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1AD6F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=acD1fcM+
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-79ab3e26cceso11214037b3.3
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Apr 2026 14:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776462968; cv=none;
        d=google.com; s=arc-20240605;
        b=T94ufhLdXtIsPPp+vzTme7UojnOyYT4YdNEmEcPz9pL0ZpfvZkqYB+b7nuVSWIM5YR
         xkjpgloUU530lZZcPHGAz5eBLa9O8j0fXnI4yE98IoD9IUEOamyCBR4FEt1PESfhHcbr
         cwawEed847qeYzTT8KRNh1DXW6bQORe4Dxj3/sqZcqrunzSE41tkFWWiQpRSMB/ZDs5X
         A7/yUwZrYOS1oaIz3pHn97lFhtF2N0bvV8aYHv9ibNc1URFMYyo2BHHD3lIQC18WxjJU
         nsXWNmAu9hgXZRIYbcWyiTMjk6IpLCI40Vdj+edBwgAnZ16vuzpA7zQybE7HkU+IqBw2
         sGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/LngGdEO6OXdKcAm0T5vwwr/+iddBYXO0mROOzoQ72Y=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=cTSPml33e8+k/MnNevdr4PV3uvXmFwF4Ec6syWu2EUCjyAo4W4ek3EhFN3ceoKbetJ
         In0BBpB6dEW5TemdN6XPoJwWh1RUtoeom1+Fho/GIRKykwLkeiqzoINb8AqVhHyjWRQg
         EdwHvXBxmFkUCW6IHvoRVzcAD/NEHorWbmeDnUTKzvhr1YBsaLh6vBFKeQU4P2kRxGns
         i4Luu9geIzI1KC812DEvWNDzG2ioDo5XXgBbgH270ptDM9zCNStE01lAmNrkGF8t633P
         xFHwwDtASDPps5/mK/LCpMZfSvLhC7SxCguvbN4CeAENKyik1Ul4LtfXTXywXeymZqOn
         Ifgg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776462968; x=1777067768;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LngGdEO6OXdKcAm0T5vwwr/+iddBYXO0mROOzoQ72Y=;
        b=acD1fcM+J9GW+bYiMIMREQsggHeCpwW/372Sg7kmM9sJ9qnB7aJA/1EMvHUjRBE/YJ
         DYwJo0VcQcmTnoJ0gppRYNQSZKs9QeDO/MFG5vplRe/Lvz22yBncjmol5n90DrkijWvG
         GTpPcnpfcesED8r01EVdSQ64g9U6d34HJjDm9MGYdqigAcgUf64yjHpUWK4/kDXKb5R5
         N6wb0au4t8GlfGAilGbZcLhY2CncKaZQfKPQioQYPR6Krqs7JgKgw3SvoDHE5/Uxr90l
         M4WCLzOWuFpEMrBD8Qc65z0vxCvT4jmDQqIGBdYqb0h8MLApj257XWyQJxRETNAURxpA
         Y5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462968; x=1777067768;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LngGdEO6OXdKcAm0T5vwwr/+iddBYXO0mROOzoQ72Y=;
        b=d4+rtg86DQR1jGmFQPsbmJCu/vpQ51iDm0eHIFA0TrW+f+u1+UrPSSjPjbM55T9Dll
         dmML5dReaqnp7byIuvv1LUQ6BUHGiDGuMNN7uWW8uw4VlZEDV9Y8Ey4nQqANfHxEAPug
         Mf5NoEFnQWttGYYacr61epvyCe4E9o0U/wr7+HjqJVFobeYZyM9Vy4RiG80/5FHHMdMW
         nYrmG/ZaQ04aroT3OgTHcNwB/GX+R3vlWtL7yIXIj32/aX2i3rSkVVKsHXS4Ry5sU730
         GGkfyC4jo2x3EO0zpnrnu+ZZAxvH9iPtMCm+YFDAe/4Y7AYiPl5IEbVhXCTC3S1Pnsg3
         2wWA==
X-Gm-Message-State: AOJu0Yw5DIPHHgk1zIRxFYTJ4p4DINLJP7JYD1vSgsU91jtQl2syqxKI
	7SGj+xNuO3fkc5pZzEbbFffbO42jULNsizPiJO6IZnH2N+fD8yACr92CdtWknhFIoMJndaEL9AO
	yEszYCdpDii/CAT3Vmcfbp6bdXbwmPyY0+ooAz70=
X-Gm-Gg: AeBDievxsKoFTnoZcbUmnnDkh2Z+H8uLlMY7HeFyRlKajtCMClAY+hQ2rh3xpALQiNi
	fib6d57D0Leapxrr15N2DQwbZatfYhLsLVj/Kjajc9t6woofODkMUej3Pbap7FrDj83pc8V47oH
	TQ0thWktP/ZV8hoPo0I/17KPAN33nVK3pTXhCrlUi3Y/oxg+Ahtax6KtlaaNj7bJ+Ybac1AUNiH
	2bH3rCXag3nJvbcAcrJcAVJdihc1k4j/LILqd6UgxjHMVP78WdI6eaUn5ilE487yDbDbv3UyDye
	QShFxvBRbdZ6Iy+V28o=
X-Received: by 2002:a05:690c:c511:b0:79a:b272:f933 with SMTP id
 00721157ae682-7b9ecf96b25mr47954577b3.23.1776462967711; Fri, 17 Apr 2026
 14:56:07 -0700 (PDT)
MIME-Version: 1.0
From: Kostua Voronin <voronin166@gmail.com>
Date: Fri, 17 Apr 2026 23:55:56 +0200
X-Gm-Features: AQROBzD2zYe1RsuW735YBhXGTUvE1EKhavfzAZU3MkqgcJySR2O0KZkrazJtrNU
Message-ID: 
 <CAEUVUX_-_pFagixLs59crtbHShziR=FhrF-jZ+NeEFD-QJV7Mw@mail.gmail.com>
Subject: 
 =?UTF-8?Q?Honor_MagicBook_Art_14_=28HONOR=2DMRA=2C_MTL=2DP=29=3A_RT1308_sm?=
	=?UTF-8?Q?art_amp_on_I2C3_not_functional_=E2=80=94_BIOS_disables_I2C3_contro?=
	=?UTF-8?Q?ller?=
To: alsa-devel@alsa-project.org
X-MailFrom: voronin166@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HNYELKH4BQ2G24ZFFYVRVKJJZCLXLGV2
X-Message-ID-Hash: HNYELKH4BQ2G24ZFFYVRVKJJZCLXLGV2
X-Mailman-Approved-At: Sat, 18 Apr 2026 19:58:11 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HNYELKH4BQ2G24ZFFYVRVKJJZCLXLGV2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkknbSByZXBvcnRpbmcgYSBMaW51eCBhdWRpbyBpc3N1ZSBvbiBIb25vciBNYWdp
Y0Jvb2sgQXJ0IDE0IChJbnRlbCBNZXRlb3INCkxha2UtUCkgd2hlcmUgNCBvdXQgb2YgNiBzcGVh
a2VycyBhcmUgc2lsZW50IGR1ZSB0byB0aGUgUlQxMzA4IHNtYXJ0DQphbXBsaWZpZXIgYmVpbmcg
aW5hY2Nlc3NpYmxlLg0KDQpIYXJkd2FyZToNCiAgTGFwdG9wOiAgSG9ub3IgTWFnaWNCb29rIEFy
dCAxNCwgSE9OT1ItTVJBX1hYWC1NMTEwMCwgU0tVIEMyMzMNCiAgQ1BVOiAgICAgSW50ZWwgTWV0
ZW9yIExha2UtUCAoQ29yZSBVbHRyYSA3KQ0KICBCSU9TOiAgICAzLjA1ICgyMDI1LTAzLTA3KSwg
bGF0ZXN0IGF2YWlsYWJsZQ0KICBDb2RlYzogICBSZWFsdGVrIEFMQzI1NiAoSERBLCBzdWJzeXN0
ZW0gMHgxZWU3MjA2MCkg4oCUIHdvcmtzLCAyIHR3ZWV0ZXJzDQogIEFtcDogICAgIFJlYWx0ZWsg
UlQxMzA4IChBQ1BJOiAxMEVDMTMwODowMCwgcGF0aCBcX1NCXy5QQzAwLkkyQzMuSERDMSwNCiAg
ICAgICAgICAgSTJDIGFkZHIgMHgxMCwgSTJTIGF1ZGlvICsgSTJDIGNvbnRyb2wgbW9kZSDigJQg
bm90IFNvdW5kV2lyZSkNCiAgS2VybmVsOiAgNi4xNy4wLTIwLWdlbmVyaWMNCiAgU3RhY2s6ICAg
U09GIHNvZi1oZGEtZHNwLCBQaXBlV2lyZSAxLjQuNywgdG9wb2xvZ3kNCnNvZi1oZGEtZ2VuZXJp
Yy00Y2gudHBsZw0KDQpUaGUgbGFwdG9wIGhhcyA2IHNwZWFrZXJzOiAyIHR3ZWV0ZXJzIChBTEMy
NTYpICsgNCB3b29mZXJzIChSVDEzMDgpLg0KT25seSB0aGUgMiB0d2VldGVycyB3b3JrIHVuZGVy
IExpbnV4Lg0KDQpSb290IGNhdXNlIChmdWxseSBpbnZlc3RpZ2F0ZWQpOg0KICBCSU9TIHBoeXNp
Y2FsbHkgZGlzYWJsZXMgdGhlIEkyQzMgY29udHJvbGxlcjoNCg0KICAxLiBHTlZTIHZhcmlhYmxl
IEkyU0MgPSAweDAwIGF0IEdOVlNfQkFTRSArIDB4ODRFICgweDY1REQ4ODY2KS4NCiAgICAgUlQx
MzA4IF9TVEEgaW4gRFNEVDoNCiAgICAgICBJZiAoKChJMlNDID09IDB4MDIpICYmIChDRElTICE9
IE9uZSkpKSB7IFJldHVybigweDBGKSB9DQogICAgIFdpdGggSTJTQz0weDAwLCBfU1RBIHJldHVy
bnMgMCAtPiBBQ1BJIGRldmljZSBkaXNhYmxlZC4NCiAgICAgY2F0IC9zeXMvYnVzL2FjcGkvZGV2
aWNlcy8xMEVDMTMwODowMC9zdGF0dXMgLT4gMA0KDQogIDIuIEkyQzMgUENJIGRldmljZSBpcyBh
YnNlbnQg4oCUIG9ubHkgMDA6MTUuMCAoSTJDMCkgYW5kIDAwOjE1LjEgKEkyQzEpDQogICAgIGFy
ZSB2aXNpYmxlIGluIGxzcGNpLg0KDQogIDMuIEkyQzMgTU1JTyAoMHg0ODE5MkQxMDAwKSByZXR1
cm5zIDB4RkZGRkZGRkYg4oCUIGhhcmR3YXJlIGlzIG9mZi4NCiAgICAgQWRkcmVzcyBvdmVybGFw
cyB3aXRoIFRodW5kZXJib2x0IEJBUjIgKFBDSSAwMDowZC4zKS4NCg0KICA0LiBOSExUIHRhYmxl
IGhhcyBubyBSVDEzMDggZW5kcG9pbnQg4oCUIG9ubHkgQlQgb24gU1NQNCBhbmQgNCBETUlDLg0K
DQogIDUuIFNvdW5kV2lyZSBidXMgZXhpc3RzIGluIGtlcm5lbCAoL3N5cy9idXMvc291bmR3aXJl
LykgYnV0IGlzIGVtcHR5Lg0KDQogIDYuIFdhcm0gcmVib290IGZyb20gV2luZG93cyBkb2VzIG5v
dCBoZWxwIOKAlCB0ZXN0ZWQgbXVsdGlwbGUgdGltZXMuDQoNCkFDUEkgZGV0YWlsczoNCiAgSTJT
QiA9IDB4MDMgKEkyQzMpLCBSVDEzMDggSTJDIGFkZHIgPSAweDEwICg3LWJpdCkNCiAgR05WUyBP
cGVyYXRpb25SZWdpb246IFN5c3RlbU1lbW9yeSwgYmFzZSAweDY1REQ4MDE4LCBzaXplIDB4MERB
QQ0KICBJMlNDIGF0IG9mZnNldCAweDg0RQ0KDQpTT0Ygc3RhdGU6DQogIE5vIE1UTCArIFJUMTMw
OCAoSTJDIG1vZGUpIG1hY2hpbmUgZHJpdmVyIG9yIHRvcG9sb2d5IGV4aXN0cy4NCiAgRXhpc3Rp
bmcgUlQxMzA4IHRvcG9sb2dpZXMgdGFyZ2V0IEFETC9UR0wgd2l0aCBTb3VuZFdpcmUuDQoNClF1
ZXN0aW9uczoNCiAgMS4gSXMgdGhlcmUgYSBrbm93biB3YXkgdG8gZm9yY2UtZW5hYmxlIEkyQzMg
ZnJvbSBMaW51eA0KICAgICAoQUNQSSBtZXRob2QsIEVGSSB2YXJpYWJsZSB3cml0ZSk/DQogIDIu
IElzIGEgbWFjaGluZSBkcml2ZXIvdG9wb2xvZ3kgZm9yIE1UTCArIFJUMTMwOC12aWEtSTJDIGZl
YXNpYmxlPw0KICAzLiBTaG91bGQgdGhpcyBiZSByZXBvcnRlZCB0byBIb25vci9JbnRlbCBhcyBh
IEJJT1MgYnVnPw0KDQpJIGNhbiBwcm92aWRlIGZ1bGwgQUNQSSB0YWJsZXMsIGRtZXNnLCBvciBh
bnkgYWRkaXRpb25hbCBkaWFnbm9zdGljcy4NCg0KQmVzdCByZWdhcmRzLA0KS29uc3RhbnRpbiBW
b3JvbmluDQo=
