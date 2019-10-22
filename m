Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF14CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:41:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0C3218AE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q5V6Meu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0C3218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 979B41607;
	Tue, 22 Oct 2019 21:40:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 979B41607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571773259;
	bh=DLz2HmtZbwMzQQI4D8fmK0ZiYl+wlcN0vez5fqmy7hg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q5V6Meu0X/iTxSxTaj1hKBosefhk0zHfI1MKTpsN9apj47xU6IFPfBvH+PesuaM28
	 PILMEHXWDaOY2sxLAAKWudGHVdLzcNJa9aQV32ETxugqzebxlsTksC9C/OQP0hbwDL
	 3VT10dU3+pne9HMlxvmMbcHUpUj1VDCByq8uUHWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ADB7F80322;
	Tue, 22 Oct 2019 21:40:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADB46F800C0; Tue, 22 Oct 2019 21:40:06 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17524F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 21:40:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17524F800C0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 12:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; d="scan'208";a="197218211"
Received: from mssikder-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.68.44])
 by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2019 12:39:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 14:39:53 -0500
Message-Id: <20191022193955.21766-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/2] ASoC: SOF: make hw_info platform specific
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
