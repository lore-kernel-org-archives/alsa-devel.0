Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CCC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 09:43:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3662164DBD
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 09:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3662164DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8D4616BD;
	Thu, 28 Jan 2021 10:42:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8D4616BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611826993;
	bh=1J4VIJyfAM7PAUB/M6jjO+9pDRjSoyndbqoCbBOp+N8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AexXhFekYmqPTFWgMRLllktEh1oFGeuLVWU1byQu0k7puKd+YfK9SgpM7cfkpLF9Z
	 Gx97a/Zo75tBEKhLBVVEZEtjgpckYexF1Z+ZcMTUHmEySKkPkjx5BPKVqxHP4kvPqc
	 ExkFGf+In7aL4v71LLc8RTaaAs3iZCy/mT7pzZkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0334DF80158;
	Thu, 28 Jan 2021 10:42:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F955F800D1; Thu, 28 Jan 2021 10:42:21 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C26FDF800D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 10:42:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C26FDF800D1
IronPort-SDR: qp7jYTLtyBiyx40LeuY2PZUYpepM+tJow/2N66NWzQp4JhPf/7ZOg3QTBDIVqbAWxlTjZKzjyW
 IOq6S2LzX5/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159380099"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="159380099"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2021 01:42:12 -0800
IronPort-SDR: PF1PHCDvhlYhEyjXQiQ5Pckf5IBKb8Km+An1G6FJH7Gc/86XwPFFLhneEg5aFj1VJtVW6ZeoqD
 cbonsRPbiLzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="369789088"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 28 Jan 2021 01:42:10 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/5] ASoC: SOF: use common code for DSP core pm
Date: Thu, 28 Jan 2021 11:38:45 +0200
Message-Id: <20210128093850.1041387-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Series to refactor the DSP core management:
 - move tracking of powered up DSP cores to common SOF code
 - add logic filter unnecessary power actions
 - modify existing implementations to use common code 
   whenever DSP cores are powered, so the state in common
   code stays in sync

Bard Liao (5):
  ASoC: SOF: Intel: hda: use snd_sof_dsp_core_power_up/down API
  ASoC: SOF: Intel: hda-loader: keep init cores alive
  ASoC: SOF: update dsp core power status in common APIs
  ASoC: SOF: Filter out unneeded core power up/downs
  ASoC: SOF: intel: hda-loader: use snd_sof_dsp_core_power_down/up APIs

 sound/soc/sof/intel/hda-dsp.c    |  2 +-
 sound/soc/sof/intel/hda-loader.c |  9 +++++----
 sound/soc/sof/intel/hda.c        |  2 +-
 sound/soc/sof/loader.c           |  6 ------
 sound/soc/sof/ops.h              | 24 ++++++++++++++++++------
 sound/soc/sof/pm.c               |  1 -
 sound/soc/sof/topology.c         |  8 --------
 7 files changed, 25 insertions(+), 27 deletions(-)


base-commit: e32df142359fb6f4d27977b7652549f0844aa62f
-- 
2.29.2

