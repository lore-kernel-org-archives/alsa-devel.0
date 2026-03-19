Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32E1075276
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:20:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 778ED601FA;
	Thu, 19 Mar 2026 09:20:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 778ED601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773908447;
	bh=DLUD7pcn99NHYMMjNd5R8QZlNyOd1KCacY8BaU8u4uY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZDzZrzq5J6odxi6Cuck1qJUCjMp4WhesmyKMiF+TVtv2PUiChJlZKUdOm1wgGjPyK
	 yDtn/RCQSbXDxR/zwjDYR8x+wq6JSc8/+oM4NJnr0nrqpYHnITnRmDkMVzMeFN9dmY
	 mqIWz2KJfZBzPQFdadzXh9d7ZK9ZDRhT+4q/yQMg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8865F805F2; Thu, 19 Mar 2026 09:20:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC741F805F2;
	Thu, 19 Mar 2026 09:20:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7A95F8056F; Thu, 19 Mar 2026 09:20:05 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D67DBF80071
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2026 09:19:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D67DBF80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=bmbYDwa1
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J8Jo4mA3374378,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773908390; bh=mJt7nViUIXfdIj2NwlDjCiQH1cgNzvQsimaNZpI+4d0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=bmbYDwa1oamqq6C2VC7TbiMwt0CTNCdlUhFYJ4EdTlg8Ptmw4DTsSu/d4Oyf7wFu7
	 AnS9MNh6JjVvAvcGDFVpFUVH9TjqS4s9cTfy7M3XCXaR4P4AG/2ldYbrB3KMDcWpbH
	 0e1Ug2gUqm4uo+KcZuMT0+KC1neEfjzzP1alkyVFlGPaic6w6iCcCm23POipFjRAMX
	 2g4CvfOrMNdbg9zjo/wY9aYHYLybwcp1hjO4eW+8jAjgxwSHI3xNxXL4Vz3EC5V2VZ
	 bs92xbBJF0jGtqeaa74pLD24jZ7MXqnh2bPezgomlQWyMLTiHF1U+iXFw6BsujacY+
	 O+UV9au5NsBhQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J8Jo4mA3374378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 16:19:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 16:19:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 19 Mar 2026 16:19:49 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        Chris Chiu
	<chris.chiu@canonical.com>
Subject: Fix speaker mute LED for HP EliteBoard G1a
Thread-Topic: Fix speaker mute LED for HP EliteBoard G1a
Thread-Index: Ady3eK5w59bdlfMNTFqK9E9hUhRblQ==
Date: Thu, 19 Mar 2026 08:19:49 +0000
Message-ID: <279e929e884849df84687dbd67f20037@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_279e929e884849df84687dbd67f20037realtekcom_"
MIME-Version: 1.0
Message-ID-Hash: 33XOBS4WJ26IV3W6FJTYGBPMOQOGKBOS
X-Message-ID-Hash: 33XOBS4WJ26IV3W6FJTYGBPMOQOGKBOS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/33XOBS4WJ26IV3W6FJTYGBPMOQOGKBOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_279e929e884849df84687dbd67f20037realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

HP EliteBoard G1a platform, the speaker mute LED failed to function.
Attach patch will fix it.

Thanks.

BR,
Kailang

--_002_279e929e884849df84687dbd67f20037realtekcom_
Content-Type: application/octet-stream;
	name="0000-hp-nexusx-mute-led-v001-2-1.patch"
Content-Description: 0000-hp-nexusx-mute-led-v001-2-1.patch
Content-Disposition: attachment;
	filename="0000-hp-nexusx-mute-led-v001-2-1.patch"; size=2265;
	creation-date="Thu, 19 Mar 2026 07:48:48 GMT";
	modification-date="Thu, 19 Mar 2026 08:14:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYjllYmY1ZGZmNGYzMDljMWUwMjFiZDZmZjc2MzA5MWRlY2FiMjAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMTkgTWFyIDIwMjYgMTU6NDk6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIFNwZWFrZXIgTXV0ZSBMRUQgZm9yIEhQIEVsaXRlQm9hcmQg
