Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF8C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:40:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A8C20809
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HfmU6rZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A8C20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 087CF1746;
	Wed, 29 Jul 2020 09:39:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 087CF1746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596008406;
	bh=TkQ51LBFKROrZjZo1oZLDifO5pmMOaCbmlcfYmoFqdQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HfmU6rZajUMlyG6PDwfeNRpoa+VPjaHKU10ITNvPVy7q/30zQw+eV4mi2oL/r2tVh
	 4/idTJQtjLmLrB6u+US4AYF3SjzC8lFL2WLBwvwvj9HrCfqlU9QPqb6lhVm02Edijg
	 Q1xg1TX2Y80+qo2nRE7O18NykP2v7OMoBxcrtx1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDB7AF80232;
	Wed, 29 Jul 2020 09:38:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9772DF801ED; Wed, 29 Jul 2020 09:38:20 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EBDEF80171
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 09:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EBDEF80171
IronPort-SDR: k04fQceD1X3Fk/cGqfSC2gOnjYgcoAFQEGkfQerVDkPNp7Ao83fuR/H/uWhxUWpaXWvrBwqU4r
 mDv8xCnEEvYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="149216417"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; d="scan'208";a="149216417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 00:38:00 -0700
IronPort-SDR: GRp/kI6xIrCYBkzX3bYtCDLvtXoMQBZXy6wYT0yiNwg4J9LdSgigxY7UzxaAmCm+2SU3NTpnzV
 LIzqxxmnVJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; d="scan'208";a="434604190"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 00:37:57 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: codec: tlv3204: Codec workaround
Date: Wed, 29 Jul 2020 15:32:53 +0800
Message-Id: <20200729073256.24028-1-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, a-estrada@ti.com, andriy.shevchenko@intel.com,
 zakkaye@ti.com, tiwai@suse.com, jee.heng.sia@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, dmurphy@ti.com
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

This patch series enables some features on the tlv3204 codec
and also fixes some issues faced while testing

v1: initial ASoC: codec: tlv3204: Codec workaround series

Michael Sit Wei Hong (3):
  ASoC: codec: tlv3204: Enable 24 bit audio support
  ASoC: codec: tlv3204: Increased maximum supported channels
  ASoC: codec: tlv3204: Moving GPIO reset and add ADC reset

 sound/soc/codecs/tlv320aic32x4.c | 60 +++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 16 deletions(-)

-- 
2.17.1

