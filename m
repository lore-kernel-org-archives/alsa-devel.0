Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEBC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:38:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6A460FC3
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF6A460FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8760E828;
	Tue, 17 Aug 2021 02:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8760E828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629160683;
	bh=otfWXTTclp8V/hz/HUXQCkvW4Hvw8Bf9NI/fjWoDTVk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MFJyH6987HBwOQLosDEsFr1N64hTsgSqzMzPZL0Rj+644d0fc9JkuFORwPU89sq2/
	 GJsfcQZJBOI99hZ3dccYfkYEhicsXJHA7llMJtiv0zfM+qfMECFFelmT0EVEQ7fw27
	 xN0DtW9zuSH7kKLJl31NgRqWRT8+P7D22Fp+lgnY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48826F804AC;
	Tue, 17 Aug 2021 02:36:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A57C3F804E6; Tue, 17 Aug 2021 02:36:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8BBEF804AC
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 02:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8BBEF804AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QNyCKaX0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ADCA60F5C;
 Tue, 17 Aug 2021 00:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629160557;
 bh=otfWXTTclp8V/hz/HUXQCkvW4Hvw8Bf9NI/fjWoDTVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QNyCKaX0aG21cuOJNAy60KmI9/Rhx2lMj/bDW7Yahd7FzF6HMOwKXm16gVpN0b9Ya
 KtyQHHkTZFl13BOBzLuVH0JtdDpQQpu7q/psYQuGIIWtcp+M0togCmFJu+98HfDlJL
 sCqIPSfWBiJEP5gFCPHLCDqgW44nQHZw50hXq0YD1OgCP2pKaq+GZfFfzbWhvXg89n
 7g9nbSsS7PHo1yU6hpibRLA8qVRrJ/c1IepRcAkohjmCMqRZiLGo4OiwAPlu387rXM
 n8sn68YxzJX8KwKS4twybixUJk5mj++rPFuut0LbnxRkkrp7UTkhqdx/tF6vS/JWFW
 ZXO8dJYZtS7WA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/9] ASoC: component: Remove misplaced prefix
 handling in pin control functions
Date: Mon, 16 Aug 2021 20:35:47 -0400
Message-Id: <20210817003554.83213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817003554.83213-1-sashal@kernel.org>
References: <20210817003554.83213-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 31428c78748cafdd9352e1f622eb89bf453d9700 ]

When the component level pin control functions were added they for some
no longer obvious reason handled adding prefixing of widget names. This
meant that when the lack of prefix handling in the DAPM level pin
operations was fixed by ae4fc532244b3bb4d (ASoC: dapm: use component
prefix when checking widget names) the one device using the component
level API ended up with the prefix being applied twice, causing all
lookups to fail.

Fix this by removing the redundant prefixing from the component code,
which has the nice side effect of also making that code much simpler.

Reported-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20210726194123.54585-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-component.c | 63 +++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 728e93f35ffb..4295c0592901 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -135,86 +135,75 @@ int snd_soc_component_set_bias_level(struct snd_soc_component *component,
 	return soc_component_ret(component, ret);
 }
 
-static int soc_component_pin(struct snd_soc_component *component,
-			     const char *pin,
-			     int (*pin_func)(struct snd_soc_dapm_context *dapm,
-					     const char *pin))
-{
-	struct snd_soc_dapm_context *dapm =
-		snd_soc_component_get_dapm(component);
-	char *full_name;
-	int ret;
-
-	if (!component->name_prefix) {
-		ret = pin_func(dapm, pin);
-		goto end;
-	}
-
-	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
-	if (!full_name) {
-		ret = -ENOMEM;
-		goto end;
-	}
-
-	ret = pin_func(dapm, full_name);
-	kfree(full_name);
-end:
-	return soc_component_ret(component, ret);
-}
-
 int snd_soc_component_enable_pin(struct snd_soc_component *component,
 				 const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_enable_pin);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_enable_pin(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin);
 
 int snd_soc_component_enable_pin_unlocked(struct snd_soc_component *component,
 					  const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_enable_pin_unlocked);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_enable_pin_unlocked(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin_unlocked);
 
 int snd_soc_component_disable_pin(struct snd_soc_component *component,
 				  const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_disable_pin);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_disable_pin(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin);
 
 int snd_soc_component_disable_pin_unlocked(struct snd_soc_component *component,
 					   const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_disable_pin_unlocked);
+	struct snd_soc_dapm_context *dapm = 
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_disable_pin_unlocked(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin_unlocked);
 
 int snd_soc_component_nc_pin(struct snd_soc_component *component,
 			     const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_nc_pin);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_nc_pin(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin);
 
 int snd_soc_component_nc_pin_unlocked(struct snd_soc_component *component,
 				      const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_nc_pin_unlocked);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_nc_pin_unlocked(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin_unlocked);
 
 int snd_soc_component_get_pin_status(struct snd_soc_component *component,
 				     const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_get_pin_status);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_get_pin_status(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_get_pin_status);
 
 int snd_soc_component_force_enable_pin(struct snd_soc_component *component,
 				       const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_force_enable_pin);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_force_enable_pin(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin);
 
@@ -222,7 +211,9 @@ int snd_soc_component_force_enable_pin_unlocked(
 	struct snd_soc_component *component,
 	const char *pin)
 {
-	return soc_component_pin(component, pin, snd_soc_dapm_force_enable_pin_unlocked);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	return snd_soc_dapm_force_enable_pin_unlocked(dapm, pin);
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin_unlocked);
 
-- 
2.30.2

