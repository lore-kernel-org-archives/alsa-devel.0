Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BD8C4451C
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:42:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D5A360253;
	Sat, 18 Jul 2026 11:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D5A360253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367740;
	bh=qK0vhqSbNbJmamigtYc21fsla9CGMhi+N7a8ATKMhUI=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=O998o+YmnFrl4xlC2Rwo6nS963rGkbQYexNQsKBNyoJ73EfGsKe5njdYJVPEv0dtK
	 l5yxCJbClCtUyVe/XQEleMDwO+EYohLMQByu+3xbFQr4o647VsVPpBrUcFIusrzetD
	 D/nZfQLSC9eYhOvk4ZQBEZ/VelO/tVGK4qM7H+O0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51B05F806C0; Sat, 18 Jul 2026 11:40:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB6EF806B4;
	Sat, 18 Jul 2026 11:40:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 427EDF80526; Fri, 17 Jul 2026 16:50:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784299839;
	b=irBMvAQP5bmMc9YL27cdsDa2PrFlly6ArnBFppoxnAC9XxRs36zZ21yeetGsHbRZfazo
	 DqxKCafblnUcp51hvUx7iEU5tar2u2BAhJmuSht21pHOg/1BLkjUptRRthO90GtAkbne5
	 na2d17de4ODKvSWXzvYqYzlma70hYrJv+UaL/MaY+BZKRvsgeimW8Rjkknh0FgIdyK96v
	 HW0gJdwL+tCH8pemP/yjY+MLSg9aqBjJSm1sqydjpuHILrBX0fJYinBU32hXm9RZoy8Y2
	 BGtaYDgRnowqP8UO1Lyn3IjFKSA4L2QoK4s1RhUk7Irab63tUpvr4Llvh2ZF1hZcnUQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784299839;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=WjX2+8z3tL+LmsCzxv0ijIDzKn2zHmXYxHX0empA2UE=;
	b=LF5XvkpKo3BAJTIwodHnnPSYyHUjsNEQy+FHENS2n1YfFMDdJLnZugH0qNWAVO/3aIEP
	 sWif4KaNEXriFQKo4CYnq40BrbE1PM4p1W/g8EeliLlHntgLz2zm2cdhM+Oj8vKPIkatV
	 s66H7jvZv6HOhL+W4ZO+YHUkVqEAc/01rp62QFzLfz7+nB2EdUjw7cTsFgy90IywRx7y5
	 ozTlC6gZ7hA2A5XdvLnIkdVkRoskWBFWT8cQmWDQ2+V8kQrn53/9BkBVq0NX6ByC/JCvB
	 W1GzOZRZDgThZBWdGO9HEmqnfn6OLW/+6cwotuby80uSMeX8G+2Wit+nUcYgAyxenLw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oHko9Lpa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52DC5F8025A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 16:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52DC5F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oHko9Lpa
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e5918a0dfso4563a91.3
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Jul 2026 07:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299836; cv=none;
        d=google.com; s=arc-20260327;
        b=rCfFhRxw+DOGIImeuCOX1zMgIUgGwemiOeMmlRXVBKCtkQTqaia2KXcdEbQiZNazoz
         OID/mqph6OCfnE4EUg/fYjaBA3FUOujU4G9bNHgGwheFexUXNMRSPWMQVVZ+23Ytrbw6
         AhknVuwzx2I7DcmRlrU7jIlubrdqtObDB78CZtNgaQivHw2EZ2ifXe0sCGhirf0I5m73
         7OZEr0bgiNf62BsUNC59RfgCh2mfx29UIJowVEB6PGenw9Cvofw09jXucIPn8V8gxp+J
         z9sJlUGsMx514nXYLfx2WSutPHGw5QsgziIRuQlPkUcvfFtfsrQdyNfvSfjeBhvOzJp6
         0uWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gcjzHdnT7z9myWoQ8Bhj9TTCK4ruvBlLkCtTwApryhA=;
        fh=+Ze04VPT5qbxKO/UZIoGNm+tS+O0IHH4ohBHWziwaDo=;
        b=nGBvYBS6qilGa1af8f1Y/jq8MqgU7IsMjENluAKINcXY2tE/b+ebgo94S8bc06as1e
         Q98BucbsIXzmcdhqfx3qr5Nq9Ct912onZBzxIMO7NKR+ue+zCnq5EwtDhZ9DVa6Elr8a
         nt4LkXuFp9bLArhxEnmIZacvefM6/Md9QGL+hUqFKiWwEHgux7SH0zkJanZwHXmwIyNS
         JX0vAOUFZJLtuDhujeAQ/Wbc/uGoqxyf+PlR1xt+79wKDKP/dDLH0wAfpvxJwy64boct
         XpNBdLU5wbIafdY06kULg+r3aH1GNzcDjWUl8vU1ZHHH20DM0Tc604mKk54+J9IU6spC
         BfRA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299836; x=1784904636;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gcjzHdnT7z9myWoQ8Bhj9TTCK4ruvBlLkCtTwApryhA=;
        b=oHko9LpawGVjje3bTdo0q1aj3Xujl8DWjK7JqfnDuxGrFoWqK65eIucpplSXJd7/wE
         N8qG1rp0ib8mc90CoNWGbgwaucjPq7oWxDJrs9kwFZF0Qai1Biyiw8EwZ/ASSJziSJuk
         xEqPcBf+GNjhtcfTHmPSbIsGxfeWmUN8GvHqDWNFahPI37Yvbqq4qv6V+n64uyNLLTiq
         OPtqeDEClbwWhAtZrKlF/c8LUy/Bv0LR01zt21tzTdNa+82P6M0NrC5/6IWi1BmcCldj
         wjnuEBs8j08hLeO+DXTQ2iNsa4zvp0bWdchKJwFMGFS/5b8vFY3205RQ/aTcy1JWMnz9
         px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299836; x=1784904636;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcjzHdnT7z9myWoQ8Bhj9TTCK4ruvBlLkCtTwApryhA=;
        b=Ug7/Jxbz/9L0gd8fMu40cXR38coMjsrb5itszt8WFvSDPHq6mKdNt5ZOTnN6tR1FoP
         YlWHZJsaFh8sMeOMKpOjMnMHN+9KcJoW6nM/InSyTJ1aHVm5dNN+FkTR2iNxn1pJY+F0
         TxNJVBH9p+au6qaRXkREvoLxnj60gxGESglqqHJCySiSzTu6sazD0/3dLstVA4QnVUJ+
         imqjt6ZTVN6iOCh/ZXf0k394nWbUM9PGF6luYQ+wMsgr+ZWLQokAlYC/HiRar1cwYIdf
         mu0AXQWXlZkPeEhfPnsU58xzhmV6u5/YP3E0Nh/wSlgkaxH8R1maIkbQE+9IPYfP42me
         Ngnw==
