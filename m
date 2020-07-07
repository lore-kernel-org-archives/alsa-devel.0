Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJECT_NEEDS_ENCODING,SUBJ_ILLEGAL_CHARS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590CC433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:08:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEB220738
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b2OOMNsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEB220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 050131682;
	Tue,  7 Jul 2020 21:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 050131682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594148909;
	bh=3sOyg+O0NorRWW1SVDHL+1/gc3wo0xpa8K1UbqcqAh8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b2OOMNsg1HCmJtV+zWAViRTkvIL3EniI8sZKltiRSry3ZAUCiIYO2a+rbgbyLnjEs
	 OnBEOqHN5VFCiFPdVDgiSk2STrW1qygMUa66HcXJ7LNum6032DaB4XCqK3k6ID+1LL
	 9jyyEhctVwF0fwtWfoq3h76sOT3dGnLExFxQKbuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5C1CF802DB;
	Tue,  7 Jul 2020 21:06:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDCBFF802BE; Tue,  7 Jul 2020 21:06:44 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5A80F8025A
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5A80F8025A
IronPort-SDR: zaMcggbJqA4GIPZ5+XcyhOa2U38LL/afvNKDhlPQuShbVZAzrC4Qk6ibinMURp+ealzpSti47v
 BrF/sfAMmQrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149202886"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="149202886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:06:28 -0700
IronPort-SDR: TlEMDsVMAQX9iQaP3HK7C9nEyiGG2NqWRogNThvmKde6GjjYku6E9QUY120M14RPnTXG+4Q69c
 1RG6FhHozRcg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="268278515"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:06:28 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 00/13] ASoC: Clean-up W=1 build warnings​ - part1
Date: Tue,  7 Jul 2020 14:05:59 -0500
Message-Id: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Lee Jones <lee.jones@linaro.org>,
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

Both Lee Jones and I submitted separate series, this is the first part
of the merged result, which includes all previously reviewed patches
or suggested changes along with trivial ones for CONFIG_ACPI.

Lee Jones (2):
  ASoC: codecs: jz4770: Remove defined but never used variable
    'mic_boost_tlv'
  ASoC: ti: omap-mcbsp-st: Remove set, but unused variable 'w'

Pierre-Louis Bossart (11):
  ASoC: atmel: fix kernel-doc
  ASoC: samsung: spdif: fix kernel-doc
  ASoC: samsung: pcm: fix kernel-doc
  ASoC: tegra: tegra20_das: remove always-true comparison
  ASoC: uniphier: aio-core: fix kernel-doc
  ASoC: codecs: da7210: fix kernel-doc
  ASoC: codecs: da7219: fix 'defined but not used' warning
  ASoC: codecs: cros_ec_codec: fix 'defined but not used' warning
  ASoC: codecs: es8316: fix 'defined but not used' warning
  ASoC: codecs: max98390: fix 'defined but not used' warning
  ASoC: codecs: rt*: fix 'defined but not used' warning

 sound/soc/atmel/atmel-pcm-dma.c  |  2 +-
 sound/soc/atmel/atmel_ssc_dai.c  |  1 +
 sound/soc/codecs/cros_ec_codec.c |  2 ++
 sound/soc/codecs/da7210.c        | 12 +++++++-----
 sound/soc/codecs/da7219.c        |  2 ++
 sound/soc/codecs/es8316.c        |  2 ++
 sound/soc/codecs/jz4770.c        |  1 -
 sound/soc/codecs/max98390.c      |  8 --------
 sound/soc/codecs/rt274.c         |  2 ++
 sound/soc/codecs/rt286.c         |  2 ++
 sound/soc/codecs/rt298.c         |  2 ++
 sound/soc/codecs/rt5660.c        |  2 ++
 sound/soc/codecs/rt5677-spi.c    |  2 ++
 sound/soc/samsung/pcm.c          |  5 +++++
 sound/soc/samsung/spdif.c        |  6 +++---
 sound/soc/tegra/tegra20_das.c    |  3 +--
 sound/soc/ti/omap-mcbsp-st.c     |  3 ---
 sound/soc/uniphier/aio-core.c    |  7 +++----
 18 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.25.1

