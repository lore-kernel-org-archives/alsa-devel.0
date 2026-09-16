Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB3CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:02:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFEEC601E1;
	Tue, 29 Sep 2026 21:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFEEC601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708527;
	bh=ttblJqzCW0Fyih5WkQMPrUMyauAJRBgRysdFW7U5zko=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=X1F2J3KCWZso3/juvLAwbL9Lcab6TSYkDkhvsHM+Qd8eiqDSBWFgvzKDqiWMgljlq
	 Jfm4mL7DQnQb0gkKXOdCjUgHwlTyyiyAhpIe4WOZixZxhx9COM50e4PHwF8gUyWpBU
	 8fB0jjZl2Sx0Rxr2VvzJ60RGOZ1P71/vR67bw/EQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89173F805FA; Tue, 29 Sep 2026 21:01:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 411F7F805ED;
	Tue, 29 Sep 2026 21:01:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0EC6F802DB; Wed, 16 Sep 2026 18:21:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.140
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789575685;
	b=r7tSvzKbx7ynFolELgbG5WKZs0WS+gtWJC8u9AXNeo1+wNrXB+GWz4LZtuXVUZ5s2xzP
	 a4qIpZdyza1NBeieRXdZE0oldj+JVqas9ZScmEkeVgQSn8UhnrLBVlqVl8/dbRpIDamI1
	 OVLqtFwV2x7qWRCWe1vciVf1Q1SasHqL41y9SS0IKk1clp1zzWnuhDsSBCaWJPLAO/vl8
	 3WRFIIj1CjCf+WrxLQe/Txedp6YxWfUUZ3Cwxq5Ez6v0AjW2tylneZ8ipour55swa7inT
	 8PrN6/Kk3MvxwhaZXb/fkR9wGptUhFOXdAUjo1J4F49NscLDkXZZ4qVAq2QiJHHnvWA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789575685;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=v9NsUrRrJigr6jOtPdAzrcFaVIAPAuNUVsUAST4pTlc=;
	b=KPXSlMdWRUytK5a/wn/c5GCY87hpf4zv5ZBz5M9hHBf4/5+q/om6WbhvB2o18JKgzftl
	 ia1q2NS210EXYrZSjlbVvu5BaoiZ2KxutHuAeVVGzmZdoQFljrXHgY3FwVY8xuYabrAJ6
	 Xsgs7UEDEgFd+pTX0L6rD3v18QqqWZ/qeGSI56zdfzVMfw2pYm0tdj6kfZuaOlDAfXai4
	 suhrvilje3GPmu5EH/P3cpFc3o2v2GqaY1b6JUCYR4i4FjOc3SoLDYXSRl3K1NthnT6fw
	 x1OBWalZbD+BYdYEIQUbdV38mkhwisdbfEtS8LWQLQZCMKl8P3Av7Ky19yvGuTbFnXg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lPuNVMVl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.140
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA977F8007E
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 18:21:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA977F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lPuNVMVl
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d4ddd17a0so9447687b3.0
        for <alsa-devel@alsa-project.org>;
 Wed, 16 Sep 2026 09:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575683; cv=none;
        d=google.com; s=arc-20260327;
        b=J2wIyVBAA2xEW4BUKajuop36cg484Qt7c2pWDeE1Zh3N9qYBqGjCEl/Yqgc+1dQ+U0
         3NDStX3coxevvZsjHNRq8RiKxu5r4danGV/wPpjlNTSqLTmX/lJnwE5LtARgRSOHtsZd
         p5btFwxjMMS+nlDut2SF1CaJgubONdgHNKRE6pG/Q4omdDj9p5XGGQF4Hk0bdWcOfFDL
         ugKfUdICkeKWJjUGjX0xzh+zgInXkVTyqJl1CSuVuSXOxb0mJz4IR6rVI0SVSCumtLpj
         eOtpPrFUvT+Z5J8qgtZnl1QjaS5KPGcJWpYyPImm7VrrQ7RDiBPCR3PSvPaf/oNFGqFW
         AIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BUMVor2qgnoWP925r5ybdzWXN9sw8E0x1jyogVcavKI=;
        fh=7Qv95SR7dcKd7r588wgQzvi0GFsNecz8Duad4kCTTbI=;
        b=q2SlarqZWvR4obUHJrQeBMa8PqvUgeafmiMGrPZf0G5e17oO6wXYd+eJw0mXETkZoH
         9/PgLRQpLLNXw6csUCpmxEyRhFE/Remuab3iEs+brdBCAJpcWt+LBEyXcCBlmCtlNO+W
         jmYOaUggdY+Lck8dxUZSKhYUjB6R2kPeVh1Ng790gfPRQlw0NzYQZwJKWSpc3YZNruIT
         d7wd/aVgDQdTL6bvYc8bKpl2xAXoWgUMZP/YFGpY+JPiV2hHmkg6W+O8yxzpCt1zc/Hr
         nfSNhyz0/5/F3BCdgdX6n7T+uEpuLVciuJjuwfR4UqmgmGorlZXjx4fmBrWj/Qh90lc/
         7ynQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575683; x=1790180483;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUMVor2qgnoWP925r5ybdzWXN9sw8E0x1jyogVcavKI=;
        b=lPuNVMVlmbLWbJZ4frEQYuj1WJm8XiChZ61mYsWt7paoEyzf5CsAtB3HJi8nyDhzve
         qUZEbyX0pC6Gyf0JHB/+NTG0lP01XAqUiM7Ahl5L1rUT0WGn32wrQWweAdSAWQkS67fb
         rGRQYyguyoe08+vsSAy+MeUjV+S+6IUHOYvYMzuMxPAUkd8Tf8UcpDzlua0u/7JPlBy0
         iDDR8zB5sr6vOGFhZhzBFAaazEFSCVZdmDbHT/DvIvYbl3san9sIoGpyvWxKdn8gs3fA
         2wFEKdilj6e++Bo8HqmpZo7pcXan0Yh3H9gWVhthxvimxetPiNMIrDrpBQU8ldLnuEwa
         uZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575683; x=1790180483;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BUMVor2qgnoWP925r5ybdzWXN9sw8E0x1jyogVcavKI=;
        b=bGFv9tOD0QLYIt3pePVBuDqzTkmK9EpIO6gjohDpBxgI/tp7VZ0g5qG2WvNAwsXWB0
         5+ez2MIOerS9Y6wOy036csB8RDbHWTtOFvNggA6i5pRkigkdc6jSXzkDOAF3ZBk8fbEt
         uCB3ggoTpDaZQ5DLBTMCbDd4zFdH/l2T9MYWxo3KU90hIlHYjR9KkO0i2JgAlU6Glc4O
         G0ize7pTIhIo/GFLwJ6AcyxiQe/hfqcHwHRjWCgbXBgpyJo/PZk2GpBIfK0MEW4yP5tM
         StP9cLSLpFlW2kvgRmT2sOfJgAx6OWRXpGdWik0wT5bQOxawuGlGWm3BPB0/2JEdUqmB
         7M2g==
