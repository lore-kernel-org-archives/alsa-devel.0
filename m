Return-Path: <SRS0=92Yh=F6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C1C433E6
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:39:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9012184D
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9012184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F3B41837;
	Sat, 26 Dec 2020 22:38:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F3B41837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609018759;
	bh=r+AAtXu9uVUHjLS6lWZ+FjSayfR8Pc+/Z3uMLtxL4xE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t8qLuVXDOnMXa11c52uVmvvjHtMu68AwYutjw8pfq6bKeJQybPcc27TFv3/3M3M96
	 va/4C0Hn+74osRgWp/T4D3MTFLzj+B4gER5e0zd7EkLFsNjegw7UG0bnjqyrMZb/A5
	 +Elm9FhmZNolgNM1Yw4gRaa5R2cbAuuZ8lJIJ6Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D682F804CA;
	Sat, 26 Dec 2020 22:36:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 131ECF804C1; Sat, 26 Dec 2020 22:36:40 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 192FCF800C8
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 22:36:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 192FCF800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XQ7sy9+R"
Received: by mail-pg1-x52a.google.com with SMTP id i5so5057006pgo.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uikd2d1f0O9TMn/hgiaFkHgpit9JCJ+1iQ2EccHa8vs=;
 b=XQ7sy9+RlZSxBDdR1diJHNmmzE8CP5TkR8NBisXljYpQFg0P7iluwBtTlQAOaXk4me
 A9oH81Ll/up00Ku1BCl5VdSwox+KloI3oTOMlg35P+PpbNO6DE8QoVHzpFbNirEP8d0O
 c8e4FnNubT7XvgXg17fg9ig0Vlx+8cIa5lia/49dzKJIpKg7ZP1mgU+LXO+oaGUObzni
 SjDdK2BrObrDT2hw1WYOkVnwc+BUyp/KSCReoGXQRwcwPPE2WiPd36cmLwrrB2G2ymha
 nLTJI4Kwizu0ghg+V4PmvzFlJ1rWjJ+1/0lZhmkSPJYDngGe2cQDsVskLSvcmj1NTwUq
 bbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uikd2d1f0O9TMn/hgiaFkHgpit9JCJ+1iQ2EccHa8vs=;
 b=gRcwbn1zoQL+dw3iFMce8HnzJ1OLZWjnGATVCvycWdX2bb/1TsKnzhT34RjFssUFEO
 eCb4NO8VKShuPwKNdhTYbZ2SjURMUlSzOauxISWagmLdYyJX4xcV+ZLQE7RiBjeQP4hh
 7ExIKSDMVHhN8ettK7VEwwoBPM3Joa6CPZ4gFbn6HJqqDtyyg+vEeHbBjXLB2UhowGdK
 0EPNLtadOS7S8Q7tNzgLPBBHYcpRCwdPHzDyEIAdhC8QEfwqCOTmwzt2cKwMao2HlC59
 6BIC2tfFLnFGxI9NpCUY4xqwt5O1uTWzzj5ygCoAP7r1wzXVfYNbyyxIEc+Za8VOdVMo
 HuBA==
X-Gm-Message-State: AOAM532VywxXFAU6+caquf6o2DdYeUkLElPpwFGEdFbozjt7tuGeCcxk
 ZNddse4cqsOUJ5bD12XX/tcxYN8A+lKYDQ==
X-Google-Smtp-Source: ABdhPJyA9A3ZGhs7vj0jri5DwutWZUOWrnUO7i8av0i7FJCv5PWvdM/2TDt5xwO6ekdqRJNR8ql+dQ==
X-Received: by 2002:a62:64d2:0:b029:19e:662e:5e99 with SMTP id
 y201-20020a6264d20000b029019e662e5e99mr35052463pfb.17.1609018586093; 
 Sat, 26 Dec 2020 13:36:26 -0800 (PST)
Received: from viper.bn-i.net ([2001:470:b:65c:b92f:8d47:b3dd:6388])
 by smtp.gmail.com with ESMTPSA id b12sm30990560pft.114.2020.12.26.13.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Dec 2020 13:36:25 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.de
Subject: [PATCH 1/9] conf: fix use after free in _snd_config_load_with_include
Date: Sat, 26 Dec 2020 14:35:39 -0700
Message-Id: <20201226213547.175071-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.29.2.368.ge46b91665e.dirty
In-Reply-To: <20201226213547.175071-1-alexhenrie24@gmail.com>
References: <20201226213547.175071-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Henrie <alexhenrie24@gmail.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 src/conf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/conf.c b/src/conf.c
index 7df2b4e7..44d1bfde 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -1970,7 +1970,9 @@ int _snd_config_load_with_include(snd_config_t *config, snd_input_t *in,
 		SNDERR("%s:%d:%d:%s", fd->name ? fd->name : "_toplevel_", fd->line, fd->column, str);
 		goto _end;
 	}
-	if (get_char(&input) != LOCAL_UNEXPECTED_EOF) {
+	err = get_char(&input);
+	fd = input.current;
+	if (err != LOCAL_UNEXPECTED_EOF) {
 		SNDERR("%s:%d:%d:Unexpected }", fd->name ? fd->name : "", fd->line, fd->column);
 		err = -EINVAL;
 		goto _end;
-- 
2.29.2.368.ge46b91665e.dirty

