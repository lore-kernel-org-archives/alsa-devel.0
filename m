Return-Path: <SRS0=5Ozn=7Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B5C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:26:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC0320734
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U7YIaLCB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXGkfR/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC0320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC8EC1614;
	Wed,  3 Jun 2020 11:25:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC8EC1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591176368;
	bh=T2Baua1ji97VefGilqXTRLjZ/rALTAyMHM/Zkkrg/1Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U7YIaLCBhk5Ddfby2u2zUQRZBWM+DLlQQIokr3gdknvR3O/ueVSPxIQ9USv8MBfK7
	 w+zmk5fbu9CJg7iIh/kSsGK56afcsmij29COjgJwM86AUQfx2L8TGriJMLWntKyOi1
	 BfFttkOQTYr5u9H57rR1UNxoy8c0rFNEhFx7AwuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 507A6F801EC;
	Wed,  3 Jun 2020 11:25:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB011F801ED; Wed,  3 Jun 2020 11:25:16 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B894EF800BC
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2020 11:25:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B894EF800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="vXGkfR/7"
Received: by mail-pg1-x544.google.com with SMTP id 185so1340486pgb.10
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2020 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h9GWHN/DvK6JVin1rcNjThobH5dDbmXKSSUaeKlXzRE=;
 b=vXGkfR/7XSismMTy2xpUY5NzSV5dRMg7Guk1ZLQycKkPBte420Yl461lMIv/rglXKh
 w4il0wt8H6u5mGEF8JOzcWDpDIQauqQBF5XK7V+X7Q8ijutPrNAxUElJTbjfstPLLq29
 a8xzgCZGiK6K7QcxTlfOsI9ezP1PmXcn9ADWOaFeMXco2LIBgvGBEBZE3ZK782mUyJm1
 U9pEifOCdt5b8+46i0+Rf4sSaMk8Pji9J/TlxZcafoR3Luj+ltt+lx13AwdwgmKeSgH/
 O6janjDQ7zW+cPm3/nTTIDbDZk0xScqllUC+VgMJtvcQe68+ZxdKmltNxbU+VngFsjlK
 UTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h9GWHN/DvK6JVin1rcNjThobH5dDbmXKSSUaeKlXzRE=;
 b=IzfpgH4IawVHNls/kKa3pXeGXjgv6Goa8dOr6o3e6pJd8dA6E3DwcuiEc0r4+J28sg
 LAklJzAp4qkToj9vi9ljP+Yp9vmPLxSqAz/jD0Oek+m524mwiaatyB63WzeHRccF4op0
 CWtySf9Uj+8f5HvRZi43K3So9BWQydrAHQPLlaVqrlr5CehQcvzAaIJBhwMh/g9VoQKh
 uJ8RGfJ/xQ5LedODu8l1ikrv4QhJIpQLQ6KnsGQHrF882+nouRfbo5OJMF7xz3+Vvbld
 MuGPz+bppKwo0vb97Gl8w47hfGuQ1TlG02OqzCXJYkC1B0sC762nzuHU9W55bh3aRh4L
 HO3g==
X-Gm-Message-State: AOAM531C5s3E1jZUex9X1hSMDttqCVoDjfj9w9d2ccvhdmF55hSNVTtS
 TfyaN2i9ZK8ReFfiohcaZM0=
X-Google-Smtp-Source: ABdhPJxQJFUYXkI0isRKjX5Mhc1Yo7lqwg+c3t7XD2aFMg2edgicu2ExjwQ4hRDFq6zPrhjSBucpuw==
X-Received: by 2002:a63:4b55:: with SMTP id k21mr28425585pgl.46.1591176309952; 
 Wed, 03 Jun 2020 02:25:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.gmail.com with ESMTPSA id h21sm1945710pjz.6.2020.06.03.02.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 02:25:09 -0700 (PDT)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH] ALSA: es1688: Add the missed snd_card_free()
Date: Wed,  3 Jun 2020 17:24:59 +0800
Message-Id: <20200603092459.1424093-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, alsa-devel@alsa-project.org,
 Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

snd_es968_pnp_detect() misses a snd_card_free() in a failed path.
Add the missed function call to fix it.

Fixes: a20971b201ac ("ALSA: Merge es1688 and es968 drivers")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/isa/es1688/es1688.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index ff3a05ad99c0..64610571a5e1 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -267,8 +267,10 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 		return error;
 	}
 	error = snd_es1688_probe(card, dev);
-	if (error < 0)
+	if (error < 0) {
+		snd_card_free(card);
 		return error;
+	}
 	pnp_set_card_drvdata(pcard, card);
 	snd_es968_pnp_is_probed = 1;
 	return 0;
-- 
2.26.2

