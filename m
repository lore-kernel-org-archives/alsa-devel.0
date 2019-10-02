Return-Path: <SRS0=2KR+=X3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD715C352AA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:08:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB30921783
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qXrH4Slq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB30921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E7A1661;
	Wed,  2 Oct 2019 11:07:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E7A1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570007294;
	bh=rC5lDIPxnvO/cOcwCZ/aD/Oq7CRcrbkp/Oos547XB2c=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qXrH4SlqDrOPkD8d32ZOsYeT86kGPnQOVklzyCUyB4Ag8AHbEeMuMIZ+ubY8LDexg
	 bHNidnNr1HXU0DKKmtGiHUSI75SfaqZvMxS1zsgNzSOUWdCNPUR2iIW+L0N5ejZnC9
	 7mtSXS++692gFDBbwHqByMhXLk58VLg3b6ZTr/mI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 279B3F8036E;
	Wed,  2 Oct 2019 11:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDF7DF80391; Wed,  2 Oct 2019 11:07:22 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A298AF8036E
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 11:07:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A298AF8036E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Oct 2019 02:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; d="scan'208";a="343268371"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by orsmga004.jf.intel.com with ESMTP; 02 Oct 2019 02:07:12 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  2 Oct 2019 17:04:32 +0800
Message-Id: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Brent Lu <brent.lu@intel.com>
Subject: [alsa-devel] [PATCH] ASoC: bdw-rt5677: enable runtime channel merge
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In the DAI link "Capture PCM", the FE DAI "Capture Pin" supports 4-channel
capture but the BE DAI supports only 2-channel capture. To fix the channel
mismatch, we need to enable the runtime channel merge for this DAI link.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 4a4d335..8d07038 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -273,6 +273,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 		},
 		.dpcm_capture = 1,
 		.dpcm_playback = 1,
+		.dpcm_merged_chan = 1,
 		SND_SOC_DAILINK_REG(fe, dummy, platform),
 	},
 
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
