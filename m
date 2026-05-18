Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F3CD4F3C
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 12:35:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DECF660219;
	Mon, 18 May 2026 14:35:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DECF660219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779107733;
	bh=Bu4zUzk3v0EQyzxUXRpp34IqCulmSe+OHHxCD3WKhN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RJWsMB2oIsOW0/nXw5cWy4ZW0u2rl3tnHT2e0Ixrn4sRCzmrBeFahCOjzPl62y7EY
	 f7tr5+Vp+W3btrcGAKJdKfggBrWtS84jVstYOlYvUk9NSILKEEaaKcsCxX+UDs4IjY
	 mk48MueRteLNL8atzbotoGBkj88sGRmLIAv6iWMw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E02DF805C8; Mon, 18 May 2026 14:34:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A2A5F805ED;
	Mon, 18 May 2026 14:34:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B139F804F3; Mon, 18 May 2026 11:23:30 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1648DF80088
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 11:23:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1648DF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=izNz9zbo
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d75312379so1958498f8f.1
        for <alsa-devel@alsa-project.org>;
 Mon, 18 May 2026 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779096207; x=1779701007;
 darn=alsa-project.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0hsr+KlAbSUcD5ADOjmOJgDc+od8XWr1gxN0Ixp5PY=;
        b=izNz9zbodyhueINb7Zje6Ed8LANamCWcsGezilrcnTQPSoJ6SIG16OReTOEguz1D+g
         Hnhr9T7b6Dj9XhVpY7+YHTdqqN9ci+dRWw/q7fhSgu8a3prDhaGb5Jp0AWTdLiNpQ+l5
         364EUhpOrGZ5Fc7HwKfqOUVxIfpYZ7uX4J/ALxqNHC9CSR9/uOnLdsz9xCRM1RsJKCU6
         otA70Wam5LbuMVDGP0ZUqZaSi/ipAiOFjKkZGv1+CtOXQuspOgQqjdGVUjipgKlBmEmD
         JGnK41FeT47Fsaco4VVPiDcdlvU2CIBHMlvxJCuOtLRt/yIlQdINeyO6S3LBkTxaMaYI
         6Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096207; x=1779701007;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0hsr+KlAbSUcD5ADOjmOJgDc+od8XWr1gxN0Ixp5PY=;
        b=LIWq3KdBO+6xPwUg8cKK7kWb88mqOr4ocl4/Sqn//JTwNAvqkc6vrht82hv7ezJu/Q
         33gwIxYa4W8Pze2tQ8upGtyh1pbmcsbltN0vze0KLpTLo9AfCZ2DhGNYVkcBZk2D3Riz
         zBVbaqpRPZmasVlaPn+FMkcTsk3gRiKCGtzK5SFapB51B0JrJS0UjN+OzJ3wBEtNMNfY
         MsOIdZdJpHTm4gz4mqOmE4bAjieK17uqS5yRXXUdjGjp6J4Df/6Av6nSQSJbNW8mRwNa
         T3bZ+zC15dS5G1YaOR/UUR6TxBYs4lgQq1JLedjujtJ2mY0IhYsWGqDO7shRvlemJBlw
         1KyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k1qJOXAbRx7sMWXBmG1Q4Xw5WgK6AG9+St0513VvsG050Vwk+w8HavLZSHUlW6wg9tAuERJ96Of5B@alsa-project.org
X-Gm-Message-State: AOJu0Yxx6yodpRwrjPI01aIkRa6mz93sQZhhIk9IqPDclaqj6VTySkc+
	FeUmUSp3kGcZ2ujHUvs5xNVLjBKwyTROC40dhUleDuJhKTBRTjekDAMR
X-Gm-Gg: Acq92OFG9EUK19UvTqL5OHbT+XOV0JgYOWeAHwKrzEvU7T7dUHJhNyIcdD3saMbizgi
	iCn7dQvUEMnabLwHMjVpwZwm/Zy7tdjF/Ez+yXHj2Wpeg/xPMkepJlk4eNc3RZ4/2q9ChwEwaEY
	yQWRI6YjPqqj5UOdGIJ6sk+Om+R5Se/kaq8H1TpyE5MWfuvyhTBGeOjcVvnaHXuMiB7TTyctRrS
	og+7z6q57L6++fK9H0DX3mDq74hHb4wdh7/Wq6vakpR6M9mxkb5ewu4Oa/tvQiUg72J5I5FUCAT
	lArI/SyZ9UMCEEP0bYxPQbGEbkZSo7CtV++grHwkJCgJ/rhaEygnwUAO3zwdb0L5gX4+i5TcU3+
	pvK0h0gf16qniWwCoXJ9LUirF+5TIM7VCZoM7VkEcfrrTIV3ZrB9DYrmEH5TcCodG1JxZ4sNX6B
	x3F3nnjxLkLwsGCPfPzA==
