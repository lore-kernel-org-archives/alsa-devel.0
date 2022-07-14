Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B7C43334
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 04:26:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B05E17F8;
	Thu, 14 Jul 2022 06:25:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B05E17F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657772788;
	bh=OuR2fE51Nw9KFMYwaWsMlNUb5eNbAno7VLPZUKUduTk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ryx0ayAsHTloaNjrHGIlkPvf61UJ6y8qNWcldjUbrui1zZ9/5Yxz/af3wQGedBxPL
	 yOJmkn5nmOSRhhDtjiYzKwJD03kg8OOPu36SutjX2TSUQtvJxgxfwyMof3GfIdToka
	 z64UTxDlK1JBwmhjXl+Sbd21Bft22j4TWWYECv+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B87AF805BE;
	Thu, 14 Jul 2022 06:23:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8D07F805B6; Thu, 14 Jul 2022 06:23:05 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BCDDF805A0
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 06:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BCDDF805A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="drYQSQ4F"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D060EB82282;
 Thu, 14 Jul 2022 04:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D82C34114;
 Thu, 14 Jul 2022 04:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657772580;
 bh=OuR2fE51Nw9KFMYwaWsMlNUb5eNbAno7VLPZUKUduTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=drYQSQ4F970Z38kngtVcJ/hLXkrJ/vXxAddKoFOHS5XUSE2rgUkDLA21Z5wgz9lbF
 wWfTXOjQNUohxbbWkLd5yYR+3VrydVpnHImzAbplFhMwG1WIF0leSPrq4vMXlr1FXa
 F4yFxvBiLPKE4IG0IGvCwqBO4OtENiP9nQ5W3nX4Jcolz4RRiZV2rxCa1nYKvKS+68
 2mtouRsVum6oI7fOlLsy0UdOUi0/DTSh8zetiShnt9UGN5KR551eFSFj6zN0XLiVX7
 sIyLG4SEdxUFR6yaCGquXHPN93Wc9NdKiXgI6dk308/n/M+KJf7rzRkN2R9Nh6QoZ/
 A5E4JEVuTR5iA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 14/41] ASoC: wcd938x: Fix event generation for
 some controls
Date: Thu, 14 Jul 2022 00:21:54 -0400
Message-Id: <20220714042221.281187-14-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042221.281187-1-sashal@kernel.org>
References: <20220714042221.281187-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 kernel test robot <lkp@intel.com>, lgirdwood@gmail.com, tiwai@suse.com,
 Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org,
 quic_potturu@quicinc.com, yong.wu@mediatek.com, quic_srivasam@quicinc.com
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

[ Upstream commit 10e7ff0047921e32b919ecee7be706dd33c107f8 ]

Currently wcd938x_*_put() unconditionally report that the value of the
control changed, resulting in spurious events being generated. Return 0 in
that case instead as we should. There is still an issue in the compander
control which is a bit more complex.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20220603122526.3914942-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 898b2887fa63..088cfda767cc 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2519,6 +2519,9 @@ static int wcd938x_tx_mode_put(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
+	if (wcd938x->tx_mode[path] == ucontrol->value.enumerated.item[0])
+		return 0;
+
 	wcd938x->tx_mode[path] = ucontrol->value.enumerated.item[0];
 
 	return 1;
@@ -2541,6 +2544,9 @@ static int wcd938x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
+	if (wcd938x->hph_mode == ucontrol->value.enumerated.item[0])
+		return 0;
+
 	wcd938x->hph_mode = ucontrol->value.enumerated.item[0];
 
 	return 1;
@@ -2632,6 +2638,9 @@ static int wcd938x_ldoh_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
+	if (wcd938x->ldoh == ucontrol->value.integer.value[0])
+		return 0;
+
 	wcd938x->ldoh = ucontrol->value.integer.value[0];
 
 	return 1;
@@ -2654,6 +2663,9 @@ static int wcd938x_bcs_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
+	if (wcd938x->bcs_dis == ucontrol->value.integer.value[0])
+		return 0;
+
 	wcd938x->bcs_dis = ucontrol->value.integer.value[0];
 
 	return 1;
-- 
2.35.1

