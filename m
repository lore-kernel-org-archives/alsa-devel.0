Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92294C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 16:56:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C0064FC1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 16:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C0064FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EE4E167C;
	Mon,  1 Mar 2021 17:55:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EE4E167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614617757;
	bh=0OfRl03HKZA5ID9TSwcTqf52jj4bc5i38OmFiDpyg9s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnzaoOvlNWdncfYqk36tB4yFOshb2EZDg3iXceZkjsp5z9/yzoyzga5qOY/Ryeov4
	 xBPHQFx9gp8DawRLOF7RX28Trm+VrWsASE5WF+WZkqh+A8HjZk6wOOpdzuuDUP41cU
	 m2iQf2x55aEzVRacQ0L7yUh3jumv54/DMkMmWBZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FFC1F802DF;
	Mon,  1 Mar 2021 17:54:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05439F802E2; Mon,  1 Mar 2021 17:54:16 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FB4CF8010B
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 17:54:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FB4CF8010B
IronPort-SDR: SSfmSFXV31AlcvlGJgRjuasmW9oes7UvP8QSCw/OFCjwcXIhPjNHrDtjgPoaKFan3aK1iXRuIb
 iMi85aJfrOhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186580165"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="186580165"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 08:54:01 -0800
IronPort-SDR: xceTXNsatojtI+s437Evkof7HQPbTwRFDpIv0g4otuLCcBgvMIjBeNF8DwNWMQnR412HeHqIx0
 ByCSYeyNluyQ==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="505330627"
Received: from mhuang8-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.25.220])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 08:54:01 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: nau8825: fix kernel-doc
Date: Mon,  1 Mar 2021 10:53:46 -0600
Message-Id: <20210301165349.114952-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301165349.114952-1-pierre-louis.bossart@linux.intel.com>
References: <20210301165349.114952-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
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

v5.12-rc1 flags new warnings with make W=1, fix missing or broken
function descriptors.

sound/soc/codecs/nau8825.c:298: warning: wrong kernel-doc identifier
on line:
 * Ramp up the headphone volume change gradually to target level.

sound/soc/codecs/nau8825.c:358: warning: expecting prototype for This
func(). Prototype was for nau8825_intlog10_dec3() instead

sound/soc/codecs/nau8825.c:411: warning: wrong kernel-doc identifier
on line:
 * computes cross talk suppression sidetone gain.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/nau8825.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index f0cba7b5758b..e19db30c457b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -295,7 +295,7 @@ static inline void nau8825_sema_reset(struct nau8825 *nau8825)
 }
 
 /**
- * Ramp up the headphone volume change gradually to target level.
+ * nau8825_hpvol_ramp - Ramp up the headphone volume change gradually to target level.
  *
  * @nau8825:  component to register the codec private data with
  * @vol_from: the volume to start up
@@ -347,8 +347,9 @@ static void nau8825_hpvol_ramp(struct nau8825 *nau8825,
 }
 
 /**
- * Computes log10 of a value; the result is round off to 3 decimal. This func-
- * tion takes reference to dvb-math. The source code locates as the following.
+ * nau8825_intlog10_dec3 - Computes log10 of a value
+ * the result is round off to 3 decimal. This function takes reference to
+ * dvb-math. The source code locates as the following.
  * Linux/drivers/media/dvb-core/dvb_math.c
  * @value:  input for log10
  *
@@ -408,7 +409,7 @@ static u32 nau8825_intlog10_dec3(u32 value)
 }
 
 /**
- * computes cross talk suppression sidetone gain.
+ * nau8825_xtalk_sidetone - computes cross talk suppression sidetone gain.
  *
  * @sig_org: orignal signal level
  * @sig_cros: cross talk signal level
-- 
2.25.1

