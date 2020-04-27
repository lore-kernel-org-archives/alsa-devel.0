Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C42C4CECD
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:44:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA52214AF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qbj6QOdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA52214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DEE716B4;
	Mon, 27 Apr 2020 19:43:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DEE716B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588009441;
	bh=6tkcbpyBPGzJdJGUX0ZV12RAluHQ3xJYAVCl86rmzu8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qbj6QOdv/32w2aWYptm/AtL7kjJciAhagfsmuVsHPFPm4ueOy38vqjKCu3PvjLitD
	 ARewsjXzcCNgmM+zy2VaEgNzEAshAjVsU9tvJSrzlb7roya5K/BlGZUrToP+JVuHkh
	 vQLw7Til6L+4BK1WMBJIF6f0Qg/dhz78giOg8tcY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B57DF802DF;
	Mon, 27 Apr 2020 19:29:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74A2AF802DB; Mon, 27 Apr 2020 19:29:48 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B70DF80247
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 19:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B70DF80247
IronPort-SDR: kwGZFomapaYZEw8Ka1mfsfgZ6fu1IRHyt2sLE+DcW3n6MEpPSuJn221JICJVqc87hHeGlj64BN
 QWMlD4I4mIpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 10:29:39 -0700
IronPort-SDR: AMq8eLszGw2hJ8uvdwqckXyKEk71pXEi0WAcvlp3UMXAWiuVxillX7Qrp2//SKCyD9EX9MKLnT
 UcLdPg9u5G5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="458935995"
Received: from dbombien-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.51.189])
 by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:29:39 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] SOF topology parsing updates
Date: Mon, 27 Apr 2020 10:29:35 -0700
Message-Id: <20200427172939.25848-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
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

This series includes updates in the topology parser for DAIs
and their config.

The first three patches address the problem of sending the DAI
config to the DSP when there are multiple DAIs associated with
a DAI link.

The last patch deals with setting the default trigger order 
for all links. Exceptions needed for HDA links are moved to
the DAI link fixup() callback.

Bard Liao (3):
  ASoC: SOF: topology: send ipc for all found DAIs in sof_set_dai_config
  ASoC: topology: set component dai_index to ipc dai config dai_index
  ASoC: SOF: topology: replace sof_link_hda_process by
    sof_set_dai_config

randerwang (1):
  ASoC: SOF: Intel: change trigger sequence to fix pop noise when
    stopping playback on sdw platforms

 sound/soc/sof/pcm.c      |  12 ++-
 sound/soc/sof/topology.c | 167 ++++++++++-----------------------------
 2 files changed, 51 insertions(+), 128 deletions(-)

-- 
2.17.1

