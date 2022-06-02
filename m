Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A41C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 13:57:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27D2F17DD;
	Thu,  2 Jun 2022 15:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27D2F17DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654178221;
	bh=8mtQAJrIEjtHGBDCgoCCiRJJcw6/xBU7GFilFnU4ESQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AIUZtMk0AFWm//S4jTv7d76h27nEZef0lmMvgwDcfkAewBva8L+qV6ZaDyMqUNvvG
	 ucTl0X7OG/ELIFtYEUoKFlBFwepYGbAfKWwcN1Ams7m/5XT5evFlYssEfhRrPjpzZM
	 1T3m9f+lnXCLjwRrkRlyhQhhrrSq1jash566t/Qo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33E66F80570;
	Thu,  2 Jun 2022 15:53:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C5C6F80553; Thu,  2 Jun 2022 15:53:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B926CF80539
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 15:53:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B926CF80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N5PYZx5u"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D887617D7;
 Thu,  2 Jun 2022 13:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC13DC385A5;
 Thu,  2 Jun 2022 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654178012;
 bh=8mtQAJrIEjtHGBDCgoCCiRJJcw6/xBU7GFilFnU4ESQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N5PYZx5uIm1MEJpBUnEeP7WGh+XDheBVjEKChddgDQOIQDXUrqDTTTO+YvOCHu1SF
 vjai/mno3PQhCpUozISk/6MtZPhRjA1lJHvArM4ZYRUhxdf/XGjqVBFVZFupFWEpSj
 Il0NgKv1ehehEjwjJI5uYCjL5q1xUJ0Ua1j2o6hC9Oc14+RHv3O3cobmBn44vveX+r
 JeyeVHiKQMN3nNdROhEvQXPvUN0Itl5PrMgMOFQbjxpktQVE40eIZ8AdbO1ykBXgk3
 51e95diYwLbtY3kwRPA3qDmFdq4C9ethQi1aneSaXysYQhaQhOEe2Sx0Hdf6WJTQBD
 HUA79poVqOZqw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 09/20] ASoC: tas5086: Use modern ASoC DAI format terminology
Date: Thu,  2 Jun 2022 15:53:05 +0200
Message-Id: <20220602135316.3554400-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602135316.3554400-1-broonie@kernel.org>
References: <20220602135316.3554400-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; h=from:subject;
 bh=8mtQAJrIEjtHGBDCgoCCiRJJcw6/xBU7GFilFnU4ESQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBimMCVKKvgw2zxc59AqTTeO+6U52K3aDXnEyFgBQSc
 4vRJbCyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYpjAlQAKCRAk1otyXVSH0Jz9B/
 9Nv66oIPbEhjBFOrQZgFt8m6URL2hSWYZqiO3LzesmhyE4p0UjR7QiKD1CrpQLhf6UENsPM0/N5ey1
 0AFH+XZHXuG2LYCNNkPNbviG6fB490JWPsVdhJGuiHZgVA/k/67+wt5twIIC5wNsiT+mP139m3SRJd
 /cljTbC6vI+8M846siW5rpLJRqkW8wZJi9KNuSayhdy261p7+kPFOqyrk/H0qp7/FVVR0bhqnKk7Lb
 KouTmlMIb9TKSLE4cp0gn7XaUwk/BjC6jiK0tdHGv2N5LNHzN2uNsibyubEKYOcSMsccY+wmxvfEUJ
 VAQshEN+1WcegSGCTjmTf4flVGZk8W
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

As part of moving to remove the old style defines for the bus clocks update
the tas5086 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5086.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 5c0df3cd4832..05b57bb1aea0 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -318,7 +318,7 @@ static int tas5086_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	/* The TAS5086 can only be slave to all clocks */
-	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+	if ((format & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_CBC_CFC) {
 		dev_err(component->dev, "Invalid clocking mode\n");
 		return -EINVAL;
 	}
-- 
2.30.2

