Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76997C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8992089D
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Czdu5g+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8992089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61977852;
	Wed, 17 Jun 2020 18:48:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61977852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592412541;
	bh=SeCYAD8trpmc6TyeKj3eK1/VQNcZx6JdF4JmCDwWQao=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Czdu5g+5xGOBGs5qWezkRwmt98ZUEVWjV0ULcXLm2kfGFlZCAkVrmNc8HpeieITdp
	 f3NnTlI3anderYit38hMOr4TXckBqXVsYh7Dv61gk6drsv6gH9jJmNpG3L6Jcwj7lT
	 v4ccGMXIWmg00EPm1EcFLIilXs5BAH61C9YeXDhc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFEBCF800EF;
	Wed, 17 Jun 2020 18:48:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A297F800EF; Wed, 17 Jun 2020 18:48:08 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52815F800EF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 18:48:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52815F800EF
IronPort-SDR: zF2Qq6vEqaFcBGlUr4raTjQVIN3JrfkcErek5dpa5WggvVJcCg2nwbsOUbE/DteDUvldtdByvl
 J37NwcrHcJkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 09:48:01 -0700
IronPort-SDR: 19bC/MPo4kYU5bWbo3gkUSKL34rantg7cwZgvmzCL1ZUQ7yZcO9fXfluZ59+y0RShGCWlN8ByK
 kmioJcOqbXEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="261776791"
Received: from zdsmith-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.128])
 by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2020 09:48:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: SOF: Intel: update PCI IDs
Date: Wed, 17 Jun 2020 11:47:52 -0500
Message-Id: <20200617164755.18104-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
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

Clean-up CometLake and add missing PCI IDs. Changes for the legacy
driver are sent separately.

Pierre-Louis Bossart (3):
  ASoC: Intel: SOF: merge COMETLAKE_LP and COMETLAKE_H
  ASoC: SOF: Intel: add PCI ID for CometLake-S
  ASoC: SOF: Intel: add PCI IDs for ICL-H and TGL-H

 sound/hda/intel-dsp-config.c   |  4 +---
 sound/soc/intel/boards/Kconfig |  4 ++--
 sound/soc/sof/intel/Kconfig    | 29 ++++++++---------------------
 sound/soc/sof/sof-pci-dev.c    | 24 ++++++++++++++----------
 4 files changed, 25 insertions(+), 36 deletions(-)

-- 
2.20.1

