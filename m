Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C46C433E6
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:06:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406742068E
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kcQPP3+D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjgsXOg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406742068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB6ED1840;
	Wed,  2 Sep 2020 06:05:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB6ED1840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599019572;
	bh=x93pgomIBkVJcZhajgAt9oPhkSzzXzyHRpYhezI0NyQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kcQPP3+DbaMc5jDTydCfvT5AhNgyXp6DDebmgbdJkT1aa9uqqR8VD904RwbxqUzZG
	 UdqoNcyF1GSUetPoSYhj/WwxFJMry5+9N1DTJnIXiLC1tNG/+lmLMletTU6Y9eJhPb
	 kGCjRWTgsUSK/UA9EilcA2ecaOO7Aedwy40SeymQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AF61F802EA;
	Wed,  2 Sep 2020 06:02:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96DDEF802E8; Wed,  2 Sep 2020 06:02:56 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FFCFF802DF
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 06:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FFCFF802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TjgsXOg5"
Received: by mail-pl1-x642.google.com with SMTP id l9so1650915plt.8
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hszyES/Fl/Gw5AGYyyoWQldbZRH+o5Xzr54HG49ANFU=;
 b=TjgsXOg55yX9RAn8hTjPVDok97aH/aE/uvSPSjMNXF9j7Oe7EXHHAYXaHiZXr21uYB
 b88451DV6dwr/5Cr3Y87lJXwnNdsRFJdigYuwvyaM+uzU0LkE91EpRb880szRR93DX+t
 jE+T1I+NAjsckfnmwd/SxFdtNxmiqzbFS6GEwziyy1E+fyHJEuwx+R8KY3yLmbVE8BUm
 y3taJo57lv0vECQk6mUKQsdY82lcnhkG39WUka07JlcBE7nqdZNps9dj2hxsiE6G69dB
 HrlwrCh7BGPi5PpI3ZcffNBovw3BuHPTzZ+0R5/JXrWes5BubW/Wu2sadm9nRWeaynbq
 Gmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hszyES/Fl/Gw5AGYyyoWQldbZRH+o5Xzr54HG49ANFU=;
 b=nU790zqq50yG3po9RpNiz9Ay2Ub2tNZmN9qdKkZVX9PFYOhepiANmFzy2S52ySdAyL
 5J8QOSlfSiRkuduNCLzZqxghVqUharuvP5wWoK/VqM/7IrteATjpZDynD6iTeiib83MA
 XqXmkLmqOk3N4gCXG2cuj5PkbnymVuqkjHbjL1U8xXBpqxwX5M7OGkolOwoSoNOremHH
 Z3ISnkQPsKxPadXv9c69VfXAn8aNp2LvH72AOZ6zDCsF1q3fJKQluoIkbqhYfVao+8VM
 SUNj8dV0u9ctENnaHiNieqq4CgN9hPQsWLqgaET+eYg0j/vmSbZr8mzSurtzM+Esa8kL
 TwAA==
X-Gm-Message-State: AOAM530amx67b4VpX+c7mbWQukMXG4Y0hg3lvzi/ysAxyUnTM74UKJJh
 RtrGlBnOrkj/wG+108niy78hrVYZvxDW3A==
X-Google-Smtp-Source: ABdhPJx2dpNYmH7xmBm33vvi67A1Ibu1x1+BBcAF4mDU3sZ7Nv5R+QFauyGsMrXk9uB2yt/Vpc9JFg==
X-Received: by 2002:a17:90a:8402:: with SMTP id
 j2mr461268pjn.153.1599019366292; 
 Tue, 01 Sep 2020 21:02:46 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
 by smtp.gmail.com with ESMTPSA id q71sm3058350pjq.7.2020.09.01.21.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 21:02:45 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org
Subject: [PATCH v2 04/10] ALSA: riptide: convert tasklets to use new
 tasklet_setup() API
Date: Wed,  2 Sep 2020 09:32:15 +0530
Message-Id: <20200902040221.354941-5-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902040221.354941-1-allen.lkml@gmail.com>
References: <20200902040221.354941-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 clemens@ladisch.de, Allen Pais <allen.lkml@gmail.com>, nicoleotsuka@gmail.com,
 Romain Perier <romain.perier@gmail.com>
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

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/pci/riptide/riptide.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b4f300281822..098c69b3b7aa 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1070,9 +1070,9 @@ getmixer(struct cmdif *cif, short num, unsigned short *rval,
 	return 0;
 }
 
-static void riptide_handleirq(unsigned long dev_id)
+static void riptide_handleirq(struct tasklet_struct *t)
 {
-	struct snd_riptide *chip = (void *)dev_id;
+	struct snd_riptide *chip = from_tasklet(chip, t, riptide_tq);
 	struct cmdif *cif = chip->cif;
 	struct snd_pcm_substream *substream[PLAYBACK_SUBSTREAMS + 1];
 	struct snd_pcm_runtime *runtime;
@@ -1843,7 +1843,7 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	chip->received_irqs = 0;
 	chip->handled_irqs = 0;
 	chip->cif = NULL;
-	tasklet_init(&chip->riptide_tq, riptide_handleirq, (unsigned long)chip);
+	tasklet_setup(&chip->riptide_tq, riptide_handleirq);
 
 	if ((chip->res_port =
 	     request_region(chip->port, 64, "RIPTIDE")) == NULL) {
-- 
2.25.1

