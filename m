Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F090AC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:47:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B1206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FjOR/rT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B1206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C6FC1672;
	Mon,  8 Jun 2020 21:46:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C6FC1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591645621;
	bh=DZxX9ZT9bm8DBjtIHPH+CAFjBK6ZmqJOktScSmMazPk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjOR/rT2mEXh2kmKxtmZifKZ1UakMiuzAzdpgixDw2Vf8skJ5RXSNnKtKBhpab3JF
	 Ndar4VUK3HFVG7XqAtwFvPsxMTivvsNVW4u9Q0CZsI4XpnP/6OyKlHaGDv1PFvKcgj
	 74guEXTa+kwF5qVhFTmK8pNExj+DfWmjemk0wvxA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7542BF8021E;
	Mon,  8 Jun 2020 21:44:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63E60F802A2; Mon,  8 Jun 2020 21:44:33 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC59DF8021E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 21:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC59DF8021E
IronPort-SDR: 5/RIneGcZ/nUpXkRuUgpcIvULSxmVV5zOEzjFuUVur0iQtjmYV3BHwYwSH0XsQw9Dn8sDnjm8/
 FL2Gssyj+dCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 12:44:22 -0700
IronPort-SDR: 6YzOEfClcGvqLvynUYpt304VbMrt0i/1SyxXPq5djQqOtda3IBFUkJ/ngEVAbgtLKUuNKP8suf
 k/cTSCnV420w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="305939481"
Received: from skarmaka-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.104.56])
 by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2020 12:44:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: core: only convert non DPCM link to DPCM link
Date: Mon,  8 Jun 2020 14:44:13 -0500
Message-Id: <20200608194415.4663-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608194415.4663-1-pierre-louis.bossart@linux.intel.com>
References: <20200608194415.4663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Additional checks for valid DAIs expose a corner case, where existing
BE dailinks get modified, e.g. HDMI links are tagged with
dpcm_capture=1 even if the DAIs are for playback.

This patch makes those changes conditional and flags configuration
issues when a BE dailink is has no_pcm=0 but dpcm_playback or
dpcm_capture=1 (which makes no sense).

As discussed on the alsa-devel mailing list, there are redundant flags
for dpcm_playback, dpcm_capture, playback_only, capture_only. This
will have to be cleaned-up in a future update. For now only correct
and flag problematic configurations.

Fixes: 218fe9b7ec7f3 ("ASoC: soc-core: Set dpcm_playback / dpcm_capture")
Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b07eca2c6ccc..7b387202c5db 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1648,9 +1648,25 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			dai_link->platforms->name = component->name;
 
 			/* convert non BE into BE */
-			dai_link->no_pcm = 1;
-			dai_link->dpcm_playback = 1;
-			dai_link->dpcm_capture = 1;
+			if (!dai_link->no_pcm) {
+				dai_link->no_pcm = 1;
+
+				if (dai_link->dpcm_playback)
+					dev_warn(card->dev,
+						 "invalid configuration, dailink %s has flags no_pcm=0 and dpcm_playback=1\n",
+						 dai_link->name);
+				if (dai_link->dpcm_capture)
+					dev_warn(card->dev,
+						 "invalid configuration, dailink %s has flags no_pcm=0 and dpcm_capture=1\n",
+						 dai_link->name);
+
+				/* convert normal link into DPCM one */
+				if (!(dai_link->dpcm_playback ||
+				      dai_link->dpcm_capture)) {
+					dai_link->dpcm_playback = !dai_link->capture_only;
+					dai_link->dpcm_capture = !dai_link->playback_only;
+				}
+			}
 
 			/*
 			 * override any BE fixups
-- 
2.20.1

