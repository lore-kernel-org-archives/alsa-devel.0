Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E9C531DF
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Aug 2024 07:33:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A27613E7;
	Thu, 22 Aug 2024 09:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A27613E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724312019;
	bh=YMTcMRAmuMV/qyUnZuT+QygntPpHZMYDL7Q6RWLxqG0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nPl6BrxOx6jGGoQavpbuO4/DkLSw6mZSjirlm6QKsMJUJMWQXuUF8HCk417jm01pa
	 LmhBtr0qOYqAwthHiGs79O0o1pXaeKx2MbmzAaHHer5BmiA5CwdJOejFTR1crJt+wb
	 NoQTUWdyEnitOgQpFCSV7OeNvRtAU7krcJ/eMTUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38CA4F80654; Thu, 22 Aug 2024 09:31:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B907BF80655;
	Thu, 22 Aug 2024 09:31:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD909F80496; Wed, 21 Aug 2024 09:00:59 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8D51F80494
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 09:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8D51F80494
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpcdJ49KXzpTPd;
	Wed, 21 Aug 2024 14:59:16 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B70961401F4;
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
Subject: [PATCH -next 4/5] sound/soc remove unused substream in macro
 soc_link_mark_pop
Date: Wed, 21 Aug 2024 15:08:14 +0800
Message-ID: <20240821070815.2326534-5-lihongbo22@huawei.com>
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
Message-ID-Hash: 5YLEBYSXSQBSZT6RQKFEUISZXWHBNY6Y
X-Message-ID-Hash: 5YLEBYSXSQBSZT6RQKFEUISZXWHBNY6Y
X-Mailman-Approved-At: Thu, 22 Aug 2024 07:28:28 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YLEBYSXSQBSZT6RQKFEUISZXWHBNY6Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The soc_link_mark_pop don't need substream, therefore we can
remove it.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 sound/soc/soc-link.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-link.c b/sound/soc/soc-link.c
index fee4022708bc..7f1f1bc717e2 100644
--- a/sound/soc/soc-link.c
+++ b/sound/soc/soc-link.c
@@ -35,7 +35,7 @@ static inline int _soc_link_ret(struct snd_soc_pcm_runtime *rtd,
  * In such case, we can update these macros.
  */
 #define soc_link_mark_push(rtd, substream, tgt)		((rtd)->mark_##tgt = substream)
-#define soc_link_mark_pop(rtd, substream, tgt)		((rtd)->mark_##tgt = NULL)
+#define soc_link_mark_pop(rtd, tgt)		((rtd)->mark_##tgt = NULL)
 #define soc_link_mark_match(rtd, substream, tgt)	((rtd)->mark_##tgt == substream)
 
 int snd_soc_link_init(struct snd_soc_pcm_runtime *rtd)
@@ -94,7 +94,7 @@ void snd_soc_link_shutdown(struct snd_pcm_substream *substream,
 		rtd->dai_link->ops->shutdown(substream);
 
 	/* remove marked substream */
-	soc_link_mark_pop(rtd, substream, startup);
+	soc_link_mark_pop(rtd, startup);
 }
 
 int snd_soc_link_prepare(struct snd_pcm_substream *substream)
@@ -138,7 +138,7 @@ void snd_soc_link_hw_free(struct snd_pcm_substream *substream, int rollback)
 		rtd->dai_link->ops->hw_free(substream);
 
 	/* remove marked substream */
-	soc_link_mark_pop(rtd, substream, hw_params);
+	soc_link_mark_pop(rtd, hw_params);
 }
 
 static int soc_link_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -175,7 +175,7 @@ int snd_soc_link_trigger(struct snd_pcm_substream *substream, int cmd,
 			break;
 
 		ret = soc_link_trigger(substream, cmd);
-		soc_link_mark_pop(rtd, substream, startup);
+		soc_link_mark_pop(rtd, startup);
 	}
 
 	return ret;
@@ -209,7 +209,7 @@ void snd_soc_link_compr_shutdown(struct snd_compr_stream *cstream,
 	    rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
 
-	soc_link_mark_pop(rtd, cstream, compr_startup);
+	soc_link_mark_pop(rtd, compr_startup);
 }
 EXPORT_SYMBOL_GPL(snd_soc_link_compr_shutdown);
 
-- 
2.34.1

