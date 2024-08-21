Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AD6C3DA4A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Aug 2024 07:32:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28ABB820;
	Thu, 22 Aug 2024 09:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28ABB820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724311966;
	bh=Efohe42vAuAor80qMzZo3RBzR9BzV0xqithNlsU6+lk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vH+7CuSMTRyqi/LUTpJk6hHvklp5C1LZ715yRCz2m1TWFQKq9irWhdup8YXy0jDzz
	 jMwPETc3oWqQHbtE2r7FM3XBCqwRQ9O9UD4VpS9NI0RdpuZhNd6+O6OxpuDuRfDyT/
	 ZICzZByuS7QL91nat056gV8q3oIdQGoVix77sdsI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C54CF8060C; Thu, 22 Aug 2024 09:31:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02883F805ED;
	Thu, 22 Aug 2024 09:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63A80F80579; Wed, 21 Aug 2024 09:00:55 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 044F3F8025E
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 09:00:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 044F3F8025E
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpcYf0nkmz20m68;
	Wed, 21 Aug 2024 14:56:06 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 968A91401F3;
	Wed, 21 Aug 2024 15:00:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 15:00:47 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <peter.ujfalusi@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next 3/5] sound/soc remove unused substream in macro
 soc_dai_mark_pop
Date: Wed, 21 Aug 2024 15:08:13 +0800
Message-ID: <20240821070815.2326534-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821070815.2326534-1-lihongbo22@huawei.com>
References: <20240821070815.2326534-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-MailFrom: lihongbo22@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JDWG3TEURLLU3XS4FOE7NCUJWNEMOBFJ
X-Message-ID-Hash: JDWG3TEURLLU3XS4FOE7NCUJWNEMOBFJ
X-Mailman-Approved-At: Thu, 22 Aug 2024 07:28:27 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JDWG3TEURLLU3XS4FOE7NCUJWNEMOBFJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The soc_dai_mark_pop don't need substream, and also
substream is not used in this macro, so we can remove it.
This is detected by macro_checker.py script.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 sound/soc/soc-dai.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 302ca753a1f3..4000385e0863 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -37,7 +37,7 @@ static inline int _soc_dai_ret(const struct snd_soc_dai *dai,
  * In such case, we can update these macros.
  */
 #define soc_dai_mark_push(dai, substream, tgt)	((dai)->mark_##tgt = substream)
-#define soc_dai_mark_pop(dai, substream, tgt)	((dai)->mark_##tgt = NULL)
+#define soc_dai_mark_pop(dai, tgt)	((dai)->mark_##tgt = NULL)
 #define soc_dai_mark_match(dai, substream, tgt)	((dai)->mark_##tgt == substream)
 
 /**
@@ -416,7 +416,7 @@ void snd_soc_dai_hw_free(struct snd_soc_dai *dai,
 		dai->driver->ops->hw_free(substream, dai);
 
 	/* remove marked substream */
-	soc_dai_mark_pop(dai, substream, hw_params);
+	soc_dai_mark_pop(dai, hw_params);
 }
 
 int snd_soc_dai_startup(struct snd_soc_dai *dai,
@@ -453,7 +453,7 @@ void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 		dai->driver->ops->shutdown(substream, dai);
 
 	/* remove marked substream */
-	soc_dai_mark_pop(dai, substream, startup);
+	soc_dai_mark_pop(dai, startup);
 }
 
 int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
@@ -678,7 +678,7 @@ int snd_soc_pcm_dai_trigger(struct snd_pcm_substream *substream,
 			r = soc_dai_trigger(dai, substream, cmd);
 			if (r < 0)
 				ret = r; /* use last ret */
-			soc_dai_mark_pop(dai, substream, trigger);
+			soc_dai_mark_pop(dai, trigger);
 		}
 	}
 
@@ -742,7 +742,7 @@ void snd_soc_dai_compr_shutdown(struct snd_soc_dai *dai,
 		dai->driver->cops->shutdown(cstream, dai);
 
 	/* remove marked cstream */
-	soc_dai_mark_pop(dai, cstream, compr_startup);
+	soc_dai_mark_pop(dai, compr_startup);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_compr_shutdown);
 
-- 
2.34.1

