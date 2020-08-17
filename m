Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE7C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE852072D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g4cnIHiZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyNFTefB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE852072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB8316B1;
	Mon, 17 Aug 2020 11:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB8316B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597656187;
	bh=GFfAbFKZ1kPka9ZIhpFG5rPh420Kibyp3R9JkLhZrIE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g4cnIHiZYjVaVOe1AAFL6iY15XWMNOEfwUbxi+kRXUkh1PLA80Au2zhgz8yrj4NH6
	 Ofhe5H/M2PHm077bxfdKDIvaOlwwZoWU8aW5YYwPt3FwvNWiumauPqGQsJ8BgK2mLN
	 Sfj1lBM/bk8ay6pIjORONiH0CIYg4Aq9EpLDnfR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B73EF802FD;
	Mon, 17 Aug 2020 11:17:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA526F80255; Mon, 17 Aug 2020 10:58:07 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F88EF800EF
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 10:58:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F88EF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OyNFTefB"
Received: by mail-pl1-x644.google.com with SMTP id g7so6038345plq.1
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=upmEUnhhDdxgVkgtOGQcHXFVgTj9nyWc06FqARMGISM=;
 b=OyNFTefB9dsBDrJk4+b3/O9xDgCkBGYAZEtl8e1sFe8eqB+0z37g1bXuaGh5Rz/mOV
 Vu9xGEY1MYjz55jhlzbwsAahCtRbdTz3TmGBn7sQxztPqM7rTG+RzjI3Oiny8RejrZuR
 CcmoL/IjRiGZ+ssZ2n0xgb+pW4Z6Lea77AxG5cveoSTlnxxqUI7fbOJagqytds6FoNFo
 1itqsHARb9BlloVmjtqZv2KTHfwoy66YYWvv6YpBzgnvUwBIky4PzzfF4Ms719j3PL/i
 QUcVdpfYvYncsl7g9tvyZcNhfOVL8zhRmQ4Bm1y4PBi86/ARuEB3MdIQHbhmEwr5gUVt
 g9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=upmEUnhhDdxgVkgtOGQcHXFVgTj9nyWc06FqARMGISM=;
 b=gFsJ+3k/W/wnxI0v3zEcHewjn4muwGZms+WCXqDQMg0Y3/Bpl0CYa0dPYsDLsLu8nN
 iMV4Eojh9r/78uEaj+Yx3XmkdvBHZ+Aoc3nzjcgPDED8JWxAAbjB5xEhyODAWfBCGHux
 gi0E7+rp9Fj0cTKteuR3qc9o/qRU9woHb5MWSdrNszMPlXFLO/u/+tRCxeya6lj3rnpD
 c+BTidKhWgJgTFTtsaOHPMeJjx7vE0RFxtlzmuevkSSQTyu8TH/lSWKz/Nn0fnPwXmnR
 W1E68Q94tyyswsLQNic9CYxoUN/TOD2Jsd+7CrLqtnTdx5Ua8/ZpvnNIUKLiFaWXoLFv
 oeHA==
X-Gm-Message-State: AOAM5309T8Xso62VxZB0bSSuOQ26I1k1SNWk+YMv+EP7XoB+IcTfDRtC
 d4oikNJvwAUmV0uBgTR+Ays=
X-Google-Smtp-Source: ABdhPJy7woL4CHSE/M6HLZYby07kKJL7B6uvdb2M5oCEkFLXCvckJ3TLTnOJ9pzsBst4THF5+GoOoQ==
X-Received: by 2002:a17:902:ee02:: with SMTP id
 z2mr10362445plb.291.1597654679016; 
 Mon, 17 Aug 2020 01:57:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:57:58 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 07/10] sound/soc: sh: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:27:00 +0530
Message-Id: <20200817085703.25732-8-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085703.25732-1-allen.cryptic@gmail.com>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
X-Mailman-Approved-At: Mon, 17 Aug 2020 11:17:21 +0200
Cc: alsa-devel@alsa-project.org, keescook@chromium.org,
 Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org
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

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/soc/sh/siu_pcm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index bd9de77c35f3..50fc7810723e 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -198,9 +198,9 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
 	return 0;
 }
 
-static void siu_io_tasklet(unsigned long data)
+static void siu_io_tasklet(struct tasklet_struct *t)
 {
-	struct siu_stream *siu_stream = (struct siu_stream *)data;
+	struct siu_stream *siu_stream = from_tasklet(siu_stream, t, tasklet);
 	struct snd_pcm_substream *substream = siu_stream->substream;
 	struct device *dev = substream->pcm->card->dev;
 	struct snd_pcm_runtime *rt = substream->runtime;
@@ -520,10 +520,8 @@ static int siu_pcm_new(struct snd_soc_component *component,
 		(*port_info)->pcm = pcm;
 
 		/* IO tasklets */
-		tasklet_init(&(*port_info)->playback.tasklet, siu_io_tasklet,
-			     (unsigned long)&(*port_info)->playback);
-		tasklet_init(&(*port_info)->capture.tasklet, siu_io_tasklet,
-			     (unsigned long)&(*port_info)->capture);
+		tasklet_setup(&(*port_info)->playback.tasklet, siu_io_tasklet);
+		tasklet_setup(&(*port_info)->capture.tasklet, siu_io_tasklet);
 	}
 
 	dev_info(card->dev, "SuperH SIU driver initialized.\n");
-- 
2.17.1

