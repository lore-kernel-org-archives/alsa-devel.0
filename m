Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11990C54E94
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 11:49:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCF58206;
	Wed, 25 Jan 2023 12:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCF58206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674647387;
	bh=RGkhOGbRm5cwx74CiurmOgI1lc+qA8Fuigx5JEuF0lk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=asmPYJjysXSwle3/9jRgi3hLvuqCHUQRQXUUGFOR4T4++Mrbq9HbxgHSQwXRpXrOs
	 qlBp9E6h/OofLktJqQtoW36Karfb3zMJ1G7Ki0uz8M4E1uWed9auBkxxdYEF4583wS
	 vYzMoHHS9apuGTGqQ437YMsXBrEM7pQ3n5asmF2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11C9FF804A9;
	Wed, 25 Jan 2023 12:47:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D825F805AA; Wed, 25 Jan 2023 12:46:39 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B1E3F804A9
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 12:46:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B1E3F804A9
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IkvNz3bm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674647170; x=1706183170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RGkhOGbRm5cwx74CiurmOgI1lc+qA8Fuigx5JEuF0lk=;
 b=IkvNz3bmQrGbmYv88FGfRtRE66nXFTaCMXV5R75GXh/bqqvOvJajtNx6
 g2kCUociqtAz6/D/PuinRiOuyES8GNly4uD99EOwY3URSRS93x6yOzT8E
 ZnzH++1gxOhy8FVtc5R6mPBBPSJx4qe1erzscfCs9ynxUAIiCUOZ4R2ug
 p0R1Z1T/W9MlNcrVcHpHiaU0zbUUg5meP9L7aXT2REOzz7DEJ0NZ5e1pE
 ZmXk25XJYhWkW0JkEr8imIOPNzOi7VJ2y+NiOP6L1kLqn9Nr8deDIG+7m
 CpSsoywNbzoetjL/EU0Xj+mIirIr6JvQrjSiPcO3zsNKAR4O4ffNiMrE9 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324234197"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="324234197"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 03:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612393982"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="612393982"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 03:46:04 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 04/11] ASoC: topology: Fix function name
Date: Wed, 25 Jan 2023 20:46:42 +0100
Message-Id: <20230125194649.3485731-5-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
References: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Functions other than soc_valid_header have soc_tplg_ prefix. Rename
function to follow convention in file.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b9c29effeb60..1fe4fa82fa2f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2389,7 +2389,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 }
 
 /* validate header magic, size and type */
-static int soc_valid_header(struct soc_tplg *tplg,
+static int soc_tplg_valid_header(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	if (soc_tplg_get_hdr_offset(tplg) >= tplg->fw->size)
@@ -2526,7 +2526,7 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
 		while (!soc_tplg_is_eof(tplg)) {
 
 			/* make sure header is valid before loading */
-			ret = soc_valid_header(tplg, hdr);
+			ret = soc_tplg_valid_header(tplg, hdr);
 			if (ret < 0) {
 				dev_err(tplg->dev,
 					"ASoC: topology: invalid header: %d\n", ret);
-- 
2.25.1

