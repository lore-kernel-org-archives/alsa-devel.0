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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A79C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:40:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE3E2184D
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3E2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CAE817E2;
	Sat, 26 Dec 2020 22:39:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CAE817E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609018799;
	bh=sPskISSkHf67G79XiidFSR9sYjMVxWX29MR7q19iVRE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9lK2BCDPMdvi5yk0KCzGuLOg+Z9NuguRwfzofJQ40DEPJQp6kJatztXXQmepJGqu
	 GgINaPExoXSLlPBEDgNgVVk8vPcHhrm6cs6loDwWmDbz57uOX8al3ybCN45nLcjELv
	 QUkiZ68BHkdF+TlhChp52Iz0FI1mTPR6Wl2jDCgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42404F804E0;
	Sat, 26 Dec 2020 22:36:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79D7FF804B3; Sat, 26 Dec 2020 22:36:42 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 304DCF8021D
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 22:36:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 304DCF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Hw31J2lc"
Received: by mail-pj1-x102f.google.com with SMTP id m5so4374578pjv.5
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 13:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KNxKH7kPT8D5/vzKIanSIdnixFhHf6LxdF+kDOphzzQ=;
 b=Hw31J2lck1Mv9PKOhzuZyGaQcQIrBy8gWfmYr3CZbut8eGVU7WduZRzOtbCyerv+s6
 gTjJzt9jpXpuwCz2sFpYrDS2SlP5GMzhesa3ays7j+0HNgY94Ck7QaSQeanUCKgyJ2WL
 674k4bIvoS6FfSFmUX3+4SbhVGRYcw15ydA4SAO/owjl/f+5CbmaiEb5ncdO1eiNOUqP
 G9g+hsbtIEafeFWcen/jHn+WeO0ZEILrhHgME+QdDHxPpsHz0hOgxKuHYgEN2+WXs2gU
 4uGueGHPpYfy1xkDieeMU8FgI73DAnEnPv+WB+30A79I6nSMhEw92PYkBwr3kKeuIoDY
 X+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KNxKH7kPT8D5/vzKIanSIdnixFhHf6LxdF+kDOphzzQ=;
 b=QmOJEZK2JP/0+ZA7Y1OjboRr4mUhpcvNdNQBB1X7XeDrmOdy+I2gH6+fo+rCMV/IU5
 J517QlgrehlNtt4J2G4JlK4I4SSz9V+rNfpt80V2VpFCbwczpCptOnv4xtBwFJWCxsKA
 RP9STq/TxOzuLaCOIjsbj6rE5ww5mr0GexkDyM+cv7DU+RqqG7vCBnKkB4E91qhbgiWa
 C4n34F8APpFiJiu1emPWQxKiFkC++fhP2v5X03Pr+ZmHcrM3J2yCA8kNmnvHv2gTAc3r
 59Be9sgPXBuDJ4yMyQKjqCK3XnWVsl6itT5wvJFPTqXiVZRU/f2BcQ1578xdMZ74+P3/
 Xw/Q==
X-Gm-Message-State: AOAM532Pzvp2AhOX1UMX2bWy0ikARB1f1DzABAx6PTJmqLqblPBKN6N4
 nmpYCYcPnT6DO6+4Vm2f/Dd9u5Fm2aAx3g==
X-Google-Smtp-Source: ABdhPJzJNbCJz9GV5pjgQIewG3tTHjBE+uwZcpR4A/hnAuFlgyux2M09hIP/L9aRDW4kP1HqbFEVwA==
X-Received: by 2002:a17:90b:4b06:: with SMTP id
 lx6mr13996160pjb.224.1609018592703; 
 Sat, 26 Dec 2020 13:36:32 -0800 (PST)
Received: from viper.bn-i.net ([2001:470:b:65c:b92f:8d47:b3dd:6388])
 by smtp.gmail.com with ESMTPSA id b12sm30990560pft.114.2020.12.26.13.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Dec 2020 13:36:32 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.de
Subject: [PATCH 5/9] timer: fix sizeof operator mismatch in
 snd_timer_query_hw_open
Date: Sat, 26 Dec 2020 14:35:43 -0700
Message-Id: <20201226213547.175071-6-alexhenrie24@gmail.com>
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
 src/timer/timer_query_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/timer/timer_query_hw.c b/src/timer/timer_query_hw.c
index dad228c8..d8bac6e7 100644
--- a/src/timer/timer_query_hw.c
+++ b/src/timer/timer_query_hw.c
@@ -104,7 +104,7 @@ int snd_timer_query_hw_open(snd_timer_query_t **handle, const char *name, int mo
 		close(fd);
 		return -SND_ERROR_INCOMPATIBLE_VERSION;
 	}
-	tmr = (snd_timer_query_t *) calloc(1, sizeof(snd_timer_t));
+	tmr = (snd_timer_query_t *) calloc(1, sizeof(snd_timer_query_t));
 	if (tmr == NULL) {
 		close(fd);
 		return -ENOMEM;
-- 
2.29.2.368.ge46b91665e.dirty

