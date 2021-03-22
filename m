Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA12C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 10:32:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9691619A0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 10:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9691619A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3005F9F6;
	Mon, 22 Mar 2021 11:31:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3005F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616409155;
	bh=0gwjaGh2QNNtiYFZp+OcuO3B2CPc4ZEG93Au7ykg3Xw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NXFctIBWr0V+IqwrwTzyDT8VzszswtVYi5cXBq+Bu3nB0Mv6ghkvrcXcxWVnu8mAt
	 4va5zmF9C07YUIjxfunTnn6ulaGzeIvoAxR1o0gV58r9ej8pt/XVbcGZCC93VA8m3s
	 qadSJa6K2d0qk+T39v4Idbesr1wud3Hk+QWN4O6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA50BF80156;
	Mon, 22 Mar 2021 11:31:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 929F2F8016B; Mon, 22 Mar 2021 11:31:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B499F80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 11:31:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B499F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GUjfLL2U"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A02BF6198F;
 Mon, 22 Mar 2021 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616409091;
 bh=0gwjaGh2QNNtiYFZp+OcuO3B2CPc4ZEG93Au7ykg3Xw=;
 h=From:To:Cc:Subject:Date:From;
 b=GUjfLL2U3oXbElSPWKJcICyjNmRVGK2FtlGfiTlN8mAMgQ3x7YCJhNOm11PbjqAFm
 6L0D7bT8llSYRXlJZgRGKe77Bf/jfpb5g5jpkifS8gypR+oxd23jCiSYTvLkR9jKXh
 HNDKeLCDuS2She8u34z1SerJByUMaiaLnycbY6o4XF33MNj1+UfALXIlVnCglBkclI
 /oF4HXVBlW3C7vK2Ko6TFQiTltjWghwckuxiLW/i2mQHykj5zT04JGsIb1xRxsO5fI
 6Rq6DKUo0TxDLkcz8cIbt7tSRzQBSI27fOXod5Rm9znnvDbeJNBDaICRC71wofnEfX
 WsICWwOS2dpkA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: core: avoid -Wempty-body warnings
Date: Mon, 22 Mar 2021 11:31:10 +0100
Message-Id: <20210322103128.547199-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
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

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows some warnings about empty function-style
macros:

sound/core/pcm_memory.c: In function 'preallocate_pages':
sound/core/pcm_memory.c:236:49: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  236 |                 preallocate_info_init(substream);

sound/core/seq_device.c: In function 'snd_seq_device_dev_register':
sound/core/seq_device.c:163:41: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  163 |                 queue_autoload_drivers();

Change them to empty inline functions, which are more robust here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/oss/pcm_oss.c |  8 ++++++--
 sound/core/pcm_memory.c  |  4 +++-
 sound/core/seq_device.c  | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 142fc751a847..86c39ee01aaa 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -3069,8 +3069,12 @@ static void snd_pcm_oss_proc_done(struct snd_pcm *pcm)
 	}
 }
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
-#define snd_pcm_oss_proc_init(pcm)
-#define snd_pcm_oss_proc_done(pcm)
+static inline void snd_pcm_oss_proc_init(struct snd_pcm *pcm)
+{
+}
+static inline void snd_pcm_oss_proc_done(struct snd_pcm *pcm)
+{
+}
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
 /*
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 289dd1fd8fe7..c440f67b34a3 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -210,7 +210,9 @@ static inline void preallocate_info_init(struct snd_pcm_substream *substream)
 }
 
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
-#define preallocate_info_init(s)
+static inline void preallocate_info_init(struct snd_pcm_substream *substream)
+{
+}
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
 /*
diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index 7ed13cb32ef8..382275c5b193 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -133,10 +133,19 @@ void snd_seq_device_load_drivers(void)
 	flush_work(&autoload_work);
 }
 EXPORT_SYMBOL(snd_seq_device_load_drivers);
-#define cancel_autoload_drivers()	cancel_work_sync(&autoload_work)
+
+static inline void cancel_autoload_drivers(void)
+{
+	cancel_work_sync(&autoload_work);
+}
 #else
-#define queue_autoload_drivers() /* NOP */
-#define cancel_autoload_drivers() /* NOP */
+static inline void queue_autoload_drivers(void)
+{
+}
+
+static inline void cancel_autoload_drivers(void)
+{
+}
 #endif
 
 /*
-- 
2.29.2