X-Gm-Message-State: AFuF++m+II1IxfiEZGNgSE732d62UlMop3EOXjFBnk+2wNBU+Gt9O92l
	Ctu+H90O9Qqt0/AmqJqPDcwojtU6UbddBmLPqSwL3xl5BcBQQa/9KnEny0bVMBbOxrkLYBvCHPB
	nCLXwM1Wh+lXQLPVsPMEbQg1esiZg6jKnEQ==
X-Gm-Gg: AYBFou0MkRiFmXZPZXgpUnG89Zz12n0jKnxTaAPRYtnuf9dnZiHxMHmulkfRjj55cQY
	Z4GnE6SdA0w1sS/JN5Zy21NI2fbOW2232eJJiOS7eo/OY6cFHq21PE00zKpKvxSO9JzJCN5zUMl
	5TiHmJ6jPuljg7SEaMMNMB9LDcHuisKsC4yIbklsJyPIjEcf3O79fQ+rFgY5BLS5wwzm7Mrv9Az
	0F9KIJaQmrfm/ugBF3n1UHoRvpHV+rt3kXcdzm9cDKUVCQLy8wZ4gbHgbo7PWTqMMlo4gRtNWXP
	d1KvcjvT1+jVbHdzgzL+HbqNv5WUVaASb16OJNAbtuZfCvbPossU6KZlwOpSiCxrBF3uPZk9J2G
	SbR6Ewv3nC0YXzZ+mFWsiSBpZieHmXHolfiUbjfk=
X-Received: by 2002:a05:690c:386:b0:873:ea3b:6c5d with SMTP id
 00721157ae682-892254608c6mr15127927b3.14.1789575682923; Wed, 16 Sep 2026
 09:21:22 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 12:21:22 -0400
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 12:21:22 -0400
MIME-Version: 1.0
From: Khagen <khagenboy@gmail.com>
Date: Wed, 16 Sep 2026 12:21:22 -0400
X-Gm-Features: AcwNN1XpC6U24znwaZKC8JfK7_Vl64tzRrWHSMhjDK5mD9Xlnnvx0exubQOlC7w
Message-ID: 
 <CALF7MW_AEzieQv7RF5jSOY6-+kxLDbMJiwae-V9d87CArcic=A@mail.gmail.com>
