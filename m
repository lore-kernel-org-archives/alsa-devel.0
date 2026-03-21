Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B014DD58CA3
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:30:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAA9D601F3;
	Sun, 22 Mar 2026 22:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAA9D601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774215057;
	bh=PwItHwTTObaejlEbx8xlTwJ8wJGJs7f9XvMh/KFKao0=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=itb1+dGM9qpdKAb/CxQJKfV9ZQhwp4R+FAM9wjFDD0PQru2J/YArTR0HyYyPNR4aM
	 J5xHgKLTGw+vU8HBHs3HK9GPBWBdBr638Ka8yxwaQn276mAmRxawLFO1ReQhNxdGow
	 NJbg9LxIZgWOcgziYs3fCZ42Idw+NL3tfWBcL2Ag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CCFAF805EE; Sun, 22 Mar 2026 22:30:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67E2EF805D9;
	Sun, 22 Mar 2026 22:30:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6EDEF80549; Sat, 21 Mar 2026 04:37:45 +0100 (CET)
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch
 [185.70.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 925E7F802DB
	for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2026 04:37:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 925E7F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=TnMAqQWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1774064262; x=1774323462;
	bh=k7DC4XstUOL7A8CuO76QykgmqERwOlo8ijM5kkSyHic=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TnMAqQWDICaOencElS3waxcTQWT8uX2UEUBsn4cnRHUFdg70L1hCQL6ELDkKEr47A
	 5a/Z4V12QY5Uh/2SpOceJ2gU2dN+6/k3Xozi3KoKEI2PYaTxH7SJjvPo4MI7pFzrmD
	 /bpp3qInQzhMRgdV9em5UsiMnTOTvq3l2jjcIyn9HwlZQxeF/6R0zYWpkGfgFvKuG2
	 niiSnt9RV6YT07h1PT2x5PfZRJ5LQyEao8JLyDI/Abh3QpWcfLH2i6Z2z4FEQnKINO
	 mPRP6z8PQ1KgIL5r0023R/eQr4EKE39U++sCHl1MrVRmOVh55lLYqQPAaHsbS/J6Ht
	 ZUO18O0Mt97wg==
Date: Sat, 21 Mar 2026 03:37:36 +0000
To: martin.pechstein@posteo.de
From: midiborg <midiborg@proton.me>
Cc: alsa-devel@alsa-project.org
Subject: Re: BUG: snd_ctxfi Oops in set_field() with Creative X-Fi Titanium
 (EMU20k2, 1102:000b) on Linux 6.19.x, regression from 6.18
Message-ID: 
 <iTTGZgdSe-CSUOUVP1M3Lwf6IlyZnOR7UyRxZOiOx2p9QkSo1j1gjkWrzwxU6hoatgiHbh5yyNTnPHM0tOy3mWmQ2woiuY6UPOpiAiDbmKk=@proton.me>
Feedback-ID: 138406005:user:proton
X-Pm-Message-ID: 509a2dbb560312690b3cd37f98fd01293f0cd9cc
MIME-Version: 1.0
X-MailFrom: midiborg@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PCCFVPJHC2N562XTENYSCQEUDAE5HGYG
X-Message-ID-Hash: PCCFVPJHC2N562XTENYSCQEUDAE5HGYG
X-Mailman-Approved-At: Sun, 22 Mar 2026 21:30:16 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PCCFVPJHC2N562XTENYSCQEUDAE5HGYG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gcHJvdmlkZSBhZGRpdGlvbmFsIGRhdGEgZm9yIHRoaXMg
cmVncmVzc2lvbi4gSSBhbSBleHBlcmllbmNpbmcgdGhlIHNhbWUgc25kX2N0eGZpIHBhZ2UgZmF1
bHQgYXQgc2V0X2ZpZWxkKzB4MjcvMHg1MCBvbiBLZXJuZWwgNi4xOS43LgoKSW1wb3J0YW50IG9i
c2VydmF0aW9ucyBmcm9tIG15IHRlc3Rpbmc6CgpUaGlzIHJlZ3Jlc3Npb24gaXMgbm90IGNvbXBp
bGVyLXNwZWNpZmljOyBpdCBvY2N1cnMgb24gYm90aCBDYWNoeU9TIChjb21waWxlZCB3aXRoIENs
YW5nIDIxKSBhbmQgc3RhbmRhcmQgQXJjaCBMaW51eCAoY29tcGlsZWQgd2l0aCBHQ0MpLgoKTXkg
aGFyZHdhcmUgaXMgYSBSZXZpc2lvbiAwNCBjYXJkOgowNTowMC4wIEF1ZGlvIGRldmljZSBbMDQw
M106IENyZWF0aXZlIExhYnMgRU1VMjBrMiBbU291bmQgQmxhc3RlciBYLUZpIFRpdGFuaXVtIFNl
cmllc10gWzExMDI6MDAwYl0gKHJldiAwNCkKCkNydWNpYWxseSwgdGhlIE9vcHMgZHVyaW5nIGhh
cmR3YXJlIHByb2JpbmcgdHJpZ2dlcnMgYSB0b3RhbCBzeXN0ZW0gaGFuZyBkdXJpbmcgc2h1dGRv
d24vcmVib290LiBUaGUgc2NyZWVuIHN0YXlzIHN0dWNrIGF0IHRoZSAiUG93ZXJpbmcgb2ZmLiIg
c3RhZ2UgaW5kZWZpbml0ZWx5IHVudGlsIGEgaGFyZCByZXNldCBpcyBwZXJmb3JtZWQuCgpCbGFj
a2xpc3RpbmcgdGhlIHNuZF9jdHhmaSBtb2R1bGUgdmlhIGJvb3QgcGFyYW1ldGVycyByZXNvbHZl
cyB0aGUgc2h1dGRvd24gaGFuZyBlbnRpcmVseS4KCkZ1bGwgT29wcyB0cmFjZSBmcm9tIEtlcm5l
bCA2LjE5Ljc6CgpbIDkuMDI5NzEzXSBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBm
b3IgYWRkcmVzczogZmZmZjhkNTY0NzIzY2IxMApbIDkuMDI5NzE2XSAjUEY6IHN1cGVydmlzb3Ig
cmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKWyA5LjAyOTcxN10gI1BGOiBlcnJvcl9jb2RlKDB4
MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlClsgOS4wMjk3MThdIFBHRCAxMmFhMDEwNjcgUDREIDEy
YWEwMTA2NyBQVUQgMApbIDkuMDI5NzIxXSBPb3BzOiBPb3BzOiAwMDAwIFsjMV0gU01QIE5PUFRJ
ClsgOS4wMjk3MjNdIENQVTogMTQgVUlEOiAwIFBJRDogNjgzIENvbW06ICh1ZGV2LXdvcmtlcikg
Tm90IHRhaW50ZWQgNi4xOS43LTEtY2FjaHlvcyAjMSBQUkVFTVBUKGZ1bGwpClsgOS4wMjk3MjVd
IEhhcmR3YXJlIG5hbWU6IE1pY3JvLVN0YXIgSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4gTVMtN0I1
MS9NUEcgWjM5MCBHQU1JTkcgUExVUyAoTVMtN0I1MSksIEJJT1MgMS5GMCAwNy8wOC8yMDI0Clsg
OS4wMjk3MjddIFJJUDogMDAxMDpzZXRfZmllbGQrMHgyNy8weDUwIFtzbmRfY3R4ZmldClsgOS4w
Mjk3MzldIENvZGU6IDkwIDkwIDkwIDBmIDFmIDQwIGQ2IDBmIDFmIDQ0IDAwIDAwIDg1IGY2IDc0
IDMwIGI4IGZmIGZmIGZmIGZmIDY2IDY2IDY2IDY2IDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAw
IDAwIGZmIGMwIDBmIGEzIGM2IDczIGY5IDxjND4gZTIgNDggZjIgMGYgYzQgZTIgNzkgZjcgYzIg
MjEgZjAgMDkgYzggODkgMDcgYzMgY2MgY2MgY2MgY2MgY2MKWyA5LjAyOTc0MV0gUlNQOiAwMDE4
OmZmZmZkMzU0MDIzMDczYjAgRUZMQUdTOiAwMDAxMDI1NwpbIDkuMDI5NzQyXSBSQVg6IDAwMDAw
MDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMGZmZmZmZmVhIFJDWDogMDAwMDAwMDAwMDAwMDAwMQpb
IDkuMDI5NzQzXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDAwMDAwMDAxIFJE
STogZmZmZjhkNTY0NzIzY2IxMApbIDkuMDI5NzQ0XSBSQlA6IDAwMDAwMDAwZmZmZmZmZWEgUjA4
OiAwMDAwMDAwMDAwMDAwMDA4IFIwOTogMDAwMDAwMDAwMDAwMDAwMApbIDkuMDI5NzQ1XSBSMTA6
IGZmZmY4ZDUyNDExYTlhNDggUjExOiBmZmZmZmZmZmMxYmU4NGYwIFIxMjogZmZmZjhkNTI0MTAy
NmMwMApbIDkuMDI5NzQ2XSBSMTM6IGZmZmZkMzU0MDIzMDc0MzQgUjE0OiBmZmZmOGQ1MjQ3MjNj
YjQwIFIxNTogZmZmZjhkNTI0NzIzYzdlMApbIDkuMDI5NzQ4XSBGUzogMDAwMDdmNWYzMjc0Njg0
MCgwMDAwKSBHUzpmZmZmOGQ1NWVkYzU2MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAK
WyA5LjAyOTc0OV0gQ1M6IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUw
MDMzClsgOS4wMjk3NTBdIENSMjogZmZmZjhkNTY0NzIzY2IxMCBDUjM6IDAwMDAwMDAxMDhlZjgw
MDUgQ1I0OiAwMDAwMDAwMDAwMzcyNmYwClsgOS4wMjk3NTFdIENhbGwgVHJhY2U6ClsgOS4wMjk3
NTNdIDxUQVNLPgpbIDkuMDI5NzU0XSBkYWlvX21ncl9lbmJfZGFpKzB4MmEvMHg1MCBbc25kX2N0
eGZpXQpbIDkuMDI5NzYyXSBkYWlvX21ncl9lbmJfZGFpbysweDEwNC8weDExMCBbc25kX2N0eGZp
XQpbIDkuMDI5NzY5XSBnZXRfZGFpb19yc2MrMHgzNGUvMHgzODAgW3NuZF9jdHhmaV0KWyA5LjAy
OTc3Nl0gYXRjX2dldF9yZXNvdXJjZXMrMHgxYTMvMHg2MTAgW3NuZF9jdHhmaV0KWyA5LjAyOTc4
Ml0gY3RfYXRjX2NyZWF0ZSsweDNjZC8weDQ1MCBbc25kX2N0eGZpXQpbIDkuMDI5NzkwXSBjdF9j
YXJkX3Byb2JlKzB4ZTkvMHgyNzAgW3NuZF9jdHhmaV0KWyA5LjAyOTc5Nl0gcGNpX2RldmljZV9w
cm9iZSsweDFkMS8weDI4MApbIDkuMDI5ODAwXSByZWFsbHlfcHJvYmUrMHgxYmMvMHg1MTAKWyA5
LjAyOTgwM10gX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzcvMHgxMDAKWyA5LjAyOTgwNV0gZHJp
dmVyX3Byb2JlX2RldmljZSsweDFlLzB4MTEwClsgOS4wMjk4MDddIF9fZHJpdmVyX2F0dGFjaCsw
eGE4LzB4MjIwClsgOS4wMjk4MTFdIGJ1c19mb3JfZWFjaF9kZXYrMHgxMTcvMHgxNjAKWyA5LjAy
OTgxM10gYnVzX2FkZF9kcml2ZXIrMHgxNmEvMHgyZDAKWyA5LjAyOTgxNV0gZHJpdmVyX3JlZ2lz
dGVyKzB4NjgvMHgxMTAKWyA5LjAyOTgyNF0gZG9fb25lX2luaXRjYWxsKzB4MTM1LzB4MzQwClsg
OS4wMjk4NThdIGRvX2luaXRfbW9kdWxlKzB4NjcvMHgzNzAKWyA5LjAyOTg2MF0gbG9hZF9tb2R1
bGUrMHgyZjQ4LzB4MzA5MApbIDkuMDI5ODY0XSBfX3NlX3N5c19maW5pdF9tb2R1bGUrMHgyOTkv
MHg0MTAKWyA5LjAyOTg2OF0gZG9fc3lzY2FsbF82NCsweDZiLzB4MjkwClsgOS4wMjk4ODZdIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc5LzB4ODEKWyA5LjAyOTkxMl0gPC9UQVNL
PgoKQmVzdCByZWdhcmRzLApNaURpQm9yZw==
