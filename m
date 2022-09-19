Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B4DECAAD3
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 11:47:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BFEA163A;
	Mon, 19 Sep 2022 13:47:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BFEA163A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663588076;
	bh=0jyAuv+SExqY+upytNWQUSFFNqVklzAyiZiuwDk6r6k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IT7gkDl7QYw1MCQZf4kUO14kJED1O3/NosoxpEWqQydD1jt6AV0QoL98di5T/hFMR
	 AXCur5jAVWHHHgd5+JwNx0MtsiYI97M56efZjKNUY/qe4psz3Zm9JTl+1LUxMK5KEZ
	 YElLKxvaZL69YRjcPiYrO/z0ZwqkxcRd5jh4oTd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4455F804B4;
	Mon, 19 Sep 2022 13:47:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5420EF804AE; Mon, 19 Sep 2022 13:47:03 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B137EF800E5
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 13:46:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B137EF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="cOnQvGMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663588017; x=1695124017;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0jyAuv+SExqY+upytNWQUSFFNqVklzAyiZiuwDk6r6k=;
 b=cOnQvGMs7izZ0podtPW6MLW21fy8/ceQo7axox7NLNF4J1DTnd+Nosv7
 jIzkejT37T2vd4BeduE7ifa365iW23KFLMyRS08MrNsUrfrDpD5b6kArH
 V8V9XPtZO63ChiswJ1UY+AFoeQS8FpHLjH/qU8+dsQgklhDf39/qb7vkT
 KfMYqrEbWpOqHBf6WcZ5wMzK+1BRMZ+WCPY53I1f0q0TCWx+dUlgUWQ+V
 RFMudydn1nzTGjzIdwbuB9X9nOMV8VRlnPvvCZ9G0kqb8oVut9xxR0gEH
 oJf1tzgbWIMDQtiJd8XBUtnDns0chtsKkuLWZAy/fw8udbaPwU4HXHEvd Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="325669247"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="325669247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 04:46:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="569626202"
Received: from amagnus-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.249.46.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 04:46:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: sof_sdw: add support for Dell SKU 0AFF
Date: Mon, 19 Sep 2022 13:46:40 +0200
Message-Id: <20220919114640.42803-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
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

Yet another SKU that needs a quirk for jack detection and four-speaker
support.

BugLink: https://github.com/thesofproject/linux/issues/3777
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a49bfaab6b21f..2ff30b40a1e4c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -266,6 +266,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0AFF")
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2 |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.34.1