X-Gm-Message-State: AOJu0Yx5B91K44FUkFvQB1TwrYDEngTWjJNd9FLYE8zs5WgA/qUg64HW
	OW/CIBhCEkHX1AH2u19lVEkpsksXWe8YUAwkIezu7j1GWKoow4Ic6wySb2U2TG40Ow+TtSitTQz
	Rg+3KiYnA52wOzxiQTJR2I/LWXVy7Y3XmHU9c
X-Gm-Gg: AfdE7cnsoa8kKrRC4LPQqUL9Co6iULCR9osDdbJq82OgEVqhaSTv9PS8BszvcJjKhVK
	gRI5c6zOGkpN6A0t3MKve9hYeE24x475je+V991kHoaIJ9VWgApBLhv1qYKsx1FX8UjccPD4UIM
	iJD1d9E6EYOVEqSH03we+uKXlPSHoff91728j8sG2u+kifVUSGpQhSDgUydl+n73w3RyvCWpry0
	xne0r2U8HALnoduFWTATEGCvvRrmWVsrXh3huTXtNnXSjYCs98jVZuqLvKjK+fsNRP/YkHw3cu3
	nz1EzL5j55eX9Ak+tJs/sPA=
X-Received: by 2002:a17:90b:5588:b0:381:cef1:11b2 with SMTP id
 98e67ed59e1d1-38e4b550a72mr2466769a91.7.1784299835689; Fri, 17 Jul 2026
 07:50:35 -0700 (PDT)
