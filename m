Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC013C7EE2E
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 13:46:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B22D91DC;
	Wed, 31 May 2023 15:45:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B22D91DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685540789;
	bh=Luun0qN3Hqo2+HrVtNije7hzgiJtuA0kucqBhrlDmSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MDSxIo2RVXyVm+y/z65FdCR/rGA086TgCr1MbEFEkJsSCB5nhjBhrKFtG89yXUNa4
	 Dok2NLanfD73MUpA/yKSUIUC1fic3MW7xE6Jex0e2vn5pysX0Vc1AlmNkzwPwACP4O
	 vyvaVE7bsNbjRWruInPNLw2iwyrwLenlsJbCsBxs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A3C7F805D4; Wed, 31 May 2023 15:44:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4AABF8059F;
	Wed, 31 May 2023 15:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02352F805BF; Wed, 31 May 2023 15:44:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8AC54F80551
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 15:42:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AC54F80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YTL6tGHo
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4DE63B53;
	Wed, 31 May 2023 13:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A81EC433D2;
	Wed, 31 May 2023 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685540564;
	bh=Luun0qN3Hqo2+HrVtNije7hzgiJtuA0kucqBhrlDmSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTL6tGHoJKARf8VeqOOEqVCBEtTG08JHjcCub/pfYKBS+Nc+/9vuJzfsvSWK9dpbq
	 mZQ4txEnpBMjd4S8CFI8QFBUpUBts7a2TtWXNHzOG0gYHbxl7IRqFydCA81VENz7UT
	 wXbvghutBA7MH77K2JVOK7y6JVyhcCek/J2OJ4x430cebGwi/N5TGK0FbF1PGElaxx
	 4pUSk91YD4pZWfWbgCQGAMgSiHG8qsOEtSm9rmLv2mKP9sx2hCQlfbsOt/2Myh7GNF
	 30CNTLXrYASga5+yuFDb1ViEPzL5eLb4mhTc0w2fdDNGe1tZET2DJeCT+rh2pA1Eq1
	 5T709Qbvaf24A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 21/33] ASoC: Intel: avs: Add missing checks on FE
 startup
Date: Wed, 31 May 2023 09:41:47 -0400
Message-Id: <20230531134159.3383703-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: D7E4RQRN75FKPA4FGXBSDX2KQ7N6IL6Q
X-Message-ID-Hash: D7E4RQRN75FKPA4FGXBSDX2KQ7N6IL6Q
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D7E4RQRN75FKPA4FGXBSDX2KQ7N6IL6Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 25148f57a2a6d157779bae494852e172952ba980 ]

Constraint functions have return values, they should be checked for
potential errors.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-8-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/pcm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 8fe5917b1e263..22f21f3f612d1 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -424,21 +424,34 @@ static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_so
 
 	host_stream = snd_hdac_ext_stream_assign(bus, substream, HDAC_EXT_STREAM_TYPE_HOST);
 	if (!host_stream) {
-		kfree(data);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	data->host_stream = host_stream;
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto err;
+
 	/* avoid wrap-around with wall-clock */
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	if (ret < 0)
+		goto err;
+
 	snd_pcm_set_sync(substream);
 
 	dev_dbg(dai->dev, "%s fe STARTUP tag %d str %p",
 		__func__, hdac_stream(host_stream)->stream_tag, substream);
 
 	return 0;
+
+err:
+	kfree(data);
+	return ret;
 }
 
 static void avs_dai_fe_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.39.2

