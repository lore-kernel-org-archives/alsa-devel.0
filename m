Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF41C4451C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:47:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B25B601FA;
	Tue, 21 Jul 2026 09:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B25B601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784620064;
	bh=hRceb/2EQpmlP8QJH3a+Ib7rKOmy+Cb/m46LR67EXqc=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=QdmNsawL2fc6SEZn6G7MVZ5TvWhadvOnh4C1pkZhZ0+nH1m8Uz/Jw06kIuDbNCyuQ
	 VhbDThXuKmvl7QcHC8m5uIWppYJfa0tRGvyBQEwn19PWN0GEdiwRbSWz9S6PBTVr2l
	 wR1Usbq5OLfJS1TkcjEMRG90hfyuX55PAM5gyJpE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA9ADF80601; Tue, 21 Jul 2026 09:47:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70CE2F805F9;
	Tue, 21 Jul 2026 09:47:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C58AF8053D; Tue, 21 Jul 2026 09:47:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784620020;
	b=G6Jev55KcX2yvpk2eO3ylsmy3UZQu/5cLu3ru69jE3unm4av9Zy1uP/wF9Wu0+8vFxAO
	 2IYJloFnuh6ntiggOlXZiRHaI+6RlmrC+8cqy/cdh9d+0dElkRyHyQZNXAGeB5kEfT1Nt
	 I0f0Xv43VkhUZXA6UbmZAbwdvmb6FooHk4UHn3zscAQxCbE5Qp0fuv/JSLp1R/E45qnR+
	 7XP3ajceBnY5o3IH/rGL9BTjG1Sstj56C5Au6peOVOvpR+ls452OBxinvrC1HSVJ6X/Dg
	 Q6W1XFOzCBwybEURyOSHTaDxHpVrKxt4Tv3ZmSPHKuwXbEKNKfIhb78S6JRSIOM5DlQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784620020;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hRceb/2EQpmlP8QJH3a+Ib7rKOmy+Cb/m46LR67EXqc=;
	b=IL4gwBblw1pCjIITRW41sTANRCy3Z4H8DhzmDpJf+oYBzbkSPIFlpLgs7mMvee11fA97
	 npGyrLDHx19SjichYx/pS1BBUOcBn1NOGY/6LHHEV8IVIL8jY74s5tQyMbiKf5TkDxkB3
	 Tbb9UboNB5+CgNCYGTZ20Ups6d7CS/M10KZTOGNbwSKmGMSp/8bmHXZQwoeCaL2jmZ52Y
	 i7KG0XDBoyvYnztrNUPOoyMaKFB+s03Fd8jiPhzwMRmMplDWR/Arbc3cPCa4J7S5MGRxI
	 ZIm7x1EgUdRoJLFLUzj+V+ijMGr7yRo//kMJ0KshQHzU8mBPQPHXqO7dwjBW7RCKKhw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=KVDwgeoz;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 38F70F80423
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2026 09:46:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38F70F80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=KVDwgeoz
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L7koD533031040,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784620010; bh=+YTkHeXa7EOUCkMZxVh4rg/KoiEmphR7pKIdtpyaU5o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=KVDwgeozA+3mALaDR0UfjC4ztQORGIiBnvWCpPnlcK0k/qpCe2+Tmy5u9pBjEdwjc
	 KP+3X8trLjpMChF2Do08WJ+LS1oL4hLYwjDSBKG8BB41q9O6olUrMcZL6SWTjw7oYA
	 3VfDVBFriDazMe0INXyE3flFA+EApam4sx+iMcdfkyrsj+tVV65xAFyv6wimss5TFp
	 FOPR0t9M53OUGuZR6gxrIjCYBnA4dN5jH15YJctrqwTE+rgTrxf8RlS52rltpvWVaO
	 Pu2vupcEuC1YD9qBpBjO5fMe2jJGVBj7g1Z8ZyCb1NvuFoj7x2Raq47kEdrR7/TnJ+
	 BN/InjA9H54CQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L7koD533031040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 15:46:50 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 15:46:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 15:46:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 21 Jul 2026 15:46:50 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: ALSA: hda/realtek - Add quirk for Dell Pro QC1255
Thread-Topic: ALSA: hda/realtek - Add quirk for Dell Pro QC1255
Thread-Index: Ad0Y5DVG+tQyhmJsTjKUwyDtJgH2Zg==
Date: Tue, 21 Jul 2026 07:46:50 +0000
Message-ID: <e13d08e96ac449b6994d56dfe6ce3f5c@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_e13d08e96ac449b6994d56dfe6ce3f5crealtekcom_"
MIME-Version: 1.0
Message-ID-Hash: UMNOYWKCH6QHXES325EOX5GPBEKXYAHM
X-Message-ID-Hash: UMNOYWKCH6QHXES325EOX5GPBEKXYAHM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UMNOYWKCH6QHXES325EOX5GPBEKXYAHM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_e13d08e96ac449b6994d56dfe6ce3f5crealtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Vendor want to add more SSID.
They forgot to list all the supported SSIDs.

