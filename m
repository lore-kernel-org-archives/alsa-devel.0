Return-Path: <SRS0=I1aD=YZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC6CA9ED3
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:45:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8041721928
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mmwN+OL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8041721928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33AF2397;
	Fri,  1 Nov 2019 18:37:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33AF2397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572629874;
	bh=NVuhExEnD+cejrC1NXIc6wftdmdfE26KwLu5HDsD4lc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mmwN+OL6hIh3AREzTXP+mR9QD3eGXc4DVszoZqXk3jzxxAWXVuSzBjhffXCvK+3ea
	 Kq4ruXo2BoZRHvZGAyA17HZ5002wEUTWlxJrewwtnUlOBdtUKcn4Oyvsa9KthN5asP
	 6LmCrklFpxr1Regy0qabridj6HGgFWdhVUWpEfDU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A38EF80677;
	Fri,  1 Nov 2019 18:31:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEBABF805FE; Fri,  1 Nov 2019 18:31:23 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 364DFF80363
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2019 18:30:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 364DFF80363
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 10:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; d="scan'208";a="206457402"
Received: from ggarreto-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.92.243])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2019 10:30:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri,  1 Nov 2019 12:30:34 -0500
Message-Id: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 00/11] ASoC: SOF/Intel: Kconfig
	improvements/fixes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

We have a number of distros who unfortunately selected the wrong
options for SOF. The first patches in this series enforce mutual
exclusions, add explicit developer options and add help text to make
sure SOF or SOF debug options are not selected by mistake.

Patch 5..6 are a follow-up on a report from Arnd Bergman.

Patches 7..11 fix mistakes with dependencies in the board
Kconfig. This should not have any impact for distros but help
developers trying to build a minimal config.

Pierre-Louis Bossart (11):
  ASoC: SOF: Intel: Baytrail: clarify mutual exclusion with Atom/SST
    driver
  ASoC: SOF: Intel: Broadwell: clarify mutual exclusion with legacy
    driver
  ASoC: Intel: add mutual exclusion between SOF and legacy Baytrail
    driver
  ASoC: SOF: Kconfig: add EXPERT dependency for developer options,
    clarify help
  ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency
  ASoC: SOF: Intel: use def_tristate, avoid using select
  ASoC: Intel: Skylake: mark HDAudio codec support as deprecated.
  ASoC: Intel: boards: remove select SND_HDA_DSP_LOADER
  ASoC: Intel: boards: fix configs for bxt-da7219-max98057a
  ASoC: Intel: boards: Geminilake is only supported by SOF
  ASoC: Intel: boards: sof_rt5682: use dependency on SOF_HDA_LINK

 sound/soc/intel/Kconfig         | 17 +++++++++++----
 sound/soc/intel/boards/Kconfig  | 37 ++++++++++++++++++++++++---------
 sound/soc/intel/boards/Makefile |  2 +-
 sound/soc/sof/Kconfig           | 27 ++++++++++++++----------
 sound/soc/sof/imx/Kconfig       |  8 +++++--
 sound/soc/sof/intel/Kconfig     | 24 +++++++++++++++++----
 6 files changed, 83 insertions(+), 32 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
