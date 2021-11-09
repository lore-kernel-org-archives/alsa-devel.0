Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378CC4332F
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:19:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550BA61A0D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 550BA61A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B556166F;
	Tue,  9 Nov 2021 23:18:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B556166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496350;
	bh=bjPXB5HH1GtIMshiC2IBO4Pln2KOJyhpk465bQoQ92w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5htrhEAy3TNh1CU16ADCFCSc6mFqFmb0Oe0NiWY9Mb9eG+ganI+ocheEIjziwFG/
	 lSN5FfSACQI7LyfcjKIZPxRojxbZTdl+gqll7T9EhTfsZMX2vGPleGruWWlLp//8mi
	 lo6GHIGxEdq0aSCxa7cBYMj0jllUG5FIE79oww2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B98BCF804EB;
	Tue,  9 Nov 2021 23:18:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64B4BF80425; Tue,  9 Nov 2021 23:18:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5B39F80425
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:18:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5B39F80425
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ayaUmjoy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 985CD61881;
 Tue,  9 Nov 2021 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496278;
 bh=bjPXB5HH1GtIMshiC2IBO4Pln2KOJyhpk465bQoQ92w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ayaUmjoyzxm5pgETBYilkWZRSomnrY9+0LuEZ8TrC9rXvSuBg/Kd0+02rfeyoajLM
 Pk3QXGLuSa2LyokuGE2Hpgr6tNjD9aQTzk4e8cdNR7GQbz9XQs05CNxquTybuyw7tA
 As07Ig1G80/L4fX0NtHwX4ygRjKwKx1JPj9iPhopSnz5DkujAtBurm9DULjRADv2Ns
 DvKr3DbJaV0RJWCfm+402Xp6hLljqMNlzmvOdj78fVAMdHYhWqJ8isg4fGj7y6XuMJ
 fI+YNB1+qSwCI8kL6oqX6ocdpYESI4Jo16G2rAir8aknDrcqYybTGeimdqkmrgH7Y4
 ByPY/mHtQnphg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 40/82] ASoC: es8316: Use IRQF_NO_AUTOEN when
 requesting the IRQ
Date: Tue,  9 Nov 2021 17:15:58 -0500
Message-Id: <20211109221641.1233217-40-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1cf2aa665901054b140eb71748661ceae99b6b5a ]

Use the new IRQF_NO_AUTOEN flag when requesting the IRQ, rather then
disabling it immediately after requesting it.

This fixes a possible race where the IRQ might trigger between requesting
and disabling it; and this also leads to a small code cleanup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20211003132255.31743-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 067757d1d70a3..5fb02635c1406 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -811,12 +811,9 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 	mutex_init(&es8316->lock);
 
 	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"es8316", es8316);
-	if (ret == 0) {
-		/* Gets re-enabled by es8316_set_jack() */
-		disable_irq(es8316->irq);
-	} else {
+	if (ret) {
 		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
 		es8316->irq = -ENXIO;
 	}
-- 
2.33.0

