Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3192C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 16:47:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 037CB17CF;
	Tue,  8 Mar 2022 17:47:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 037CB17CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646758071;
	bh=PzxFyLd/rO91ybtvgJOJHOWIs23pguPCAA7eI9h9IgA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BUlzZBdYiA4qw9SkypzxpgBmLHqTfGxOuvBw0r2G9W5EVfgWgnyjA8WTOJMqA6dH8
	 yIVxgvoCXO+Ro18VNgOkBlPPhywa3QhEhVj3CPesXTzwu1BbDjY75m6GM5IWruoxQ3
	 rfiNcve1AYWIl7GYM3a9HmhpxoG0sgF9S/jYVmGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3BE0F80544;
	Tue,  8 Mar 2022 17:44:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37639F80533; Tue,  8 Mar 2022 17:44:20 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A861F804F3
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 17:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A861F804F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="F68nfVvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646757851; x=1678293851;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PzxFyLd/rO91ybtvgJOJHOWIs23pguPCAA7eI9h9IgA=;
 b=F68nfVvF5dPlRpTADbmZLqE+HsWFqz0MiGA/B5Q37PIT4OtQpS8x1ovz
 NpjxHrTJKkQ45K1b/tyrsacnc8CILIX2wDiyiM8BfuynVnKigXQp9HMee
 40sGgp7EUUh6s+4RkNDlrhrQSrmiMaQTzHt+fa7VK88HtEWFdGp99ITe1
 mG+1/o4BQMYP7Vk8imnMva0/qtOSuHRLsNSGOZ82rqR/7RPuPMYN9uilx
 JrTxcT9/zcuG/w8bD68w1LyEHu839KvhcFahj0ECR84JLJN1NTyKJOvUw
 +Wv8v7ivhNprYSt4YD7dJpyS+zbgzRYxRUmQZ4usN4wrN8I3KnAvZktA7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252307198"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252307198"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="537633201"
Received: from bustam3x-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.251.130.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:51 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 00/18] Clean ups and preparation for IPC abstraction in the
 SOF driver
Date: Tue,  8 Mar 2022 08:43:26 -0800
Message-Id: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 amadeuszx.slawinski@linux.intel.com
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

In preparation for adding support for the new IPC version that has been
introduced in the SOF firmware, this patch set includes some clean ups
and necessary modifications to commonly used functions that will be
re-used across different IPC-specific code.

Changes in v2:
- Use guid_t instead of u8 array for uuid and the helper guid_is_null()

Pierre-Louis Bossart (1):
  ASoC: SOF: sof-audio: removed unused function

Rander Wang (1):
  ASoC: SOF: move definition of snd_sof_ipc to header file

Ranjani Sridharan (16):
  ASoC: SOF: remove snd_sof_pipeline_find()
  ASoC: SOF: simplify snd_sof_device_remove()
  ASoC: SOF: set swidget's core for scheduler widget
  ASoC: SOF: topology: remove redundant code
  ASoC: SOF: topology: remove redundant code in sof_link_afe_load()
  ASoC: SOF: topology: Drop the size parameter from struct
    sof_topology_token
  ASoC: SOF: topology: Modify the get_token op for string tokens
  ASoC: SOF: topology: expose some get_token ops
  ASoC: SOF: change comp_dai to a pointer in struct snd_sof_dai
  ASoC: SOF: make struct snd_sof_widget IPC agnostic
  ASoC: SOF: topology: make sof_route_load() IPC agnostic
  ASoC: SOF: Add a tuples array to struct snd_sof_widget
  ASoC: SOF: topology: Modify signature for token parsing functions
  ASoC: SOF: topology: Rename arguments in sof_parse_token_sets()
  ASoC: SOF: topology: Rename arguments in sof_parse_tokens()
  ASoC: SOF: make struct snd_sof_dai IPC agnostic

 include/sound/sof/dai.h       |   5 +
 include/sound/sof/topology.h  |   8 -
 sound/soc/sof/core.c          |  10 +-
 sound/soc/sof/intel/hda-dai.c |  27 ++-
 sound/soc/sof/intel/hda.c     |  39 +++-
 sound/soc/sof/ipc.c           |  12 --
 sound/soc/sof/pcm.c           |  77 +++----
 sound/soc/sof/sof-audio.c     | 108 +++-------
 sound/soc/sof/sof-audio.h     |  30 ++-
 sound/soc/sof/sof-priv.h      |  12 ++
 sound/soc/sof/topology.c      | 392 +++++++++++++++++-----------------
 11 files changed, 354 insertions(+), 366 deletions(-)

-- 
2.25.1

