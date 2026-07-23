Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC5DC44524
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:16:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 589DD601FC;
	Thu, 23 Jul 2026 09:16:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 589DD601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784790997;
	bh=ydpWMNazXbR1dy5fVTGqIscLCeSrT6lVDeoIj/FXIk0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rhn0XXG/dUpHAPIfFw7mfwhMeUeC2Z9wHJWCY/NeuxAgZmBu3vY9CWxEACbgJLQWO
	 sBmI7hdG2WbCJw3ippRl2DzE73KbRbu5WTL+JYI5vL21HiexjnGaetDbbSXw4xQ9nD
	 pFKVzsw7Hyjv0lwkM9McHAVe98qgAcqgPJtABcAA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5F40F805FE; Thu, 23 Jul 2026 09:16:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A62EF80600;
	Thu, 23 Jul 2026 09:16:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6ADEF8056F; Thu, 23 Jul 2026 09:15:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784790955;
	b=clLAjzCls+gmU7sHaJ4RY9UPe2AQdTSart/4WjUpNeQXx9U1MAV286ByM8J0N5Y662X/
	 stmjUneDVKdPvS+iLKnpt7Goq7p8sNqrVL2BrxPXU/8zbuALx9oEZZW+CLvm82slza5P1
	 nhmmsZOoNvVJcMShSsJYw6XXNXATH10lUyy7P0AUo514uZe0YlvqwaA10or4oIBoBtp80
	 AJ+35uRjV6QwsdDcA8Qxcg0JsoCY/B9hs386Pnw3jFiTiQmV7DZwx6nWFE4SJ91lxVSJv
	 hHyjZ5RlIFlQcLkT6xOJWRtHGJOjGAyYhIFv6G5d1wy5FE1D4G2OeoWfTS/SNpF+viw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784790955;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ydpWMNazXbR1dy5fVTGqIscLCeSrT6lVDeoIj/FXIk0=;
	b=jxBXYeGTAT71m6+vlJ7USeSTRVWqTH4R93eZzoawXog0G20INezH0nYbOwyJz3HmsucR
	 oLUzNdf8RwMPE2BZEs8qerHRxGuSl0OWVuc+Kw+YbLCGQ+kqDgZDYJFjBvqcOxba78eDn
	 H99EbbOcmya2r5BDazEmfCZN+TirHNi4Pe30pYVgC5hpqGUma1H2EhzoTuTdyYa4Gwo/x
	 6qo6gQkbiQfmYAOQsm5qY16K5fJ1XTkzb4bYrPVIHYfpiKNsAe3EWvwu1ggP7ugFFzBPp
	 0I0A0AAbGh8BhMnMApF6e7PCiFDGI10HANxNz+jvpjOeMrYNhQMEKMlD3pnIyfHrxXQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b="uv4d/VP7";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EF3AF802BE
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2026 09:15:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EF3AF802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=uv4d/VP7
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N7FieK6277919,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784790944; bh=0ZWxfw2lQrj7bDvw7NIqLdCf2fLmKPrQ7tQ7YcRepGA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=uv4d/VP7bLgr8KLdwAk0oOgXN567wf/vaeuflY64twrguI5aEeMGIWIN9WADF1pig
	 WjrHaCOwQF48/jf3CoeHQKhR+jhiHy2pCTm+CHjI3eE7BEtpQtY44gB/DXPJZMwy3M
	 sQCmdeUCOon+yXbUQgQamfgYjuvzkvEoGr9q4T50lcaw59HZEkX8NiijmL+tXh0seX
	 dAf//MEluWt0YwXY01voQE5zMaiUBpK24QOz050zzppOfc3w5FSZGKU4TRJBzLhfzb
	 +bhwGY2KfSwfsCArIHYeNOVhATJqKN83DsVwPEKX10kNDoTOUEuqpugezl5ElBg6zP
	 VlkjOuEawogww==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N7FieK6277919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 15:15:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 15:15:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 23 Jul 2026 15:15:44 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Add quirk to another Razer Blade 16
