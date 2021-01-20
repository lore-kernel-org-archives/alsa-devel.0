Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 15:31:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4861F23358
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 15:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4861F23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5083417F8;
	Wed, 20 Jan 2021 16:30:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5083417F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611156675;
	bh=DvqBS0cnT3E2twVNsimmHVIPTXdE3MNmMJU2zXZIdEA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hvkgj5GqBelyWIzb3LqM9MlWNJGwiWLwomS3uxLNtk5m02PTvwxp0hQAtmfXtPxa9
	 sKjEmOHlPqDisY2LlK0bH2cLV7c1dlNmsS9DFyHSDlMNSP5ULYw4FvnvdTWJ0R7Vgk
	 Sncf8dn7uhR5aTCAwGtx+vdt7vU7BlO1zDpuF7dI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F424F80227;
	Wed, 20 Jan 2021 16:29:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85CE0F802BE; Wed, 20 Jan 2021 16:29:08 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 110EFF80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 16:29:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 110EFF80164
IronPort-SDR: q+4vPyFLpkQuJmI/0Cconj37iaCssw3vvFbzahoJk0fYtbAksz20hQrlbX1msF8SxuesfZOj1Z
 8EoSb88zESrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="197850617"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="197850617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 07:28:54 -0800
IronPort-SDR: /U5XH3hz/kCeKJWU6D+BCo/WsOZKWrFYk9+4DRKXyngpFh9duf6gV2rtMGbNGcjB11qSSYddOW
 M/RfEjD12qww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="354347824"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by orsmga006.jf.intel.com with ESMTP; 20 Jan 2021 07:28:51 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/5] Add KUNIT tests for ASoC topology
Date: Wed, 20 Jan 2021 16:28:41 +0100
Message-Id: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

This series adds unit tests for ASoC topology.

First fix problems found when developing and running test cases and
then add tests implementation.

Tests themselves are quite simple and just call
snd_soc_tplg_component_load() with various parameters and check the
result. Tests themselves are described in more detail in commits
adding them.

Goal is to expand the amount of test cases in following patches.

Prerequisity for this patchset are 2 patches which have already been
sent:
https://lore.kernel.org/alsa-devel/20210114163602.911205-1-amadeuszx.slawinski@linux.intel.com/T/#t

Description on how typical test case itself works:

In order to load topology we need to have 3 things:
card, codec component & platform component.

In typical test case we register card and platform component and bind
to dummy codec. There are of course execeptions, when we want to
test behaviour of topology API when component or card is missing.
Note that this is bit different from typical scenario (in SOF and skylake
drivers) where card is registered by machine driver and component by
platform driver, as we register both when setting up test.

If you check the test case most of them have similar architecture of:
1.
	/* run test */
	ret = snd_soc_register_card(&kunit_comp->card);
	if (ret != 0 && ret != -EPROBE_DEFER)
		KUNIT_FAIL(test, "Failed to register card");

2.
	ret = snd_soc_component_initialize(&kunit_comp->comp, &test_component, test_dev);
	KUNIT_EXPECT_EQ(test, 0, ret);

3.
	ret = snd_soc_add_component(&kunit_comp->comp, NULL, 0);
	KUNIT_EXPECT_EQ(test, 0, ret);

Ad. 1.
First we register card, which in most tests returns -EPROBE_DEFER
(from snd_soc_bind_card()), as platform component is not yet created.
I test for both 0 and -EPROBE_DEFER, as it makes it easier to reshuffle
this code around if needed and there is one test case which does it in
different order.

Ad. 2.
Then we initialize platform component with structure pointing at proper
probe function, which calls snd_soc_tplg_component_load() with test
parameters and checks expected result.

Ad. 3.
And then in follow up we call snd_soc_add_component() which creates
platform component for us and calls snd_soc_try_rebind_card() which
if everything is bound properly calls previously set probe function.

Amadeusz Sławiński (5):
  ASoC: topology: Properly unregister DAI on removal
  Revert "ASoC: soc-devres: add devm_snd_soc_register_dai()"
  ASoC: topology: KUnit: Add KUnit tests passing various arguments to
    snd_soc_tplg_component_load
  ASoC: topology: KUnit: Add KUnit tests passing empty topology with
    variants to snd_soc_tplg_component_load
  ASoC: topology: KUnit: Add KUnit tests passing topology with PCM to
    snd_soc_tplg_component_load

 include/sound/soc.h           |   4 -
 sound/soc/Kconfig             |  17 +
 sound/soc/Makefile            |   5 +
 sound/soc/soc-devres.c        |  37 --
 sound/soc/soc-topology-test.c | 843 ++++++++++++++++++++++++++++++++++
 sound/soc/soc-topology.c      |   9 +-
 6 files changed, 870 insertions(+), 45 deletions(-)
 create mode 100644 sound/soc/soc-topology-test.c

-- 
2.25.1