Subject: 
 =?UTF-8?Q?Re=3A_cs35l41=2Dhda=3A_PUP=5FDONE_times_out_on_ASUS_UX3405CA?=
	=?UTF-8?Q?_=28SSID_10431A63=29_=E2=80=94_also_fails_on_resume_with_BIOS_=2E316?=
To: alsa-devel@alsa-project.org
Cc: patches@opensource.cirrus.com
X-MailFrom: khagenboy@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 65HET5PLWNWBN2ENDKZNMKRLGIYIBQOF
X-Message-ID-Hash: 65HET5PLWNWBN2ENDKZNMKRLGIYIBQOF
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:01:29 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/65HET5PLWNWBN2ENDKZNMKRLGIYIBQOF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkZvbGxvd2luZyB1cCBvbiBMdXFtYW4gSCdzIHJlcG9ydCBmcm9tIEF1Z3VzdCBhYm91
dCBQVVBfRE9ORSB0aW1lb3V0cyBvbg0KdGhlIEFTVVMgWmVuYm9vayBVWDM0MDVDQSAoU1NJRCAx
MDQzMUE2MykuIEkgaGF2ZSB0aGUgc2FtZSBsYXB0b3AgbW9kZWwgYW5kDQp3YW50IHRvIGFkZCBh
IGRhdGEgcG9pbnQ6IHRoZSBCSU9TIC4zMTUgZml4IHJlcG9ydGVkIHRoZXJlIGRvZXMgbm90IGZ1
bGx5DQpyZXNvbHZlIHRoaXMgZm9yIG1lIG9uIHRoZSBuZXdlciAuMzE2Lg0KDQpTeXN0ZW06DQot
IEFTVVMgWmVuYm9vayAxNCBVWDM0MDVDQV9VWDM0MDVDQSwgU1NJRCAxMDQzMUE2Mw0KLSBCSU9T
OiBVWDM0MDVDQS4zMTYgKDIwMjYvMDYvMjYpDQotIEtlcm5lbDogNy4wLjAtMzEtZ2VuZXJpYyAo
VWJ1bnR1IDI2LjA0LjEgTFRTKSwgZmlybXdhcmUtc29mLXNpZ25lZA0KMjAyNS4xMi4yLTENCi0g
VHdvIENTMzVMNDEgYW1wcyB2aWEgU1BJIChzcGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEuMC8u
MSkNCg0KRGlmZmVyZW5jZSBmcm9tIHRoZSBvcmlnaW5hbCByZXBvcnQ6IGF1ZGlvIHdvcmtzIGNv
cnJlY3RseSBvbiBhIGNvbGQgYm9vdA0KKGJvdGggYW1wcyBsb2FkIHByb3BlciB0dW5pbmcsIGUu
Zy4gLi4uL1VYMzQwNU1BL1R1bmluZy8xMDI1Mi4uLikuIFRoZQ0KZmFpbHVyZSBvbmx5IGFwcGVh
cnMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg4oCUIHJlcHJvZHVjZWQgb24gYm90aCBzMmlkbGUgYW5k
DQpkZWVwIChTMykgc2xlZXAgbW9kZXMuIFNvIHRoaXMgbG9va3MgbGlrZSBhIHJlc3VtZS1wYXRo
IGJ1ZyBkaXN0aW5jdCBmcm9tDQoob3Igbm90IGZ1bGx5IGNvdmVyZWQgYnkpIHRoZSAuMzE1IGJv
b3QtdGltZSBmaXguDQoNCkZhaWx1cmUgc2lnbmF0dXJlIG9uIHJlc3VtZToNCmNzMzVsNDEtaGRh
IHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4xOiBGYWlsZWQgd2FpdGluZyBmb3IgT1RQX0JP
T1RfRE9ORQ0KY3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjE6IFBNOiBk
cG1fcnVuX2NhbGxiYWNrKCk6DQpjczM1bDQxX3N5c3RlbV9yZXN1bWUgW3NuZF9oZGFfc2NvZGVj
X2NzMzVsNDFdIHJldHVybnMgLTExMA0KY3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVs
NDEtaGRhLjE6IFBNOiBmYWlsZWQgdG8gcmVzdW1lOiBlcnJvciAtMTEwDQpjczM1bDQxLWhkYSBz
cGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEuMTogRmFpbGVkIHdhaXRpbmcgZm9yDQpDUzM1TDQx
X1BVUF9ET05FX01BU0s6IC0xMTANCmNzMzVsNDEtaGRhIHNwaTAtQ1NDMzU1MTowMC1jczM1bDQx
LWhkYS4wOiBGYWxsaW5nIGJhY2sgdG8gZGVmYXVsdCBmaXJtd2FyZS4NCmNzMzVsNDEtaGRhIHNw
aTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4wOiBVbmFibGUgdG8gZmluZCBmaXJtd2FyZSBhbmQN
CnR1bmluZw0KY3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjA6IENhbm5v
dCBJbml0aWFsaXplIEZpcm13YXJlLg0KRXJyb3I6IC0yDQoNCkF1ZGlibGUgc3ltcHRvbTogc3Bl
YWtlcnMgc3RheSBvbiwgYnV0IG9uIGRlZmF1bHQvdW50dW5lZCBmaXJtd2FyZSDigJQNCm5vdGlj
ZWFibHkgbG93IHZvbHVtZSBhbmQgaW1iYWxhbmNlZCBsZWZ0L3JpZ2h0LCBub3Qgc2lsZW5jZS4N
Cg0KV29ya2Fyb3VuZCBmb3VuZDogcmVsb2FkaW5nIHRoZSB3aG9sZSBzbmRfc29mX3BjaV9pbnRl
bF9tdGwgbW9kdWxlIHJlc3RvcmVzDQpiYXNpYyBQQ00gcmVnaXN0cmF0aW9uIGJ1dCB0aGUgYW1w
cyBzdGF5IG9uIGZhbGxiYWNrIGZpcm13YXJlIChsb3cNCnZvbHVtZS9pbWJhbGFuY2UgcGVyc2lz
dHMpLiBVbmJpbmRpbmcgYW5kIHJlYmluZGluZyBqdXN0IHRoZSB0d28gYW1wIFNQSQ0KZHJpdmVy
IGluc3RhbmNlcywgaG93ZXZlciwgcmVsaWFibHkgcmVsb2FkcyBjb3JyZWN0IHR1bmluZzoNCg0K
Zm9yIGQgaW4gc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjAgc3BpMC1DU0MzNTUxOjAwLWNz
MzVsNDEtaGRhLjE7IGRvDQplY2hvICIkZCIgPiAvc3lzL2J1cy9zcGkvZHJpdmVycy9jczM1bDQx
LWhkYS91bmJpbmQ7IGRvbmUNCnNsZWVwIDINCmZvciBkIGluIHNwaTAtQ1NDMzU1MTowMC1jczM1
bDQxLWhkYS4wIHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4xOyBkbw0KZWNobyAiJGQiID4g
L3N5cy9idXMvc3BpL2RyaXZlcnMvY3MzNWw0MS1oZGEvYmluZDsgZG9uZQ0KDQpBZnRlciB0aGlz
LCBkbWVzZyBzaG93cyBib3RoIGNoYW5uZWxzIGNvcnJlY3RseSBib3VuZDoNCmNzMzVsNDEtaGRh
IHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4wOiBGaXJtd2FyZSBMb2FkZWQgLSBUeXBlOg0K
c3BrLXByb3QsIEdhaW46IDE5DQpjczM1bDQxLWhkYSBzcGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1o
ZGEuMDogQ1MzNUw0MSBCb3VuZCAtIFNTSUQ6IDEwNDMxQTYzLA0KQlNUOiAxLCBWU1BLOiAxLCBD
SDogTCwgRlcgRU46IDEsIFNQS0lEOiAxDQpjczM1bDQxLWhkYSBzcGkwLUNTQzM1NTE6MDAtY3Mz
NWw0MS1oZGEuMTogRmlybXdhcmUgTG9hZGVkIC0gVHlwZToNCnNway1wcm90LCBHYWluOiAxOQ0K
Y3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjE6IENTMzVMNDEgQm91bmQg
LSBTU0lEOiAxMDQzMUE2MywNCkJTVDogMSwgVlNQSzogMCwgQ0g6IFIsIEZXIEVOOiAxLCBTUEtJ
RDogMQ0KDQpJJ20gcnVubmluZyB0aGlzIGFzIGEgc3lzdGVtZCBzbGVlcCBob29rICh1bmJpbmQv
cmViaW5kIG9uIGV2ZXJ5IHJlc3VtZSkgYXMNCmEgc3RvcGdhcC4gSGFwcHkgdG8gdGVzdCBwYXRj
aGVzIG9yIHByb3ZpZGUgYSBmdWxsZXIgQUNQSSBkdW1wL2RtZXNnIGlmDQp1c2VmdWwuDQoNClRo
YW5rcywNCktoYWdlbiBMYW1hDQo=
