Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169CC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:51:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77A864EFE
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77A864EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D26921660;
	Fri,  5 Feb 2021 19:50:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D26921660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612551059;
	bh=9PmQp3otCUTxwI45UCU4lcfuynK1AEfcM77NtKAbKlc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JijNI1sORjimsbHVCHmlV2Y/PHCwel1+9BwpMSoUSoFIiORqMLuI/3Dwa90+sOKIb
	 YS7wkx6073e2hvlX+I0YAt/WRTaWuleSRq9LNynMYqzgpF2UuezqFAPqd7rho+10mu
	 av8F8r3PUyUlzmbvrgvewzq+EQJdFvYc24969v+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A5D1F8016E;
	Fri,  5 Feb 2021 19:50:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CB90F800C0; Fri,  5 Feb 2021 19:50:07 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9C49F800C0
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 19:50:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9C49F800C0
IronPort-SDR: cBeeWJKzltHttLnx6PVB0UJuA84X5f4XtrPlj9BF2Ec2I7rrt2+MAZ+TfBlMqPBoo2rarIpieg
 gwbqAN0CYxtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="178914203"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="178914203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 10:49:59 -0800
IronPort-SDR: ZOnn4ChEQbSvTfvsAmto6L/hgfvvW5jAMT/y3iD+t1rKigL1j4snnPgPrpdQMOiOTitDVXddM1
 7HsT4S/kn+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="508632679"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 10:49:58 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH v2 0/3] ALSA: hda: add link_power op to hdac_bus_ops
Date: Fri,  5 Feb 2021 20:46:27 +0200
Message-Id: <20210205184630.1938761-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

Here's the 2nd iteration of the patch to improve link management
granularity between controllers using HDA extended bus and HDA
codec drivers.

Based on feedback to V1, this now adds a new link_power op.
This allows to decouple HDA codec drivers from the hdac_ext core.

I also included two patches to SOF to show how this interface is
used in SOF.

Kai Vehmanen (3):
  ALSA: hda: add link_power op to hdac_bus_ops
  ASoC: SOF: Intel: hda: use hdac_ext fine-grained link management
  ASoC: SOF: Intel: hda: release display power at link_power

 include/sound/hdaudio.h             | 14 ++++-------
 include/sound/hdaudio_ext.h         |  2 ++
 sound/hda/ext/hdac_ext_controller.c | 37 +++++++++++++++++++++++++++++
 sound/hda/hdac_bus.c                | 23 ++++++++++++++++++
 sound/hda/hdac_controller.c         | 14 +++++++++++
 sound/soc/sof/intel/hda-bus.c       | 33 ++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h           |  3 ++-
 7 files changed, 115 insertions(+), 11 deletions(-)


base-commit: 387740a5e9532db13dfb577bd4b8d1aa496487ab
-- 
2.29.2

