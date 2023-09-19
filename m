Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744D7CD54A8
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 08:41:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CCEFDE5;
	Tue, 19 Sep 2023 10:40:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CCEFDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695112868;
	bh=NCHUqcGvIH7Nxqyq2cDNeSZjOi7wP/zk/c3WJom6zNI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lH7OxS3Tlf/Swhmxlku93MYYnY0y7G1TErwm9vBBSJ9eMlcNYjpHaN65iIcjcWS5l
	 1OLTmSP5wZV0nKm2YAKYqO/6JeS3uaGTxt9F9/NQ55yEYV9GneEakMNqMcKlQ4Fpa2
	 a+xQ62ojncoMK3ANZdrgcJ8Hx9oXJAn8++oGzlK4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 302E5F801F5; Tue, 19 Sep 2023 10:39:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68CB3F8025A;
	Tue, 19 Sep 2023 10:39:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54B14F801F5; Tue, 19 Sep 2023 10:39:51 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9756F800F4
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 10:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9756F800F4
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38J8ddTiB3327648,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38J8ddTiB3327648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:39:39 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Sep 2023 16:39:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 19 Sep 2023 16:39:39 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Tue, 19 Sep 2023 16:39:39 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
Subject: New Lenovo MTL platform
Thread-Topic: New Lenovo MTL platform
Thread-Index: Adnq1LeQH4JNluaFTnGFES3wVjJ+ug==
Date: Tue, 19 Sep 2023 08:39:39 +0000
Message-ID: <8d63c6e360124e3ea2523753050e6f05@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.22.102.106]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: multipart/mixed;
	boundary="_002_8d63c6e360124e3ea2523753050e6f05realtekcom_"
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Message-ID-Hash: OSH7ZEGIMQA3PTTGOT2FGQ3FR3DKX24G
X-Message-ID-Hash: OSH7ZEGIMQA3PTTGOT2FGQ3FR3DKX24G
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OSH7ZEGIMQA3PTTGOT2FGQ3FR3DKX24G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_8d63c6e360124e3ea2523753050e6f05realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

SSID:0x231f Lenovo new MTL platform.
Attach patch will support it.

BR,
Kailang

--_002_8d63c6e360124e3ea2523753050e6f05realtekcom_
Content-Type: application/octet-stream;
	name="0000-alc287-lenovo-platform.patch"
Content-Description: 0000-alc287-lenovo-platform.patch
Content-Disposition: attachment;
	filename="0000-alc287-lenovo-platform.patch"; size=1131;
	creation-date="Tue, 19 Sep 2023 08:29:08 GMT";
	modification-date="Tue, 19 Sep 2023 08:34:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyZjgzZjZhMmI3OTI5MWNmMTg1YTExNGU1NjdjM2EzYjY4NjBhMjM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTkgU2VwIDIwMjMgMTY6Mjc6MTYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFMQzI4NyBSZWFsdGVrIEkyUyBzcGVha2VyIHBsYXRmb3JtIHN1cHBv
cnQKCk5ldyBwbGF0Zm9ybSBTU0lEOjB4MjMxZi4KMHgxNyB3YXMgb25seSBzcGVha2VyIHBpbiwg
REFDIGFzc2lnbmVkIHdpbGwgYmUgMHgwMy4gSGVhZHBob25lIGFzc2lnbmVkIHRvIDB4MDIuClBs
YXliYWNrIHZpYSBoZWFkcGhvbmUgd2lsbCBnZXQgRVEgZmlsdGVyIHByb2Nlc3NpbmcuU28saXQg
bmVlZHMgdG8gc3dhcCBEQUMuIAoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5n
QHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMg
Yi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCA4ODNhN2U4NjViYzUuLjc1MTc4
M2YzYTE1YyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTEwNTc3LDYgKzEwNTc3LDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2hkYV9waW5fcXVpcmsgYWxjMjY5X3Bpbl9maXh1cF90Ymxb
XSA9IHsKIAkJezB4MTcsIDB4OTAxNzAxMTB9LAogCQl7MHgxOSwgMHgwM2ExMTAzMH0sCiAJCXsw
eDIxLCAweDAzMjExMDIwfSksCisJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI4NywgMHgxN2Fh
LCAiTGVub3ZvIiwgQUxDMjg3X0ZJWFVQX1RISU5LUEFEX0kyU19TUEssCisJCXsweDE3LCAweDkw
MTcwMTEwfSwgLyogMHgyMzFmIHdpdGggUlRLIEkyUyBBTVAgKi8KKwkJezB4MTksIDB4MDRhMTEw
NDB9LAorCQl7MHgyMSwgMHgwNDIxMTAyMH0pLAogCVNORF9IREFfUElOX1FVSVJLKDB4MTBlYzAy
ODYsIDB4MTAyNSwgIkFjZXIiLCBBTEMyODZfRklYVVBfQUNFUl9BSU9fTUlDX05PX1BSRVNFTkNF
LAogCQl7MHgxMiwgMHg5MGE2MDEzMH0sCiAJCXsweDE3LCAweDkwMTcwMTEwfSwK

--_002_8d63c6e360124e3ea2523753050e6f05realtekcom_--
