Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8AAC43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 02:21:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 624F218E9;
	Tue, 14 Jun 2022 04:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 624F218E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655173270;
	bh=RLHSQVtkqrazy0mBeNjXkqecGr67GUWi+zQRgtJ/3Bw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khjWYdtlhGMR5GOvsBVuohOJOnspMGRJNxVQTWy1Qb/8Xs4U8fGw9ch6/1TlunFdm
	 SW6cJqe3MGJ52ShkFXfV5GxXtZw3mcc0MwFqQ4oFjeZjqA0+lJnATL8TFmlSm+fvB7
	 ZdlU1jg0fD7rUF3TstuLw4byuaRmkLOXr8GL1Zvc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 540E3F80677;
	Tue, 14 Jun 2022 04:09:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B69FF80671; Tue, 14 Jun 2022 04:09:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 753C3F80640
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 04:09:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 753C3F80640
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pPnuuAfA"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EB50CB8169A;
 Tue, 14 Jun 2022 02:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68903C36B01;
 Tue, 14 Jun 2022 02:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655172562;
 bh=RLHSQVtkqrazy0mBeNjXkqecGr67GUWi+zQRgtJ/3Bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pPnuuAfAUd492Mu0fgNSQDJ1yL7UfT/r5NHrxH12Rb9tsUBhSVxH9mwruk+WaX5JY
 dJRluPM7nKVeI1ITiJjG/gzk3DmxZ1pNdXIm3b/boL8mji3VGCRJVLlrKIaWRN5ieV
 SCFRrIfkbzrP5clk/uWQmRrzwiTFpPPV1tbRCcO1iGByuOx1z83ph6Jwp4RCbzlC/N
 zd8LKXSZz7DpkfW35xhY5FGHpCPL3MJW48gyDqpOFtV59Tf8x2mPcAX7t0C2izp/d5
 uUslaMF0H9JifK5trQtV94ljmCK4g2ZEfZaQL+EVMtchgZ43X1sFrppq5C6RFsL3oK
 g37Fb1q9nl4fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/23] ASoC: wm_adsp: Fix event generation for
 wm_adsp_fw_put()
Date: Mon, 13 Jun 2022 22:08:48 -0400
Message-Id: <20220614020900.1100401-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614020900.1100401-1-sashal@kernel.org>
References: <20220614020900.1100401-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>
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

[ Upstream commit 2abdf9f80019e8244d3806ed0e1c9f725e50b452 ]

Currently wm_adsp_fw_put() returns 0 rather than 1 when updating the value
of the control, meaning that no event is generated to userspace. Fix this
by setting the default return value to 1, the code already exits early with
a return value of 0 if the value is unchanged.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220603115003.3865834-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 13672928da99..aedfa6b2895b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -791,7 +791,7 @@ int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
-	int ret = 0;
+	int ret = 1;
 
 	if (ucontrol->value.enumerated.item[0] == dsp[e->shift_l].fw)
 		return 0;
-- 
2.35.1

