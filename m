Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DC8C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 06:22:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BB122CA2
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 06:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BB122CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25DB41875;
	Mon, 25 Jan 2021 07:21:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25DB41875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611555727;
	bh=DW/L42FzV0B1yJ5q6SNG8Ti1I20WNptRWTBTA5tAQ4k=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mm2cKSBkAeUkNuclJlJzqMFJNwqyWst1CKUcFiI8d//oJdKUsgJCNNP6Td9bRNc+t
	 9KVbU2IKlSy5ojVgkXaZxH90EG9EdmUMXrCVdcWS+537IoyiLhxWFZNzkHm0LTSgOK
	 KKkudNne+USDPziUu4JNQrl6UDxK8VkZBUXsdKgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8497DF8028B;
	Mon, 25 Jan 2021 07:20:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97596F80260; Mon, 25 Jan 2021 07:20:25 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15DE0F80260
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 07:20:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15DE0F80260
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="EjG8tmTV"
Received: by mail-yb1-xb4a.google.com with SMTP id f127so10427321ybf.12
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2021 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=v0aGf6GESKmGuuzroZCK6d4SzanQPWilzAzV1+qKSgM=;
 b=EjG8tmTVksUZWiqpNrVXic+HmbRAQ6e38FafXnSKrzlpLx73g2ZyAYvJspPs6PRkFA
 dEbI8vyTXoEU3rDJFDebgP/iVxd2PBMrUMeubEWQFo11BDSf6cQ4BhXJz5OA1ifxe2hN
 SXD63f8kItcSAM27t8iMZ4TwNw0h1kNGF+NJR2kV386J/j3SQeMc5jCoMAG43AZDJ1hm
 tNdcVkSyIeJGBL2iCeEISPUzoWb5eaWizdXsLniBvMhdTdyydMOgctWFKOpISOzOU5/q
 yngEp4momNCusFjtLiuVp13vpbEaB/MgS0lpj4Z36twKug7m+ri6Go7UF9FRpAhReTHV
 IEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=v0aGf6GESKmGuuzroZCK6d4SzanQPWilzAzV1+qKSgM=;
 b=A8cvHP6rXCdPS/BP2FLW/qoG3GrTZiIcA58UnirhFoV87RrbOwU5fsDev59QrQgK20
 vYoHya8pCA7MmHcywBxR1DhJVC6uOpbCPZpbdGbJU8Iikvsi0utr3YRhDk6WddT88Ohe
 eGx33UvYmkQ7JMeGawMhaRtY6TOD3eCkmcu7DuukYOLhGv/hsnwJc/Xz0lfakA/+yMcH
 HE1ttlF2ThcZsQc+g5XdMuGjDOyukZk+SyXj0vTrYu2+342Zr8qfGL/Pf0hAV3cO3IQK
 Zdw1FkA7za2CH8e9CMON9q7OOJK4P78eh8PljwN/b77oKQBUbT5Qv9rIJ8NdVOPjfRs7
 W1Ng==
X-Gm-Message-State: AOAM530nefCZEesx3cGA7Odvg6Rw6yJElhEGBmHT0ZviFkQwD0GHbP3j
 KRyrwSwNcW+5hOYel9LNlN0B2ETK959q
X-Google-Smtp-Source: ABdhPJwswAsYiFSbwZmnRshYlc7KPgS8g2jA/6syu/bEV/ja02Igk28PxJ5n4SyMXz7j1C4z+4DFy2kYDV4X
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:b870:8946:4704:f6a0])
 (user=tzungbi job=sendgmr) by 2002:a25:328e:: with SMTP id
 y136mr20628191yby.442.1611555620142; Sun, 24 Jan 2021 22:20:20 -0800 (PST)
Date: Mon, 25 Jan 2021 14:20:02 +0800
In-Reply-To: <20210125062003.1221810-1-tzungbi@google.com>
Message-Id: <20210125062003.1221810-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20210125062003.1221810-1-tzungbi@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 2/3] ASoC: mediatek: mt8192: use asoc_substream_to_rtd()
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Uses asoc_substream_to_rtd() helper.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index e7fec2d75e3d..7a1724f5ff4c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -42,7 +42,7 @@ static const struct snd_pcm_hardware mt8192_afe_hardware = {
 static int mt8192_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
@@ -59,7 +59,7 @@ static int mt8192_get_dai_fs(struct mtk_base_afe *afe,
 
 static int mt8192_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-- 
2.30.0.280.ga3ce27912f-goog

