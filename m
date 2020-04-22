Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD6C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:36:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16EA206D6
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HYGhO18V";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="USb5ZSf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16EA206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E968016A9;
	Wed, 22 Apr 2020 10:36:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E968016A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587544617;
	bh=VkJW/jNkxhqU+BNTxUX5gdpwLGU8NCnvlG8kn8QinsA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HYGhO18VHo8/71cI0xygryLLDrIo4p3E66Q38eYlpCVpCrz6rOTfqqq2FZcnL8av5
	 nOzAJxSiz1Z1Ew2/GZK486e/Oa2HOgbEigAha0gnmTuTkSXeSa0xzP6m7uuzH+mUNF
	 NTBz3HNyDguG/q4m2lIO1i4lD7/18vn1Z3kIo/fA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64220F80142;
	Wed, 22 Apr 2020 10:36:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C3CCF801D9; Wed, 22 Apr 2020 10:36:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7BB3F800FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 10:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7BB3F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="USb5ZSf6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 476A9206B9;
 Wed, 22 Apr 2020 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587544556;
 bh=VkJW/jNkxhqU+BNTxUX5gdpwLGU8NCnvlG8kn8QinsA=;
 h=From:To:Cc:Subject:Date:From;
 b=USb5ZSf6VJh7fAHyk06zFq9KTO0ODkE0pTSSbI24H/X3WlCye9KYHeFT/5uhsEJuE
 mDpZpw3cZDJ3G63Ss3rmrTUWuKPPlVOLgFrmq/2pM/TqzCcoDtduRYWMxarENy3TSx
 Yu/6wkzHVyQ2Jz7jkUjOXPvkhC4SFYUUTc8cm+fw=
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: dmic: Allow GPIO operations to sleep
Date: Wed, 22 Apr 2020 09:35:50 +0100
Message-Id: <20200422083550.50711-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

If there is a power GPIO provided we control it from DAPM context so there
is no problem with a sleeping GPIO, use the _cansleep() version of the API
to allow this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index f5560a49b9e5..5d079d90fd3b 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -59,14 +59,14 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (dmic->gpio_en)
-			gpiod_set_value(dmic->gpio_en, 1);
+			gpiod_set_value_cansleep(dmic->gpio_en, 1);
 
 		if (dmic->wakeup_delay)
 			msleep(dmic->wakeup_delay);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		if (dmic->gpio_en)
-			gpiod_set_value(dmic->gpio_en, 0);
+			gpiod_set_value_cansleep(dmic->gpio_en, 0);
 		break;
 	}
 
-- 
2.20.1

