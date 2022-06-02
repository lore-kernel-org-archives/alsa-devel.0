Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B3C43334
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 13:12:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2F1F173A;
	Thu,  2 Jun 2022 15:11:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2F1F173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654175519;
	bh=/amF8VBWYkiy4mjjtHELSK7VyNNsD5l5DPvfFLqd4p0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OhehNeFaKbc5/bauyqFli1d5ntbFRmvm+c9hhgcKE2M/l8a/keraqz24X049u5sVh
	 51x7TDgvMuOduXSvd4JdQLczxPMWrsuju6d+nC++xwlbD/EMsVjX8pTgPbsGl4EwfH
	 jGfVYuoWWIcfqHuG6sxknjHrK8SMyIJIC9hUbxDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85040F80158;
	Thu,  2 Jun 2022 15:11:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05125F80236; Thu,  2 Jun 2022 15:11:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 863A9F80149
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 15:11:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 863A9F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UIBA4gXV"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDB661777;
 Thu,  2 Jun 2022 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20F5C385A5;
 Thu,  2 Jun 2022 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654175462;
 bh=/amF8VBWYkiy4mjjtHELSK7VyNNsD5l5DPvfFLqd4p0=;
 h=From:To:Cc:Subject:Date:From;
 b=UIBA4gXVABx9ey/YpKuZjqTKRMLoprsaIfa+nuugxa4QDyq2HyMT7vYxNWZ4w/b96
 ASUAsWs5fEkxTPK7b3Z2lWoEfOpZdOA7/5sUkp6m5auZEsCPaUO2ho+qioYm/NW0hb
 B17Svp2awTV7vz6UMikfVNt7cBQ2qpwlLlDOxUHb1NIb4ms5x1TOuANwuADiiHt5hb
 VKwB+qIPEuXd+YAJ96GfMQdfEaD4JbsNoBeQuQukif9mO4GkXDR68WktnjYrqMcZpQ
 aBfqxv3gT+4mqBk1yavE1WpoE11puTqoQ7ixzK5F0kV2/rNEj2peOpuRvzitq6sTyd
 wYihLdk40pcgg==
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: tfa9879: Use modern ASoC DAI format terminology
Date: Thu,  2 Jun 2022 15:10:58 +0200
Message-Id: <20220602131058.3552621-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; h=from:subject;
 bh=/amF8VBWYkiy4mjjtHELSK7VyNNsD5l5DPvfFLqd4p0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBimLbFXP+HNNUfGT37i6RkgtzbWrSLNcoH5hPvzZXt
 e3Id/bmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYpi2xQAKCRAk1otyXVSH0D+iB/
 0XMbzNBZaTuOznAqh3HYCLevsjC7sQSIGXpaWuG2MHOPl+2JXzHy2vjdnmlOZrt/dhFMFZffWBPZ9J
 OZSC95+15krd/Qshc1D4SFz5ss4/oRnZmx0yR3dn5aeLDLsO+pjWOhp2Ua0PDYoxs6H/37Ns9JN5yW
 NbWyJGG1t6MMKS8MPFYg0/LfHX83p2xsgtwIauwEanGef4T0XHqNbCbbx/0p5Xzcliq+2tCOKtVj9H
 tXiNIe9urgDLQYRRt/PYc/fO1WlR+HEXyxXV0TrvRDLV4OLbYebN5PV7MmMCGizmvwU24uwRdGy8r9
 YLKU87/LZlt9SUiS14RLIYkhKjFvCR
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
the tfa9879 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tfa9879.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 3d8e8c2276f0..41a9b1b76e62 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -111,8 +111,8 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	int i2s_set;
 	int sck_pol;
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
 		break;
 	default:
 		return -EINVAL;
-- 
2.30.2

