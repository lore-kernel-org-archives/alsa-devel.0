Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656B8C7EE22
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 10:44:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDB581E4;
	Mon, 15 May 2023 12:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDB581E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684147476;
	bh=Rb5w7fWuL05LcXc2sz8XB+x2YMr4XdjNx8H4fxISL9o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fxLPcvj89worgXYtddsNG5n9Pwssq6ByqMNgDnvDAQggxA4Uh0xuXvILQl80JhgT3
	 fRCDkNyi+VkOMDzyPANXF4b4ZJym9k+O0NUAB9AiQCUzlBa1BdkzO7Y9SZutarQAHv
	 UrE8BQTvpdRkTCyoq7VqRuGcyPm5v2FbrRG57NL8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6859AF8016D; Mon, 15 May 2023 12:43:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7005F80272;
	Mon, 15 May 2023 12:43:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A378DF80272; Mon, 15 May 2023 12:43:15 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4F84F8024E
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 12:43:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4F84F8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EXL/U0rn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684147393; x=1715683393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rb5w7fWuL05LcXc2sz8XB+x2YMr4XdjNx8H4fxISL9o=;
  b=EXL/U0rnNi6nXp0n0h7MmGh9wgijMKdKkTUYFz8Ts/Y2Eddhd7KnP29L
   qfnxHP2Cq5lX6XaiGz+XYsZFlqe7QOO7XACu0gSO4nt+nD1qMmMt5n0gJ
   5mjAzag5sb9qcEyFfbD1C4INgUs9Cm180JTuKVQ7LwZq/u1Hk7cVcsU5A
   RTvxu58o1OwxPcauH0HHyeVfVqWVzZztxYkfPW3zgJ8aXz9SNMR7Aa8WS
   0pmuYqajX1CumVLctbzFGcYfHhpiGFchY+1nC3h3J8mLlEKMEOBej4SQC
   sdkQX5OTqzNYhueT3fFE8aE8iky+h4eJnMVaJ8m8IOKnNk74gxpVlcpyn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="353438013"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="353438013"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 03:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="825137461"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="825137461"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.48.230])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 03:43:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	paul.olaru@oss.nxp.com
Subject: [PATCH] ASoC: SOF: Separate the tokens for input and output pin index
Date: Mon, 15 May 2023 13:44:03 +0300
Message-Id: <20230515104403.32207-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7INHUIFL2UXYDUCEO6Q4J2WCWNVNBJWO
X-Message-ID-Hash: 7INHUIFL2UXYDUCEO6Q4J2WCWNVNBJWO
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7INHUIFL2UXYDUCEO6Q4J2WCWNVNBJWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Using the same token ID for both input and output format pin index
results in collisions and incorrect pin index getting parsed from
topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/uapi/sound/sof/tokens.h | 3 ++-
 sound/soc/sof/ipc4-topology.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index bbc37877aaff..e9ec7e4eb982 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -183,7 +183,7 @@
 #define SOF_TKN_CAVS_AUDIO_FORMAT_IN_INTERLEAVING_STYLE	1906
 #define SOF_TKN_CAVS_AUDIO_FORMAT_IN_FMT_CFG	1907
 #define SOF_TKN_CAVS_AUDIO_FORMAT_IN_SAMPLE_TYPE	1908
-#define SOF_TKN_CAVS_AUDIO_FORMAT_PIN_INDEX		1909
+#define SOF_TKN_CAVS_AUDIO_FORMAT_INPUT_PIN_INDEX	1909
 /* intentional token numbering discontinuity, reserved for future use */
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OUT_RATE	1930
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OUT_BIT_DEPTH	1931
@@ -194,6 +194,7 @@
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OUT_INTERLEAVING_STYLE	1936
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OUT_FMT_CFG	1937
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OUT_SAMPLE_TYPE	1938
+#define SOF_TKN_CAVS_AUDIO_FORMAT_OUTPUT_PIN_INDEX	1939
 /* intentional token numbering discontinuity, reserved for future use */
 #define SOF_TKN_CAVS_AUDIO_FORMAT_IBS		1970
 #define SOF_TKN_CAVS_AUDIO_FORMAT_OBS		1971
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 059eebf0a687..5abe616a2054 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -59,7 +59,7 @@ static const struct sof_topology_token ipc4_in_audio_format_tokens[] = {
 		audio_fmt.interleaving_style)},
 	{SOF_TKN_CAVS_AUDIO_FORMAT_IN_FMT_CFG, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, audio_fmt.fmt_cfg)},
-	{SOF_TKN_CAVS_AUDIO_FORMAT_PIN_INDEX, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+	{SOF_TKN_CAVS_AUDIO_FORMAT_INPUT_PIN_INDEX, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, pin_index)},
 	{SOF_TKN_CAVS_AUDIO_FORMAT_IBS, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, buffer_size)},
@@ -79,7 +79,7 @@ static const struct sof_topology_token ipc4_out_audio_format_tokens[] = {
 		audio_fmt.interleaving_style)},
 	{SOF_TKN_CAVS_AUDIO_FORMAT_OUT_FMT_CFG, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, audio_fmt.fmt_cfg)},
-	{SOF_TKN_CAVS_AUDIO_FORMAT_PIN_INDEX, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+	{SOF_TKN_CAVS_AUDIO_FORMAT_OUTPUT_PIN_INDEX, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, pin_index)},
 	{SOF_TKN_CAVS_AUDIO_FORMAT_OBS, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc4_pin_format, buffer_size)},
-- 
2.40.1