MIME-Version: 1.0
From: Grant Diffey <gdiffey@gmail.com>
Date: Sat, 18 Jul 2026 00:50:24 +1000
X-Gm-Features: AUfX_mw3_vRErBkw1i43mSHdPaXgN8lLmdefl1CCYY9MsIdIfyKzkdifcNwgZIY
Message-ID: 
 <CACckToXHuiq4RYeoBfpbui_wNCYSgjRmOiDFZH1EW_1VQLr3cQ@mail.gmail.com>
Subject: [PATCH] More quirks for M-Audio Fast Track Ultra.
To: ALSA development <alsa-devel@alsa-project.org>
Content-Type: multipart/mixed; boundary="000000000000e132c40656cfadf2"
X-MailFrom: gdiffey@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UBXB2CC6NC4OBHOHPA53FOOZP6HVXPMG
X-Message-ID-Hash: UBXB2CC6NC4OBHOHPA53FOOZP6HVXPMG
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:40:24 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UBXB2CC6NC4OBHOHPA53FOOZP6HVXPMG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--000000000000e132c40656cfadf2
Content-Type: text/plain; charset="UTF-8"

Hi all

86aa1ea1f15ce broke the fast track ultra... patch adds a quirk for 'broken
GET_CUR'  which is absolutely required to be able to configure this
interface.

I've also applied the IMPLICIT FEEDBACK quirk as I believe this card should
be treated as implicit feedback like the C600

This should probably be applied for the Fast track ultra 8R as well but I
don't have one to test.


Regards
Grant

--000000000000e132c40656cfadf2
Content-Type: text/x-patch; charset="US-ASCII";
 name="m-audio-fast-track-ultra.patch"
Content-Disposition: attachment; filename="m-audio-fast-track-ultra.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mrp0v3l20>
X-Attachment-Id: f_mrp0v3l20

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3NvdW5kL3VzYi9xdWlya3MuYwppbmRl
eCA0MTE0OTU2MWFhMDYuLmFiNWQwMDhhMjc0OCAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3F1aXJr
cy5jCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYwpAQCAtMjMyMCw2ICsyMzIwLDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB1c2JfYXVkaW9fcXVpcmtfZmxhZ3NfdGFibGUgcXVpcmtfZmxhZ3NfdGFi
bGVbXSA9IHsKIAkJICAgUVVJUktfRkxBR19HRU5FUklDX0lNUExJQ0lUX0ZCKSwKIAlERVZJQ0Vf
RkxHKDB4MDc2MywgMHgyMDMxLCAvKiBNLUF1ZGlvIEZhc3QgVHJhY2sgQzYwMCAqLwogCQkgICBR
VUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpLAorCURFVklDRV9GTEcoMHgwNzYzLCAweDIw
ODAsIC8qIE0tQXVkaW8gRmFzdCBUcmFjayBVbHRyYSAqLworCQkgICBRVUlSS19GTEFHX01JWEVS
X0dFVF9DVVJfQlJPS0VOIHwgUVVJUktfRkxBR19HRU5FUklDX0lNUExJQ0lUX0ZCKSwKIAlERVZJ
Q0VfRkxHKDB4MDdmZCwgMHgwMDBiLCAvKiBNT1RVIE0gU2VyaWVzIDJuZCBoYXJkd2FyZSByZXZp
c2lvbiAqLwogCQkgICBRVUlSS19GTEFHX0NUTF9NU0dfREVMQVlfMU0pLAogCURFVklDRV9GTEco
MHgwOGJiLCAweDI3MDIsIC8qIExpbmVYIEZNIFRyYW5zbWl0dGVyICovCg==
--000000000000e132c40656cfadf2--
