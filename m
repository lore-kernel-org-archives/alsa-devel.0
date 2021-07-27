Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74260C432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:21:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB4C61A0B
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EB4C61A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FEC21F07;
	Tue, 27 Jul 2021 15:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FEC21F07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627392072;
	bh=9Ekw3+9sj0iwmU+tEstdxAwWf8wSv4kj+Ikag/p3grk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gNzsTmwoT3siHCNdF0sXZxR2ZT65vtj3HiV+zH9vkNEI0xEj21U2JC0XkKOOD9dsw
	 WuWBVqvKCTIk4QnJXdgBq8kHbDSSeO7TyUF3hOtBVngEEgo0o/1/0/BDkF5g9Zbx+p
	 xwm45RXih8ynlNw7yEmLKJ/dzjlN/lX/TxfU4ITw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A41A0F804AF;
	Tue, 27 Jul 2021 15:19:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F358FF804BD; Tue, 27 Jul 2021 15:19:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9762CF80212
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 15:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9762CF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Tswn5y/L"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7047961A8F;
 Tue, 27 Jul 2021 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391967;
 bh=9Ekw3+9sj0iwmU+tEstdxAwWf8wSv4kj+Ikag/p3grk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tswn5y/LoxdKAl8jUC9VvP3ryxW460G2u8qp1yBie8HVo2tDdqn9X74pVfEbbp7Co
 UW9dydCCooxhzNJE8Gt8a/StUJR/KBrWZVcPSqBu9wkq+6v5vYXatMekzUkxE/Wnwg
 JLNzbAs99jt35Um5uFo2a2sbz4ZE0OWUHEs6hEa75nlZQiF2NQ3w1J2tjNcd5/8SiD
 9eOGiPZxYgDk1bmIYfpTC00ntqNoJmNVCsL0cKTiwAD9UKiFsh7mjuNDnrp1n7Rsyt
 svT9UTl56LznkO/IQT86nwcuoVhlTlits2YR3+RNCm6O2DlRAUyjBxNaE+np+oqHhu
 xqmNi+128wwYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 13/21] ASoC: ti: j721e-evm: Fix unbalanced domain
 activity tracking during startup
Date: Tue, 27 Jul 2021 09:19:00 -0400
Message-Id: <20210727131908.834086-13-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131908.834086-1-sashal@kernel.org>
References: <20210727131908.834086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>
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

From: Peter Ujfalusi <peter.ujfalusi@gmail.com>

[ Upstream commit 78d2a05ef22e7b5863b01e073dd6a06b3979bb00 ]

In case of an error within j721e_audio_startup() the domain->active must
be decremented to avoid unbalanced counter.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20210717122820.1467-2-peter.ujfalusi@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/j721e-evm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index a7c0484d44ec..017c4ad11ca6 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -278,23 +278,29 @@ static int j721e_audio_startup(struct snd_pcm_substream *substream)
 					  j721e_rule_rate, &priv->rate_range,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 
-	mutex_unlock(&priv->mutex);
 
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Reset TDM slots to 32 */
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 32);
 	if (ret && ret != -ENOTSUPP)
-		return ret;
+		goto out;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2, 32);
 		if (ret && ret != -ENOTSUPP)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	if (ret == -ENOTSUPP)
+		ret = 0;
+out:
+	if (ret)
+		domain->active--;
+	mutex_unlock(&priv->mutex);
+
+	return ret;
 }
 
 static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
-- 
2.30.2

