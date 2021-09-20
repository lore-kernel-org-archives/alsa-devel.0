Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50359C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E7E613CE
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3E7E613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53FE116C8;
	Mon, 20 Sep 2021 18:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53FE116C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632156742;
	bh=F7sOW1vexoB2v8FksKoOtHQcajSljza5Ii8GRyz8RO0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lXrjwcobGFxo9yg0XstcqtlyAtCvw07wNzLLXgZeuaXXNvYHjJeB63fhK3HHX2kcw
	 emPsHLxvMjiS96B0JXbr4zUx8Z+U0uLUQizsTw5mvbyVP82iH9iYgGJ/SNJRbtFQAF
	 RhxEqC8wxvixV621yJjcncKCXwu1XYC8R+aiR+lQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00C2EF80246;
	Mon, 20 Sep 2021 18:51:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D19AF80129; Mon, 20 Sep 2021 18:51:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B3BCF80129
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 18:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B3BCF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZL03OpMG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0EB261264;
 Mon, 20 Sep 2021 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632156681;
 bh=F7sOW1vexoB2v8FksKoOtHQcajSljza5Ii8GRyz8RO0=;
 h=From:To:Cc:Subject:Date:From;
 b=ZL03OpMGWYPqgg/N+ot50oRcPGpHCiuxnJkAoTL9c9D82ffS6DymnOR0zvwH5tZjO
 kWBa61UID+WBlz8f7g4X/AX/g6OqmLsFT5MQZVZv4QqnNHUt3y5VZgHUmPtU4HX/r/
 0lfdzR0j6ZXpeCgsR8yfI3D9fIpgnQI0/GaMYLVdUkZlF2y3D3iSvz0F3GuEqyAKNu
 feV23ym8IktEVLhqbNWo8T43BQZMPmpYAtv0WO/kcoarFgrOFNCJ08H8M6mzUTCyxz
 +Vi62pFc/ek+pRPYI/sjulCOUUwXqThv2u9o8EUhjhmbydAg7yO5FNdyx7IgJU90O9
 c9VdTXMlxDQBQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: alc5623: Use modern ASoC DAI format terminology
Date: Mon, 20 Sep 2021 17:50:36 +0100
Message-Id: <20210920165036.17142-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; h=from:subject;
 bh=F7sOW1vexoB2v8FksKoOtHQcajSljza5Ii8GRyz8RO0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSLu1WepUwbG2DZI2+vz0n7M3wrpzEK1KuB2EzL6e
 sFSLZSmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUi7tQAKCRAk1otyXVSH0InlB/
 9QUFqmaEcQqAQMUzZvq0HzhiIx6uZ3j2nXxjU3QUv26TvQOJrDRCkdc8Nl71quNB+U06kIE9Hy5Q6Z
 e3mqJRlO/mrnv2nm7tD7hxCSjwTNRGFBMNCVnvx3373iYq3qwD3RcDcY8S3TQztZD1F5eWTYcesQ8d
 GWYM+q/95VcKtynNLhyDCfAnSOuKfLS6ZUeL9TEWzQiZPjsabu1g+LVO8VKFLReic6zlZ/IJw3WB1I
 q65r7wWRXCML+oU973IEy/yk5Lm44bEjIot1ZL7sHvpagw9SCuNLogPgqLnVFwcp8uj/b9X1EwjnDe
 mAgt7cSQW4m7OjV7VcMcQgqH9H4Gd2
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
the alc5623 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/alc5623.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 54f489837162..b10357a6d655 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -641,12 +641,12 @@ static int alc5623_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
 
-	/* set master/slave audio interface */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	/* set audio interface clocking */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		iface = ALC5623_DAI_SDP_MASTER_MODE;
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBC_CFC:
 		iface = ALC5623_DAI_SDP_SLAVE_MODE;
 		break;
 	default:
-- 
2.20.1

