Return-Path: <SRS0=AXUI=KO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5855BC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 10:52:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7436135B
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 10:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7436135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E8D81695;
	Wed, 19 May 2021 12:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E8D81695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621421534;
	bh=JFFkX404BkwfG05MFFIzO0jx0zElPnJrPWEORZ4DJVg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M4Wqq8uiOZTWinOi40oxnmxOmIMgOBMncleVsBLpsElp0sqTGLRGMoXwhjJ8/HoOQ
	 l68zD2DBB1WMnzEwFTySn1bQ6ZaRLwjsBmLN9KABXf3Kh0oi3JdP+5k5JXRrXbA6ZD
	 Bs1TvZK+rgkd/Oly5tDHj9bZzidq0BxRnTza9em4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16824F80430;
	Wed, 19 May 2021 12:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D658F80425; Wed, 19 May 2021 12:49:57 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE11BF80148
 for <alsa-devel@alsa-project.org>; Wed, 19 May 2021 12:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE11BF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="p3uEAGJA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1621421392; x=1652957392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JFFkX404BkwfG05MFFIzO0jx0zElPnJrPWEORZ4DJVg=;
 b=p3uEAGJAG7IVai/EZw6YR2VUb+QTlMkbSsHF3IkVNAlH70+Ss0cS2dLz
 RVY4L2ibK8Mgq6BopC1T2gIkv46Rnz1yPv1ZoS1XEHKajsXztQKjBROb/
 u2pDFksZED42figBT9jDX9fTQTO7I89VxQR3TtPDn6eETqJU3ZwayCg+1
 quQAinJqQXb6bKap6ebRNVAkdyV5/BEn1jfP6ytJD6mDQSDvrSGWhxgrM
 QrLtNJ98rEMkLTqIU88h2yR0I4CXVvJiHOpCOkTnUFnBEFwJYrur7JO5u
 Q35wKOdbcJzfnxdRsMg4LlexVk9cUtB90eeZEAO8a8mVnyySv6VhZ6UTs Q==;
IronPort-SDR: A/6enPl3sXMuDKOC3o/+zfU14TticU+tncYhfLbTamWSpR5eMnWc3wtu5mZB3VjjhXi/mVxdNL
 1km9NLBeIHuYy0QDtdGk9NTlYd6S+yE3NHWFfSdOwYj6EA2wrkx5e4e5wFRtDXoyMDqdJ9PhN0
 us2V+/I6F6tNJVldJ3Qit8hLeBo/P0KrmHpSBw05mrhNzgwWI+fHzYAi2RO5XUmS1V6MkvAhQ9
 4jfJ9MtVjje/THdvakFvFA6WLfRadchGBJFSHXcU95PVBcRk5MhoRqN5Zuz69yT6lEbA594gfa
 BsQ=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; d="scan'208";a="128651226"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 19 May 2021 03:49:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:34 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:29 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/6] soc-pcm: Add separate snd_pcm_runtime for BEs
Date: Wed, 19 May 2021 13:48:36 +0300
Message-ID: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: lars@metafoo.de, kuninori.morimoto.gx@renesas.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
 joe@perches.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Cristian.Birsan@microchip.com, nicolas.ferre@microchip.com
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

This patchset adds a different snd_pcm_runtime in the BE's substream,
replacing the FE's snd_pcm_runtime. With a different structure, the BE
HW capabilities and constraints will no longer merge with the FE ones.
This allows for error detection if the be_hw_params_fixup() applies HW
parameters not supported by the BE DAIs. Also, it calculates values
needed for mem-to-dev/dev-to-mem DMA transfers, such as buffer size and
period size, if needed.

The first 4 patches are preparatory patches, that just group and export
functions used to allocate and initialize the snd_pcm_runtime. Also, the
functions that set and apply the HW constraints are exported.
The 5th patch does (almost) everything need to create the new snd_pcm_runtime
for BEs, which includes allocation, initializing the HW capabilities,
HW constraints and HW parameters. The BE HW parameters are no longer
copied from the FE. They are recalculated, based on HW capabilities,
constraints and the be_hw_params_fixup() callback.
The 6th and last patch basically adds support for the PCM generic
dmaengine to be used as a platform driver for BE DAI links. It allocates
a buffer, needed by the DMA transfers that do not support dev-to-dev
transfers between FE and BE DAIs.

This is a superset of
https://mailman.alsa-project.org/pipermail/alsa-devel/2021-March/182630.html
which only handles the BE HW constraints. This patchset aims to be more
complete, defining a a snd_pcm_runtime between each FE and BE and can
be used between any DAI link connection. I am sure I am not handling all
the needed members of snd_pcm_runtime (such as handling
struct snd_pcm_mmap_status *status), but I would like to have your
feedback regarding this idea.

Codrin Ciubotariu (6):
  ALSA: core: pcm: Create helpers to allocate/free struct
    snd_pcm_runtime
  ALSA: pcm: Export constraints initialization functions
  ALSA: pcm: Check for substream->ops before substream->ops->mmap
  ALSA: pcm: Create function for snd_pcm_runtime initialization
  ASoC: soc-pcm: Create new snd_pcm_runtime for BE DAIs
  ASoC: dmaengine: Allocate buffer if substream is unmanaged

 include/sound/pcm.h                   |   7 ++
 sound/core/pcm.c                      |  82 ++++++++++-------
 sound/core/pcm_native.c               | 116 +++++++++++++-----------
 sound/soc/soc-generic-dmaengine-pcm.c |  18 ++++
 sound/soc/soc-pcm.c                   | 126 ++++++++++++++++++--------
 5 files changed, 229 insertions(+), 120 deletions(-)

-- 
2.27.0

