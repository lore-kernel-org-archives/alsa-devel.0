Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF0CD8CAA
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06CD060213;
	Tue,  9 Jun 2026 13:28:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06CD060213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781004528;
	bh=PkBSbhQ7a1CxArVHmV4k7bkJzO93k39ayAPKZYMvb5Q=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=u3z8yAvOxjpoEBmJuiRm8SIyT5zu/1cxZi2R+gnFsfigVEaCi6b+fYMa8B/7HyoUG
	 +y5IPv0h5wZXz5auBjdoBJtTxqgGqFQK6v86/XcyMiSaHOcqDDQWqB3YNRI2Az1Z53
	 1VQTYCudsEv9/BHoTC8WVJbBI2VbY6l/3W9qWsMo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48219F80607; Tue,  9 Jun 2026 13:28:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FA01F8061D;
	Tue,  9 Jun 2026 13:28:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0DEFF80423; Mon,  8 Jun 2026 13:57:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780919831;
	b=XenGW59dNI+oCwSBYxuAO+U4v3QTYNw0jBCJEY1uVJnrQ2iJWmVqSgqCgtAdxOQCUiAc
	 6np410TbcvgFAj9ae1R54DDAgOVt2hmjNWP79bKgBbuZPfU0k+zpVFU0C8GcNMQQ3jOYo
	 5C68xNiJNoPk6ZrT8KulGUpiUwYFQuZ9eOGht9tMSd83zgieAoQzmdlNHwohiXnW5M5Bb
	 Qb2ysWC8TjDkPPbCcPCOYuKiwlTz4a6HoJatrMuWNIK5fSLm2n9lZBIjlwCR2LoX+H5qZ
	 V4UVCzN1q4ZmGIRUPnHoxbrv6GuFHBU2afMfVFNKQAzuaw9c0tZbJ/AbKDX0rZucG+g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780919831;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=PkBSbhQ7a1CxArVHmV4k7bkJzO93k39ayAPKZYMvb5Q=;
	b=pL8f4HWsS0Cr3LbA/i595cWMCbNlEBsMI8306s74kqYNEhn2pBgGLRJacHs0IYb8SzNi
	 ZB2JNRuWxun/4NyHrgYnwp8KkjVs0+Ay/Ds+qIWkklJPOBMjeFjGENfk98eM1c7PPioSv
	 zSysINdUO9mN9c0ZjcqUCoN0Rg/Jm7cVejc5WYCGgHnjyOLfh8Dy8UWFZtxRKvN7ueq8A
	 N60ByPv4FXB1EI0Cti6N+V1iyHpqprQVbRJ/bJJhKjSfjzWycsRq4hJ1EWsl+xylkUijc
	 RnSQ6z0toHdQKIfIFxuzBeNsl84O2AwIZmhL1VGBqZBLl5vFQ91aC2UzTkg0liHfFIw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b="WC0TrYS/";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55543F80124
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 13:57:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55543F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=WC0TrYS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PkBSbhQ7a1CxArVHmV4k7bkJzO93k39ayAPKZYMvb5Q=; b=W
	C0TrYS/xgExvJtBsLyLGGVdXf2Ec+NGUt9kEBD5/Hw/2cw5okt633VZaC/l585uR
	wnfWp+sc72rUbuAlkrdxyzXe+d2tQAHaywICaW3M11L/LHkPnPPs6StuQqJNGO4y
	L6nuK7eb/41V9oP0bk9iU0HRNcznaauJrgfAeLdH7o=
Received: from ks002278$163.com ( [101.241.83.252] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Mon, 8 Jun 2026 19:57:04 +0800 (CST)
X-Originating-IP: [101.241.83.252]
Date: Mon, 8 Jun 2026 19:57:04 +0800 (CST)
From: "thomas.kuang" <ks002278@163.com>
To: alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X) - No
 soundcards detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: 
 AL_Qu2TAvWatkAp4iWbYOkcnEobges3WcG2uP8m1Ydfc+IEmx3o+SI7XEdRNkXX4s2FMg+cjT22fQZj0cRRXoJjSOXh2tFUJ6GADdwCGZq5Wg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bSgvCgDnL58QriZqyykFAA--.632W
X-CM-SenderInfo: dnvqijqsxyqiywtou0bp/xtbDABDTdGomrhD3BAAA32
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: ks002278@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EDV6EGPQ3GRFNKJWJ5CB6FQVLK7DVITR
X-Message-ID-Hash: EDV6EGPQ3GRFNKJWJ5CB6FQVLK7DVITR
X-Mailman-Approved-At: Tue, 09 Jun 2026 11:28:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EDV6EGPQ3GRFNKJWJ5CB6FQVLK7DVITR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

