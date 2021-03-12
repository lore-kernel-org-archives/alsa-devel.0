Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34981C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:24:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16AD64F52
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16AD64F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 905BB170A;
	Fri, 12 Mar 2021 19:23:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 905BB170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573447;
	bh=TxSvL9Rr0NFHEZK4hT4Ngs5hyRuYtLidJWj/6IvO0L8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hux3RqNvcoC+h3h+GO11l7a0M+zJPUZjAt9xNzW2lbSXpbmQRg/nh21hGCiAtLw6x
	 5ycSB8PttwlMOQV+IQow3Qbf5qIInEMcQXbxF4AMZcJym6AHDT1C+sq2ZVrr51Dbwu
	 QYRg6gvBZOoXz7oWjHWRQ26FG00OLUXIo2Amxi8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92A9AF80217;
	Fri, 12 Mar 2021 19:23:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B67B2F800BF; Fri, 12 Mar 2021 19:23:15 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C407F800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C407F800BF
IronPort-SDR: dLq2gjsXj4X0IpJluBz56w5FdNicaGoMCF+DWQ7+zE/PFr4kWDHEcePJ5L84/hDG3ifv+pbqX+
 oSeN2l04Ls+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185515158"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="185515158"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:05 -0800
IronPort-SDR: dz+4xBIo5L82iNDTeCRE3tKDsS/tPmiFhGcK0H8Hbu73iirH3Xq+mARzzE4qJRL4lpj4kDEPNC
 kDV6h32oMI6w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377791892"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:05 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/23] ASoC: codecs: remove cppcheck warnings
Date: Fri, 12 Mar 2021 12:22:23 -0600
Message-Id: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
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

Lots of small fixes in various codec drivers that should have no
functional impact.

Pierre-Louis Bossart (23):
  ASoC: ab8500-codec: remove useless structure
  ASoC: ad1836: remove useless return
  ASoC: adau1977: remove useless return
  ASoC: cros_ec_codec: remove null pointer dereference warning
  ASoC: cx2070x: remove useless assignment
  ASoC: cx2070x: remove duplicate else branch
  ASoC: da7219-aad: remove useless initialization
  ASoC: hdac_hdmi: remove useless initializations
  ASoC: hdac_hdmi: align function arguments
  ASoC: hdmi-codec: remove useless initialization
  ASoC: hdmi-codec: remove unused spk_mask member
  ASoC: max98090: remove useless assignment
  ASoC: mt6358: remove useless initializations
  ASoC: mt6359: remove useless assignment
  ASoC: nau8825: remove useless assignment
  ASoC: pcm1681: remove useless assignment
  ASoC: sigmadsp: align function prototype
  ASoC: sti-sas: remove unused struct members
  ASoC: tas2562: remove useless assignment
  ASoC: tas2562: remove warning on return value
  ASoC: tas2770: remove useless initialization
  ASoC: tlv320dac33: clarify expression
  ASoC: tscs454: remove useless test on PLL disable

 sound/soc/codecs/ab8500-codec.c  |  7 -------
 sound/soc/codecs/ad1836.c        |  2 --
 sound/soc/codecs/adau1977.c      |  2 --
 sound/soc/codecs/cros_ec_codec.c |  2 +-
 sound/soc/codecs/cx2072x.c       | 11 ++++-------
 sound/soc/codecs/da7219-aad.c    |  2 +-
 sound/soc/codecs/hdac_hdmi.c     | 14 +++++++-------
 sound/soc/codecs/hdac_hdmi.h     |  2 +-
 sound/soc/codecs/hdmi-codec.c    |  3 +--
 sound/soc/codecs/max98090.c      |  2 +-
 sound/soc/codecs/mt6358.c        |  4 ++--
 sound/soc/codecs/mt6359.c        |  4 ++--
 sound/soc/codecs/nau8825.c       |  2 +-
 sound/soc/codecs/pcm1681.c       |  2 +-
 sound/soc/codecs/sigmadsp.h      |  2 +-
 sound/soc/codecs/sti-sas.c       |  3 ---
 sound/soc/codecs/tas2562.c       |  3 +--
 sound/soc/codecs/tas2770.c       |  2 +-
 sound/soc/codecs/tlv320dac33.c   |  2 +-
 sound/soc/codecs/tscs454.c       |  7 ++++++-
 20 files changed, 32 insertions(+), 46 deletions(-)

-- 
2.25.1

