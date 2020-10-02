Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE21C4363D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:20:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C8820754
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WhAsvcd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C8820754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E5491AB7;
	Fri,  2 Oct 2020 23:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E5491AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601673618;
	bh=9brTSjrGhv9kpjTIXVovYPeCMNLnRAONewmD5bmbXio=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WhAsvcd/K/dw+5O9cy1welm+dj2j4hr1uWw/eTwOoFrlEpcKPCCWhlqZvrgsYt1qM
	 fXnu0/e3t9bcaT2pB2YanEIv4k4gaWWcQRfgz9qbdjfgmcm+hySXK3AcqkXiTwk38A
	 7N50SQHhu88t2/CmL70KCZGA43X6J6rdVITIv4v4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C05ACF80228;
	Fri,  2 Oct 2020 23:19:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 017D9F801A3; Fri,  2 Oct 2020 23:19:25 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DF25F801A3
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 23:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF25F801A3
IronPort-SDR: HwyVtXy8NF3Dnyn/FDL/hK2I4OoZJd8eLYRFLC9YtRtAhK4Nx/fUil0RK6cuQpPTervERPXCgV
 MSvycMB/514g==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247823956"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; d="scan'208";a="247823956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 14:19:16 -0700
IronPort-SDR: 7sQe0XRmTzbkiQa6tqH5Azg/NKZi3I4P66BfzB9BCBdMyeL7A3EIa5jL7PK51tNGkZsMg3QI0V
 TeLbIwOaBScw==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; d="scan'208";a="346580600"
Received: from johnthom-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.158.101])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 14:19:15 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: Intel: sof_sdw: minor corrections
Date: Fri,  2 Oct 2020 16:18:58 -0500
Message-Id: <20201002211902.287692-1-pierre-louis.bossart@linux.intel.com>
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

This small patchset adds a missing component string needed by UCM and
corrects a confusion on Realtek part numbers.

Pierre-Louis Bossart (4):
  ASoC: Intel: sof_sdw_rt1308: add extra check on init
  ASoC: Intel: sof_sdw_rt1316: add missing component string
  ASoC: rt715-sdw: probe with RT714 Device ID
  ASoC: Intel: sof_sdw: add version_id to avoid rt714/rt715 confusion

 sound/soc/codecs/rt715-sdw.c            |  1 +
 sound/soc/intel/boards/sof_sdw.c        | 16 ++++++++++++++++
 sound/soc/intel/boards/sof_sdw_rt1308.c |  4 ++++
 sound/soc/intel/boards/sof_sdw_rt1316.c |  6 ++++++
 4 files changed, 27 insertions(+)

-- 
2.25.1

