Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE13CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:10:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C35D6602B8;
	Tue, 29 Sep 2026 21:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C35D6602B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708998;
	bh=r8NO6JB3elwWuWYjTtea5EP+cR7QQnepvsYaO4Fu5gc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WBgN6BCCeEKrQLlnpAe5hhl1OuILhoVanD7XRcDPR7npWhdiIdjFw1WaHXEzCx+QH
	 PaReA7V/i38LJS2381UMc/49Nbcqygsz3qqEdqfZzy67hLNltG7cBFlWRr88Zoy/5R
	 DFNKBLhIaJ6zDEvdhxhUr5GvBgRj4opw/GAMftKY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B64FF806DE; Tue, 29 Sep 2026 21:07:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFB83F806E3;
	Tue, 29 Sep 2026 21:07:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A6E3F80525; Mon, 28 Sep 2026 10:33:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.208.4.200
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790584413;
	b=E/boYbL81iDb6Q084DzYhJDFFcDW+7T1iCiO/vbASKsoojVk+hr1afhx6egvI8YZZYsO
	 EvBmW6Evx3u1SuJ+NpkSoMiEPar7Lyq8LjjOrJLHrlfiTByw0+j5i78u424oRTjX38SML
	 WgIwfXnv3nOEECW3xe+oup1MtabZizV8on4UVbjuVZ8tg85rYgqfcnRmzJEWwL4SMw3zz
	 Ge/r2b3iHjbd3cfu3Xo6rWS4hYo5iOgXtK8B6aGr64rhuxP3sR/mC+uI67BtT2osLji32
	 NT5eTiiadbXetXeXSdCuqRDIfuzAH2RgKygBinoEm2TJ3NWTSn7ZrPcJboYAjO+Gf/g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790584413;
	h=DKIM-Signature:MIME-Version:Message-ID:From:To:Subject:Date;
	bh=hGRNADY6if7hLz6vzw3vsMsz70epmnuFq8B3PtJqHgU=;
	b=ikk6JMfSAzAWtq+5s70cL4Zms06PQzlvY7z/cB4C3xSuIhmekBZMOVPjHDC2Iy9MVc/1
	 0eHupxu5yVobea1EYwLohquwKeoYPo/84Nqw/tiUpOPEcfHBoaahS/pkI8cCEHYsyKdKa
	 aXDtjn/GccKnfmHcOhL69LC/+uupGGSxGr/6IYvffgRCo3wQ0ax9pddRN+CUr6Yv8OYYU
	 eUAcQPsa7PXf5u8LjElmq8iXBxIKOWUiDLtJLX8LBxGUZ4AS0pHzwf3uJYN4bj3mnStEk
	 H5GbWk7mvpinnSwuQwRvEVWFOpvkBfKCIIbxrECH+dIyFmY/tvD/Er++cRtikJPKBpg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=consultant.com header.i=kmpnixonfabiantxpvo@consultant.com
 header.a=rsa-sha256 header.s=s1089575 header.b=iu+s3wT7;
	arc=none smtp.remote-ip=74.208.4.200
