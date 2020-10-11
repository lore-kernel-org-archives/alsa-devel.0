Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D77C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:04:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCB62083B
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H6c0zBCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCB62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 970721676;
	Sun, 11 Oct 2020 12:03:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 970721676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602410674;
	bh=ZkWmRGsAOCl71k2jWUZZg/QznK7wxX+MsjCMWCjCyOo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H6c0zBCmV9JlupxrCTK10LYaPTlZvB7DJNGKYB4mx34fVoyd70RhGVr0D5MTS5P4P
	 ljKLsS5ylJa6XrngnTs4AeqJ4UW49onJ/IMU1vKSk2BgqGLPvCOyRSrUYVqC6Y2bxk
	 EInOB5ppAvbGCVEiiQUQ5ELb3ouuYQLXV2PUZ08o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FE4EF8026B;
	Sun, 11 Oct 2020 12:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76717F80268; Sun, 11 Oct 2020 12:02:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63D65F8013C
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 12:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63D65F8013C
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; d="scan'208";a="471981618"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 11 Oct 2020 12:02:41 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/8] ASoC: wm8350: use semicolons rather than commas to
 separate statements
Date: Sun, 11 Oct 2020 11:19:32 +0200
Message-Id: <1602407979-29038-2-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
Cc: alsa-devel@alsa-project.org,
 =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
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

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/codecs/wm8350.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index a6aa212fa0c8..15d42ce3b21d 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -218,7 +218,8 @@ static void wm8350_pga_work(struct work_struct *work)
 
 	/* PGA volumes have 6 bits of resolution to ramp */
 	for (i = 0; i <= 63; i++) {
-		out1_complete = 1, out2_complete = 1;
+		out1_complete = 1;
+		out2_complete = 1;
 		if (out1->ramp != WM8350_RAMP_NONE)
 			out1_complete = wm8350_out1_ramp_step(wm8350_data);
 		if (out2->ramp != WM8350_RAMP_NONE)

