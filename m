Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B553CD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:41:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35A8E601CA;
	Mon, 11 May 2026 16:41:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35A8E601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510478;
	bh=DDqGSHJsubJUTme3WquCI0gxmWbKglUz7t2UcXMYYe0=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cwN+EJpYYseqeroRK65isoRXmBBBOaWxQ8cDqE3IUIMWRu5MFTceW62SVIpdIz2CI
	 sobV6x3HIH2y0BZeHaRUCTmYxogyvAva9XE8PBo/ysw2MhlRThyZef3bQBd84XlrSs
	 4iivQnkXlbrS2lGN+MBisBtTrzDOZuT65L1fb0mo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4F1DF805ED; Mon, 11 May 2026 16:40:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 814E1F805EF;
	Mon, 11 May 2026 16:40:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F97EF80535; Mon, 11 May 2026 00:20:04 +0200 (CEST)
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 04080F80154
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 00:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04080F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256
 header.s=s1 header.b=xfUAagw6
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 0B21013AB7AD5
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 00:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778451599;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=mExHaWjcoexyrtYslB6fVDayh6FbfWhFwOzQUQDp3I0=;
	b=xfUAagw66Huw4GLf02Nvc7r1y6ZQNsIPxofcfc07cyYAJpESnZ6ol2vP0dOCxtlo
	DEEd1lNPph+Vo3BAXzLXmaGLQRrxvCOaQj6Y8aCZjFEcqZLlgkQ2YCStrltJyOPwrWO
	cHbg9BjWaH76nobP+81dhlNCcidQ9Na+ZbQc7a+fDnUYnPWU2TyrVhcJIhE0jwCw7cP
	WVsv+Wr7m2NRKJizJ7FG5Hfmfsf9a3JnEvQqofUEUi3OsgamRe8TuuQPWTAJcyyAY5N
	AXYiVsLzgRgTbFiImTylYC4TfNAUxeYrH/5/JoeqD7+aTquBnbLHpk30SZtBGUNXXs+
	rdsd/Xk91Q==
Date: Mon, 11 May 2026 00:19:59 +0200 (CEST)
From: jf84ut@tutamail.com
To: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <OsIyOGC--F-9@tutamail.com>
Subject: Problems compiling alsa-utils
MIME-Version: 1.0
Feedback-ID: 
 0155c3e1b9ac8597c29bc580ff5705bb785790668c1216a9574153e5334ccfb32eddab030ac6cb91038ecb95181bf04ed5e11f3c328b728f871a63f0a95be5e128:TurnOnPrivacy!:tutamail
X-MailFrom: jf84ut@tutamail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WRBISOUFM5WBPK7CLWF2O4RYCEUPUSNJ
X-Message-ID-Hash: WRBISOUFM5WBPK7CLWF2O4RYCEUPUSNJ
X-Mailman-Approved-At: Mon, 11 May 2026 14:40:37 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WRBISOUFM5WBPK7CLWF2O4RYCEUPUSNJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

