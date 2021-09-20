Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3267C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:55:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0825615A2
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0825615A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE2CC16C9;
	Mon, 20 Sep 2021 18:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE2CC16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632156913;
	bh=ZSbsqtm50QTeE32VXtGGhUOpXaVxWKEcuEdRBzgcF9s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E9TKjD/78ZHDOATJB+KOKNgdbZoQ85qzkVDFZYinRJsW2dnvFkcJtfKjsOOus2Bk+
	 MMuPEcc7RSr1Y3yRyQh4VpWO/5AcikaOvTfxrXngi14z/rp62BegvbHtp005sv26fB
	 7gYc1XmUvDDj/5Iba/9+iXkkLONsmWb0+wXeMqBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C426F80246;
	Mon, 20 Sep 2021 18:54:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48365F8025D; Mon, 20 Sep 2021 18:54:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D175F80129
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 18:54:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D175F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uMhEgFN3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E115261505;
 Mon, 20 Sep 2021 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632156847;
 bh=ZSbsqtm50QTeE32VXtGGhUOpXaVxWKEcuEdRBzgcF9s=;
 h=From:To:Cc:Subject:Date:From;
 b=uMhEgFN3nmxxckKfJLDXVomNaFBwwVs66Gcbdut5vDhmY4jJtUwO9wpg5+wwkeegC
 fjUbjMT07zpwaYsfydQ02F1+kKHWQpRZDRayp9AllqeY2cVLlXabxzBJjgJn8J1e3p
 ML2ze2FfR5tmoe8uGqV3GWvR809816JxgdYmzvY+IfGwEtgF9pQPNCoJKNHmoJ9k2K
 v0nZjQ5/KTOSDiTV0y/xRF3ak5byBEfXmv6hAZs1r85/LwysmEzMpIRxzYSWMTolOG
 Bv9wyDCxPZXdl4z66f39kSttEQaL1sWxzuf7n6GgZ2kMMTlooHsI+zvw0wD41PdCeF
 fZLcFsCcd7dFg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: cpcap: Use modern ASoC DAI format terminology
Date: Mon, 20 Sep 2021 17:53:23 +0100
Message-Id: <20210920165323.17338-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; h=from:subject;
 bh=ZSbsqtm50QTeE32VXtGGhUOpXaVxWKEcuEdRBzgcF9s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSLxnE4vjLYX3Vn5PcRRxrZGE1uAaVPtwvQUiYO/x
 OedQmCSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUi8ZwAKCRAk1otyXVSH0A+oCA
 CGtUVfW0cdfvrU7cY1dyi0HuydzY7REKMfAFqo+etbNC4IAGkr9r6QaF3Rtc8m5L+wUGJc4FAg7mou
 cLTHbyjy74YFXa3tHeiOU4MqHZCq6pvXvx4JZQxlt4wMB8qkApyYpXmR091m7p7m4siqGSeC5QIpFA
 k9IKbXo0aspVTEzBjARslBifMwWtNc+3ZxH8qKy/A6ZlHBjFkYZ0KunGBqFGYPhlbxSy6P8S4jexIf
 nD3SPByRK5Is3EGiiT2jPz4R3XFwWyJ0lMMPcM2geuiy/T6XgHHMgIEcDCEpMx+4VUd0vswRSTZ97P
 OAvSkcXgsWrN4bpihUuD+v5QYsVnc/
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
the cpcap driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cpcap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 05bbacd0d174..9a932d088fb5 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -1168,15 +1168,15 @@ static int cpcap_hifi_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	/*
 	 * "HiFi Playback" should always be configured as
-	 * SND_SOC_DAIFMT_CBM_CFM - codec clk & frm master
+	 * SND_SOC_DAIFMT_CBP_CFP - codec clk & frm provider
 	 * SND_SOC_DAIFMT_I2S - I2S mode
 	 */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		val &= ~BIT(CPCAP_BIT_SMB_ST_DAC);
 		break;
 	default:
-		dev_err(dev, "HiFi dai fmt failed: CPCAP should be master");
+		dev_err(dev, "HiFi dai fmt failed: CPCAP should be provider");
 		return -EINVAL;
 	}
 
-- 
2.20.1

