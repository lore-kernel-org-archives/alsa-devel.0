Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A3C41537
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:12:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7BB610EA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D7BB610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C61717DB;
	Fri, 13 Aug 2021 17:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C61717DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628867550;
	bh=FEDRmmpHo7gb1qRGTp+PU5GRsnbpPa6goE7sfS1lRGY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WHctDwyitCVVvYO2bbM6/QSJ73ZrY/esGHTZ8DVrlTe0IVjIygQyjY6qlhsZywTNq
	 x97bouP32MmlQ4KjnTwg2ysO+ZOJDh41G0WWgkg6jqyHJLWKqrzIptIzuH8MF683UZ
	 YS2vp0u8b1073lf3RDPtwuOrDOMDa4ORsUv4p0Os=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98F93F804CC;
	Fri, 13 Aug 2021 17:11:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5555CF80129; Fri, 13 Aug 2021 17:11:36 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D9C9F80129
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 17:11:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D9C9F80129
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215301872"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="215301872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="422888853"
Received: from mchatter-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:26 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 0/8] ASoC: Intel: boards: use software node API
Date: Fri, 13 Aug 2021 10:11:08 -0500
Message-Id: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

This is an update on an earlier contribution from Heikki Krogerus

The function device_add_properties() is going to be removed.
Replacing it with software node API equivalents.

Thanks for Hans de Goede and Andy Shevchenko for their comments,
suggestions and Reviewed-by tags on GitHub. The review thread can be
found at https://github.com/thesofproject/linux/pull/3041)

v3 changes:
Fixed nit-picks from Andy: label, return value, missing commas/periods.
Added Andy's Reviewed-by tag

v2 changes: feedback from Andy and Hans
Better error handling
Codec reference is kept until the .remove callback
Remove bus search to find device

v1 changes from Heikki's patches:
Avoid the use of devm_ routines for Baytrail machine drivers.

Heikki Krogerus (1):
  ASoC: Intel: boards: use software node API in Atom boards

Pierre-Louis Bossart (7):
  ASoC: Intel: boards: harden codec property handling
  ASoC: Intel: boards: handle errors with acpi_dev_get_first_match_dev()
  ASoC: Intel: boards: get codec device with ACPI instead of bus search
  ASoC: Intel: sof_sdw: pass card information to init/exit functions
  ASoC: Intel: sof_sdw_rt711*: keep codec device reference until remove
  ASoC: Intel: use software node API in SoundWire machines
  ASoC: Intel: remove device_properties for Atom boards

 sound/soc/intel/boards/bytcht_es8316.c      | 31 ++++++++--
 sound/soc/intel/boards/bytcr_rt5640.c       | 60 +++++++++++++++-----
 sound/soc/intel/boards/bytcr_rt5651.c       | 63 ++++++++++++++-------
 sound/soc/intel/boards/sof_sdw.c            | 20 ++++---
 sound/soc/intel/boards/sof_sdw_common.h     | 37 +++++++-----
 sound/soc/intel/boards/sof_sdw_max98373.c   |  3 +-
 sound/soc/intel/boards/sof_sdw_rt1308.c     |  3 +-
 sound/soc/intel/boards/sof_sdw_rt1316.c     |  3 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c     |  3 +-
 sound/soc/intel/boards/sof_sdw_rt700.c      |  3 +-
 sound/soc/intel/boards/sof_sdw_rt711.c      | 51 +++++++++--------
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 52 +++++++++--------
 sound/soc/intel/boards/sof_sdw_rt715.c      |  3 +-
 sound/soc/intel/boards/sof_sdw_rt715_sdca.c |  3 +-
 14 files changed, 223 insertions(+), 112 deletions(-)

-- 
2.25.1

