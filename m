Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6BCC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:56:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F53613AC
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7F53613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DB99166D;
	Tue,  5 Oct 2021 00:55:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DB99166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633388209;
	bh=FROmqw4oA9p71zxtFJ4fYt3FCFFBP72F5vYlG2/BRzw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uh7RAuaR/49Z1sg+3P+Uwonvpgy2hVAOsgVnyrSFGQMMm+vIEplOB72zSW0BTFa09
	 xvdilzHq7/toYAOPE2ZAnyH9NBeYUeVttcDjktnotpUdCUfPTb+10peNEH1TsKPLVM
	 9cB2yQfxiSZ6FeL4KY+R3tmTyZNvp7HH41TJEvw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B915F802D2;
	Tue,  5 Oct 2021 00:55:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE5CFF804E2; Tue,  5 Oct 2021 00:55:13 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 922E0F80240
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 00:55:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 922E0F80240
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205727437"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; d="scan'208";a="205727437"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 15:55:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; d="scan'208";a="559011876"
Received: from ksgonzal-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.181.38])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 15:55:01 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v2 2/5] ASoC: soc-pcm: don't export local functions,
 use static
Date: Mon,  4 Oct 2021 17:54:38 -0500
Message-Id: <20211004225441.233375-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
References: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, vkoul@kernel.org, broonie@kernel.org,
 Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

No one uses the following functions outside of soc-pcm.c

snd_soc_dpcm_can_be_free_stop()
snd_soc_dpcm_can_be_params()
snd_soc_dpcm_be_can_update()

In preparation for locking changes, move them to static functions and
remove the EXPORT_SYMBOL_GPL()

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dpcm.h | 12 ------------
 sound/soc/soc-pcm.c      | 21 +++++++++++++++------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 72d45ad47ee3..9c00118603e7 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -113,18 +113,6 @@ struct snd_soc_dpcm_runtime {
 #define for_each_dpcm_be_rollback(fe, stream, _dpcm)			\
 	list_for_each_entry_continue_reverse(_dpcm, &(fe)->dpcm[stream].be_clients, list_be)
 
-/* can this BE stop and free */
-int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
-/* can this BE perform a hw_params() */
-int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
-/* is the current PCM operation for this BE ? */
-int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
-		struct snd_soc_pcm_runtime *be, int stream);
-
 /* get the substream for this BE */
 struct snd_pcm_substream *
 	snd_soc_dpcm_get_substream(struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 17476e3219ea..360811f8a18c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -29,6 +29,18 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+/* can this BE stop and free */
+static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+					 struct snd_soc_pcm_runtime *be, int stream);
+
+/* can this BE perform a hw_params() */
+static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+				      struct snd_soc_pcm_runtime *be, int stream);
+
+/* is the current PCM operation for this BE ? */
+static int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+				      struct snd_soc_pcm_runtime *be, int stream);
+
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
 {
 	return (rtd)->num_cpus == 1 ? asoc_rtd_to_cpu(rtd, 0)->name : "multicpu";
@@ -2806,7 +2818,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 }
 
 /* is the current PCM operation for this BE ? */
-int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	if ((fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_FE) ||
@@ -2815,7 +2827,6 @@ int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 		return 1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_can_update);
 
 /* get the substream for this BE */
 struct snd_pcm_substream *
@@ -2861,7 +2872,7 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
  * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
  * are not running, paused or suspended for the specified stream direction.
  */
-int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	const enum snd_soc_dpcm_state state[] = {
@@ -2872,13 +2883,12 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 
 /*
  * We can only change hw params a BE DAI if any of it's FE are not prepared,
  * running, paused or suspended for the specified stream direction.
  */
-int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	const enum snd_soc_dpcm_state state[] = {
@@ -2890,4 +2900,3 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
-- 
2.25.1

