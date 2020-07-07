Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C711C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91C4206BE
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iafGcPNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91C4206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78B8016A2;
	Tue,  7 Jul 2020 21:25:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78B8016A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594149961;
	bh=MnmFIyfz8opQA73+gocp84GeFftVL/WCyQjynZzRmhY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iafGcPNUKsbwlzeZtiRJLiruU7U6TsyA1LniOg+iBTe9VuNwaqu+QMu27SFNitVzw
	 uxiHDQbJ70Tu6hGVTnAgP4u1XJr5l/XoisXNYilZvoIH1rQYUc6sRAzHbIQgJ4exQk
	 1abYgtMz+5zByRP9RQmvzXvZxvwqubbF9BQq/jxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43A65F80264;
	Tue,  7 Jul 2020 21:23:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94B0CF802C2; Tue,  7 Jul 2020 21:23:42 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79575F80257
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:23:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79575F80257
IronPort-SDR: aq+QswkhpIbxrlB2CN5UJVT6vwl5Don3rWA2+G4YOtK5GSkD55Amk70RNwnDhHpEYQ7UZZDl2G
 yK9UmZR/rmUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145187060"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="145187060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:23:28 -0700
IronPort-SDR: SXk1Q10/dEw/B/Ix8SBzmmQ/EaXgCGiyRZzY/KFVwafU5RV1QwarZfIx8N5njtxEpEbarCmYED
 AVEqznV6nxUQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="266915974"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:23:26 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ASoC: meson: axg-pdm: remove comparison always false
 warning
Date: Tue,  7 Jul 2020 14:23:09 -0500
Message-Id: <20200707192310.98663-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707192310.98663-1-pierre-louis.bossart@linux.intel.com>
References: <20200707192310.98663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: open list <linux-kernel@vger.kernel.org>, tiwai@suse.de,
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org,
 "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/Amlogic Meson SoC support"
 <linux-arm-kernel@lists.infradead.org>, Jerome Brunet <jbrunet@baylibre.com>
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

Fix W=1 warning.

sound/soc/meson/axg-pdm.c: In function ‘axg_pdm_set_channel_mask’:
include/linux/bits.h:26:28: warning: comparison of unsigned expression
< 0 is always false [-Wtype-limits]

cast the channel number to an int to avoid checking if an unsigned
value is lower than zero.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/meson/axg-pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index bfd37d49a73e..8fe5b2563619 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -206,7 +206,7 @@ static int axg_pdm_set_sample_pointer(struct axg_pdm *priv)
 static void axg_pdm_set_channel_mask(struct axg_pdm *priv,
 				     unsigned int channels)
 {
-	unsigned int mask = GENMASK(channels - 1, 0);
+	unsigned int mask = GENMASK((int)channels - 1, 0);
 
 	/* Put all channel in reset */
 	regmap_update_bits(priv->map, PDM_CTRL,
-- 
2.25.1

