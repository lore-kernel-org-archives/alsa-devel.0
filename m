Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F1C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:11:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C238B206D3
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CkDRkv7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C238B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05077844;
	Fri, 20 Dec 2019 18:10:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05077844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576861898;
	bh=LPuAznoYxSe9lt5+chkkX4cXqdztE09tbjF1xZ2B240=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CkDRkv7WIIvi3HFhyXhYPmiVBAxUb1S5ORzy/x2Q/CLd3oy+vQdbNPHA8l6lVaeTF
	 LboMsRgJlazR2vbDLAn7iIb1S4y+j+iPnxW1fAnlnFU8hC7iy8C4xn2qeNgj10/dcH
	 nAOQT683zRVLrcEIOMi2JZmMs1pXO8yHpsyU2AnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71D18F8022C;
	Fri, 20 Dec 2019 18:10:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82E9FF80088; Fri, 20 Dec 2019 18:10:46 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 504E4F80088
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 18:10:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 504E4F80088
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 09:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; d="scan'208";a="228657489"
Received: from landre-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.133.224])
 by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 09:10:40 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 11:10:35 -0600
Message-Id: <20191220171037.10689-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/2] ASoC: SOF: Intel: add support for
	TigerLake 4th iDISP link
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

TigerLake has 4 iDISP connections, not 3 as in previous
generations. The patches add the relevant DAI definition. This was
tested as having no impact on previous generations.

Support for 4 links with the legacy HDaudio driver is already planned
and will be release soon by Kai.

Sathyanarayana Nujella (2):
  ASoC: SOF: Intel: hda: Add iDisp4 DAI
  ASoC: hdac_hda: Update hdac hda dai table to include intel-hdmi-hifi4

 sound/soc/codecs/hdac_hda.c   | 16 ++++++++++++++++
 sound/soc/codecs/hdac_hda.h   |  3 ++-
 sound/soc/sof/intel/hda-dai.c |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
