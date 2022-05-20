Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68373C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 21:19:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3086174A;
	Fri, 20 May 2022 23:19:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3086174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653081595;
	bh=FAx2MGkYD7Q5PvZNIT+bSe+ZVEwgYp9aY1CsIJL8knk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQqybR/axfru2tzKJD2a/uKsSvXOxFPZGFDhmaH8B5VRqrEFmwJUqtX9WkIUyPtGB
	 ky34Yj4nsPajHmlruUbKFB4WoKC09Tsa8CxE5BbWyQMZk2szAxe/vuBv5V4LshVTgj
	 OmQNpI5UqFfiAinrTCmqmeYnHa9LfmGSPm2XVesw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4800F804C1;
	Fri, 20 May 2022 23:17:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95EE3F80527; Fri, 20 May 2022 23:17:47 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FB1BF800F0
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 23:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FB1BF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="W/mT4hbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653081463; x=1684617463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FAx2MGkYD7Q5PvZNIT+bSe+ZVEwgYp9aY1CsIJL8knk=;
 b=W/mT4hbBF5AEY+IZUwCrRcW7Ns4/HY2/VuB+zYQXOwSr3BVcarWvNkq2
 qHE8spInVYcOqMVsyCHz3jdiQ2T5p+WzQ4pzVcy/8sAe37sozj25GSua2
 YBpHomyVfO7rTiYqH8GkM8t5sqk03F36xEtNmg7JeK94maUPZdL0WImKC
 g6DSCfeJtClze7JrhJzVsFqzaHbARxPbd7BJYZCntYH5oJGhp47uds2iW
 x11nCibzrhcsBWPf3cMvFkG9i5zxRAjAU1Mj9zDU+eat9vQCypk0qz1N/
 Tu6nM5B9AVtRzbfpaYrvIM9c9vx8Gn5m4O1RFfSsgDtEboR0i7luTOpxX Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270324240"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="270324240"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="674796029"
Received: from achsu-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.181.190])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:35 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/16] ASoC: Intel: atom: controls: remove useless
 initializations
Date: Fri, 20 May 2022 16:17:11 -0500
Message-Id: <20220520211719.607543-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
References: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck complains about invalid NULL dereferences but there's indeed
no need to initialize loop variables or before allocating memory.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 335c327329945..34d63252debfd 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1328,7 +1328,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 {
 	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
 	struct snd_soc_dapm_widget *w;
-	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dapm_path *p;
 
 	dev_dbg(dai->dev, "enter, dai-name=%s dir=%d\n", dai->name, stream);
 
@@ -1392,7 +1392,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 static int sst_fill_module_list(struct snd_kcontrol *kctl,
 	 struct snd_soc_dapm_widget *w, int type)
 {
-	struct sst_module *module = NULL;
+	struct sst_module *module;
 	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
 	struct sst_ids *ids = w->priv;
 	int ret = 0;
-- 
2.30.2

