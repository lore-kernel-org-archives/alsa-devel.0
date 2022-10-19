Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B944C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 16:25:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BFA3AEAE;
	Wed, 19 Oct 2022 18:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BFA3AEAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666196701;
	bh=ZDCX/HQsqCpf4HlZUCeSthuxbScKckRID2axud5DfH8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KV3cpzGRZbfsS1bOKClbNpwpyNTGfMEEE8h0ccdBKJaAsEi2IAsveLJsUutCDdvKI
	 aRcndMYjBD3cSIMIMsOrB8WyhUngMASc9mnddEzoJzMvC70MuaDdwz3wlfExSV/+GU
	 /w9BaiH3l2+Bebi5Dtcpsscdp8Ug6I6OKphYcGww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B88F1F80552;
	Wed, 19 Oct 2022 18:23:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB91BF80553; Wed, 19 Oct 2022 18:23:53 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C152F804CB
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 18:23:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C152F804CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MILn5ALV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666196629; x=1697732629;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZDCX/HQsqCpf4HlZUCeSthuxbScKckRID2axud5DfH8=;
 b=MILn5ALVxK3XyfKR+VzdzR7DkgmovPNMiK51g5zwUZHcBflxBdy0ftBM
 cQEUBJ/nBiWQn2RqSZz22cQGw7Dj3ULnFKrpzBlS9kUAQJCEEh4ezsIIc
 O0JYPLzCyHiLJ5ArHl0tRYlEG7jliHcgwtfANWPOsz8NUd392n0I9pRqY
 T3LTxAhUbz3GXVhhSegAZY9cvqbgjLrNghcVPOx/Bo4YRpM5qed6nEFeq
 cdtLWwWaGe0yXM2U6BWJ+Tvz1kri8hx360Q4TkMOzMr1HOwJ99QxR/oA6
 ov6r/N7CIxK+UErSlWFoveduhbA62X8cXfMb9ZHJkKBgFGBwq0qAcIqo1 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286856209"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="286856209"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 09:21:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="698153807"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="698153807"
Received: from afsinurr-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.16.185])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 09:21:24 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/10] ALSA/ASoC: hda: cleanup sound/hda/ext code
Date: Wed, 19 Oct 2022 11:21:05 -0500
Message-Id: <20221019162115.185917-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org,
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

The code in sound/hda/ext can be cleaned-up. This patchset suggests a
more consistent use of prefixes and variable names. It also removes
useless code, uses helpers when possible, and clarifies an incorrect
assumption that SPIB/DRMS capabilities are tied to Intel multi-link
and DSP extensions (they are not).

This is a rather invasive set of changes touching sound/hda,
sound/soc/intel/skylake, sound/soc/intel/avs and sound/soc/sof/intel,
but there should be no change in terms of functionality.

I would recommend merging these changes through the ASoC tree.

Pierre-Louis Bossart (10):
  ALSA: hda: ext: hdac_ext_controller: use helpers in loop
  ALSA: hda: ext: hda_ext_controller: use hlink variable/parameter
  ASoC: SOF: Intel: hda-dai: use hlink variable/parameter
  ALSA/ASoC: hda: clarify bus_get_link() and bus_link_get() helpers
  ALSA/ASoC: hda: ext: add 'ext' prefix to snd_hdac_link_free_all
  ALSA/ASoC: hda: ext: remove 'link' prefix for stream-related
    operations
  ALSA/ASoC: hda: ext: add 'bus' prefix for multi-link stream setting
  ALSA: hda: ext: reduce ambiguity between 'multi-link' and 'link' DMA
  ALSA: hda: hdac_ext_controller: remove useless loop
  ALSA/ASoC: hda: move SPIB/DRMS functionality from ext layer

 include/sound/hdaudio.h                |  26 ++++
 include/sound/hdaudio_ext.h            |  66 ++------
 sound/hda/ext/hdac_ext_controller.c    | 116 ++++++++------
 sound/hda/ext/hdac_ext_stream.c        | 203 +++----------------------
 sound/hda/hdac_stream.c                | 136 +++++++++++++++++
 sound/soc/codecs/hda.c                 |   4 +-
 sound/soc/codecs/hdac_hda.c            |   6 +-
 sound/soc/codecs/hdac_hdmi.c           |   8 +-
 sound/soc/intel/avs/core.c             |   2 +-
 sound/soc/intel/avs/loader.c           |  16 +-
 sound/soc/intel/avs/pcm.c              |  16 +-
 sound/soc/intel/skylake/skl-messages.c |   6 +-
 sound/soc/intel/skylake/skl-pcm.c      |  35 +++--
 sound/soc/intel/skylake/skl.c          |   2 +-
 sound/soc/sof/intel/hda-dai.c          |  42 ++---
 sound/soc/sof/intel/hda-pcm.c          |   3 +-
 sound/soc/sof/intel/hda-stream.c       |  16 +-
 sound/soc/sof/intel/hda.c              |   2 +-
 18 files changed, 343 insertions(+), 362 deletions(-)

-- 
2.34.1

