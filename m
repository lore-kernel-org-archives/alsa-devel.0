Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A89C10F25
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:29:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F7524656
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="it9IxZn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F7524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49F2216A4;
	Mon,  9 Mar 2020 20:28:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49F2216A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583782184;
	bh=dBRps52Wn2jpp8jq7wCR4AHz8lHLp9eqELh1aEMrwa0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=it9IxZn/gi/Zylpff6WbEdIh+rkeyNvAyHwpXJ89nIUE40R17aMnEy5uGB+2dmf2K
	 7ESEyIsHjw7XcTwgft7lcLDAaWfu0FqGC9VYIMyYeAGzFKRKZyJVTOi6JRyaNhu4hn
	 IDk0Dd52MjTM49aZmraGLIh4wIorQxbAovvEhmfM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EA73F80260;
	Mon,  9 Mar 2020 20:28:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CA4EF801F8; Mon,  9 Mar 2020 20:27:57 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46B73F801A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 20:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46B73F801A3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 12:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="442858062"
Received: from dmaida-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.17.65])
 by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2020 12:27:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: soc-core: disable route checks for legacy devices
Date: Mon,  9 Mar 2020 14:27:43 -0500
Message-Id: <20200309192744.18380-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309192744.18380-1-pierre-louis.bossart@linux.intel.com>
References: <20200309192744.18380-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

v5.4 changes in soc-core tightened the checks on soc_dapm_add_routes,
which results in the ASoC card probe failing.

Introduce a flag to be set in machine drivers to prevent the probe
from stopping in case of incomplete topologies or missing routes. This
flag is for backwards compatibility only and shall not be used for
newer machine drivers.

Example with an HDaudio card with a bad topology:

[ 236.177898] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Failed to
add route iDisp1_out -> direct -> iDisp1 Tx

[ 236.177902] skl_hda_dsp_generic skl_hda_dsp_generic:
snd_soc_bind_card: snd_soc_dapm_add_routes failed: -19

with the disable_route_checks set:

[ 64.031657] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Failed to
add route iDisp1_out -> direct -> iDisp1 Tx

[ 64.031661] skl_hda_dsp_generic skl_hda_dsp_generic:
snd_soc_bind_card: disable_route_checks set, ignoring errors on
add_routes

Fixes: daa480bde6b3a9 ("ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 81e5d17be935..96226036ddc2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1063,6 +1063,7 @@ struct snd_soc_card {
 	const struct snd_soc_dapm_route *of_dapm_routes;
 	int num_of_dapm_routes;
 	bool fully_routed;
+	bool disable_route_checks;
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f2cfbf182f49..25eb2ef48e16 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1260,8 +1260,18 @@ static int soc_probe_component(struct snd_soc_card *card,
 	ret = snd_soc_dapm_add_routes(dapm,
 				      component->driver->dapm_routes,
 				      component->driver->num_dapm_routes);
-	if (ret < 0)
-		goto err_probe;
+	if (ret < 0) {
+		if (card->disable_route_checks) {
+			dev_info(card->dev,
+				 "%s: disable_route_checks set, ignoring errors on add_routes\n",
+				 __func__);
+		} else {
+			dev_err(card->dev,
+				"%s: snd_soc_dapm_add_routes failed: %d\n",
+				__func__, ret);
+			goto err_probe;
+		}
+	}
 
 	/* see for_each_card_components */
 	list_add(&component->card_list, &card->component_dev_list);
@@ -1948,8 +1958,18 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 
 	ret = snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 				      card->num_dapm_routes);
-	if (ret < 0)
-		goto probe_end;
+	if (ret < 0) {
+		if (card->disable_route_checks) {
+			dev_info(card->dev,
+				 "%s: disable_route_checks set, ignoring errors on add_routes\n",
+				 __func__);
+		} else {
+			dev_err(card->dev,
+				 "%s: snd_soc_dapm_add_routes failed: %d\n",
+				 __func__, ret);
+			goto probe_end;
+		}
+	}
 
 	ret = snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
 				      card->num_of_dapm_routes);
-- 
2.20.1

