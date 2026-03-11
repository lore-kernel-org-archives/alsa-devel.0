Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E39F1067044
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:25:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FD2C60230;
	Thu, 12 Mar 2026 16:24:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FD2C60230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773329107;
	bh=TPU0qOuESeoqzMsH1iHrGqR8ckYTZCC1B7j+ZgUkJw8=;
	h=Date:From:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Mw4Xs65Fc8UaqYlW6u9JNkYga5YRK7RhAwfhnxVi9Bd94z5CO1G0gqEI1jbK8YJR+
	 YrDFWY9hig0Nli6dsdV2e59QhNg9t5LUPgeTif6wCASYl0czl91+bSsM5Yi0NnGtCS
	 VC9c+izbr02mBbxxv40LEiHMNHCVzVL+UjuoTYxg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 412FDF805E2; Thu, 12 Mar 2026 16:23:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0B90F8026D;
	Thu, 12 Mar 2026 16:23:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22BCAF80552; Wed, 11 Mar 2026 09:25:02 +0100 (CET)
Received: from mail.internetuniverse.org (mail.internetuniverse.org
 [66.235.173.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA512)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E49FCF80171
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2026 09:24:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E49FCF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=internetuniverse.org header.i=@internetuniverse.org
 header.a=rsa-sha256 header.s=202512r header.b=Aus2oboP
DKIM-Signature: v=1; a=rsa-sha256; s=202512r; d=internetuniverse.org;
 c=relaxed/relaxed;
	h=To:Subject:Message-ID:From:Date; t=1773217487; bh=3bQAepcTrpOY4ruE8H5+uc2
	oqHfyUtnU1u3kZunssvU=; b=Aus2oboPbVxUvDPzat6EGra61ynNQwgDV8yhxmpZSMT3lmXxuk
	//qaMoeE0Ptk2RdLW8b101eB/dPKY9isLPM6YsqEbpgY2n0fFYZaxrjPb9Xm6rdSc55uQqP01Hr
	X5OIaFmFInZkYSuxkxsMJ8vcw2oYpK2mQuuQHKCM0BZMARwfOn/8UVkV6BA5Ckvr9UdtvQzmlRz
	jYB2IClK9r+9CgGrG8ptYzE01TM9EY/jIjHSsTSDvAg2X7wltTji22jZGHtFkTMDg2FXUdnhBiE
	U3ZaIkbkVlG9ZAVu6g3xwz7PBEes2JKz066KzvSR6/Ec+3Fp+8zgUOh6aL1TUn/yKAA==;
MIME-Version: 1.0
Date: Wed, 11 Mar 2026 08:24:47 +0000
Content-Type: multipart/mixed;
 boundary="81463dbb-a229-400f-b5af-782f002c83b6-1"
From: "Zack Fitch" <zack@internetuniverse.org>
Message-ID: <98643a1eb0aba1a7dbc0742fc831317e35581c5c@internetuniverse.org>
TLS-Required: No
Subject: [PATCH] ALSA: hda/realtek: enable dual-DAC on Gigabyte X570S/X870E
 ALC1220
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
X-MailFrom: zack@internetuniverse.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2UVMQCBIWUDHU4DEIF2GZALH3JRT43QC
X-Message-ID-Hash: 2UVMQCBIWUDHU4DEIF2GZALH3JRT43QC
X-Mailman-Approved-At: Thu, 12 Mar 2026 15:23:29 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2UVMQCBIWUDHU4DEIF2GZALH3JRT43QC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--81463dbb-a229-400f-b5af-782f002c83b6-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

  Please consider the attached patch for the Gigabyte X570S/X870E Aorus
  ALC1220 audio codec.

  Thanks,
  Zack
--81463dbb-a229-400f-b5af-782f002c83b6-1
Content-Type: text/x-diff;
 name="0001-ALSA-hda-realtek-enable-dual-DAC-on-Gigabyte-X570S-X.patch"
Content-Disposition: attachment;
 filename="0001-ALSA-hda-realtek-enable-dual-DAC-on-Gigabyte-X570S-X.patch"
Content-Transfer-Encoding: base64

RnJvbSAwNmRlZWUxODVlMjllZTM1MmVkZTkwZWE2M2ZkYjA0NDhkYTI0MmFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBaYWNrIEZpdGNoIDx6YWNrQGludGVybmV0dW5pdmVy
c2Uub3JnPgpEYXRlOiBXZWQsIDExIE1hciAyMDI2IDAxOjIyOjM5IC0wNzAwClN1YmplY3Q6
IFtQQVRDSF0gQUxTQTogaGRhL3JlYWx0ZWs6IGVuYWJsZSBkdWFsLURBQyBvbiBHaWdhYnl0
ZSBYNTcwUy9YODcwRQogQUxDMTIyMAoKVGhlIEFMQzEyMjAgY29kZWMgb24gR2lnYWJ5dGUg
WDU3MFMgQW9ydXMgTWFzdGVyIGFuZCBYODcwRSBBT1JVUwpYVFJFTUUgQUkgVE9QIGJvYXJk
cyAoc3Vic3lzdGVtIDB4MTQ1ODoweGEwZDUpIGhhcyB0d28gdXNhYmxlIG91dHB1dApwYXRo
czoKCiAgLSBQaW4gMHgxNCAoZnJvbnQgSFApOiBoYXJkd2lyZWQgdG8gbWl4ZXIgMHgwYyAt
PiBEQUMgMHgwMgogIC0gUGluIDB4MWIgKHJlYXIgbGluZS1vdXQpOiA1IGNvbm5lY3Rpb25z
ICgweDBjIDB4MGQgMHgwZSAweDBmIDB4MjYpCgpUaGUgZXhpc3RpbmcgQUxDMTIyMF9GSVhV
UF9HQl9YNTcwIHF1aXJrIG92ZXJyaWRlcyAweDFiJ3MgY29ubmVjdGlvbgpsaXN0IHRvIHsw
eDBjfSBvbmx5LCBmb3JjaW5nIGJvdGggb3V0cHV0cyBvbnRvIERBQyAweDAyLiBJdCBhbHNv
IGRvZXMKbm90IHN1cHByZXNzIGF1dG8tbXV0ZSwgc28gaW5zZXJ0aW5nIGhlYWRwaG9uZXMg
c2lsZW5jZXMgdGhlIHJlYXIKbGluZS1vdXQuCgpEZXNrdG9wIHVzZXJzIG5lZWQgYm90aCBv
dXRwdXRzIGFjdGl2ZSBzaW11bHRhbmVvdXNseSB3aXRoIGluZGVwZW5kZW50CkRBQyByb3V0
aW5nIGZvciBwZXItYXBwbGljYXRpb24gYXVkaW8gKGUuZy4sIERpc2NvcmQgdG8gaGVhZHBo
b25lcywKbXVzaWMgdG8gc3BlYWtlcnMpLgoKQWRkIEFMQzEyMjBfRklYVVBfR0JfQU9SVVNf
Tk9fQVVUT01VVEUgd2hpY2g6CiAgLSBEb2VzIE5PVCByZXN0cmljdCAweDFiJ3MgY29ubmVj
dGlvbiBsaXN0LCBhbGxvd2luZyB0aGUgZ2VuZXJpYyBIREEKICAgIHBhcnNlciB0byBhc3Np
Z24gREFDIDB4MDMgKHZpYSBtaXhlciAweDBkKSBhcyBhbiBpbmRlcGVuZGVudCBvdXRwdXQK
ICAtIFNldHMgc3VwcHJlc3NfYXV0b19tdXRlIHNvIGZyb250IEhQIGluc2VydGlvbiBkb2Vz
IG5vdCBtdXRlIHJlYXIKClRoZSBjb2VmZmljaWVudCB3cml0ZXMgZnJvbSBnYl94NTcwIGFy
ZSBub3QgcmVxdWlyZWQgZm9yIGF1ZGlvIG91dHB1dApvbiB0aGVzZSBib2FyZHMsIGFzIGNv
bmZpcm1lZCBieSB0ZXN0aW5nIHdpdGggbW9kZWw9Z2VuZXJpYyBhbmQgYnkKcmV2ZXJzZS1l
bmdpbmVlcmluZyB0aGUgV2luZG93cyBSZWFsdGVrIGRyaXZlciB3aGljaCBhcHBsaWVzIG5v
CmJvYXJkLXNwZWNpZmljIGhhbmRsaW5nIGZvciB0aGlzIHN1YnN5c3RlbSBJRC4KClRlc3Rl
ZCBvbjogR2lnYWJ5dGUgWDg3MEUgQU9SVVMgWFRSRU1FIEFJIFRPUAogIEFMQzEyMjAgY29k
ZWMsIHN1YnN5c3RlbSAweDE0NTg6MHhhMGQ1CiAgQU1EIFJ5emVuIEhEIEF1ZGlvIENvbnRy
b2xsZXIgWzEwMjI6MTVlM10KICBLZXJuZWwgNi4xOC4xMy1hcmNoMS0xCgpTaWduZWQtb2Zm
LWJ5OiBaYWNrIEZpdGNoIDx6YWNrQGludGVybmV0dW5pdmVyc2Uub3JnPgotLS0KIHNvdW5k
L2hkYS9jb2RlY3MvcmVhbHRlay9hbGM4ODIuYyB8IDIyICsrKysrKysrKysrKysrKysrKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzg4Mi5jIGIvc291bmQv
aGRhL2NvZGVjcy9yZWFsdGVrL2FsYzg4Mi5jCmluZGV4IDUyOWZlY2Q1YmEuLjZiNjE3MTli
OTYgMTAwNjQ0Ci0tLSBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGM4ODIuYworKysg
Yi9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjODgyLmMKQEAgLTU0LDYgKzU0LDcgQEAg
ZW51bSB7CiAJQUxDODg3X0ZJWFVQX0JBU1NfQ0hNQVAsCiAJQUxDMTIyMF9GSVhVUF9HQl9E
VUFMX0NPREVDUywKIAlBTEMxMjIwX0ZJWFVQX0dCX1g1NzAsCisJQUxDMTIyMF9GSVhVUF9H
Ql9BT1JVU19OT19BVVRPTVVURSwKIAlBTEMxMjIwX0ZJWFVQX0NMRVZPX1A5NTAsCiAJQUxD
MTIyMF9GSVhVUF9DTEVWT19QQjUxRUQsCiAJQUxDMTIyMF9GSVhVUF9DTEVWT19QQjUxRURf
UElOUywKQEAgLTIxMSw2ICsyMTIsMjAgQEAgc3RhdGljIHZvaWQgYWxjMTIyMF9maXh1cF9n
Yl94NTcwKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCX0KIH0KIAorLyogR2lnYWJ5dGUg
WDU3MFMvWDg3MEUgQW9ydXMgYm9hcmRzOiBlbmFibGUgaW5kZXBlbmRlbnQgREFDIHJvdXRp
bmcKKyAqIGJ5IG5vdCByZXN0cmljdGluZyBwaW4gMHgxYidzIGNvbm5lY3Rpb24gbGlzdCwg
YW5kIHN1cHByZXNzIGF1dG8tbXV0ZQorICogc28gZnJvbnQgaGVhZHBob25lIGluc2VydGlv
biBkb2VzIG5vdCBzaWxlbmNlIHJlYXIgbGluZS1vdXQuCisgKi8KK3N0YXRpYyB2b2lkIGFs
YzEyMjBfZml4dXBfZ2JfYW9ydXNfbm9fYXV0b211dGUoc3RydWN0IGhkYV9jb2RlYyAqY29k
ZWMsCisJCQkJCSAgICAgICBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwICpmaXgsCisJCQkJCSAg
ICAgICBpbnQgYWN0aW9uKQoreworCXN0cnVjdCBhbGNfc3BlYyAqc3BlYyA9IGNvZGVjLT5z
cGVjOworCisJaWYgKGFjdGlvbiA9PSBIREFfRklYVVBfQUNUX1BSRV9QUk9CRSkKKwkJc3Bl
Yy0+Z2VuLnN1cHByZXNzX2F1dG9fbXV0ZSA9IDE7Cit9CisKIHN0YXRpYyB2b2lkIGFsYzEy
MjBfZml4dXBfY2xldm9fcDk1MChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCQkgICAg
IGNvbnN0IHN0cnVjdCBoZGFfZml4dXAgKmZpeCwKIAkJCQkgICAgIGludCBhY3Rpb24pCkBA
IC01MTQsNiArNTI5LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzg4
Ml9maXh1cHNbXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfRlVOQywKIAkJLnYuZnVuYyA9
IGFsYzEyMjBfZml4dXBfZ2JfeDU3MCwKIAl9LAorCVtBTEMxMjIwX0ZJWFVQX0dCX0FPUlVT
X05PX0FVVE9NVVRFXSA9IHsKKwkJLnR5cGUgPSBIREFfRklYVVBfRlVOQywKKwkJLnYuZnVu
YyA9IGFsYzEyMjBfZml4dXBfZ2JfYW9ydXNfbm9fYXV0b211dGUsCisJfSwKIAlbQUxDMTIy
MF9GSVhVUF9DTEVWT19QOTUwXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfRlVOQywKIAkJ
LnYuZnVuYyA9IGFsYzEyMjBfZml4dXBfY2xldm9fcDk1MCwKQEAgLTYzNSw3ICs2NTQsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9xdWlyayBhbGM4ODJfZml4dXBfdGJsW10gPSB7
CiAJU05EX1BDSV9RVUlSSygweDE0NTgsIDB4YTBiOCwgIkdpZ2FieXRlIEFaMzcwLUdhbWlu
ZyIsIEFMQzEyMjBfRklYVVBfR0JfRFVBTF9DT0RFQ1MpLAogCVNORF9QQ0lfUVVJUksoMHgx
NDU4LCAweGEwY2QsICJHaWdhYnl0ZSBYNTcwIEFvcnVzIE1hc3RlciIsIEFMQzEyMjBfRklY
VVBfR0JfWDU3MCksCiAJU05EX1BDSV9RVUlSSygweDE0NTgsIDB4YTBjZSwgIkdpZ2FieXRl
IFg1NzAgQW9ydXMgWHRyZW1lIiwgQUxDMTIyMF9GSVhVUF9HQl9YNTcwKSwKLQlTTkRfUENJ
X1FVSVJLKDB4MTQ1OCwgMHhhMGQ1LCAiR2lnYWJ5dGUgWDU3MFMgQW9ydXMgTWFzdGVyIiwg
QUxDMTIyMF9GSVhVUF9HQl9YNTcwKSwKKwlTTkRfUENJX1FVSVJLKDB4MTQ1OCwgMHhhMGQ1
LCAiR2lnYWJ5dGUgWDU3MFMvWDg3MEUgQW9ydXMiLCBBTEMxMjIwX0ZJWFVQX0dCX0FPUlVT
X05PX0FVVE9NVVRFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTQ2MiwgMHgxMWY3LCAiTVNJLUdF
NjMiLCBBTEMxMjIwX0ZJWFVQX0NMRVZPX1A5NTApLAogCVNORF9QQ0lfUVVJUksoMHgxNDYy
LCAweDEyMjgsICJNU0ktR1A2MyIsIEFMQzEyMjBfRklYVVBfQ0xFVk9fUDk1MCksCiAJU05E
X1BDSV9RVUlSSygweDE0NjIsIDB4MTIyOSwgIk1TSS1HUDczIiwgQUxDMTIyMF9GSVhVUF9D
TEVWT19QOTUwKSwKQEAgLTcxOCw2ICs3MzcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhk
YV9tb2RlbF9maXh1cCBhbGM4ODJfZml4dXBfbW9kZWxzW10gPSB7CiAJey5pZCA9IEFMQzg4
N19GSVhVUF9BU1VTX0JBU1MsIC5uYW1lID0gImFzdXMtYmFzcyJ9LAogCXsuaWQgPSBBTEMx
MjIwX0ZJWFVQX0dCX0RVQUxfQ09ERUNTLCAubmFtZSA9ICJkdWFsLWNvZGVjcyJ9LAogCXsu
aWQgPSBBTEMxMjIwX0ZJWFVQX0dCX1g1NzAsIC5uYW1lID0gImdiLXg1NzAifSwKKwl7Lmlk
ID0gQUxDMTIyMF9GSVhVUF9HQl9BT1JVU19OT19BVVRPTVVURSwgLm5hbWUgPSAiZ2ItYW9y
dXMtbm8tYXV0b211dGUifSwKIAl7LmlkID0gQUxDMTIyMF9GSVhVUF9DTEVWT19QOTUwLCAu
bmFtZSA9ICJjbGV2by1wOTUwIn0sCiAJe30KIH07CgpiYXNlLWNvbW1pdDogZmQ3ZGY5MzAx
M2M1MTE4ODEyZTYzYTUyNjM1ZGM2YzNhODA1YTFkZQotLSAKMi41My4wCgo=
--81463dbb-a229-400f-b5af-782f002c83b6-1--