Thread-Topic: Add quirk to another Razer Blade 16
Thread-Index: Ad0acr1oaml9H8FAQTuH7IPjumBaRw==
Date: Thu, 23 Jul 2026 07:15:44 +0000
Message-ID: <0cd8c77a82a4481ca9409ac68f1041e8@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_0cd8c77a82a4481ca9409ac68f1041e8realtekcom_"
MIME-Version: 1.0
Message-ID-Hash: W7SGG2ZQQGNV6A3AMZ22R63AX5XYYHRO
X-Message-ID-Hash: W7SGG2ZQQGNV6A3AMZ22R63AX5XYYHRO
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W7SGG2ZQQGNV6A3AMZ22R63AX5XYYHRO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_0cd8c77a82a4481ca9409ac68f1041e8realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Razer Blade 16 had another SSID.
The patch will add quirk to another machine.

BR,
Kailang

--_002_0cd8c77a82a4481ca9409ac68f1041e8realtekcom_
Content-Type: application/octet-stream; name="0000-razer-p11.patch"
Content-Description: 0000-razer-p11.patch
Content-Disposition: attachment; filename="0000-razer-p11.patch"; size=1210;
	creation-date="Thu, 23 Jul 2026 07:15:13 GMT";
	modification-date="Thu, 23 Jul 2026 07:11:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNzJhNjBkYTcxM2YyYTBiYWNmZTMzNGRjNDc4M2FmOTUzNmRkOGVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMjMgSnVsIDIwMjYgMTQ6NTk6NDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFkZCBxdWlyayB0byBhbm90aGVyIFJhemVyIEJsYWRlIDE2CgpBZGQg
cXVpcmsgdG8gYW5vdGhlciBtYWNoaW5lLgoKRml4ZXM6IDk2MWQ5Zjk4ZGEwZCAoIkFMU0E6IGhk
YS9yZWFsdGVrOiBFbmFibGUgaW50ZXJuYWwgc3BlYWtlcnMgb24gUmF6ZXIgQmxhZGUgMTYgKDIw
MjUpIikKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoK
ZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYyBiL3NvdW5kL2hk
YS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCBhZGRlN2M5NTNkNjYuLjVjMjcxNWI0OWE4
ZCAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCisrKyBiL3Nv
dW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAtODAzMiw2ICs4MDMyLDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewogCVNORF9Q
Q0lfUVVJUksoMHgxOWU1LCAweDMyMDQsICJIdWF3ZWkgTUFDSC1XWDkiLCBBTEMyNTZfRklYVVBf
SFVBV0VJX01BQ0hfV1g5X1BJTlMpLAogCVNORF9QQ0lfUVVJUksoMHgxOWU1LCAweDMyMGYsICJI
dWF3ZWkgV1JULVdYOSAiLCBBTEMyNTZfRklYVVBfQVNVU19NSUNfTk9fUFJFU0VOQ0UpLAogCVNO
RF9QQ0lfUVVJUksoMHgxOWU1LCAweDMyMTIsICJIdWF3ZWkgS0xWLVdYOSAiLCBBTEMyNTZfRklY
VVBfQUNFUl9IRUFEU0VUX01JQyksCisJU05EX1BDSV9RVUlSSygweDFhNTgsIDB4MjAyMywgIlJh
emVyIEJsYWRlIDE2ICgyMDI1KSIsCisJCSAgICAgIEFMQzI5OF9GSVhVUF9SQVpFUl9CTEFERTE2
XzIwMjVfUElOUyksCiAJU05EX1BDSV9RVUlSSygweDFhNTgsIDB4MzAwZSwgIlJhemVyIEJsYWRl
IDE2ICgyMDI1KSIsCiAJCSAgICAgIEFMQzI5OF9GSVhVUF9SQVpFUl9CTEFERTE2XzIwMjVfUElO
UyksCiAJU05EX1BDSV9RVUlSSygweDFiMzUsIDB4MTIzNSwgIkNaQyBCMjAiLCBBTEMyNjlfRklY
VVBfQ1pDX0IyMCksCg==

--_002_0cd8c77a82a4481ca9409ac68f1041e8realtekcom_--
