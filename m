Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9812C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 10:37:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B2660FC0
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 10:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19B2660FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B6A17D3;
	Wed, 28 Jul 2021 12:36:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B6A17D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627468626;
	bh=sCLElTKWTaBz5laViNx3qfrphPXuOGVNigCLfoKIQBU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uh5EYdXdVm7HQh/Zs1QU58tWuOcwru2/FWxR4zrebwTS331Xa63DBhX7xECtiS+0f
	 rN2rdcVYmuLKl/nkaS3A0BWJFpA/8aMPlZDbC17GixGd10X5poJs2dyCDJkokXB15K
	 Ilfmsha+vSbqKhAaaf5Fl1RCEkG3YI93bLQPkRmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D922F80253;
	Wed, 28 Jul 2021 12:36:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4BFDF8025A; Wed, 28 Jul 2021 12:36:13 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDC92F8020D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 12:36:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDC92F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="T6Y2Wsac"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 286E63F245; 
 Wed, 28 Jul 2021 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1627468564;
 bh=X0DrZSFLZf175Lh2Gia6ktHZuwvpS8paTwWSPxV8GHA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=T6Y2WsacwjCrVOGIAr0Do6u3JceM7xIZX3vQxqhljqaU74Qw8MZf9tQobWPEnxyTX
 1emVK4+0r/5KP+BzYfWjEo/QG0dv5rm3Y0jJigCN5qLXd8DiM7eVbNKxpXJI4AteuR
 NLsta805WyClfdupYkSPOBbQTHbYNtWyPoY8h2gJroexvxJOX6KWsTSY0kh0ghVPCR
 eRxc8Y9JNozJ7ZQQVAU1MgHf3GvgbsmHIpoubS7RC7k4m598VZIpCLoP17M1dk4NyT
 FFDZDM4o5kUgEa5u6AwVUYdQDQdkLg42eZtUqEhKqBcmF1/3XOgpoMxt353ZwkRYpI
 uGemIUG0atygA==
From: Colin King <colin.king@canonical.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
Date: Wed, 28 Jul 2021 11:36:02 +0100
Message-Id: <20210728103602.171817-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index a8a9aa0057d3..4e8382097e61 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -128,7 +128,7 @@ int sst_post_message_mrfld(struct intel_sst_drv *sst_drv_ctx,
 		while (header.p.header_high.part.busy) {
 			if (loop_count > 25) {
 				dev_err(sst_drv_ctx->dev,
-					"sst: Busy wait failed, cant send this msg\n");
+					"sst: Busy wait failed, can't send this msg\n");
 				retval = -EBUSY;
 				goto out;
 			}
-- 
2.31.1

