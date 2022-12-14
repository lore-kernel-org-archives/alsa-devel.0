Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E640C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 10:55:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 366311707;
	Wed, 14 Dec 2022 11:54:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 366311707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671015307;
	bh=RTH1ZULx0uV/HvODs6IX7TRnibOuuAQaLUW7WuCJsP0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ma0qi3OmGTf7xbBmFn+t50q45FJpuNDgodmtVhoW7i/VBzXM5KGDgsZHPRwTTPSfQ
	 wsyWU0GtKUmvKfEKS+00aI9gCz+xGSE0Dq4Modzz8+PMp8ZizvPmlvCg7ieFvNbMTn
	 ZHebDLOihVoXw8k5ggBAtP42bBPKtTg1RnDthEsE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E51E2F804D7;
	Wed, 14 Dec 2022 11:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 468E4F804D7; Wed, 14 Dec 2022 11:54:16 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FFBBF801D5
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 11:54:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FFBBF801D5
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KKXfMwNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671015255; x=1702551255;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RTH1ZULx0uV/HvODs6IX7TRnibOuuAQaLUW7WuCJsP0=;
 b=KKXfMwNE7tmPu7qHrdEWUJWYKgIuM2iVUptZGEDFSyM/NlaskpAdCvG/
 roI7jgBFOX8l370f9kjEhzQNXxo/Mr/9QIlicehRwBktAKLWugKP8VLXp
 pX3NtdNbl5wX0ZDDiNUwj3DtMhgCkx4Gg62y1A0djr8KcS/j1FMXf1kO0
 gILornIUh2vD/Rcvco+C7Xdv5VcX1HZip1ImYC2rl0Rly0OHl6DQUjIJM
 kzbmO02uWzJVtdFhbxi4Mw03Hbp1cGc0plfqXm8y/869VFrWfkTwZx4Al
 4DtTXy9lVY7taW+5LNmTAmrLhmFrLP6PGIqRXbsdz3wmmqd7fe1JdnNTm Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="318412862"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; d="scan'208";a="318412862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2022 02:54:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="679653300"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; d="scan'208";a="679653300"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga008.jf.intel.com with ESMTP; 14 Dec 2022 02:54:09 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] Add support for DSP volume controls
Date: Wed, 14 Dec 2022 19:54:56 +0100
Message-Id: <20221214185500.3896902-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Some devices like DMIC don't expose native controls or need volume limit
due to possible HW damage. Add support for volume controls allowing to
change volume level in DSP. Maximum volume level is imposed by the
topology file which defines given path.

Amadeusz Sławiński (4):
  ASoC: Intel: avs: Add peakvol runtime-parameter requests
  ASoC: Intel: avs: Add control volume operations
  ASoC: Intel: avs: Parse control tuples
  ASoC: Intel: avs: Peakvol module configuration

 include/uapi/sound/intel/avs/tokens.h |   4 +
 sound/soc/intel/avs/Makefile          |   2 +-
 sound/soc/intel/avs/control.c         | 105 ++++++++++++++++++++++++++
 sound/soc/intel/avs/control.h         |  23 ++++++
 sound/soc/intel/avs/messages.c        |  29 +++++++
 sound/soc/intel/avs/messages.h        |  33 ++++++++
 sound/soc/intel/avs/path.c            |  62 +++++++++++++++
 sound/soc/intel/avs/topology.c        |  76 +++++++++++++++++++
 sound/soc/intel/avs/topology.h        |   3 +
 9 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/avs/control.c
 create mode 100644 sound/soc/intel/avs/control.h

-- 
2.25.1