CgpIYXJkd2FyZTogTGVub3ZvIFRoaW5rQm9vayAxNiBHNyBRT1kgKFF1YWxjb21tIFNuYXBkcmFn
b24gWCAvIFggUGx1cyAvIFggRWxpdGUpCktlcm5lbCB2ZXJzaW9uOiA3LjAuMC0yMi1nZW5lcmlj
IChVYnVudHUgMjYuMDQgTFRTKQpBcmNoaXRlY3R1cmU6IGFhcmNoNjQKClByb2JsZW0gRGVzY3Jp
cHRpb246Ci0tLS0tLS0tLS0tLS0tLS0tLS0KQXVkaW8gaXMgbm90IHdvcmtpbmcgb24gdGhpcyBT
bmFwZHJhZ29uIFgtYmFzZWQgbGFwdG9wLiBUaGUgc3lzdGVtIGZhaWxzIHRvIGRldGVjdCBhbnkg
c291bmRjYXJkcywKZXZlbiB0aG91Z2ggdGhlIFF1YWxjb21tIGF1ZGlvIGRyaXZlciBtb2R1bGVz
IGFyZSBsb2FkZWQuCgpTeW1wdG9tczoKLS0tLS0tLS0tCi0gYGFwbGF5IC1sYCBzaG93czogIm5v
IHNvdW5kY2FyZHMgZm91bmQuLi4iCi0gYGNhdCAvcHJvYy9hc291bmQvY2FyZHNgIHNob3dzOiAi
LS0tIG5vIHNvdW5kY2FyZHMgLS0tIgotIGAvZGV2L3NuZC9gIG9ubHkgY29udGFpbnMgc2VxIGFu
ZCB0aW1lciBkZXZpY2VzLCBubyBwY20gZGV2aWNlcwoKUmVsZXZhbnQgU3lzdGVtIEluZm9ybWF0
aW9uOgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgokIHVuYW1lIC1hCkxpbnV4IGtzLVRo
aW5rQm9vay0xNi1HNy1RT1kgNy4wLjAtMjItZ2VuZXJpYyAjMjItVWJ1bnR1IFNNUCBQUkVFTVBU
X0RZTkFNSUMgTW9uIE1heSAyNSAxNTozNzo0OSBVVEMgMjAyNiBhYXJjaDY0IEdOVS9MaW51eAoK
JCBjYXQgL3Byb2MvdmVyc2lvbgpMaW51eCB2ZXJzaW9uIDcuMC4wLTIyLWdlbmVyaWMgKGJ1aWxk
ZEBib3MwMy1hcm02NC0wODMpIChhYXJjaDY0LWxpbnV4LWdudS1nY2MgKFVidW50dSAxNS4yLjAt
MTZ1YnVudHUxKSAxNS4yLjAsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBVYnVudHUpIDIuNDYp
ICMyMi1VYnVudHUgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gTWF5IDI1IDE1OjM3OjQ5IFVUQyAy
MDI2CgokIGNhdCAvc3lzL2RldmljZXMvdmlydHVhbC9kbWkvaWQvcHJvZHVjdF9uYW1lCjIxTkgK
CiQgY2F0IC9zeXMvZGV2aWNlcy92aXJ0dWFsL2RtaS9pZC9wcm9kdWN0X3ZlcnNpb24KVGhpbmtC
b29rIDE2IEc3IFFPWQoKJCBjYXQgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvZG1pL2lkL3N5c192ZW5k
b3IKTEVOT1ZPCgpMb2FkZWQgQXVkaW8gTW9kdWxlczoKLS0tLS0tLS0tLS0tLS0tLS0tLS0KJCBs
c21vZCB8IGdyZXAgLWkgcWNvbSB8IGdyZXAgLWkgc291bmQKc25kX3NvY19xY29tX3Nkd8KgIMKg
IMKgIMKgIDEyMjg4wqAgMSBzbmRfc29jX3gxZTgwMTAwCnNuZF9zb2NfcWNvbV9jb21tb27CoCDC
oCDCoDE2Mzg0wqAgMSBzbmRfc29jX3gxZTgwMTAwCnNvdW5kd2lyZV9xY29twqAgwqAgwqAgwqAg
wqAgMzY4NjTCoCAwCgokIGxzbW9kIHwgZ3JlcCBzbmRfc29jX3gxZTgwMTAwCnNuZF9zb2NfeDFl
ODAxMDDCoCDCoCDCoCDCoCAxNjM4NMKgIDAKClBsYXRmb3JtIERldmljZXM6Ci0tLS0tLS0tLS0t
LS0tLS0tCiQgbHMgL3N5cy9idXMvcGxhdGZvcm0vZGV2aWNlcy8gfCBncmVwIGF1ZGlvCmF1ZGlv
LWNvZGVjCmhkbWktYXVkaW8tY29kZWMuNi5hdXRvCmhkbWktYXVkaW8tY29kZWMuNy5hdXRvCmhk
bWktYXVkaW8tY29kZWMuOC5hdXRvCgpQaXBlV2lyZSBTdGF0dXM6Ci0tLS0tLS0tLS0tLS0tLS0K
4pePIHBpcGV3aXJlLnNlcnZpY2UgLSBQaXBlV2lyZSBNdWx0aW1lZGlhIFNlcnZpY2UKwqAgwqAg
wqBMb2FkZWQ6IGxvYWRlZCAoL3Vzci9saWIvc3lzdGVtZC91c2VyL3BpcGV3aXJlLnNlcnZpY2U7
IGVuYWJsZWQ7IHByZXNldDogZW5hYmxlZCkKwqAgwqAgwqBBY3RpdmU6IGFjdGl2ZSAocnVubmlu
Zykgc2luY2UgTW9uIDIwMjYtMDYtMDggMTg6NDA6NTAgQ1NUOyAzMG1pbiBhZ28KCuKXjyBwaXBl
d2lyZS1wdWxzZS5zZXJ2aWNlIC0gUGlwZVdpcmUgUHVsc2VBdWRpbwrCoCDCoCDCoExvYWRlZDog
bG9hZGVkICgvdXNyL2xpYi9zeXN0ZW1kL3VzZXIvcGlwZXdpcmUtcHVsc2Uuc2VydmljZTsgZW5h
YmxlZDsgcHJlc2V0OiBlbmFibGVkKQrCoCDCoCDCoEFjdGl2ZTogYWN0aXZlIChydW5uaW5nKSBz
aW5jZSBNb24gMjAyNi0wNi0wOCAxODo0MDo1MCBDU1Q7IDMwbWluIGFnbwoK4pePIHdpcmVwbHVt
YmVyLnNlcnZpY2UgLSBNdWx0aW1lZGlhIFNlcnZpY2UgU2Vzc2lvbiBNYW5hZ2VyCsKgIMKgIMKg
TG9hZGVkOiBsb2FkZWQgKC91c3IvbGliL3N5c3RlbWQvdXNlci93aXJlcGx1bWJlci5zZXJ2aWNl
OyBlbmFibGVkOyBwcmVzZXQ6IGVuYWJsZWQpCsKgIMKgIMKgQWN0aXZlOiBhY3RpdmUgKHJ1bm5p
bmcpIHNpbmNlIE1vbiAyMDI2LTA2LTA4IDE4OjQwOjUwIENTVDsgMzBtaW4gYWdvCgpBZGRpdGlv
bmFsIE5vdGVzOgotLS0tLS0tLS0tLS0tLS0tLQpUaGlzIGFwcGVhcnMgdG8gYmUgc2ltaWxhciB0
byBpc3N1ZXMgcmVwb3J0ZWQgb24gb3RoZXIgU25hcGRyYWdvbiBYIEVsaXRlIGRldmljZXMKKERl
bGwgTGF0aXR1ZGUgNzQ1NSwgRGVsbCBYUFMgMTMgOTM0NSkuIFRoZSBhdWRpbyBkcml2ZXIgbW9k
dWxlcyBsb2FkIGNvcnJlY3RseSwKYnV0IHRoZSBzb3VuZCBjYXJkIHJlZ2lzdHJhdGlvbiBmYWls
cy4KCkEgd29ya2Fyb3VuZCBtZW50aW9uZWQgaW4gY29tbXVuaXR5IGRpc2N1c3Npb25zIGlzIHRv
IGFkZDoKwqAgc25kLXNvYy14MWU4MDEwMC5pX2FjY2VwdF90aGVfZGFuZ2VyPTEKdG8gdGhlIGtl
cm5lbCBjb21tYW5kIGxpbmUsIHdoaWNoIHN1Z2dlc3RzIHRoaXMgbWF5IGJlIHJlbGF0ZWQgdG8g
c3BlYWtlcgpwcm90ZWN0aW9uIG1lY2hhbmlzbXMgbm90IGJlaW5nIGZ1bGx5IGltcGxlbWVudGVk
IGZvciB0aGlzIHBsYXRmb3JtLgoKQW55IGhlbHAgb3IgZ3VpZGFuY2Ugd291bGQgYmUgZ3JlYXRs
eSBhcHByZWNpYXRlZC4KCkJlc3QgcmVnYXJkcywKdGhvbWFzLmt1YW5nCgo=
