Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE14DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:14:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C54E205CB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H8Hydqzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C54E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFD231672;
	Fri, 15 May 2020 23:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFD231672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589577245;
	bh=PHPmH50k5vZUR94M0RIU7heAetiOwSug+iZrRAsvxL8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H8Hydqzds2TTNOkUE8WQBPZaxJwYi01Hz3AjIvC4wERoVEl/j4sjtKK7ety9ybSb4
	 8q05qDIU5yyc8yriPHNX+tHsshs9E2skZo8Ykvhl3cZxjCDg9ePLmeUm6rDjxGrMx/
	 1lmLjT0t3WkRT7uf/zNoO0FroE23MjW+oMulRJZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 970F7F802A7;
	Fri, 15 May 2020 23:10:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42E99F80247; Fri, 15 May 2020 23:08:45 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 240E6F800B8
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 23:07:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 240E6F800B8
IronPort-SDR: mjP/ENr7pxx/Vte2zNGS7WZMwPtqX1qN5KYXwd7kBr4p6XhKpHeEd9FJvU0D3ayEQV5FR0MLZM
 ZFibHmSGhoAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 14:07:55 -0700
IronPort-SDR: zod3VTfx3x+1zYV8CN6iwWjkGTQIkVi6T/5n8R2mnEblTcmPLQUXRxNsNlQgDuN7HNTwIqE0xy
 23FHBfhp+JAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="410589909"
Received: from btchambe-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.66.225])
 by orsmga004.jf.intel.com with ESMTP; 15 May 2020 14:07:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: Intel: minor fixes to machine drivers
Date: Fri, 15 May 2020 16:07:26 -0500
Message-Id: <20200515210731.10942-1-pierre-louis.bossart@linux.intel.com>
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

Minor button remap changes, inspired by recent Chromebook patches,
typo in component string reported by Jaroslav and driver name change
not submitted in last wm8804 contribution.

Pierre-Louis Bossart (5):
  ASoC: Intel: soc-acpi: change machine driver name for WM8804 platforms
  ASoC: Intel: sof_sdw: fix typo in components string
  ASoC: Intel: sof_sdw_rt711: remap buttons
  ASoC: Intel: sof_sdw_rt700: remap buttons
  ASoC: Intel: cht_bsw_nau8824: remap BTN_0 as KEY_PLAYPAUSE

 sound/soc/intel/boards/cht_bsw_nau8824.c          | 4 ++--
 sound/soc/intel/boards/sof_sdw.c                  | 2 +-
 sound/soc/intel/boards/sof_sdw_rt700.c            | 8 ++++----
 sound/soc/intel/boards/sof_sdw_rt711.c            | 8 ++++----
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)


base-commit: d731c1a0f935dbebf4a851e072f8c7309eb2b8c5
-- 
2.20.1