X-Received: by 2002:a05:6000:410d:b0:451:73c8:9101 with SMTP id
 ffacd0b85a97d-45d92797006mr20880171f8f.18.1779096206896;
        Mon, 18 May 2026 02:23:26 -0700 (PDT)
Received: from [0.0.0.0] ([151.67.112.59])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm34859813f8f.19.2026.05.18.02.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:23:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1w32X7pBgFU0IWMGvWGgPZ7i"
Message-ID: <0c0b781f-1595-4595-921a-66d83cf5930b@gmail.com>
Date: Mon, 18 May 2026 11:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/ca0132: add QUIRK_GENERIC path for Gigabyte,
 GA-Z170X-Gaming G1
Content-Language: it
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela ` <perex@perex.cz>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <a1dd5dfd-8678-4dd9-b6af-68a1e078168a@gmail.com>
 <87tss7xyj5.wl-tiwai@suse.de>
 <2f45fd6e-0a5b-4f47-9f2b-75d8b323ced8@gmail.com>
 <87h5o5ersn.wl-tiwai@suse.de>
From: "eziogale@gmail.com" <eziogale@gmail.com>
In-Reply-To: <87h5o5ersn.wl-tiwai@suse.de>
X-MailFrom: eziogale@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TWXOVFUEKLF4HMHZL4G6RXVTHBNQSVGI
X-Message-ID-Hash: TWXOVFUEKLF4HMHZL4G6RXVTHBNQSVGI
X-Mailman-Approved-At: Mon, 18 May 2026 12:34:51 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TWXOVFUEKLF4HMHZL4G6RXVTHBNQSVGI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a multi-part message in MIME format.
--------------1w32X7pBgFU0IWMGvWGgPZ7i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, with gmail and OAUTH2 it's a bit complicated. I'v to make an 
attachmant.
Tanks for the patience.


--------------1w32X7pBgFU0IWMGvWGgPZ7i
Content-Type: text/plain; charset=UTF-8;
 name="0001-ALSA-hda-ca0132-add-QUIRK_GENERIC-path-for-Gigabyte-GA-Z170X-Gaming-G1-2.patch"
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-ca0132-add-QUIRK_GENERIC-path-for-Gigabyte-GA-";
 filename*1="Z170X-Gaming-G1-2.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NDExYmU2NTM0MDQyNDZlNjYxZDZiY2Y0MTgzNDVhYmY4NjZlMDk4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBFemlvIEdhbGVhenppIDxlemlvZ2FsZUBnbWFpbC5j
b20+CkRhdGU6IFN1biwgMTcgTWF5IDIwMjYgMTc6NDI6MzYgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBBTFNBOiBoZGEvY2EwMTMyOiBhZGQgUVVJUktfR0VORVJJQyBwYXRoIGZvciBHaWdh
Ynl0ZQogR0EtWjE3MFgtR2FtaW5nIEcxCgpTb21lIENBMDEzMiBpbXBsZW1lbnRhdGlvbnMg
KGUuZy4gR2lnYWJ5dGUgR0EtWjE3MFgtR2FtaW5nIEcxKSBwcm9kdWNlIHdoaXRlIG5vaXNl
IHdoZW4gdXNpbmcgdGhlIERTUCBmaXJtd2FyZSBwYXRoLiBBZGQgYSBRVUlSS19HRU5FUklD
IHBhdGggdGhhdCB1c2VzIHRoZSBzdGFuZGFyZCBIREEgZ2VuZXJpYyBwYXJzZXIgaW5zdGVh
ZCwgd2l0aCBjdXN0b20gcGluIGNvbmZpZ3MuClRoaXMgcGF0Y2ggYXBwbGllcyBhZ2FpbnN0
IHY2LjE4LjI0LgoKU2lnbmVkLW9mZi1ieTogRXppbyBHYWxlYXp6aSA8ZXppb2dhbGVAZ21h
aWwuY29tPgoKLS0tCiBzb3VuZC9oZGEvY29kZWNzL0tjb25maWcgIHwgICAxICsKIHNvdW5k
L2hkYS9jb2RlY3MvY2EwMTMyLmMgfCAxMTEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9LY29uZmlnIGIvc291
bmQvaGRhL2NvZGVjcy9LY29uZmlnCmluZGV4IGFkZGJjOTQuLmRjZjM0MGUgMTAwNjQ0Ci0t
LSBhL3NvdW5kL2hkYS9jb2RlY3MvS2NvbmZpZworKysgYi9zb3VuZC9oZGEvY29kZWNzL0tj
b25maWcKQEAgLTY5LDYgKzY5LDcgQEAgY29tbWVudCAiU2V0IHRvIFkgaWYgeW91IHdhbnQg
YXV0by1sb2FkaW5nIHRoZSBjb2RlYyBkcml2ZXIiCiAKIGNvbmZpZyBTTkRfSERBX0NPREVD
X0NBMDEzMgogCXRyaXN0YXRlICJCdWlsZCBDcmVhdGl2ZSBDQTAxMzIgY29kZWMgc3VwcG9y
dCIKKwlzZWxlY3QgU05EX0hEQV9HRU5FUklDCiAJaGVscAogCSAgU2F5IFkgb3IgTSBoZXJl
IHRvIGluY2x1ZGUgQ3JlYXRpdmUgQ0EwMTMyIGNvZGVjIHN1cHBvcnQgaW4KIAkgIHNuZC1o
ZGEtaW50ZWwgZHJpdmVyLgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9jYTAxMzIu
YyBiL3NvdW5kL2hkYS9jb2RlY3MvY2EwMTMyLmMKaW5kZXggZGQwNTRhZS4uOTJmYzkzZiAx
MDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9jYTAxMzIuYworKysgYi9zb3VuZC9oZGEv
Y29kZWNzL2NhMDEzMi5jCkBAIC0yNCw2ICsyNCw3IEBACiAjaW5jbHVkZSAiaGRhX2xvY2Fs
LmgiCiAjaW5jbHVkZSAiaGRhX2F1dG9fcGFyc2VyLmgiCiAjaW5jbHVkZSAiaGRhX2phY2su
aCIKKyNpbmNsdWRlICJnZW5lcmljLmgiCiAKICNpbmNsdWRlICJjYTAxMzJfcmVncy5oIgog
CkBAIC0xMDYwLDYgKzEwNjEsOCBAQCBlbnVtIGRzcF9kb3dubG9hZF9zdGF0ZSB7CiAgKi8K
IAogc3RydWN0IGNhMDEzMl9zcGVjIHsKKwlzdHJ1Y3QgaGRhX2dlbl9zcGVjIGdlbjsKKwog
CWNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3ICptaXhlcnNbNV07CiAJdW5zaWduZWQg
aW50IG51bV9taXhlcnM7CiAJY29uc3Qgc3RydWN0IGhkYV92ZXJiICpiYXNlX2luaXRfdmVy
YnM7CkBAIC0xMTc0LDYgKzExNzcsNyBAQCBlbnVtIHsKIAlRVUlSS19SM0QsCiAJUVVJUktf
QUU1LAogCVFVSVJLX0FFNywKKwlRVUlSS19HRU5FUklDLAogCVFVSVJLX05PTkUgPSBIREFf
RklYVVBfSURfTk9UX1NFVCwKIH07CiAKQEAgLTEyOTIsNiArMTI5NiwyMCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGhkYV9waW50YmwgYWU3X3BpbmNmZ3NbXSA9IHsKIAl7fQogfTsKIAor
c3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcGludGJsIGNhMDEzMl9nZW5lcmljX3BpbmNmZ3Nb
XSA9IHsKKwl7IDB4MGIsIDB4NDEwMTQxMTEgfSwKKwl7IDB4MGMsIDB4NDE0NTIwZjAgfSwg
LyogU1BESUYgb3V0ICovCisJeyAweDBkLCAweDAxMDE0MDEwIH0sIC8qIGxpbmVvdXQgKi8K
Kwl7IDB4MGUsIDB4NDFjNTAxZjAgfSwKKwl7IDB4MGYsIDB4NDExMTExZjAgfSwgLyogZGlz
YWJsZWQgKi8KKwl7IDB4MTAsIDB4NDExMTExZjAgfSwgLyogZGlzYWJsZWQgKi8KKwl7IDB4
MTEsIDB4NDEwMTIwMTQgfSwKKwl7IDB4MTIsIDB4MzdhNzkwZjAgfSwgLyogbWljICovCisJ
eyAweDEzLCAweDc3YTcwMWYwIH0sCisJeyAweDE4LCAweDUwMDAwMGYwIH0sCisJe30KK307
CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX3F1aXJrIGNhMDEzMl9xdWlya3NbXSA9IHsK
IAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNTdiLCAiQWxpZW53YXJlIE0xN3ggUjQiLCBR
VUlSS19BTElFTldBUkVfTTE3WFI0KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNjg1
LCAiQWxpZW53YXJlIDE1IDIwMTUiLCBRVUlSS19BTElFTldBUkUpLApAQCAtMTMwNCw2ICsx
MzIyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgY2EwMTMyX3F1aXJrc1td
ID0gewogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweEEwMTYsICJSZWNvbjNEaSIsIFFVSVJL
X1IzREkpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweEEwMjYsICJHaWdhYnl0ZSBHMS5T
bmlwZXIgWjk3IiwgUVVJUktfUjNESSksCiAJU05EX1BDSV9RVUlSSygweDE0NTgsIDB4QTAz
NiwgIkdpZ2FieXRlIEdBLVoxNzBYLUdhbWluZyA3IiwgUVVJUktfUjNESSksCisJU05EX1BD
SV9RVUlSSygweDE0NTgsIDB4QTA0NiwgIkdpZ2FieXRlIEdBLVoxNzBYLUdhbWluZyBHMSIs
IFFVSVJLX0dFTkVSSUMpLAogCVNORF9QQ0lfUVVJUksoMHgzODQyLCAweDEwMzgsICJFVkdB
IFg5OSBDbGFzc2lmaWVkIiwgUVVJUktfUjNESSksCiAJU05EX1BDSV9RVUlSSygweDM4NDIs
IDB4MTA0YiwgIkVWR0EgWDI5OSBEYXJrIiwgUVVJUktfUjNESSksCiAJU05EX1BDSV9RVUlS
SygweDM4NDIsIDB4MTA1NSwgIkVWR0EgWjM5MCBEQVJLIiwgUVVJUktfUjNESSksCkBAIC0x
MzI1LDYgKzEzNDQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9tb2RlbF9maXh1cCBj
YTAxMzJfcXVpcmtfbW9kZWxzW10gPSB7CiAJeyAuaWQgPSBRVUlSS19SM0QsIC5uYW1lID0g
InIzZCIgfSwKIAl7IC5pZCA9IFFVSVJLX0FFNSwgLm5hbWUgPSAiYWU1IiB9LAogCXsgLmlk
ID0gUVVJUktfQUU3LCAubmFtZSA9ICJhZTciIH0sCisJeyAuaWQgPSBRVUlSS19HRU5FUklD
LCAubmFtZSA9ICJnZW5lcmljIiB9LAogCXt9CiB9OwogCkBAIC05ODgyLDE0ICs5OTAyLDU3
IEBAIHN0YXRpYyB2b2lkIHNiel9kZXRlY3RfcXVpcmsoc3RydWN0IGhkYV9jb2RlYyAqY29k
ZWMpCiAJfQogfQogCitzdGF0aWMgdm9pZCBjYTAxMzJfZ2VuZXJpY19pbml0X2hvb2soc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJc3RydWN0IGNhMDEzMl9zcGVjICpzcGVjID0g
Y29kZWMtPnNwZWM7CisKKwlzbmRfaGRhX3NlcXVlbmNlX3dyaXRlKGNvZGVjLCBzcGVjLT5z
cGVjX2luaXRfdmVyYnMpOworfQorCitzdGF0aWMgaW50IGNhMDEzMl9nZW5lcmljX3Byb2Jl
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQoreworCXN0cnVjdCBjYTAxMzJfc3BlYyAqc3Bl
YyA9IGNvZGVjLT5zcGVjOworCXN0cnVjdCBhdXRvX3Bpbl9jZmcgKmNmZyA9ICZzcGVjLT5n
ZW4uYXV0b2NmZzsKKwlpbnQgZXJyOworCisJc25kX2hkYV9nZW5fc3BlY19pbml0KCZzcGVj
LT5nZW4pOworCisJc25kX2hkYV9hcHBseV9waW5jZmdzKGNvZGVjLCBjYTAxMzJfZ2VuZXJp
Y19waW5jZmdzKTsKKworCWNhMDEzMl9pbml0X2NoaXAoY29kZWMpOworCisJZXJyID0gY2Ew
MTMyX3ByZXBhcmVfdmVyYnMoY29kZWMpOworCWlmIChlcnIgPCAwKQorCQlyZXR1cm4gZXJy
OworCisJZXJyID0gc25kX2hkYV9wYXJzZV9waW5fZGVmX2NvbmZpZyhjb2RlYywgY2ZnLCBO
VUxMKTsKKwlpZiAoZXJyIDwgMCkKKwkJcmV0dXJuIGVycjsKKwllcnIgPSBzbmRfaGRhX2dl
bl9wYXJzZV9hdXRvX2NvbmZpZyhjb2RlYywgY2ZnKTsKKwlpZiAoZXJyIDwgMCkKKwkJcmV0
dXJuIGVycjsKKworCXNwZWMtPmdlbi5pbml0X2hvb2sgPSBjYTAxMzJfZ2VuZXJpY19pbml0
X2hvb2s7CisJc3BlYy0+Z2VuLmF1dG9tdXRlX3NwZWFrZXIgPSAwOworCXNwZWMtPmdlbi5h
dXRvbXV0ZV9sbyA9IDA7CisKKwlzbmRfaGRhX3NlcXVlbmNlX3dyaXRlKGNvZGVjLCBzcGVj
LT5zcGVjX2luaXRfdmVyYnMpOworCXJldHVybiAwOworfQorCiBzdGF0aWMgdm9pZCBjYTAx
MzJfY29kZWNfcmVtb3ZlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogewogCXN0cnVjdCBj
YTAxMzJfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwogCi0JaWYgKGNhMDEzMl9xdWlyayhz
cGVjKSA9PSBRVUlSS19aWFJfREJQUk8pCisJc3dpdGNoIChjYTAxMzJfcXVpcmsoc3BlYykp
IHsKKwljYXNlIFFVSVJLX0dFTkVSSUM6CisJCXNuZF9oZGFfZ2VuX3JlbW92ZShjb2RlYyk7
CisJCXJldHVybjsKKwljYXNlIFFVSVJLX1pYUl9EQlBSTzoKIAkJcmV0dXJuIGRicHJvX2Zy
ZWUoY29kZWMpOwotCWVsc2UKKwlkZWZhdWx0OgogCQlyZXR1cm4gY2EwMTMyX2ZyZWUoY29k
ZWMpOworCX0KIH0KIAogc3RhdGljIGludCBjYTAxMzJfY29kZWNfcHJvYmUoc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMsCkBAIC05OTA2LDE0ICs5OTY5LDIxIEBAIHN0YXRpYyBpbnQgY2Ew
MTMyX2NvZGVjX3Byb2JlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCWNvZGVjLT5zcGVj
ID0gc3BlYzsKIAlzcGVjLT5jb2RlYyA9IGNvZGVjOwogCi0JLyogRGV0ZWN0IGNvZGVjIHF1
aXJrICovCi0Jc25kX2hkYV9waWNrX2ZpeHVwKGNvZGVjLCBjYTAxMzJfcXVpcmtfbW9kZWxz
LCBjYTAxMzJfcXVpcmtzLCBOVUxMKTsKLQlpZiAoY2EwMTMyX3F1aXJrKHNwZWMpID09IFFV
SVJLX1NCWikKLQkJc2J6X2RldGVjdF9xdWlyayhjb2RlYyk7Ci0KKwkvKiBUaGVzZSBtdXN0
IGJlIHNldCBiZWZvcmUgYW55IHBhdGggaXMgdGFrZW4gKi8KIAljb2RlYy0+cGNtX2Zvcm1h
dF9maXJzdCA9IDE7CiAJY29kZWMtPm5vX3N0aWNreV9zdHJlYW0gPSAxOwogCisJLyogRGV0
ZWN0IGNvZGVjIHF1aXJrICovCisJc25kX2hkYV9waWNrX2ZpeHVwKGNvZGVjLCBjYTAxMzJf
cXVpcmtfbW9kZWxzLCBjYTAxMzJfcXVpcmtzLCBOVUxMKTsKKwlzd2l0Y2ggKGNhMDEzMl9x
dWlyayhzcGVjKSkgeworCWNhc2UgUVVJUktfU0JaOgorCQlzYnpfZGV0ZWN0X3F1aXJrKGNv
ZGVjKTsKKwkJYnJlYWs7CisJY2FzZSBRVUlSS19HRU5FUklDOgorCQlyZXR1cm4gY2EwMTMy
X2dlbmVyaWNfcHJvYmUoY29kZWMpOworCWRlZmF1bHQ6CisJCWJyZWFrOworCX0KIAogCXNw
ZWMtPmRzcF9zdGF0ZSA9IERTUF9ET1dOTE9BRF9JTklUOwogCXNwZWMtPm51bV9taXhlcnMg
PSAxOwpAQCAtMTAwMTQsMzYgKzEwMDg0LDUxIEBAIHN0YXRpYyBpbnQgY2EwMTMyX2NvZGVj
X2J1aWxkX2NvbnRyb2xzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogewogCXN0cnVjdCBj
YTAxMzJfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwogCi0JaWYgKGNhMDEzMl9xdWlyayhz
cGVjKSA9PSBRVUlSS19aWFJfREJQUk8pCisJc3dpdGNoIChjYTAxMzJfcXVpcmsoc3BlYykp
IHsKKwljYXNlIFFVSVJLX0dFTkVSSUM6CisJCXJldHVybiBzbmRfaGRhX2dlbl9idWlsZF9j
b250cm9scyhjb2RlYyk7CisJY2FzZSBRVUlSS19aWFJfREJQUk86CiAJCXJldHVybiBkYnBy
b19idWlsZF9jb250cm9scyhjb2RlYyk7Ci0JZWxzZQorCWRlZmF1bHQ6CiAJCXJldHVybiBj
YTAxMzJfYnVpbGRfY29udHJvbHMoY29kZWMpOworCX0KIH0KIAogc3RhdGljIGludCBjYTAx
MzJfY29kZWNfYnVpbGRfcGNtcyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIHsKIAlzdHJ1
Y3QgY2EwMTMyX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKIAotCWlmIChjYTAxMzJfcXVp
cmsoc3BlYykgPT0gUVVJUktfWlhSX0RCUFJPKQorCXN3aXRjaCAoY2EwMTMyX3F1aXJrKHNw
ZWMpKSB7CisJY2FzZSBRVUlSS19HRU5FUklDOgorCQlyZXR1cm4gc25kX2hkYV9nZW5fYnVp
bGRfcGNtcyhjb2RlYyk7CisJY2FzZSBRVUlSS19aWFJfREJQUk86CiAJCXJldHVybiBkYnBy
b19idWlsZF9wY21zKGNvZGVjKTsKLQllbHNlCisJZGVmYXVsdDoKIAkJcmV0dXJuIGNhMDEz
Ml9idWlsZF9wY21zKGNvZGVjKTsKKwl9CiB9CiAKIHN0YXRpYyBpbnQgY2EwMTMyX2NvZGVj
X2luaXQoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJc3RydWN0IGNhMDEzMl9zcGVj
ICpzcGVjID0gY29kZWMtPnNwZWM7CiAKLQlpZiAoY2EwMTMyX3F1aXJrKHNwZWMpID09IFFV
SVJLX1pYUl9EQlBSTykKKwlzd2l0Y2ggKGNhMDEzMl9xdWlyayhzcGVjKSkgeworCWNhc2Ug
UVVJUktfR0VORVJJQzoKKwkJcmV0dXJuIHNuZF9oZGFfZ2VuX2luaXQoY29kZWMpOworCWNh
c2UgUVVJUktfWlhSX0RCUFJPOgogCQlyZXR1cm4gZGJwcm9faW5pdChjb2RlYyk7Ci0JZWxz
ZQorCWRlZmF1bHQ6CiAJCXJldHVybiBjYTAxMzJfaW5pdChjb2RlYyk7CisJfQogfQogCiBz
dGF0aWMgaW50IGNhMDEzMl9jb2RlY19zdXNwZW5kKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
KQogewogCXN0cnVjdCBjYTAxMzJfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwogCisJaWYg
KGNhMDEzMl9xdWlyayhzcGVjKSA9PSBRVUlSS19HRU5FUklDKQorCQlyZXR1cm4gMDsKKwog
CWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmc3BlYy0+dW5zb2xfaHBfd29yayk7CiAJcmV0
dXJuIDA7CiB9Ci0tIAoyLjU0LjAK

--------------1w32X7pBgFU0IWMGvWGgPZ7i--
