Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A04C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 21:38:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52D361185
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 21:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D361185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E4B918A0;
	Tue, 11 May 2021 23:37:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E4B918A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620769115;
	bh=D5Z3d6E/kP669+BztM+ShYwzhDFHgFxM1VreNwJoW3I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=stbNO12EnM1KyGOIoqKNNylKZ2PscHwN9MUa9mdTc2NfqmY9sEwmy6pRqMuDP1LJ+
	 9SFlLvM/odAq7FqCBgPi44Q70Yjy/QRjywc+4xXttgDVP+N+1pwMq5XjR8+cNUUZCm
	 xrP3n93LWBFIKsBKe3mj1e6jF9YkHi0rTL74WKoM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D14E3F8028D;
	Tue, 11 May 2021 23:37:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F004FF80279; Tue, 11 May 2021 23:37:42 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 434D5F80156
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 23:37:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 434D5F80156
IronPort-SDR: 7qOh1hMoUPnj/K6iM0Y24SxTghZHm3w3KSNOOYz2RzSx4OJ1DKaKtYRP9nX9HSJzrpe3KNLmuH
 Zu6Xi0Q0+RGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186992036"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="186992036"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 14:37:31 -0700
IronPort-SDR: hejaC4vDV/ZZ/bdpopyJW3E8dR3paDY2JgE0UhypgF6MP0g9GAv48oh27YIcbhvi5Pij+tO/hN
 zC7uPzG9nG8A==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="469098895"
Received: from seanwol-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.100.14])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 14:37:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/9] ASoC: SOF/Intel: fix and remove Sparse warnings
Date: Tue, 11 May 2021 16:36:58 -0500
Message-Id: <20210511213707.32958-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

We updated our SOF CI settings last week (see below) to use more options
for Sparse, and sure enough it detected one nasty single-character bug
in one of my previous patches, along with more trivial issues with
string/integer sizes and signed/unsigned confusions.

export ARCH=x86_64
export CF="-Wsparse-error -Wsparse-all -Wno-bitwise-pointer -Wno-pointer-arith -Wno-typesign -Wnoshadow"
make -k sound/soc/sof/ C=2
make -k sound/soc/intel/common/ C=2
make -k sound/soc/intel/boards/ C=2
make -k drivers/soundwire/ C=2

Pierre-Louis Bossart (9):
  ASoC: SOF: Intel: hda: fix index used in inner loop
  ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
  ASoC: Intel: sof_cs42l42: shrink platform id below 20 characters
  ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20
    characters
  ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20
    characters
  ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20
    characters
  ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20
    characters
  ASoC: Intel: sof_sdw: fix signed/unsigned warning
  ASoC: Intel: soc-acpi: add ull suffix for SoundWire _ADR values

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 +++---
 sound/soc/intel/boards/glk_rt5682_max98357a.c |  4 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c |  4 +-
 sound/soc/intel/boards/sof_cs42l42.c          |  2 +-
 sound/soc/intel/boards/sof_da7219_max98373.c  |  8 ++--
 sound/soc/intel/boards/sof_rt5682.c           | 20 +++++-----
 sound/soc/intel/boards/sof_sdw.c              |  2 +-
 .../intel/common/soc-acpi-intel-adl-match.c   | 28 +++++++-------
 .../intel/common/soc-acpi-intel-bxt-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-cml-match.c   | 22 +++++------
 .../intel/common/soc-acpi-intel-cnl-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-glk-match.c   |  6 +--
 .../intel/common/soc-acpi-intel-icl-match.c   | 12 +++---
 .../intel/common/soc-acpi-intel-jsl-match.c   |  6 +--
 .../intel/common/soc-acpi-intel-kbl-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-tgl-match.c   | 38 +++++++++----------
 sound/soc/sof/intel/hda.c                     |  2 +-
 17 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.25.1

