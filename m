Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA99C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 18:23:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7581360C51
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 18:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7581360C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C4DA1AAC;
	Mon, 26 Jul 2021 20:22:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C4DA1AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627323783;
	bh=3A1DMzdFgpeN7PKddwa2N4GznH+KOHQP8HZdgO1B2V0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d8n6iUUQUhOMGqgijJy5Iz7SE0rGrhVz69wZLHBBO9d568MBGFkPYV+iHGsBG/KAP
	 FlukLKYu4wM4XdYlzK+Vy53nfzEmCo6kyeTTW2hUwjADWp6yoLo1XmNLmrsHD1yIZf
	 GEdcJyxoIrgB/0k68gcBZH4w9oNXwkqqPVDaYQ0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFA39F80253;
	Mon, 26 Jul 2021 20:22:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C72FF8025A; Mon, 26 Jul 2021 20:22:10 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4139F8025E
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 20:22:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4139F8025E
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="210403780"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="210403780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 11:21:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="505128276"
Received: from tskelley-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.14.236])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 11:21:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: topology: Select SND_DYNAMIC_MINORS
Date: Mon, 26 Jul 2021 13:21:42 -0500
Message-Id: <20210726182142.179604-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

The indexes of the devices are described within the topology file, it is a
possibility that the topology encodes invalid indexes when DYNAMIC_MINORS
is not enabled in kernel:

 #define SNDRV_MINOR_COMPRESS		2	/* 2 - 3 */
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
 #define SNDRV_MINOR_PCM_CAPTURE	24	/* 24 - 31 */

If the topology assigns an index greater than 7 for PLAYBACK/CAPTURE PCM
then there will be minor number collision.

As an example:
card0 creates a capture PCM with index 10 -> minor = 34
card1 creates compress device with index 0 -> minor = 34

Card1 will fail to instantiate because the minor for the compress stream is
already taken.

To avoid seemingly mysterious issues with card creation, select the
DYNAMIC_MINORS when the topology is enabled.

The other option would be to try to do out of bound index checks in case of
DYNAMIC_MINOR is not enabled and do not even attempt to create the device
with failing the topology load.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 8a13462e1a63..5dcf77af07af 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_COMPRESS
 
 config SND_SOC_TOPOLOGY
 	bool
+	select SND_DYNAMIC_MINORS
 
 config SND_SOC_TOPOLOGY_KUNIT_TEST
 	tristate "KUnit tests for SoC topology"
-- 
2.25.1

