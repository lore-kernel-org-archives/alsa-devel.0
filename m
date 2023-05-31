Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D3C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 13:43:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DC3620C;
	Wed, 31 May 2023 15:42:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DC3620C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685540612;
	bh=0l9xbhHO5u6TcLV8LFHbC5RKnck8rAa4xNop448icUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eTKNBI0QAuic6RSq0M34JNS6dgH8VRqro156l4MMGLrgRPq25wxziJS52eMfED7Ef
	 CJ+cZX6hj1NCYgt6iLwBWNbZpteXysNF/gDpEyD7Io6vLmpHL2GBb6BuC7DufSu7k+
	 sUFv2S8JnrvlBOwO1SVGZt1LMR3NQeKYSomKrHfk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 260A6F805B0; Wed, 31 May 2023 15:41:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFF9DF80563;
	Wed, 31 May 2023 15:41:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8BA7F8057C; Wed, 31 May 2023 15:41:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E443BF8056F
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 15:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E443BF8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J4AH/Orf
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9D85663B08;
	Wed, 31 May 2023 13:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B064C433EF;
	Wed, 31 May 2023 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685540478;
	bh=0l9xbhHO5u6TcLV8LFHbC5RKnck8rAa4xNop448icUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4AH/OrfYy/tBIPnm6NiaNDwysAcRDReO1IDxggLQ7xqCsFBlRuXgziDrV4BsvHPF
	 M5xxtxhMXM+KmlHbJbvrVHY6dZJRTyX8QaP3WFdDeCoSgtk75Y7spnUMm/lEaDGmDz
	 makkjT+AbjPoMDlYV226sAyq3z49hefZ+WcUHTLaHJc8KWoudxaveAD+AP/BYo0Vmd
	 5E28Bj+FFvwzehxsXI+fQ7HH66bq2h6p7CUQRxscXn9aMgYc8XZzKYx7hjt6aoFEwl
	 jHHbguuRHdPo64EMHP0hW+39pEu7P5KxPNrEEawCJOtYHKnChTguks9vN7sr8tYMB9
	 gD8wZ5+cuftcg==
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
Subject: [PATCH AUTOSEL 6.3 24/37] ASoC: Intel: avs: Add missing checks on FE
 startup
Date: Wed, 31 May 2023 09:40:06 -0400
Message-Id: <20230531134020.3383253-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 745TZX73LMAPPEXW6K5K7CF77YI3OCN3
X-Message-ID-Hash: 745TZX73LMAPPEXW6K5K7CF77YI3OCN3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/745TZX73LMAPPEXW6K5K7CF77YI3OCN3/>
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
index 31c032a0f7e4b..1fbb2c2fadb55 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -468,21 +468,34 @@ static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_so
 
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

