Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B2CA9EB9
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:16:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD4421A4C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qfx4sAva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD4421A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 292561614;
	Wed, 23 Oct 2019 23:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 292561614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571865365;
	bh=NVUoIAZK88isRXj0iOkEfFHpHTrbxv2/ntB9fPs+SWs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qfx4sAvaJTo8PJQPmbQHDSh0LlTchUDIailE8lr9pdtbg50R5KKambMqB7yYm8SqH
	 Gf/rjh2whT+M5cnXQe3eMCYYSsFNTZULf17SK/misoRfabhvoNLXzV28IiLqOkhvpr
	 jVdRazYnnmzba4BWh8MCH/7uXroZDXiKzzqMgbX0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13A69F80274;
	Wed, 23 Oct 2019 23:15:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82CBAF80368; Wed, 23 Oct 2019 23:15:12 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8CC2F80274
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 23:15:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8CC2F80274
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 14:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; d="scan'208";a="373003313"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.254.95.208])
 by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 14:15:06 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 23 Oct 2019 16:14:59 -0500
Message-Id: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/5] ASoC: SOF: Intel: Soundwire integration
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

This patchset applies on top of the series "[PATCH 0/4] soundwire:
update ASoC interfaces". The SOF/Intel code makes use of the
interfaces defined for initialization.

Build support for SoundWire is not provided for now, all
Soundwire-related code will be handled with a dummy fallback. We will
enable SoundWire interfaces in the Kconfigs when the functionality is
enabled in the soundwire tree.

In short, if the interfaces are agreed on, there is no risk with the
integration of these patches on the ASoC side.

Pierre-Louis Bossart (5):
  ASoC: SOF: Intel: add SoundWire configuration interface
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
  ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend

 include/sound/sof/dai-intel.h    |  18 +--
 sound/soc/sof/intel/hda-dsp.c    |   2 +
 sound/soc/sof/intel/hda-loader.c |  13 ++
 sound/soc/sof/intel/hda.c        | 230 ++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h        |  44 ++++++
 5 files changed, 295 insertions(+), 12 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
