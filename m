Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F1AC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:12:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818F5206D3
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aiJZof0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818F5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BE0C15F9;
	Fri, 20 Dec 2019 18:11:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BE0C15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576861952;
	bh=3ztafjtYywtMSKBJKOguCVzdS20aBSKMXfAN6tNUIpQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aiJZof0pZs3SfnBqakkODAtkaTLugCrGj+ivYTUkVHiX9hByl7c9hUl9I1shLFLxG
	 pPJNNa8P+fOuaNpJYSgeZwguSU9T2GLOe8jmKdNtmzdPdMOLG/WnvCZAnPn4Bh3Rgt
	 DyTW5l51UGlczrR0QIggXT+5jFekiLxIv/ZYjat0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6905CF80257;
	Fri, 20 Dec 2019 18:10:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8ADBFF8025F; Fri, 20 Dec 2019 18:10:48 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32E0BF8014F
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 18:10:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32E0BF8014F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 09:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; d="scan'208";a="228657502"
Received: from landre-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.133.224])
 by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 09:10:41 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 11:10:37 -0600
Message-Id: <20191220171037.10689-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220171037.10689-1-pierre-louis.bossart@linux.intel.com>
References: <20191220171037.10689-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, Jairaj Arava <jairaj.arava@intel.com>, broonie@kernel.org,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/2] ASoC: hdac_hda: Update hdac hda dai table
	to include intel-hdmi-hifi4
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

TGL supports more than three HDMI Dai's. So, update hdac_hda_dais table
to include 4th DAI.

Without this patch, we saw the below error in TGL DUT:
 sof_rt5682 tgl_max98357a_rt5682: ASoC: CODEC DAI intel-hdmi-hifi4 not

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 16 ++++++++++++++++
 sound/soc/codecs/hdac_hda.h |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 6803d39e09a5..4e0f4afe6ddc 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -164,6 +164,19 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
 		.sig_bits = 24,
 	},
 },
+{
+	.id = HDAC_HDMI_3_DAI_ID,
+	.name = "intel-hdmi-hifi4",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name    = "hifi4",
+		.channels_min   = 1,
+		.channels_max   = 32,
+		.rates          = STUB_HDMI_RATES,
+		.formats        = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+},
 
 };
 
@@ -346,6 +359,9 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	case HDAC_HDMI_2_DAI_ID:
 		pcm_name = "HDMI 2";
 		break;
+	case HDAC_HDMI_3_DAI_ID:
+		pcm_name = "HDMI 3";
+		break;
 	default:
 		dev_err(&hcodec->core.dev, "invalid dai id %d\n", dai->id);
 		return NULL;
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index e145cec085b8..598b07d9b6fe 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -13,7 +13,8 @@ enum {
 	HDAC_HDMI_0_DAI_ID,
 	HDAC_HDMI_1_DAI_ID,
 	HDAC_HDMI_2_DAI_ID,
-	HDAC_LAST_DAI_ID = HDAC_HDMI_2_DAI_ID,
+	HDAC_HDMI_3_DAI_ID,
+	HDAC_LAST_DAI_ID = HDAC_HDMI_3_DAI_ID,
 };
 
 struct hdac_hda_pcm {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
