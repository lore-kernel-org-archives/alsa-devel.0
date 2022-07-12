Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50999C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jul 2022 12:57:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5A18167B;
	Tue, 12 Jul 2022 14:56:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5A18167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657630669;
	bh=PJ2tkf6AHi8d5/vSw9Ip3Hqa3p+/cFXXUY1SC51npvY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=loHtvY1zyemRN4XAWIlUPioPHGiWfBF8INe13zncFJykJLVCGTLgg0xsoTT2z9Kdp
	 6JHRakaULWfJANsIX7YBA6T3DkO+flXnhLUZNUDIWxfuEFIJe5aiPkTRt7WVOAedQY
	 TTs5XCyKngwVojC7zJBbElISUdSC6sE6n5cqlFOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7041DF802DB;
	Tue, 12 Jul 2022 14:56:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B78F8F800BD; Tue, 12 Jul 2022 14:56:57 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B8B0F800BD
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2022 14:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B8B0F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Dcnuk5pR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657630615; x=1689166615;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PJ2tkf6AHi8d5/vSw9Ip3Hqa3p+/cFXXUY1SC51npvY=;
 b=Dcnuk5pRAJq3v2KkdYktIAJczI8BdRmr7Jy9+gHeXuW6T4fXBX9+oOdC
 eVJ+AZ6s69I6bN85vRChxhqrd1eFCTsrVMiwaKEFH2zK/Mq7ZepQJh/VG
 RljpD7EnZfQN7E1YDowKHzNAh1lR7kuwqbdLGfmnAoOSUUbclWYU9Q91i
 NZXQTlAOSBnHQbJwp6f8/s9Lq6f9YDRBYe76XcPewdHYpmMAWuNYoj3WP
 f0kTb+F2c/n/huHxpyLgwaJ+7zqJ3I8uXH3UeoNP2kPR71rn2ZMopPTdc
 RCNDAHuexQ3SdrYn97R+NuXrTSf5TmQbd3X71othGodf27T4XRPShzcDp w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346607568"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; d="scan'208";a="346607568"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 05:56:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; d="scan'208";a="662942891"
Received: from ahedstro-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.254.175])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 05:56:47 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 0/3] ASoC: SOF: Intel: hda: Correct Firmware State Register use
Date: Tue, 12 Jul 2022 15:57:31 +0300
Message-Id: <20220712125734.30512-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, rander.wang@intel.com
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

Hi,

The FSR (Firmware State Register) holds the ROM state information, it does not
contain error information.
The FSR itself is a bit more complicated as well as the state depends on the
module currently in use.

The error code from ROM or the status code from the firmware is located at the
next register.

Fix the handling of the FSR in order to provide usable and human readable (in
most cases) report on the status and error.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: SOF: Intel: hda: Correct the ROM/FW state reporting code
  ASoC: SOF: Intel: hda-loader: Use the FSR state definitions during
    bootup
  ASoC: SOF: Intel: hda: Drop no longer used ROM state definitions

 sound/soc/sof/intel/hda-loader.c |  10 +--
 sound/soc/sof/intel/hda.c        | 147 ++++++++++++++++++++++++++-----
 sound/soc/sof/intel/hda.h        |  69 +++++++++++++--
 3 files changed, 194 insertions(+), 32 deletions(-)

-- 
2.37.0

