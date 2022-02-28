Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303CBC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 05:01:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2010A16FF;
	Mon, 28 Feb 2022 06:01:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2010A16FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646024511;
	bh=ouHChIiSl2vX78TvvE/Ul3EbXu7SFvvD4uRGjJrtHTw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oRZbkO+lYSI1s11U2dDILqoOKi9t6w/BEKEYkb5OB5hQP+9st8H1Vc+tYhs67ZiGd
	 uOd3BQ+GXSMRbFioSsVzemMMWlYyBHgQXaRQiCFMK8fzF6IN83xLP964H2YtV8+kQ1
	 /hQyIcDDtdZdHh5emDwlMLiM4pnFkInIiNC5+3GQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 957D8F8025C;
	Mon, 28 Feb 2022 06:00:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A155EF80054; Mon, 28 Feb 2022 06:00:26 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC489F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 06:00:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC489F80125
X-QQ-mid: bizesmtp65t1646024411tgnc47i6
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 28 Feb 2022 13:00:05 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000B00A0000000
X-QQ-FEAT: b/pVLV+mlKhsaxZlA0xX19TWfTydP5ZCFMRVs9EBdNBpgM4KL2t4c2RDxtTgF
 ZWU/PqiF1L74EuBZ8JmCWRQaxgd3RCkJS6k4t8BZuxEOaGbNQCXBZmftjxOeGKyUewp36ro
 XB+5MMHRLBJpTU5QK+tHHsZJ17eTlkGEu7jUBY+s2gDGWJ4Cnyq5nYeCzaJ5NIKHRWQsd3V
 Pqyz6MHtYoYrDcgBJgTnf/FHX6o75LvPHIBUTTNUurixGqJ46INLMEAVi9uaI4GGRlXlLFk
 rieQ8JReScz6n8qgswVUFNR1P++2e2Yb47jRzC776LQqDjmKpLaavwUIABniEmOZMAGLoug
 h9t9YiFYKvlqyormH+H8zNvj/hDQEm5TsJuPebiAd/gOv6GFGk=
X-QQ-GoodBg: 2
From: Meng Tang <tangmeng@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v3 1/2] ALSA: core: remove initialise static variables to 0
Date: Mon, 28 Feb 2022 13:00:02 +0800
Message-Id: <20220228050003.32509-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Cc: JOE Perches <joe@perches.com>, Meng Tang <tangmeng@uniontech.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Initializing the static variable to 0 causes the following error
when exec checkpatch:

ERROR: do not initialise statics to 0
FILE: sound/sound_core.c:142:
static int preclaim_oss = 0;

In addition, considering the following way of writing
139: #ifdef config_sound_oss_core_preclaim
140: Static int preclaim_oss = 1;
141: #ELSE
142: Static int preclaim_oss = 0;
143: #ENDIF
We can optimize it by IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM),
so modified it to
static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Signed-off-by: JOE Perches <joe@perches.com>
---
 sound/sound_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd9164..aa4a57e488e5 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -136,11 +136,7 @@ struct sound_unit
  * All these clutters are scheduled to be removed along with
  * sound-slot/service-* module aliases.
  */
-#ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
-static int preclaim_oss = 1;
-#else
-static int preclaim_oss = 0;
-#endif
+static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);
 
 module_param(preclaim_oss, int, 0444);
 
-- 
2.20.1



