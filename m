Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38944C55175
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:38:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1D5460216;
	Mon,  3 Aug 2026 11:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1D5460216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749894;
	bh=8PurJRXUZ4AmvvEoHSz76jwVCgizAsNumVDq6l4KDaA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CH/qowgGNk/umor0ABA9AweAtrSEcPYUZeClVVFzveRDAOoeVxeoRDd4kuVCxPwNW
	 qABG1/Ic9mY9Zr1Uay2URBhuYwqg2hH3ZJr0L9WEL/iCUoaVcSuQt45EYpv3bjNCPo
	 EmhB1XCZmCYzPF6UXoVaqd8GKktoefBpTfTLh1Yc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C7E6F80688; Mon,  3 Aug 2026 11:37:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4889F80687;
	Mon,  3 Aug 2026 11:37:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E5BEF804F3; Sun,  2 Aug 2026 15:23:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785677003;
	b=Ad7tOqjUOSAp471FRcoVhHXSnA3iQDd42DFr3B/GrI/skVRxmDAlBxSIOm9d6g4QkMCp
	 Fh2GQQ9a6q0xom9qGDDOQ7NBoLxyQNF59hpkJAWh0iBrGHy5j4S6JWN3xFAKdl9IsXlPR
	 bOmZ8IiGqnk9EBlAovl6Zqo9pR3CTrDXd1aRCu75v5QfcluX9zfkXwZMTr5s467WFgea4
	 MjdwZflBNWWUeoiRAB5CKG8Fz+jdo6uwmjHsHDWeZaT80YejWW/6vE61k0ffpbUSwtV11
	 HUKJwXiud2XDd1pvBIbNJcUxv+1PeROGHUnpQHI7RzkL2SzJ2PjvpRSOR7RkyBu3LCw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785677003;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=hL4N+bbV6gAvwTP76kJHq/s7ggDLYI8lELHHqQbk5oE=;
	b=rxYJhcO54aqwZ8/mYhJozBUShU4gYrwnCuxkt2d8YVCE13NFHX65Dsv1Mm71iwiFR2uY
	 76CXozvWvL4L2/AN6vXxYpgqOXfg/aoy34pDCetbGDzSuGDpsXV0wO8rJh0vhjSvwVYSd
	 YGP1U8fkVf2iNOl+njujhQZV2HIYJSov4iKrh8cC8zEnVFeb+Bf0yOywKp5p7ltGsQjdj
	 1Ap6Gra8qi37IHyvPJx5eNiPmEbRZYd6a0pFHof7WCBL5HOEOf8P6RYs8qHuV0WQP3PZd
	 Io7JeTZQsenGl4cgtr7kEfo6Md08F4ClfsLlFRIPpd0nMqtmVVBt3LYqyFv7Rb0O5hg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eAvCOvPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B431DF8014C
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 15:23:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B431DF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eAvCOvPm
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51c928bf172so14327661cf.3
        for <alsa-devel@alsa-project.org>;
 Sun, 02 Aug 2026 06:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785677001; cv=none;
        d=google.com; s=arc-20260327;
        b=rNs94zCsWqku72H1GIDZBqk2VoVyXpfTIX93ZpuEEqHqyb/IRqgatj1e4E3XDQMCm+
         3EkZ5v8VvAgR2Y07ZsDKSitQeGVTV5Z+t8dO2CjWr+4pX/iiso9YEVSLR7HhkMCgj9/f
         fC0VgbFRJqgO9pYfOVIIb5/24zlihW8wqv8KBXsIgGYwDnoQW0bSjrsJn+2DYx207mJ4
         Qb9Od5ikPH5J/6BKoMlFqZdlvMsZrl761WIeF2/Ke4cKeJsoWrfpX+elZ3T7EwzRhkog
         ePuQTva/fmIMog2QJ8/LH+Mgo+p/d5j4nauXQ6LduwC69Ux+tzmsHmtme0OVHYtcdSqz
         U+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=q+GIK/w7n1DEYYQMzvBSIfLb9GR0YXMOPg69ownGL4A=;
        fh=KiUTIER/mEd9Bp2tuampBCvjMy5zduJNGxswxsTpXK4=;
        b=UejWHQjxjcm5b71lWBzHbLc4GMumBIOfvtJGzqFBSwwh6KQd4rPDZPadf39A4jxb3L
         3ahswfgzcxHtbGTY1+ahdyp9w80if7PJOhiNpzKzTy4JWANw2LQ3eMN67sTA+dsqZcA8
         UdZ+Hi2ZxD4TF5/Yb0OaKaEGcy/VW+GjvZ1dNxP0Zx/QxS+FBMOjKVakKEV3pLgZyDL/
         w459ycPGffr1az0G52fzqwud/BJH1uUMSrn3+C5bWG2nVoSXpUblNATtU4QUSV/baCY1
         aF3S1813P/oe2S5csb2+/BTjbkJSHyQRK6J8SNKcrkApALxn8HiD3zV5592EQp5KoAzK
         bclA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785677001; x=1786281801;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+GIK/w7n1DEYYQMzvBSIfLb9GR0YXMOPg69ownGL4A=;
        b=eAvCOvPmyDJt4DGhHewWKjX+2TS7PXJh0n+YETXg6mpl7mcK5pVrdsSgG5fQpgR5W8
         VwV/obbhFyyx2llN7xxJYXQqYhJlFnjRAYTay+8PbwbPNgNfte/6jXi/eKTGyYnVtdsn
         zeFc2IO59q76K0fRqRWDrMDafIgVR0wi2OcD3Q28tiNBRpmBXYbQGNUdQWzYZlSw6cjZ
         pcmAUgacnFXDKIURS+8iuxLkckg2gexe8oUMkg/nwjwUALkNBQ5TVIiP/6HGHYHoG0aO
         U3omxeS8hngn1nPsjpCSaJ5iqfq4tLKtRQMXg5Vreh+c8CDP3MiIixIMvZIRhwKHE4Zh
         Zkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785677001; x=1786281801;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q+GIK/w7n1DEYYQMzvBSIfLb9GR0YXMOPg69ownGL4A=;
        b=jCKYxhi8DBdoIkBszaCYTwLpEIat0UibA8V/r5fyR+2ycm+/au6RzErng24q29IHDd
         /K8mL7ZdZ9OyZSgJux2gxxMW/GDmEhAqR5WUIPEodwsCaoVBBCgSXks6GKxLxPdPEDMe
         fP0aA0PuL0+DMI7KX28qnEa9wiQbslud05HKgg/qCiqZWX0J3apTOgadIiSFtZoFlPuB
         QRzN5FyXYB4qJgQkFCdBLWPj4ZxuVXr5afk5Wc7WLrPo2D0GAweW5/VXv0o0oCBLqb7o
         t1D9mzfdgDHMD/6V/pZpvhk4oITcTZdODT+Rf4Dy2LvSrs68MsU400PVbqz/iwvp3iHy
         EGSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrENGN2e66tZbvE+qT2Kdwkut1SW/j/d6p5OX25CVkhTeNjLbCs2GR+ORyZ8xlnSNbN0N3aKywI2lNt@alsa-project.org
