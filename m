Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B62C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 12:11:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA156101A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 12:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CA156101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C526E16C3;
	Mon, 27 Sep 2021 14:10:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C526E16C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632744665;
	bh=zTtNKYYNKknASlm4MENv7cnvgMsIKcADBU0AgKhBbjc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hhACD2bjTdwIzayqMHqPD7+AtneVBddtK0XE84PqpT8UQKVRGK64TxTmqsix2pMVy
	 Y+P730OoeikBwMcrFKiX09nlwW7Xvk9d+eD3gS7zaJPw7GCBiKwDxTSy3/y5+gnvih
	 JNV5U1G3dbZc0IWfVj3dR4YY0cs0uyxvow2/Kn9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A938F80227;
	Mon, 27 Sep 2021 14:07:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29A25F80147; Mon, 27 Sep 2021 14:07:04 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F3A5F80272
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 14:05:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F3A5F80272
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221260478"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="221260478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 05:05:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="553164412"
Received: from unknown (HELO pujfalus-desk.ger.corp.intel.com)
 ([10.251.220.221])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 05:05:28 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com
Subject: [PATCH v3 05/12] AsoC: dapm: export a couple of functions
Date: Mon, 27 Sep 2021 15:05:10 +0300
Message-Id: <20210927120517.20505-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927120517.20505-1-peter.ujfalusi@linux.intel.com>
References: <20210927120517.20505-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 seppo.ingalsuo@intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Export a couple of DAPM functions that can be used by
ASoC drivers to determine connected widgets when a PCM
is started.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/sound/soc-dpcm.h | 1 +
 sound/soc/soc-dapm.c     | 2 ++
 sound/soc/soc-pcm.c      | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index e296a3949b18..bc7af90099a8 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -159,6 +159,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream, int cmd);
 int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream);
 int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 	int event);
+bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget, enum snd_soc_dapm_direction dir);
 
 #define dpcm_be_dai_startup_rollback(fe, stream, last)	\
 						dpcm_be_dai_stop(fe, stream, 0, last)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7b67f1e19ae9..44c4d105ffdb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1331,11 +1331,13 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	return paths;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_dai_get_connected_widgets);
 
 void snd_soc_dapm_dai_free_widgets(struct snd_soc_dapm_widget_list **list)
 {
 	dapm_widget_list_free(list);
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_dai_free_widgets);
 
 /*
  * Handler for regulator supply widget.
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e30cb5abaf7a..b5825d8d6caa 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1262,8 +1262,7 @@ static int widget_in_list(struct snd_soc_dapm_widget_list *list,
 	return 0;
 }
 
-static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
-		enum snd_soc_dapm_direction dir)
+bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget, enum snd_soc_dapm_direction dir)
 {
 	struct snd_soc_card *card = widget->dapm->card;
 	struct snd_soc_pcm_runtime *rtd;
@@ -1281,6 +1280,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(dpcm_end_walk_at_be);
 
 int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list)
-- 
2.33.0

