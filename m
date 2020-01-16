Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32975C33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:23:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17C620728
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n9rNVhYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17C620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F37C5170F;
	Fri, 17 Jan 2020 09:22:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F37C5170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579249420;
	bh=u07HTaaaqzEHVIjRVKVxndExWmRywx0dYTAS94wJOS8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n9rNVhYudz/dEMboNxGmV2/w1wToCcGTk1cjqEfpKxfqnczMWXkvBfl3NgCUIXrIf
	 aPo+WJaQNlIVJ2twME9ZS39WgUmJPF1kjvhD7waJYJ3+GZLnwRcluWG358++U7GZMQ
	 8t2kq2dtCjRBchYMsGMQkANV1yh4kkw/d/+avvmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C1FCF8021D;
	Fri, 17 Jan 2020 09:22:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 175CAF80227; Fri, 17 Jan 2020 09:22:45 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08D3BF800AA
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 09:22:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08D3BF800AA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 00:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; d="scan'208";a="274295684"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2020 00:22:31 -0800
From: Bard liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Date: Fri, 17 Jan 2020 04:26:16 +0800
Message-Id: <20200116202620.7401-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH RFC v3 0/4] ASoC: Add Multi CPU DAI support
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

changes in v3:
 - Return error if the function doesn't support multi cpu instead of
   just showing a warning message.
 - Revert changes for FE dai and compress device since we don't support
   multi cpu for FE dai and compress device yet.

Bard liao (1):
  ASoC: return error if the function is not support multi cpu yet.

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add multiple CPU DAI support for PCM ops
  ASoC: Add multiple CPU DAI support in DAPM

 include/sound/soc.h                   |  15 +
 sound/soc/soc-compress.c              |   5 +-
 sound/soc/soc-core.c                  | 205 +++++-----
 sound/soc/soc-dapm.c                  | 131 ++++---
 sound/soc/soc-generic-dmaengine-pcm.c |  18 +
 sound/soc/soc-pcm.c                   | 539 +++++++++++++++++---------
 6 files changed, 591 insertions(+), 322 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