X-Gm-Message-State: AOJu0YydCowaoGo/GPJLC7yWT/i4vpnsDrhw0G9hb+go7saJWXK3sPe/
	xn2lrtdDfU7g4Dx37tfNFJpkOhwTjO82bNF89sxu+biPgMDtbY9EKSnGW/GMGzdZ5IBvVU7BHNJ
	vKEbuuAASY5dSn+kiEhlP1Nm73GBSSw4=
X-Gm-Gg: AR+sD10A31+V/21WbzWSpK7/ljVLUBQ8Mj0Q0iK+bjFCpdtF7QN/0sZxIiA54eBWDqG
	1rLkG/6kMqy/534uJeJhJRsLvzIC4d6vZ/TMuDtDLpIqsFNmFHmIZ4Nm9KMT5m8Iy1DwaLCKIZA
	bzXK9QrcNY3v9H1LO2y+5FKOrkou+eL5iORqnS/X+cLwRCb+8GsnbzXgJQ+jB/1czKL64IbBi2Q
	8kQfF99k4yFYS9RZRRuPcVY6Jql40hO2p7o5TmltzE7lWop0rw5jbxkkG56AoCo8vCDhS+CZ8/i
	jgdfQzDoksbEuo2XB/wv4cS/CosFE5WVpHR2e+bCrhV6MqTTU302JY9i
X-Received: by 2002:ac8:7dd1:0:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52b566718bemr123318891cf.8.1785677000839; Sun, 02 Aug 2026
 06:23:20 -0700 (PDT)
