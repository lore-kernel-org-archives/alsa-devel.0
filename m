Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88B6C10F1A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 May 2024 23:09:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF0743E7;
	Wed,  8 May 2024 01:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF0743E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715123382;
	bh=KqH/EllT2nZhX3OizGudEvwDJBGY4WN0GkKk4gjgHcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PdqRUx0CPI+HIgnNm+Wu7wddxFTQhVPGRB5oY1oL2Va1Buf/CZYlABANWKujUpaqn
	 ecHHn5VlY9vuAMXgeCoKfNSbW5ZzfAvNWKTFnWdnuTXfQvagTJ4WhX0AIjF3zypOIf
	 FPlahKWeFTh+oJ0rAFE3MXCgI00UyHFDnfh7UQI4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1554F80564; Wed,  8 May 2024 01:08:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50BCEF80606;
	Wed,  8 May 2024 01:08:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FB24F805F2; Wed,  8 May 2024 01:08:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 24BFAF80564
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 01:08:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24BFAF80564
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BTKb2ilb
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B92D1619FF;
	Tue,  7 May 2024 23:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD0AC2BBFC;
	Tue,  7 May 2024 23:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123309;
	bh=KqH/EllT2nZhX3OizGudEvwDJBGY4WN0GkKk4gjgHcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTKb2ilbwb+rE3RM9BJBjbUJ8IMXx4dIFfqkk9zLFG/Ho/6M3gGOVxKUFOMGzdMDt
	 F1T2ErrY3k1ny0hybSmz12rvLWPZh/VWTzjcrWwvvwxFCqTC2M/laduJ68XLqUG0ov
	 EMAd0+izTSEXqQY3q3+lbHYvjoXQ6aFQlcfFOxnwPusqfoM35ZKmMjtpKSVIMfTpO1
	 +k9itD5ywZMWF4/x6a4mqDl3q/11MeDSLwC9YrHuis10OkKQoLsExhLiCVW9alwsuA
	 o9zJx4+2vyEoxFsSqkU4OMwRMhFP1Jhoc4nvtB+eMKiLltCYfhsJ1g/iMZMOChVdnb
	 l80kbHAwh5xuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/52] ASoC: cs35l41: Update DSP1RX5/6 Sources for
 DSP config
Date: Tue,  7 May 2024 19:06:41 -0400
Message-ID: <20240507230800.392128-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FMRUZ3FELIPWLA6OKOOTSK46ABZMHA7F
X-Message-ID-Hash: FMRUZ3FELIPWLA6OKOOTSK46ABZMHA7F
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FMRUZ3FELIPWLA6OKOOTSK46ABZMHA7F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit eefb831d2e4dd58d58002a2ef75ff989e073230d ]

Currently, all ASoC systems are set to use VPMON for DSP1RX5_SRC,
however, this is required only for internal boost systems.
External boost systems require VBSTMON instead of VPMON to be the
input to DSP1RX5_SRC.
Shared Boost Active acts like Internal boost (requires VPMON).
Shared Boost Passive acts like External boost (requires VBSTMON)
All systems require DSP1RX6_SRC to be set to VBSTMON.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240411142648.650921-1-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index dfb4ce53491bb..f8e57a2fc3e32 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1094,6 +1094,7 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 {
 	struct wm_adsp *dsp;
+	uint32_t dsp1rx5_src;
 	int ret;
 
 	dsp = &cs35l41->dsp;
@@ -1113,16 +1114,29 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 		return ret;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC,
-			   CS35L41_INPUT_SRC_VPMON);
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+	case CS35L41_SHD_BOOST_ACTV:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VPMON;
+		break;
+	case CS35L41_EXT_BOOST:
+	case CS35L41_SHD_BOOST_PASS:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VBSTMON;
+		break;
+	default:
+		dev_err(cs35l41->dev, "wm_halo_init failed - Invalid Boost Type: %d\n",
+			cs35l41->hw_cfg.bst_type);
+		goto err_dsp;
+	}
+
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC, dsp1rx5_src);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_VPMON failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write DSP1RX5_SRC: %d failed: %d\n", dsp1rx5_src, ret);
 		goto err_dsp;
 	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC,
-			   CS35L41_INPUT_SRC_CLASSH);
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC, CS35L41_INPUT_SRC_VBSTMON);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_CLASSH failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write CS35L41_INPUT_SRC_VBSTMON failed: %d\n", ret);
 		goto err_dsp;
 	}
 	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX7_SRC,
-- 
2.43.0

