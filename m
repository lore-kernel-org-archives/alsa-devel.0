Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46827C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:09:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72BD20663
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L9MKjDc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 236691690;
	Mon,  9 Mar 2020 18:09:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 236691690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583773790;
	bh=HaSKI2Vgxi+edQlsSSU/92ycWEDMqhoRZj2hA/MNhGo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L9MKjDc3s/TOmKIDD3wddLc/GIXOG0f9fZPYWLKbsmbu2wnKQprna9uQHi5tEwbc6
	 cE251i9CiBwdKlWhYqo8tsnRd5oPcpckaj9zshBlRIVxI1pYHPdOriiRVUi6INc+pZ
	 NgQVevq6fOBH2wAUqEvs33DweblQCVzVCRzujkpY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB7FCF80260;
	Mon,  9 Mar 2020 18:08:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AABECF8028C; Mon,  9 Mar 2020 18:08:05 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB932F801A3;
 Mon,  9 Mar 2020 18:07:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB932F801A3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 10:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="353408520"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.40.3])
 by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 10:07:53 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: (cosmetic) simplify dpcm_prune_paths()
Date: Mon,  9 Mar 2020 18:07:47 +0100
Message-Id: <20200309170749.32313-2-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 sound-open-firmware@alsa-project.org
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

Currently dpcm_prune_paths() has up to 4 nested condition and loop
levels, which forces the code to use flags for flow control.
Extracting widget status verification code from dpcm_prune_paths()
into a separate function simplifies the code.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-pcm.c | 63 +++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7915ada..8732cf1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1626,45 +1626,46 @@ void dpcm_path_put(struct snd_soc_dapm_widget_list **list)
 	snd_soc_dapm_dai_free_widgets(list);
 }
 
-static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
-	struct snd_soc_dapm_widget_list **list_)
+static bool dpcm_be_is_active(struct snd_soc_dpcm *dpcm, int stream,
+			      struct snd_soc_dapm_widget_list *list)
 {
-	struct snd_soc_dpcm *dpcm;
-	struct snd_soc_dapm_widget_list *list = *list_;
 	struct snd_soc_dapm_widget *widget;
 	struct snd_soc_dai *dai;
-	int prune = 0;
-	int do_prune;
+	unsigned int i;
 
-	/* Destroy any old FE <--> BE connections */
-	for_each_dpcm_be(fe, stream, dpcm) {
-		unsigned int i;
+	/* is there a valid CPU DAI widget for this BE */
+	for_each_rtd_cpu_dai(dpcm->be, i, dai) {
+		widget = snd_soc_dai_get_widget(dai, stream);
 
-		/* is there a valid CPU DAI widget for this BE */
-		do_prune = 1;
-		for_each_rtd_cpu_dai(dpcm->be, i, dai) {
-			widget = snd_soc_dai_get_widget(dai, stream);
+		/*
+		 * The BE is pruned only if none of the cpu_dai
+		 * widgets are in the active list.
+		 */
+		if (widget && widget_in_list(list, widget))
+			return true;
+	}
 
-			/*
-			 * The BE is pruned only if none of the cpu_dai
-			 * widgets are in the active list.
-			 */
-			if (widget && widget_in_list(list, widget))
-				do_prune = 0;
-		}
-		if (!do_prune)
-			continue;
+	/* is there a valid CODEC DAI widget for this BE */
+	for_each_rtd_codec_dai(dpcm->be, i, dai) {
+		widget = snd_soc_dai_get_widget(dai, stream);
 
-		/* is there a valid CODEC DAI widget for this BE */
-		do_prune = 1;
-		for_each_rtd_codec_dai(dpcm->be, i, dai) {
-			widget = snd_soc_dai_get_widget(dai, stream);
+		/* prune the BE if it's no longer in our active list */
+		if (widget && widget_in_list(list, widget))
+			return true;
+	}
 
-			/* prune the BE if it's no longer in our active list */
-			if (widget && widget_in_list(list, widget))
-				do_prune = 0;
-		}
-		if (!do_prune)
+	return false;
+}
+
+static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
+	struct snd_soc_dapm_widget_list **list_)
+{
+	struct snd_soc_dpcm *dpcm;
+	int prune = 0;
+
+	/* Destroy any old FE <--> BE connections */
+	for_each_dpcm_be(fe, stream, dpcm) {
+		if (dpcm_be_is_active(dpcm, stream, *list_))
 			continue;
 
 		dev_dbg(fe->dev, "ASoC: pruning %s BE %s for %s\n",
-- 
1.9.3

