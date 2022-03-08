Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E482C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 19:30:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD0611896;
	Tue,  8 Mar 2022 20:29:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD0611896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646767841;
	bh=mNLYcCOlZTB/AOTZHx0RCVDTtzqjNFKLR1qwmkwbWjk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7jQlp9HMhk4Sm3nE0dSs5oOiUU0CP/Nov3FGCdZHNTx4ykQeOLfy9BCD9q5kOQZ3
	 9KrcGOQ+lbdU3Am7V80z6v+q7sh4Y5gqRAPyJxCb/LuwwS+9zzJ2opxJyfkvo7k7PS
	 /RmM7G3UOVA98LXMmXLZOd4s9wojgWKPVZ/BNtbI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68573F8052E;
	Tue,  8 Mar 2022 20:27:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAB8BF8053D; Tue,  8 Mar 2022 20:26:58 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D577EF80519
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 20:26:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D577EF80519
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="P0/BTVYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646767611; x=1678303611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mNLYcCOlZTB/AOTZHx0RCVDTtzqjNFKLR1qwmkwbWjk=;
 b=P0/BTVYFsdor+wnH6G2x2KirocgU2tbConL5XzufxjBz4c3WiOIDeQXT
 fCvjuTy1VbyiEGd+7YAdRLmN1lo1B/mCmRRI0ZmrPhD8qGB5liQl91rRP
 y0lJ6CQ9Ysx96jj8krU3zHzskRK3uXzW9RDN7FoB5HU/HV98yTPHrOgdk
 cv1/lotaxi9WhTCzbyuWQLG6vCUSrgGkiUz+sghqKqPJKARiEA10gjq0m
 sBi0Gqd4Ok9VofnnRl65cjSs4hRYswPsbq8Hl/5UNjx5pAoCPVhKG3B2s
 IAxLJUa51FIlbk97KFL0y1W7obZh5mBFqa8B+Wj95G1ht+lnZyzxY6D5b g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252363726"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252363726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="495573978"
Received: from jhaskins-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.53.149])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:47 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/20] ASoC: Intel: Revert "ASoC: Intel: sof_es8336: add quirk
 for Huawei D15 2021"
Date: Tue,  8 Mar 2022 13:26:03 -0600
Message-Id: <20220308192610.392950-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
References: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Huajun Li <huajun.li@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Nikolai Kostrigin <nickel@altlinux.org>, broonie@kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

This reverts commit ce6a70bfce21bb4edb7c0f29ecfb0522fa34ab71.

The next patch will add run-time detection of the required SSP and
this hard-coded quirk is not needed.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_es8336.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index bb4a3491d71c..3376bd360a03 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -247,14 +247,6 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 					SOF_ES8336_TGL_GPIO_QUIRK |
 					SOF_ES8336_ENABLE_DMIC)
 	},
-	{
-		.callback = sof_es8336_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
-			DMI_MATCH(DMI_BOARD_NAME, "BOHB-WAX9-PCB-B2"),
-		},
-		.driver_data = (void *)SOF_ES8336_SSP_CODEC(0)
-	},
 	{}
 };
 
-- 
2.30.2

