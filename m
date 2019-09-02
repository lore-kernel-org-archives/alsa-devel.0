Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350AAC3A5A4
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:28:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94D821874
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vez0QjbQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjT1ZYCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94D821874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09BC41660;
	Mon,  2 Sep 2019 03:27:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09BC41660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567387685;
	bh=UCUHERGEc4MlRiQobqortniD4YqCSDQ6vaIeN7hUyQk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vez0QjbQU9mguet6Gxkc2xtEvh3Cizcw/SIGlHT7AhOszBiyF/f4ywYSTkH2GzYRd
	 g2ReVyWSNyHWfE/RmbixseqFUs2sCpyy914XGrCXBoVZWWXwaDh9WTriiC7Y0JqrXO
	 goIkXi2XnAstEATYHRI9jJ1Te4uDbWNtDo7xOVmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 872A4F80306;
	Mon,  2 Sep 2019 03:27:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F6F8F8045F; Mon,  2 Sep 2019 03:27:13 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43223F80306
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 03:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43223F80306
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DjT1ZYCS"
Received: by mail-pg1-x543.google.com with SMTP id n9so6547979pgc.1
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpuKjcvQL2FC1BkEAV7/GouC1zaHg3TIj3cjQPPsPps=;
 b=DjT1ZYCSQs3lZeB9H0O48+NKT9MNnw+wBgjx0zej7pEwKcE/EtA7ZWc39u18RWymRQ
 VMQXF58wZDqLH5ymYMN85RzuUKhd5nHsqHmHSYVx1EaxpZPvyRlW5t5vDTZmwFizbWZT
 svbJ60aSX76VeLaLn7yBvNyzgqpix3qOyI4fSV22/Itussx0xO92eGhuZh5QuC2lfODw
 3e3+4ssn6VOGsNye8BGHqbxZY9SjRN7IRHE1TQfS/z1oNaNVOiYLMMA7kcxS/6OCJgxt
 8KvedLm6sTqYd8GRrWhoMDuQgZSDksIfsVVjqEpRg2soWNU2MvI+iXHyFX0LSvGK3xQL
 Fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpuKjcvQL2FC1BkEAV7/GouC1zaHg3TIj3cjQPPsPps=;
 b=K+ajaMhWocC8Rlv6DiauQEZmMjUkiJt2p5OCMqzqBEGoXkvNiw8RL4TM/dno8tv5L2
 1FnreSlibh57zsxLxl0hQA37MvnovQzjmkcrEQpJKlAZXKu9Yizto/FklVD9A+VcUeHP
 U0Jk5IUOh1JnUDrAUX/a8Tfrv83oDwqyj0xGTakw+uaTG/MzZNBTJMv1FZPxRdr5X3bO
 udBjntjTYT6LzybOq8lQJqNrgxxt+N1s8zz7iir+AlUE1ffIN7/hSPTyi4YvDWuFkZEU
 tiuuSTxzHN0avD4i2qfttmvVQUajarKSt78323C5UrlmFDjn4NdaiBn59KPnUzHHMj+s
 u9Qg==
X-Gm-Message-State: APjAAAWBkaYeTZSnE0JdMr9UWFC5PjyMInYsGZbZ5zgwxFvwHZHBpajg
 POO1KEPFs0HhJgFVpqR+MTzJ+dU4Va8=
X-Google-Smtp-Source: APXvYqx5hqnU1i95c6TSWpScoJkabWsEMaFixL6QdZSGCs7a0DHNkisf1nWBzEVszf3xIjvkV+yEVQ==
X-Received: by 2002:a17:90b:14a:: with SMTP id
 em10mr10103777pjb.26.1567387628024; 
 Sun, 01 Sep 2019 18:27:08 -0700 (PDT)
Received: from localhost.localdomain (76-14-106-55.rk.wavecable.com.
 [76.14.106.55])
 by smtp.gmail.com with ESMTPSA id t11sm11947919pgb.33.2019.09.01.18.27.07
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2019 18:27:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: alsa-devel@alsa-project.org
Date: Sun,  1 Sep 2019 18:27:05 -0700
Message-Id: <20190902012705.16062-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH] alsa-utils: Remove usleep usage
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190902012705.0zybx5ALhZBt8BKoAJ5UK1pZYFpSUmopljb7vztYtLM@z>