MIME-Version: 1.0
From: Luca Caffarelli <lucacaffarelli@gmail.com>
Date: Sun, 2 Aug 2026 15:23:09 +0200
X-Gm-Features: AUfX_mwqpORmSZTqrzOG4IePTqlAtZwDSlbGz1JiOEb5u3Eaa1_CpwOCYzQfuSk
Message-ID: 
 <CAPGq_Y+g12MHPm-N+jO=6=xNn1UhL_i5J-WwH+6G6quVwuhJqQ@mail.gmail.com>
Subject: [BUG] cirrus: cs35l41 tuning alias for SSID 103C8C4D mutes left
 speaker
To: linux-firmware@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
X-MailFrom: lucacaffarelli@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JLAO4NGSAC6FFVZXCKD2RR2P7YCT5R6M
X-Message-ID-Hash: JLAO4NGSAC6FFVZXCKD2RR2P7YCT5R6M
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:37:01 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JLAO4NGSAC6FFVZXCKD2RR2P7YCT5R6M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNClRoZSBDUzM1TDQxIHR1bmluZyBmaWxlcyBhbGlhc2VkIGZvciBTU0lEIDEwM0M4QzRE
IHNpbGVuY2UgdGhlIGxlZnQgc3BlYWtlcg0KZW50aXJlbHkgb24gSFAgT01FTiAxNi11MXh4eC4g
VXNpbmcgdGhlIGdlbmVyaWMgZmlybXdhcmUgaW5zdGVhZCBtYWtlcyBib3RoDQpjaGFubmVscyB3
b3JrLCBzbyB0aGlzIGxvb2tzIGxpa2UgYW4gaW5jb3JyZWN0IGFsaWFzIHJhdGhlciB0aGFuIGEg
aGFyZHdhcmUNCm9yIGRyaXZlciBwcm9ibGVtLg0KDQpTeXN0ZW0NCi0tLS0tLQ0KTWFjaGluZTog
ICAgICAgIEhQIE9NRU4gYnkgSFAgVHJhbnNjZW5kIEdhbWluZyBMYXB0b3AgMTYtdTF4eHggKFNL
VSBBMThWNEVBI0FCWikNCkJJT1M6ICAgICAgICAgICBGLjI5LCAyMDI2LTAzLTMxDQpBdWRpbzog
ICAgICAgICAgUmVhbHRlayBBTEMyNDUgKDEwZWM6MDI0NSksIHN1YnN5c3RlbSAxMDNjOjhjNGQN
CkFtcHM6ICAgICAgICAgICAyeCBDaXJydXMgTG9naWMgQ1MzNUw0MSAoMzVhNDApIHJldiBCMiwg
aTJjIENTQzM1NTEsDQpzaGFyZWQgcmVzZXQNCkRpc3Ryby9rZXJuZWw6ICBGZWRvcmEgNDMsIGtl
cm5lbCA3LjEuMy0xMDEuZmM0My54ODZfNjQNCmxpbnV4LWZpcm13YXJlOiAyMDI2MDYyMg0KDQpD
dXJyZW50IGFsaWFzZXMNCi0tLS0tLS0tLS0tLS0tLQ0KY3MzNWw0MS1kc3AxLXNway1wcm90LTEw
M2M4YzRkLndtZncueHoNCiAgICAtPiBjczM1bDQxL3Y2LjYxLjEvaGFsb19jc3BsX1JBTV9yZXZC
Ml8yOS42My4xLndtZncueHoNCmNzMzVsNDEtZHNwMS1zcGstcHJvdC0xMDNjOGM0ZC1zcGtpZDEt
bDAuYmluLnh6DQogICAgLT4gY3MzNWw0MS1kc3AxLXNway1wcm90LTEwM2M4YmIzLXNwa2lkMS1s
MC5iaW4ueHoNCmNzMzVsNDEtZHNwMS1zcGstcHJvdC0xMDNjOGM0ZC1zcGtpZDEtcjAuYmluLnh6
DQogICAgLT4gY3MzNWw0MS1kc3AxLXNway1wcm90LTEwM2M4YmIzLXNwa2lkMS1yMC5iaW4ueHoN
Cg0KVGhlIHR1bmluZyBiaW5zIGFyZSBhbGlhc2VkIHRvIHRob3NlIG9mIGEgZGlmZmVyZW50IG1h
Y2hpbmUsIDEwM0M4QkIzLg0KDQpTeW1wdG9tDQotLS0tLS0tDQpUaGUgbGVmdCBzcGVha2VyIHBy
b2R1Y2VzIG5vIG91dHB1dCBhdCBhbGwuIFRoZSByaWdodCBzcGVha2VyIHdvcmtzIG5vcm1hbGx5
Lg0KVGhlIGRyaXZlciByZXBvcnRzIG5vIGVycm9yOiBib3RoIGFtcHMgcHJvYmUsIGxvYWQgZmly
bXdhcmUsIGFwcGx5IGNhbGlicmF0aW9uDQphbmQgYmluZCBzdWNjZXNzZnVsbHksIHdpdGggaWRl
bnRpY2FsIHBhcmFtZXRlcnMuDQoNCiAgY3MzNWw0MS1oZGEgaTJjLUNTQzM1NTE6MDAtY3MzNWw0
MS1oZGEuMDogRFNQMToNCmNpcnJ1cy9jczM1bDQxLWRzcDEtc3BrLXByb3QtMTAzYzhjNGQud21m
dzogZm9ybWF0IDMgdGltZXN0YW1wDQoweDYxMjhlMTZiDQogIGNzMzVsNDEtaGRhIGkyYy1DU0Mz
NTUxOjAwLWNzMzVsNDEtaGRhLjA6IENhbGlicmF0aW9uIGFwcGxpZWQ6IFIwPTU0MDcNCiAgY3Mz
NWw0MS1oZGEgaTJjLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEuMDogRmlybXdhcmUgTG9hZGVkIC0g
VHlwZToNCnNway1wcm90LCBHYWluOiAxNA0KICBjczM1bDQxLWhkYSBpMmMtQ1NDMzU1MTowMC1j
czM1bDQxLWhkYS4wOiBDUzM1TDQxIEJvdW5kIC0gU1NJRDoNCjEwM0M4QzRELCBCU1Q6IDAsIFZT
UEs6IDAsIENIOiBMLCBGVyBFTjogMSwgU1BLSUQ6IDENCiAgY3MzNWw0MS1oZGEgaTJjLUNTQzM1
NTE6MDAtY3MzNWw0MS1oZGEuMTogQ2FsaWJyYXRpb24gYXBwbGllZDogUjA9NTU1MA0KICBjczM1
bDQxLWhkYSBpMmMtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4xOiBGaXJtd2FyZSBMb2FkZWQgLSBU
eXBlOg0Kc3BrLXByb3QsIEdhaW46IDE0DQogIGNzMzVsNDEtaGRhIGkyYy1DU0MzNTUxOjAwLWNz
MzVsNDEtaGRhLjE6IENTMzVMNDEgQm91bmQgLSBTU0lEOg0KMTAzQzhDNEQsIEJTVDogMCwgVlNQ
SzogMCwgQ0g6IFIsIEZXIEVOOiAxLCBTUEtJRDogMQ0KDQpBTFNBIGFuZCBQaXBlV2lyZSBhcmUg
YmFsYW5jZWQgKGJvdGggY2hhbm5lbHMgMC4wMCBkQiwgYmFsYW5jZSAwLjAwKSwgYW5kIHRoZQ0K
Y29kZWMgcGluIG5vZGUgMHgxNyBzaG93cyBBbXAtT3V0IHZhbHMgWzB4MDAgMHgwMF0gb24gYm90
aCBjaGFubmVscy4NCg0KV2hhdCBJIHRlc3RlZA0KLS0tLS0tLS0tLS0tLQ0KMS4gU3RvY2sgYWxp
YXNlcyAod21mdyAxMDNjOGM0ZCArIGJpbnMgZnJvbSAxMDNjOGJiMywgbDAgYW5kIHIwKToNCiAg
IGxlZnQgY2hhbm5lbCBzaWxlbnQuDQoNCjIuIEJvdGggYW1wcyBmb3JjZWQgdG8gbG9hZCB0aGUg
c2FtZSB0dW5pbmcgYmluIChyZXBvaW50ZWQgdGhlIGwwIHN5bWxpbmsgYXQNCiAgIHRoZSAxMDNj
OGJiMyByMCBiaW4sIHNvIGJvdGggYW1wcyBnZXQgYnl0ZS1pZGVudGljYWwgZmlybXdhcmUgYW5k
IHR1bmluZyk6DQogICBsZWZ0IGNoYW5uZWwgc3RpbGwgc2lsZW50LiBUaGlzIHJ1bGVzIG91dCB0
aGUgcGVyLWNoYW5uZWwgYmluIGFzIHRoZSBjYXVzZS4NCg0KMy4gR2VuZXJpYyBmaXJtd2FyZSAo
Y2lycnVzL2NzMzVsNDEtZHNwMS1zcGstcHJvdC53bWZ3LCB0aW1lc3RhbXAgMHg2MmI1YzI2YywN
CiAgIHBsdXMgY2lycnVzL2NzMzVsNDEtZHNwMS1zcGstcHJvdC5iaW4pOiBib3RoIGNoYW5uZWxz
IHdvcmsgYW5kIGFyZQ0KICAgYmFsYW5jZWQsIGF0IGEgbm90aWNlYWJseSBsb3dlciBvdXRwdXQg
bGV2ZWwuDQoNClRlc3QgMyBzaG93cyB0aGUgbGVmdCBzcGVha2VyIGFuZCBpdHMgYW1wIGFyZSBm
dW5jdGlvbmFsLCBzbyB0aGlzIGlzIG5vdCBhDQpoYXJkd2FyZSBmYXVsdC4gVGVzdCAyIHNob3dz
IHRoZSB0dW5pbmcgYmluIGlzIG5vdCB0aGUgZGlzY3JpbWluYXRpbmcgZmFjdG9yLg0KVGhlIHJl
bWFpbmluZyBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBhbXBzIGlzIHRoZSBmYWN0b3J5IGNh
bGlicmF0aW9uIHJlYWQNCmZyb20gTlZSQU0sIFIwPTU0MDcgKGxlZnQpIGFnYWluc3QgUjA9NTU1
MCAocmlnaHQpLiBNeSBndWVzcyBpcyB0aGF0IHRoZQ0KMTAzQzhCQjMgdHVuaW5nIGNvbnN0YW50
cywgY29tYmluZWQgd2l0aCB0aGUgbW9kZWwgd21mdywgcHV0IFIwPTU0MDcgb3V0c2lkZQ0KdGhl
IGV4cGVjdGVkIHJhbmdlIGZvciB0aGUgcHJvdGVjdGlvbiBhbGdvcml0aG0gYW5kIHRoZSBjaGFu
bmVsIGdldHMgbXV0ZWQsDQpidXQgSSBoYXZlIG5vdCBjb25maXJtZWQgdGhhdCBmcm9tIHRoZSBm
aXJtd2FyZSBpbnRlcm5hbHMuDQoNClJlcXVlc3QNCi0tLS0tLS0NCkNvdWxkIHRoZSBjb3JyZWN0
IENTMzVMNDEgdHVuaW5nIGZvciBTU0lEIDEwM0M4QzREIGJlIGFkZGVkPyBJZiBpdCBpcyBub3QN
CmF2YWlsYWJsZSwgZHJvcHBpbmcgdGhlIDEwM0M4QkIzIGFsaWFzIHdvdWxkIGJlIHByZWZlcmFi
bGUgdG8gdGhlIGN1cnJlbnQNCnN0YXRlOiB1c2VycyB3b3VsZCBmYWxsIGJhY2sgdG8gdGhlIGdl
bmVyaWMgZmlybXdhcmUsIHdoaWNoIHByb2R1Y2VzIHdvcmtpbmcNCnN0ZXJlbyBvdXRwdXQgaW5z
dGVhZCBvZiBhIGRlYWQgbGVmdCBjaGFubmVsLg0KDQpNeSBjdXJyZW50IHdvcmthcm91bmQgaXMg
dG8gc2hhZG93IHRoZSBtb2RlbC1zcGVjaWZpYyBuYW1lcyB3aXRoIHRoZSBnZW5lcmljDQpmaXJt
d2FyZSB1bmRlciAvbGliL2Zpcm13YXJlL3VwZGF0ZXMvY2lycnVzLy4NCg0KSGFwcHkgdG8gcnVu
IGZ1cnRoZXIgdGVzdHMgb3IgcHJvdmlkZSBhZGRpdGlvbmFsIGxvZ3MuDQoNClRoYW5rcywNCkx1
Y2EgQ2FmZmFyZWxsaQ0K