PGh0bWw+PGJvZHk+PHByZT4NCg0KRGVhciBmcmllbmRzIGF0IGFsc2EtcHJvamVjdC5vcmcsDQoN
ClRoYW5rIHlvdSBmb3IgeW91ciBleGNlbGxlbnQgc29mdHdhcmUuwqAgSSd2ZSBiZWVuIHVzaW5n
IGxpbnV4DQphbG1vc3QgZnJvbSBpdHMgYmVnaW5uaW5nLsKgIEknbSBhbiBNLkkuVC4gZ3JhZHVh
dGUgYW5kIHByb2Zlc3Npb25hbA0KY29tcHV0ZXIgcHJvZ3JhbW1lci7CoCBJJ20gaGF2aW5nIGRp
ZmZpY3VsdHkgY29tcGlsaW5nIGFsc2EtdXRpbHMuDQrCoA0KSSdtIHVzaW5nDQrCoCAtIERlYmlh
biAxMy40LjAgbGludXgNCsKgIC0gZ2NjIDE0LjIuMA0KwqAgLSBhY2xvY2FsIDEuMTcNCsKgIC0g
Z2V0dGV4dGl6ZSAwLjIzLjENCsKgIC0gYXV0b2hlYWRlciAyLjcyDQrCoCAtIGF1dG9tYWtlIDEu
MTcNCsKgIC0gYXV0b2NvbmYgMi43Mg0KwqAgLSBHTlUgbWFrZSA0LjQuMQ0KwqANCkkndmUgdHJp
ZWQgdG8gY29tcGlsZSB0aGUgdmVyc2lvbnMgb2YgYWxzYS11dGlscyBib3RoIGZyb20gZ2l0aHVi
LmNvbSwNCmFuZCBmcm9tIGFsc2EtcHJvamVjdC5vcmcgLg0KwqANCi8tLSBUaGUgcHJvY2VkdXJl
IHRoYXQgSSdtIHRyeWluZywgc3VnZ2VzdGVkIGZyb20NCsKgwqDCoCBodHRwczovL2dpdGh1Yi5j
b20vYWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMvYmxvYi9tYXN0ZXIvSU5TVEFMTCwgaXMsDQrCoMKg
wqAgY2QgL3Vzci9zcmMvYWxzYS11dGlscw0KwqDCoMKgIGNwIC91c3Ivc2hhcmUvbGlidG9vbC9i
dWlsZC1hdXgvY29uZmlnLmd1ZXNzIC4NCsKgwqDCoCBjcCAvdXNyL3NoYXJlL2xpYnRvb2wvYnVp
bGQtYXV4L2NvbmZpZy5zdWIgLg0KwqDCoMKgIGFjbG9jYWwNCsKgwqDCoCBnZXR0ZXh0aXplDQrC
oMKgwqAgYXV0b2hlYWRlcg0KwqDCoMKgIGF1dG9tYWtlIC0tZm9yZWlnbiAtLWNvcHkgLS1hZGQt
bWlzc2luZw0KwqDCoMKgIGF1dG9jb25mDQrCoMKgwqAgLi9jb25maWd1cmUNCsKgwqDCoCBtYWtl
DQpcLS0NCsKgDQpBcmUgdGhlc2UgdGhlIGNvcnJlY3QgY29uZmlnLmd1ZXNzIGFuZCBjb25maWcu
c3ViIHRoYXQgSSBzaG91bGQNCnVzZT/CoCBBbSBJIHJ1bm5pbmcgdGhlIGNvbmZpZ3VyYXRpb24g
LyBjb21waWxhdGlvbiBjb21tYW5kcyBpbiB0aGUNCmNvcnJlY3Qgb3JkZXI/DQrCoA0KRG8geW91
IHJlY29tbWVuZCB1c2luZyBzb3VyY2UgY29kZSBmcm9tIGFsc2EtcHJvamVjdC5vcmcsIG9yIGZy
b20NCmdpdGh1Yi5jb20/DQoNCkFmdGVyIEkndmUgZmlndXJlZCBvdXQgaG93IHRvIGNvbXBpbGUg
dGhpcyBzb2Z0d2FyZSwgSSdkIGJlIHBsZWFzZWQgdG8gbWFrZQ0KZm9yIHlvdSBhIHdlYiBwYWdl
LCAiSG93IHRvIENvbXBpbGUgYWxzYS11dGlscyIsIHRoYXQgdGVsbHMgZXhhY3RseSBob3cgYWxz
YS11dGlscw0KY2FuIGJlIGNvbXBpbGVkLCBhbmQgdGhhdCB5b3UgY291bGQgcHV0IG9uIHlvdXIg
d2ViIHNpdGUuDQrCoA0KQnkgdGhlIHdheSwgdGhlIGxpbmsgb24geW91ciBzaXRlIHRvIGFsc2Et
Y29tcGlsZS5zaCwgInNjcmlwdCB0bw0KY29tcGlsZSBsYXRlc3QgQUxTQSBzb3VyY2VzIGluIGFu
IGVhc3kgd2F5LCIgcG9pbnRzIHRvIGEgbm9uLWV4aXN0ZW50DQpmaWxlLsKgIEknZCBiZSBnbGFk
IHRvIGhlbHAgeW91IHdpdGggdGhpcywgYXMgd2VsbC4NCsKgDQpJIHRoYW5rIHlvdSBraW5kbHkg
Zm9yIHlvdXIgaGVscC4NCsKgDQpWZXJ5IHRydWx5IHlvdXJzLA0KwqANCkx5bWFuIE9waWUNCmx5
bWFuQGFsdW0ubWl0LmVkdQ0KDQo8L3ByZT48L2JvZHk+PC9odG1sPg0KDQo=