dXNsZWVwIHdhcyBkZXByZWNhdGVkIGluIFBPU0lYIDIwMDggYW5kIGlzIG5vdCBhdmFpbGFibGUg
d2l0aG91dApkZXByZWNhdGVkIEFQSXMgZW5hYmxlZCBpbiB1Q2xpYmMtbmcuCgpTaWduZWQtb2Zm
LWJ5OiBSb3NlbiBQZW5ldiA8cm9zZW5wQGdtYWlsLmNvbT4KLS0tCiBhbHNhY3RsL2RhZW1vbi5j
ICB8IDMgKystCiBhbHNhbG9vcC9wY21qb2IuYyB8IDMgKystCiBhbWlkaS9hbWlkaS5jICAgICB8
IDYgKysrKy0tCiBiYXQvYmF0LmMgICAgICAgICB8IDUgKysrLS0KIDQgZmlsZXMgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hbHNhY3RsL2Rh
ZW1vbi5jIGIvYWxzYWN0bC9kYWVtb24uYwppbmRleCAxZDk4Y2FhLi4zYjg0Y2Y2IDEwMDY0NAot
LS0gYS9hbHNhY3RsL2RhZW1vbi5jCisrKyBiL2Fsc2FjdGwvZGFlbW9uLmMKQEAgLTM0OCw3ICsz
NDgsOCBAQCBzdGF0aWMgaW50IGNoZWNrX2Fub3RoZXJfaW5zdGFuY2UoY29uc3QgY2hhciAqcGlk
ZmlsZSkKIAlpZiAocGlkID49IDApIHsKIAkJLyogaW52b2tlIG5ldyBjYXJkIHJlc2NhbiAqLwog
CQlpZiAoa2lsbChwaWQsIFNJR1VTUjEpID49IDApIHsKLQkJCXVzbGVlcCgxMDAwKTsKKwkJCXN0
cnVjdCB0aW1lc3BlYyByZXEgPSB7IDAsIDEgKiAxMDAwICogMTAwMCB9OworCQkJbmFub3NsZWVw
KCZyZXEsIE5VTEwpOwogCQkJcGlkID0gcmVhZF9waWRfZmlsZShwaWRmaWxlKTsKIAkJCWlmIChw
aWQgPj0gMCkKIAkJCQlyZXR1cm4gMTsKZGlmZiAtLWdpdCBhL2Fsc2Fsb29wL3BjbWpvYi5jIGIv
YWxzYWxvb3AvcGNtam9iLmMKaW5kZXggMjlkMWFiYS4uZDAzNDdkYyAxMDA2NDQKLS0tIGEvYWxz
YWxvb3AvcGNtam9iLmMKKysrIGIvYWxzYWxvb3AvcGNtam9iLmMKQEAgLTY2MiwxMCArNjYyLDEx
IEBAIHN0YXRpYyBpbnQgeHJ1bihzdHJ1Y3QgbG9vcGJhY2tfaGFuZGxlICpsaGFuZGxlKQogCiBz
dGF0aWMgaW50IHN1c3BlbmQoc3RydWN0IGxvb3BiYWNrX2hhbmRsZSAqbGhhbmRsZSkKIHsKKwlz
dHJ1Y3QgdGltZXNwZWMgcmVxID0geyAwLCAxMDAwfTsKIAlpbnQgZXJyOwogCiAJd2hpbGUgKChl
cnIgPSBzbmRfcGNtX3Jlc3VtZShsaGFuZGxlLT5oYW5kbGUpKSA9PSAtRUFHQUlOKQotCQl1c2xl
ZXAoMSk7CisJCW5hbm9zbGVlcCgmcmVxLCBOVUxMKTsKIAlpZiAoZXJyIDwgMCkKIAkJcmV0dXJu
IHhydW4obGhhbmRsZSk7CiAJcmV0dXJuIDA7CmRpZmYgLS1naXQgYS9hbWlkaS9hbWlkaS5jIGIv
YW1pZGkvYW1pZGkuYwppbmRleCBiNmUwNWUxLi4zYjI5NTNkIDEwMDY0NAotLS0gYS9hbWlkaS9h
bWlkaS5jCisrKyBiL2FtaWRpL2FtaWRpLmMKQEAgLTI1NCwxMCArMjU0LDEyIEBAIHN0YXRpYyBp
bnQgc2VuZF9taWRpX2ludGVybGVhdmVkKHZvaWQpCiAJCQlzbmRfcmF3bWlkaV9zdGF0dXMob3V0
cHV0LCBzdCk7CiAJCQlkbyB7CiAJCQkJLyogMzIwIMK1cyBwZXIgYnl0ZSBhcyBub3RlZCBpbiBQ
YWdlIDEgb2YgTUlESSBzcGVjICovCi0JCQkJdXNsZWVwKChidWZmZXJfc2l6ZSAtIHNuZF9yYXdt
aWRpX3N0YXR1c19nZXRfYXZhaWwoc3QpKSAqIDMyMCk7CisJCQkJc3RydWN0IHRpbWVzcGVjIHJl
cSA9IHsgMCwgKGJ1ZmZlcl9zaXplIC0gc25kX3Jhd21pZGlfc3RhdHVzX2dldF9hdmFpbChzdCkp
ICogMzIwICogMTAwMH07CisJCQkJbmFub3NsZWVwKCZyZXEsIE5VTEwpOwogCQkJCXNuZF9yYXdt
aWRpX3N0YXR1cyhvdXRwdXQsIHN0KTsKIAkJCX0gd2hpbGUoc25kX3Jhd21pZGlfc3RhdHVzX2dl
dF9hdmFpbChzdCkgPCBidWZmZXJfc2l6ZSk7Ci0JCQl1c2xlZXAoc3lzZXhfaW50ZXJ2YWwgKiAx
MDAwKTsKKwkJCXN0cnVjdCB0aW1lc3BlYyBzeXNleCA9IHsgMCwgc3lzZXhfaW50ZXJ2YWwgKiAx
MDAwICogMTAwMH07CisJCQluYW5vc2xlZXAoJnN5c2V4LCBOVUxMKTsKIAkJfQogCiAJCS8qIGZp
bmQgZW5kIG9mIFN5c0V4ICovCmRpZmYgLS1naXQgYS9iYXQvYmF0LmMgYi9iYXQvYmF0LmMKaW5k
ZXggODY0NTc3MC4uMjdlN2EzNCAxMDA2NDQKLS0tIGEvYmF0L2JhdC5jCisrKyBiL2JhdC9iYXQu
YwpAQCAtMTc2LDYgKzE3Niw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfbG9vcGJhY2soc3RydWN0IGJh
dCAqYmF0KQogCXB0aHJlYWRfdCBjYXB0dXJlX2lkLCBwbGF5YmFja19pZDsKIAlpbnQgZXJyOwog
CWludCAqdGhyZWFkX3Jlc3VsdF9jYXB0dXJlLCAqdGhyZWFkX3Jlc3VsdF9wbGF5YmFjazsKKwlz
dHJ1Y3QgdGltZXNwZWMgY2FwdHVyZV9kZWxheSA9IHsgMCwgQ0FQVFVSRV9ERUxBWSAqIDEwMDAg
KiAxMDAwIH07CiAKIAkvKiBzdGFydCBwbGF5YmFjayAqLwogCWVyciA9IHB0aHJlYWRfY3JlYXRl
KCZwbGF5YmFja19pZCwgTlVMTCwKQEAgLTE4OCw3ICsxODksNyBAQCBzdGF0aWMgdm9pZCB0ZXN0
X2xvb3BiYWNrKHN0cnVjdCBiYXQgKmJhdCkKIAogCS8qIFRPRE86IHVzZSBhIHBpcGUgdG8gc2ln
bmFsIHN0cmVhbSBzdGFydCBldGMgLSBpLmUuIHRvIHN5bmMgdGhyZWFkcyAqLwogCS8qIExldCBz
b21lIHRpbWUgZm9yIHBsYXlpbmcgc29tZXRoaW5nIGJlZm9yZSBjYXB0dXJpbmcgKi8KLQl1c2xl
ZXAoQ0FQVFVSRV9ERUxBWSAqIDEwMDApOworCW5hbm9zbGVlcCgmY2FwdHVyZV9kZWxheSwgTlVM
TCk7CiAKIAkvKiBzdGFydCBjYXB0dXJlICovCiAJZXJyID0gcHRocmVhZF9jcmVhdGUoJmNhcHR1
cmVfaWQsIE5VTEwsICh2b2lkICopIGJhdC0+Y2FwdHVyZS5mY3QsIGJhdCk7CkBAIC02OTEsNyAr
NjkyLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJCX0KIAogCQkJLyog
V2FpdGluZyA1MDBtcyBhbmQgc3RhcnQgdGhlIG5leHQgcm91bmQgKi8KLQkJCXVzbGVlcChDQVBU
VVJFX0RFTEFZICogMTAwMCk7CisJCQluYW5vc2xlZXAoJmNhcHR1cmVfZGVsYXksIE5VTEwpOwog
CQl9CiAJCWdvdG8gb3V0OwogCX0KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
