Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F078ECA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:05:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF3521928
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RbRru4+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF3521928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E66241734;
	Thu, 24 Oct 2019 23:04:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E66241734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571951118;
	bh=MxhEIJ9BFzQgQ1UcQltDUo4rEjlVq3iGQ4loh+sscGw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RbRru4+7IRkWAQ9uj31wRrFm5fVktRnGzq66d8Wvn2DgTAftMJSpDH4mwt0Oc30ZY
	 ZF/DLKN91uj9d6cwruGx33hXoR+n0lzfycNNWhaSU0WkL1TPD9eiX+ftzFSKkVD2GX
	 aVcC+C1L6nUtruDev4HUVy7AAFY3o6nEEwqdQf2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB95AF803D1;
	Thu, 24 Oct 2019 23:03:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85D95F8036E; Thu, 24 Oct 2019 23:03:31 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A4A1F80274
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 23:03:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A4A1F80274
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 14:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; d="scan'208";a="398553498"
Received: from ksengupt-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.138.183])
 by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2019 14:03:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 24 Oct 2019 16:03:16 -0500
Message-Id: <20191024210318.30068-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 0/2] ASoC: SOF: make hw_info platform
	specific
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

The SOF core blindly sets the hw_info, when it should really be
platform-specific.

This move enable us to temporarily fix PulseAudio issues resulting
from inaccuracies in the hw_ptr position provided by the firmware on
Baytrail-Broadwell.

This is the first time we experiment with the GitHub low-level API to
automagically keep track of 'approvers' by inserting a Reviewed-by tag
when merging a pull-request, thanks to Ranjani for her initial work
and bearing with my habit of breaking things :-)

v2: make the code apply on Mark's tree. Sorry about that bad patch.

Pierre-Louis Bossart (2):
  ASoC: SOF: define INFO_ flags in dsp_ops
  ASoC: SOF: Intel: only support INFO_BATCH for legacy platforms

 sound/soc/sof/imx/imx8.c  |  7 +++++++
 sound/soc/sof/intel/apl.c |  7 +++++++
 sound/soc/sof/intel/bdw.c |  9 ++++++++-
 sound/soc/sof/intel/byt.c | 21 +++++++++++++++++++++
 sound/soc/sof/intel/cnl.c |  7 +++++++
 sound/soc/sof/pcm.c       |  8 +++-----
 sound/soc/sof/sof-priv.h  |  3 +++
 7 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
