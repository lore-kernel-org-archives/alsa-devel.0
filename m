Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA66C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287F464EB9
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287F464EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A006826;
	Thu, 18 Feb 2021 23:19:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A006826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613686835;
	bh=bbYSTMBUFyVPOd8MBtWw7cgtsLuY2iDZcxIybJVXIvk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gb5gAb92wNWp17UZl34KYWCcDxrtYImzzVJnbkOrEjq/ccquQJ3boU+N8VftsEbIz
	 QcBFoZPhsjXaLl7X25y+JvRTHr1rY6U0esH+cCdZfT7ShmiMHXk7Zv+e3jTTCQ8z0b
	 Z9DIfvqaw1BKV05BkZAJ7QuvNcw2woqfJzG6tpQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6F1DF8016E;
	Thu, 18 Feb 2021 23:19:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 334C7F8015A; Thu, 18 Feb 2021 23:19:43 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED9E4F800E9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 23:19:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED9E4F800E9
IronPort-SDR: akfwyRtefzH3IE9TGMEy4wHd4xSEktbBrOJQR6TSVbPX0SRa0sOba9bBJr7TmSJ+bGjQTSwiKJ
 lvF4Ej+oqH9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="170801473"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="170801473"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:19:34 -0800
IronPort-SDR: OxDC2ktLve1iPMvbTRNRQu4+tsMRWYW03gtQysxii7VhEcJD2GaazHynRjq43DvWXZ9U+mg/y7
 c7t7NvU3SVIQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="581441979"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.64.38])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:19:34 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ASoC: core: remove cppcheck warnings
Date: Thu, 18 Feb 2021 16:19:15 -0600
Message-Id: <20210218221921.88991-1-pierre-louis.bossart@linux.intel.com>
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

This is the first batch of cleanups to make cppcheck more usable,
currently we have way too many warnings that drown real issues.

Pierre-Louis Bossart (6):
  ASoC: soc-ops: remove useless assignment
  ASoC: soc-pcm: remove redundant assignment
  ASoC: soc-pcm: remove shadowing variable
  ASoC: soc-pcm: add error log
  ASoC: soc-topology: clarify expression
  ASoC: generic: simple-card-utils: remove useless assignment

 sound/soc/generic/simple-card-utils.c |  2 +-
 sound/soc/soc-ops.c                   |  2 +-
 sound/soc/soc-pcm.c                   |  4 ++--
 sound/soc/soc-topology.c              | 16 ++++++++--------
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1

