Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE3C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:31:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBCD207FB
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T3AMwbPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBCD207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D67A166E;
	Thu,  9 Jul 2020 18:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D67A166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594312271;
	bh=UBCpFvm7Avq/6AySSWTA391OABIU3cIK/9/KjFPjRHU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T3AMwbPMv0Hor6eJYXFAaoWaF9KU2cx3h7rX/T+VttQnKKQeXejYzvOuO4IBp7kXy
	 T1LcVz47TqwnD1z8kgToB3au+GoXAnm7GhK/XoIlzjVswrL9KuoXCZdOBQv1UjL+Bj
	 Io2W+TlsxNawXvLSd0IDnBMeryQZT7p5HYAlqPC8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D533F8032A;
	Thu,  9 Jul 2020 18:24:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0357F802F7; Thu,  9 Jul 2020 18:24:23 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EE8FF802A9
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 18:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EE8FF802A9
IronPort-SDR: efn6/nGbykoDY6TQBPEjsd6SPhkABZ8UiG1S8+Ki6niX2H+zGAHX/GQbo26D7dnGPgDlkc/HbR
 0vTTlaiHmreQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149515653"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="149515653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 09:24:02 -0700
IronPort-SDR: 5JAzNT2lO/ogbhTrmzaK5lxtIVpAI3zjIQspC5bYWj+dhG/S0QKmBMEfIJjsbgesKdHB5cNnh+
 I8UQrS4A2Cew==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="280353107"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 09:24:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 10/10] ASoC: codecs: ak4458: Remove set but never checked
 variable 'ret'
Date: Thu,  9 Jul 2020 11:23:27 -0500
Message-Id: <20200709162328.259586-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
References: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Mihai Serban <mihai.serban@nxp.com>, Lee Jones <lee.jones@linaro.org>
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

From: Lee Jones <lee.jones@linaro.org>

Looks as though the result of snd_soc_update_bits() has never been checked.

Fixes the following W=1 kernel build warning(s):

sound/soc/codecs/ak4458.c: In function ‘ak4458_set_dai_mute’:
sound/soc/codecs/ak4458.c:408:16: warning: variable ‘ret’ set but not
used [-Wunused-but-set-variable]

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Cc: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/ak4458.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index f180cb5dfe4f..39ae089dcd1d 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -405,7 +405,7 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-	int nfs, ndt, ret, reg;
+	int nfs, ndt, reg;
 	int ats;
 
 	nfs = ak4458->fs;
@@ -416,14 +416,14 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 	ndt = att_speed[ats] / (nfs / 1000);
 
 	if (mute) {
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
 		mdelay(ndt);
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 	} else {
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
 		mdelay(ndt);
 	}
 
-- 
2.25.1