BR,
Kailang

--_002_e13d08e96ac449b6994d56dfe6ce3f5crealtekcom_
Content-Type: application/octet-stream;
	name="0001-alc236-dell-dt-hp-noise.patch"
Content-Description: 0001-alc236-dell-dt-hp-noise.patch
Content-Disposition: attachment;
	filename="0001-alc236-dell-dt-hp-noise.patch"; size=1744;
	creation-date="Tue, 21 Jul 2026 07:39:41 GMT";
	modification-date="Tue, 21 Jul 2026 07:38:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMWM0MTI1OTQ0NzA3Mjg5MDI3NWQ5OTMwMzFiMTE1Y2FmNDYzOWViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMjEgSnVsIDIwMjYgMTU6MTQ6MjIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFkZCBxdWlyayBmb3IgRGVsbCBQcm8gUUMxMjU1CgpWZW5kb3Igd2Fu
dCB0byBhZGQgbW9yZSBtYWNoaW5lIG9uIHRoaXMgd29ya2Fyb3VuZC4KCnBhdGNoOiA5NzI3MmE1
NzA0YmYgKCJBTFNBOiBoZGEvcmVhbHRlayAtIEZpeGVkIEhlYWRwaG9uZSBub2lzZSBpc3N1ZSBm
b3IgRGVsbCBRQ00xMjU1IikKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJl
YWx0ZWsuY29tPgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5j
IGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCmluZGV4IGE5ZGExNDk4MzlhZC4u
YjAwOGI2Yzg1ZjRlIDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5
LmMKKysrIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCkBAIC03MDI2LDcgKzcw
MjYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtd
ID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDBjYzMsICJEZWxsIE9hc2lzIDE0IExvdyBX
ZWlnaHQgTVRMLVUiLCBBTEMyODlfRklYVVBfREVMTF9DUzM1TDQxX1NQSV8yKSwKIAlTTkRfUENJ
X1FVSVJLKDB4MTAyOCwgMHgwY2M0LCAiRGVsbCBPYXNpcyAxNiBNVEwtSC9VIiwgQUxDMjg5X0ZJ
WFVQX0RFTExfQ1MzNUw0MV9TUElfMiksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MGNjNSwg
IkRlbGwgT2FzaXMgMTQiLCBBTEMyODlfRklYVVBfUlRLX0FNUF9EVUFMX1NQSyksCi0JU05EX1BD
SV9RVUlSSygweDEwMjgsIDB4MGU2YiwgIkRlbGwgUHJvIFFDTTEyNTUiLCBBTEMyMzZfRklYVVBf
REVMTF9IUF9QT1BfTk9JU0UpLAorCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDBkNTYsICJEZWxs
IFBybyBUb3dlciBRQ1QxMjU1IiwgQUxDMjM2X0ZJWFVQX0RFTExfSFBfUE9QX05PSVNFKSwKKwlT
TkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwZDU4LCAiRGVsbCBQcm8gTWljcm8gUUNNMTI1NSIsIEFM
QzIzNl9GSVhVUF9ERUxMX0hQX1BPUF9OT0lTRSksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4
MGQ1YSwgIkRlbGwgUHJvIFNsaW0gUUNTMTI1NSIsIEFMQzIzNl9GSVhVUF9ERUxMX0hQX1BPUF9O
T0lTRSksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MGU2YiwgIkRlbGwgUHJvIFRvd2VyIFFD
VDEyNTUiLCBBTEMyMzZfRklYVVBfREVMTF9IUF9QT1BfTk9JU0UpLAorCVNORF9QQ0lfUVVJUkso
MHgxMDI4LCAweDBlNmMsICJEZWxsIFBybyBTbGltIFFDUzEyNTUiLCBBTEMyMzZfRklYVVBfREVM
TF9IUF9QT1BfTk9JU0UpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDBlNmQsICJEZWxsIFBy
byBNaWNybyBRQ00xMjU1IiwgQUxDMjM2X0ZJWFVQX0RFTExfSFBfUE9QX05PSVNFKSwKIAlTTkRf
UENJX1FVSVJLKDB4MTAyOCwgMHgxNjRhLCAiRGVsbCIsIEFMQzI5M19GSVhVUF9ERUxMMV9NSUNf
Tk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDE2NGIsICJEZWxsIiwgQUxD
MjkzX0ZJWFVQX0RFTEwxX01JQ19OT19QUkVTRU5DRSksCg==

--_002_e13d08e96ac449b6994d56dfe6ce3f5crealtekcom_--