RzFhIHBsYXRmb3JtCgpPbiB0aGUgSFAgRWxpdGVCb2FyZCBHMWEgcGxhdGZvcm0gKG1vZGVscyB3
aXRob3V0IGEgaGVhZHBob25lIGphY2spLgp0aGUgc3BlYWtlciBtdXRlIExFRCBmYWlsZWQgdG8g
ZnVuY3Rpb24uIFRoZSBTeXNmcyBjdGwtbGVkIGluZm8gc2hvd2VkIAplbXB0eSB2YWx1ZXMgYmVj
YXVzZSB0aGUgc3RhbmRhcmQgTEVEIHJlZ2lzdHJhdGlvbiBjb3VsZG4ndCBjb3JyZWN0bHkgCmJp
bmQgdG8gdGhlIG1hc3RlciBzd2l0Y2guCkFkZGluZyB0aGlzIHBhdGNoIHdpbGwgZml4IGFuZCBl
bmFibGUgdGhlIHNwZWFrZXIgbXV0ZSBMRUQgZmVhdHVyZS4KClRlc3RlZC1ieTogQ2hyaXMgQ2hp
dSA8Y2hyaXMuY2hpdUBjYW5vbmljYWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcg
PGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9yZWFs
dGVrL2FsYzI2OS5jIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCmluZGV4IDMy
N2Y0ZGMxYjA5Zi4uOTEwNjQ5OGViMTlmIDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvY29kZWNzL3Jl
YWx0ZWsvYWxjMjY5LmMKKysrIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCkBA
IC0zNzI1LDIyICszNzI1LDQyIEBAIHN0YXRpYyB2b2lkIGFsYzI0NV90YXMyNzgxX3NwaV9ocF9m
aXh1cF9tdXRlbGVkKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCWFsY19maXh1cF9ocF9ncGlv
X2xlZChjb2RlYywgYWN0aW9uLCAweDA0LCAweDApOwogCWFsYzI4NV9maXh1cF9ocF9jb2VmX21p
Y211dGVfbGVkKGNvZGVjLCBmaXgsIGFjdGlvbik7CiB9CisKK3N0YXRpYyB2b2lkIGFsYzI0NV9o
cF9zcGtfbXV0ZV9sZWRfdXBkYXRlKHZvaWQgKnByaXZhdGVfZGF0YSwgaW50IGVuYWJsZWQpCit7
CisJc3RydWN0IGhkYV9jb2RlYyAqY29kZWMgPSBwcml2YXRlX2RhdGE7CisJdW5zaWduZWQgaW50
IHZhbDsKKworCXZhbCA9IGVuYWJsZWQgPyAweDA4IDogMHgwNDsgLyogMHgwOCBsZWQgb24sIDB4
MDQgbGVkIG9mZiAqLworCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4MGIsIDB4MGMsIHZh
bCk7Cit9CisKIC8qIEpEMjogbXV0ZSBsZWQgR1BJTzM6IG1pY211dGUgbGVkICovCiBzdGF0aWMg
dm9pZCBhbGMyNDVfdGFzMjc4MV9pMmNfaHBfZml4dXBfbXV0ZWxlZChzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYywKIAkJCQkJICBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24p
CiB7CiAJc3RydWN0IGFsY19zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CisJaGRhX25pZF90IGhw
X3BpbiA9IGFsY19nZXRfaHBfcGluKHNwZWMpOwogCXN0YXRpYyBjb25zdCBoZGFfbmlkX3QgY29u
bltdID0geyAweDAyIH07CiAKIAlzd2l0Y2ggKGFjdGlvbikgewogCWNhc2UgSERBX0ZJWFVQX0FD
VF9QUkVfUFJPQkU6CisJCWlmICghaHBfcGluKSB7CisJCQlzcGVjLT5nZW4udm1hc3Rlcl9tdXRl
Lmhvb2sgPSBhbGMyNDVfaHBfc3BrX211dGVfbGVkX3VwZGF0ZTsKKwkJCXNwZWMtPmdlbi52bWFz
dGVyX211dGVfbGVkID0gMTsKKwkJfQogCQlzcGVjLT5nZW4uYXV0b19tdXRlX3ZpYV9hbXAgPSAx
OwogCQlzbmRfaGRhX292ZXJyaWRlX2Nvbm5fbGlzdChjb2RlYywgMHgxNywgQVJSQVlfU0laRShj
b25uKSwgY29ubik7CiAJCWJyZWFrOworCWNhc2UgSERBX0ZJWFVQX0FDVF9JTklUOgorCQlpZiAo
IWhwX3BpbikKKwkJCWFsYzI0NV9ocF9zcGtfbXV0ZV9sZWRfdXBkYXRlKGNvZGVjLCAhc3BlYy0+
Z2VuLm1hc3Rlcl9tdXRlKTsKKwkJYnJlYWs7CiAJfQogCiAJdGFzMjc4MV9maXh1cF90eG53X2ky
Yyhjb2RlYywgZml4LCBhY3Rpb24pOwotCWFsYzI0NV9maXh1cF9ocF9tdXRlX2xlZF9jb2VmYml0
KGNvZGVjLCBmaXgsIGFjdGlvbik7CisJaWYgKGhwX3BpbikKKwkJYWxjMjQ1X2ZpeHVwX2hwX211
dGVfbGVkX2NvZWZiaXQoY29kZWMsIGZpeCwgYWN0aW9uKTsKIAlhbGMyODVfZml4dXBfaHBfY29l
Zl9taWNtdXRlX2xlZChjb2RlYywgZml4LCBhY3Rpb24pOwogfQogLyoK

--_002_279e929e884849df84687dbd67f20037realtekcom_--