Received: from mout.mail.com (mout.mail.com [74.208.4.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 912ABF80301
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 10:33:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 912ABF80301
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=consultant.com header.i=kmpnixonfabiantxpvo@consultant.com
 header.a=rsa-sha256 header.s=s1089575 header.b=iu+s3wT7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=consultant.com;
	s=s1089575; t=1790584397; x=1791189197;
	i=kmpnixonfabiantxpvo@consultant.com;
	bh=hGRNADY6if7hLz6vzw3vsMsz70epmnuFq8B3PtJqHgU=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=iu+s3wT7JqktgLylEnqB9iGrn75AqjILwa4VybkczY4ZpP0f9qtg4b/WXl+0VYRt
	 fYdrOdbvZ0/soTN2RqffUOpOwBV5ASv5gxbmOKsnIxHsQN2TbXDTSODrthM0LkHNJ
	 N10/pjHaHNLznD9SqIlPYPD7ElsLbMLdtgjjmqYk6JAnMYjvaGiTCHJRZJ/zs8T+z
	 Nofcc+HyDolChitfycOOWm6yWnBdQe5zcPoQZtHwXUEpLoGS4pzYxtjSjdUU8TW3k
	 sDQnPQjeUhLwlVRczShxPPwgLrtsJRZ0YstatWl0R4QVX9H3Pifwg39XeJYKd5oPB
	 zmdMZAz/ZbEQFgp/5Q==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [188.214.106.186] ([188.214.106.186]) by
 trinity-msg-rest-gmx-mailcom-live-676578c875-9wjdz (via HTTP); Mon, 28 Sep
 2026 08:33:15 +0000
Message-ID: 
 <trinity-aeaec8ec-3aa1-47fd-a103-412b22238d19-1790584395856@trinity-msg-rest-gmx-mailcom-live-676578c875-9wjdz>
From: Rachel Andrew <KmPnixonfabiantxpVO@consultant.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: Re: [BUG] HP ZBook Fury G1i (subsystem 0x103c8de8): ALC1308 right
 speaker not working
Date: Mon, 28 Sep 2026 08:33:15 +0000
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: 
 V03:K1:3xkgoCtkwtHSKRyX8zVqZPFEDNeUEgqkxjF3YjbgKLtHXd+7whF3WullnVDWY+Sp/Csri
 F5/tBc2rnJl4MCrtJWuztgrge9fNaWABiP284ZUYmr1LBvI6SOTKdsrjvAWZz8PUPKn6PyQDrPaC
 vcO4hoow5x+tTO3g1CZMEWME7e4uGvG3nMxonl4ePkk8TZDw1i1uuIUO4oZf8IZm3AVoB8v5RdDm
 qPQ1J1+cFa0xFhpYHgb2tBtHC92diBGLVeCusFZ51H/Lmq871Rd4kgK8nu6R2dRsXkxhNMw/iOgy
 jVn9706iJm3R2uR49eXtWyhC0fzuAikt9gaeTlTkiHk+UEk64Bvbh8H8wQlFORRGWDViFoiOGkNK
 AynJrdCzc10
UI-OutboundReport: notjunk:1;M01:P0:RUjr8c08tMk=;EEpdTNWFOcinvNa+m4wyVq7iazu
 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
 4svPM+Ox2M4+MHwZ/zmPQo0w==
X-MailFrom: KmPnixonfabiantxpVO@consultant.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3SLQLPJYNBSOBD7AI6G2MSWI2E67R2JQ
X-Message-ID-Hash: 3SLQLPJYNBSOBD7AI6G2MSWI2E67R2JQ
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:01 +0000
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3SLQLPJYNBSOBD7AI6G2MSWI2E67R2JQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ICAgU3ViamVjdDogUmU6IFtCVUddIEhQIFpCb29rIEZ1cnkgRzFpIChzdWJzeXN0ZW0gMHgxMDNj
OGRlOCk6IEFMQzEzMDgKICAgcmlnaHQgc3BlYWtlciBub3Qgd29ya2luZwogICBIaSwKICAgSSB3
b3VsZCBsaWtlIHRvIGNvbmZpcm0gdGhlIGlzc3VlIHJlcG9ydGVkIGluIE1heSAyMDI2IHJlZ2Fy
ZGluZyB0aGUgSFAKICAgWkJvb2sgRnVyeSBHMWkgMTYiIChzdWJzeXN0ZW0gMHgxMDNjOGRlOCku
IEkgb3duIHRoZSBzYW1lIG1vZGVsIGFuZCBvbmUKICAgb2YgdGhlIHR3byBpbnRlcm5hbCBzcGVh
a2VycyBpcyBhbHNvIGNvbXBsZXRlbHkgc2lsZW50IHVuZGVyIExpbnV4LgogICBCb3RoIHNwZWFr
ZXJzIHdvcmsgbm9ybWFsbHkgdW5kZXIgV2luZG93cy4KICAgVGhlIGlzc3VlIGlzIHN0aWxsIHBy
ZXNlbnQgb24ga2VybmVsIDYuMTguNTEsIHNvIGl0IGlzIG5vdCBsaW1pdGVkIHRvCiAgIHRoZSA2
LjEyIGtlcm5lbCB1c2VkIGluIHRoZSBvcmlnaW5hbCByZXBvcnQuCiAgIE9uZSBkaWZmZXJlbmNl
IGZyb20gdGhlIG9yaWdpbmFsIHJlcG9ydDogb24gbXkgdW5pdCBpdCBpcyB0aGUgTEVGVAogICBz
cGVha2VyIHRoYXQgaXMgc2lsZW50LCB3aGlsZSB0aGUgcmlnaHQgb25lIHdvcmtzLiBJdCBzZWVt
cyB0aGUgc3BlYWtlcgogICBkcml2ZW4gYnkgdGhlIHNlcGFyYXRlIFJlYWx0ZWsgQUxDMTMwOCBh
bXBsaWZpZXIgaXMgdGhlIG9uZSBhZmZlY3RlZCwKICAgYW5kIHdoaWNoIHNpZGUgdGhhdCBpcyBt
YXkgZGlmZmVyIGJldHdlZW4gdW5pdHMuCiAgIFNldHVwOgogICAtIE1hY2hpbmU6IEhQIFpCb29r
IEZ1cnkgRzFpIDE2IGluY2ggTW9iaWxlIFdvcmtzdGF0aW9uIFBDCiAgIC0gQ1BVOiBJbnRlbCBD
b3JlIFVsdHJhIDkgMjg1SFgKICAgLSBCSU9TOiBYOTYgVmVyLiAwMS4wMy4wNyAoMjAyNi0wNS0w
NSkKICAgLSBPUzogUXViZXMgT1MgNC4zLjEgKExpbnV4IHJ1bm5pbmcgYXMgWGVuIGRvbTApCiAg
IC0gS2VybmVsOiA2LjE4LjUxLTEucXViZXMuZmM0MS54ODZfNjQKICAgQ29kZWMgaW5mb3JtYXRp
b24gKC9wcm9jL2Fzb3VuZC9jYXJkKi9jb2RlYyMqKToKICAgICBDb2RlYzogTnZpZGlhIEdQVSBh
YiBIRE1JL0RQCiAgICAgU3Vic3lzdGVtIElkOiAweDEwZGUwMDAwCiAgICAgQ29kZWM6IFJlYWx0
ZWsgQUxDMjQ1CiAgICAgU3Vic3lzdGVtIElkOiAweDEwM2M4ZGU4CiAgICAgQ29kZWM6IEludGVs
IE1ldGVvciBMYWtlIEhETUkKICAgICBTdWJzeXN0ZW0gSWQ6IDB4ODA4NjAxMDEKICAgQUNQSSBk
ZXZpY2UgZm9yIHRoZSBhbXBsaWZpZXIgaXMgcHJlc2VudDoKICAgICAvc3lzL2J1cy9hY3BpL2Rl
dmljZXMvMTBFQzEzMDg6MDAKICAgUmVsZXZhbnQgZG1lc2cgbGluZXM6CiAgICAgc25kX2hkYV9j
b2RlY19hbGMyNjkgZWhkYXVkaW8wRDA6IEFMQzI0NTogcGlja2VkIGZpeHVwICBmb3IgY29kZWMK
ICAgU1NJRCAxMDNjOjhkZTgKICAgICBzbmRfaGRhX2NvZGVjX2FsYzI2OSBlaGRhdWRpbzBEMDog
YXV0b2NvbmZpZyBmb3IgQUxDMjQ1OiBsaW5lX291dHM9MQogICAoMHgxNy8weDAvMHgwLzB4MC8w
eDApIHR5cGU6c3BlYWtlcgogICAgIHNuZF9oZGFfY29kZWNfYWxjMjY5IGVoZGF1ZGlvMEQwOiAg
ICBzcGVha2VyX291dHM9MAogICAoMHgwLzB4MC8weDAvMHgwLzB4MCkKICAgTm90ZSB0aGF0IHRo
ZSBmaXh1cCBuYW1lIGluIHRoZSBmaXJzdCBsaW5lIGlzIGVtcHR5LCBzbyBubyBmaXh1cCBpcwog
ICBhcHBsaWVkIGZvciBTU0lEIDEwM2M6OGRlOC4gT25seSBvbmUgc3BlYWtlciBvdXRwdXQgKHBp
biAweDE3KSBpcwogICBjb25maWd1cmVkLCBhbmQgdGhlIEFMQzEzMDggYW1wbGlmaWVyICgxMEVD
MTMwODowMCkgbmV2ZXIgc2VlbXMgdG8gYmUKICAgYm91bmQgdG8gYSBkcml2ZXIuCiAgIEkgYW0g
aGFwcHkgdG8gdGVzdCBwYXRjaGVzIG9yIHByb3ZpZGUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiAo
Zm9yCiAgIGV4YW1wbGUgYSBmdWxsIGFsc2EtaW5mby5zaCByZXBvcnQpIGlmIHRoYXQgaGVscHMu
CiAgIFRoYW5rIHlvdSBmb3IgeW91ciB3b3JrIG9uIExpbnV4IGF1ZGlvIHN1cHBvcnQuCiAgIEJl
c3QgcmVnYXJkcywKICAgRG9YCg==
