Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C9AC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jul 2022 12:58:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86AA11634;
	Thu,  7 Jul 2022 14:57:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86AA11634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657198684;
	bh=9Ji9iZZVXLOK+QnEpKIfNswLmhsOxmQFN8OKZLw48FA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuMNi9WjQLAZWApyc/k/OXw6xK2goSWDaBn+B9CziYTWGLomS8QiqduVqSbfA1wiT
	 LszJzzwNqPPPL3lAcLei9IpsSqZXJwwjDCUw8TFqFMoCNvTEjvNM/zX4WBcrOvsZrF
	 K/KChXs/iL1sRuJv/gYdQ7rtETAZMLtrmycqcMo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47664F800C5;
	Thu,  7 Jul 2022 14:56:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D2CAF8052E; Thu,  7 Jul 2022 14:56:48 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2179F804F1
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2022 14:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2179F804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="gPY3Nt4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657198605; x=1688734605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9Ji9iZZVXLOK+QnEpKIfNswLmhsOxmQFN8OKZLw48FA=;
 b=gPY3Nt4Y6cxTQ0FDxteZUvsVI832ErH5iYe3xCpcP98Lyx6AgtPdlB7X
 AXKY03LUYJos2mZ0zX6Fn+kPHJWbRLdXpRqTdwUAlh0Lylat848mOpFx5
 qoClGgrSutdQZE7OJkYyCDTEB1iy7rp24nwzPVaTZXLhp+QNhjkqABWdq
 lIOQltaPEhc+xR1pVF5bT/b9ULLlq3ua73H43LvPbmHOVzMdWpyMRJTiM
 awTOEZf1N92BlrJTZm9eZNMGbD3vL4Q+wVmMIITnpYL8ilYsFEhRY6Dur
 vZSU8s0Z8pcCJfr9RCbW5qZBGzRZKMVi8VzcnEuCm7fM7xzdCmfidwORb g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272810607"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="272810607"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 05:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="620781726"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 05:56:37 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/5] ASoC: codecs: rt298: Fix NULL jack in interrupt
Date: Thu,  7 Jul 2022 14:56:57 +0200
Message-Id: <20220707125701.3518263-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125701.3518263-1-amadeuszx.slawinski@linux.intel.com>
References: <20220707125701.3518263-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

Set rt298->jack to passed value in mic_detect, otherwise when jack is
set to NULL on next interrupt call, we may use freed pointer.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/codecs/rt298.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 266a2cc55b8d..6a615943f983 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -335,6 +335,8 @@ static int rt298_mic_detect(struct snd_soc_component *component,
 	bool mic = false;
 	int status = 0;
 
+	rt298->jack = jack;
+
 	/* If jack in NULL, disable HS jack */
 	if (!jack) {
 		regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x0);
@@ -344,7 +346,6 @@ static int rt298_mic_detect(struct snd_soc_component *component,
 		return 0;
 	}
 
-	rt298->jack = jack;
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
 	rt298_jack_detect(rt298, &hp, &mic);
-- 
2.25.1

