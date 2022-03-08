Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF27C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 16:46:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C328182B;
	Tue,  8 Mar 2022 17:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C328182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646758004;
	bh=CAwagsEqu04bePrzLJCuR7FivzNuLB37IygjFWku02k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfVL0m23tef4sh3X/ymRT2SSYFra8/xGareRnhcSOtgzNHObfeZcq5CzHmj62yKML
	 3i2S0i9buixgzxso6XVl2AhTReX0EZNVOsyBDQdO63oiE4rQl3+HUKIlSDbaOoM3rD
	 +jTc/2QghXKtI3Nt+0afokNG5eN2kjVGUO3Z+M10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BFC5F80533;
	Tue,  8 Mar 2022 17:44:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5DF8F80271; Tue,  8 Mar 2022 17:44:15 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12D58F800D2
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 17:44:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12D58F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="HAiKxPjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646757847; x=1678293847;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CAwagsEqu04bePrzLJCuR7FivzNuLB37IygjFWku02k=;
 b=HAiKxPjBifE4Z3PBVR0UEatqE8PygaJx9yuFlfOhSfjfKftFnYaU7GJD
 EbgA7yUQ++nUnxSz6e42NkkZ2lCxYTxJA7ZDur2vTqDAHWs+BxXpBzgag
 JdB3KtKUIr2KZR4dfYnishh15myHr9OsmRyA5oiS/p/3KCsofNW5gGDU6
 haxJTsRsFeTZ324XQ1WZYwirfJxRkR+B8Qmm2Ff7nY/8vI9S4LQpJLEKq
 ZWX5DoF2dVL1MmZlZW7igoOE99dxSMAEfff6AM5YVF7FS6UHSZVxG/rL2
 xzPiD7tX1jYVcoq6sNqrntSVfA/MYdvt7T8qOc76Mp+0ZzZvcO/mVR9wR A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341166848"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="341166848"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="537633274"
Received: from bustam3x-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.251.130.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:58 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 16/18] ASoC: SOF: topology: Rename arguments in
 sof_parse_tokens()
Date: Tue,  8 Mar 2022 08:43:42 -0800
Message-Id: <20220308164344.577647-17-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
References: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

Rename the count and priv_size arguments in sof_parse_tokens() and add
comments to clarify the arguments.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 0683b7d812eb..07edb8d8652c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1024,12 +1024,23 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
 	return 0;
 }
 
-static int sof_parse_tokens(struct snd_soc_component *scomp,
-			    void *object,
-			    const struct sof_topology_token *tokens,
-			    int count,
+/**
+ * sof_parse_tokens - Parse one set of tokens
+ * @scomp: pointer to soc component
+ * @object: target ipc struct for parsed values
+ * @tokens: token definition array describing what tokens to parse
+ * @num_tokens: number of tokens in definition array
+ * @array: source pointer to consecutive vendor arrays in topology
+ * @array_size: total size of @array
+ *
+ * This function parses a single set of tokens in vendor arrays into
+ * consecutive ipc structs.
+ */
+static int sof_parse_tokens(struct snd_soc_component *scomp,  void *object,
+			    const struct sof_topology_token *tokens, int num_tokens,
 			    struct snd_soc_tplg_vendor_array *array,
-			    int priv_size)
+			    int array_size)
+
 {
 	/*
 	 * sof_parse_tokens is used when topology contains only a single set of
@@ -1037,8 +1048,8 @@ static int sof_parse_tokens(struct snd_soc_component *scomp,
 	 * sof_parse_token_sets are sets = 1 (only 1 set) and
 	 * object_size = 0 (irrelevant).
 	 */
-	return sof_parse_token_sets(scomp, object, tokens, count, array,
-				    priv_size, 1, 0);
+	return sof_parse_token_sets(scomp, object, tokens, num_tokens, array,
+				    array_size, 1, 0);
 }
 
 static void sof_dbg_comp_config(struct snd_soc_component *scomp,
-- 
2.25.1

