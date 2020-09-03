Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41FAC433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:11:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8024C2071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BPt/70bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8024C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D8761753;
	Thu,  3 Sep 2020 22:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D8761753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599163916;
	bh=Dhn2XUtFkYycCuxjUMp24CZyeadpifjWGGFt75ASURw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BPt/70bkCrfcR+EBRuoRRlUrt2jU2LMivU+BrW7GvXP08pm02W4xiwfK0Fh3YtKsW
	 Ys+Z7tBzLmlMowazyyapJAm5jkl2uvMJkG+u4P0pyiRzuMg6TInjH7fkxdADf4ersq
	 W/kczWiCfvbBxVbJPxtCEEvCBef64sbRkQbLBoR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B33F8020D;
	Thu,  3 Sep 2020 22:11:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8ABA2F800BA; Thu,  3 Sep 2020 22:11:02 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F027DF800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:10:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F027DF800BA
IronPort-SDR: HmhfnXsIVZLjUSwSv89uPYEU12XI/RZW/rsbnSgKkCYZTS9MoYxuuTcVPh3j2G6UbIu9TTiVc7
 M9GUwDttG3+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="242471254"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="242471254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 13:10:46 -0700
IronPort-SDR: CDMw1GTITNzYa0tmF9cHNytOi8k+RtPHP9gLIFB+bDEN+VfRLGH+B6tqAvCx+BtLBpNaaSTJRA
 HFsNqIN8jRTg==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="447033081"
Received: from mrcordie-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.195.28])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 13:10:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/3] alsa-lib/ASoC: use inclusive language for
 bclk/fsync/topology
Date: Thu,  3 Sep 2020 15:10:21 -0500
Message-Id: <20200903201024.1109914-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

The SOF (Sound Open Firmware) tree contains a lot of references in
topology files to 'codec_slave'/'codec_master' terms, which in turn
come from alsa-lib and ALSA/ASoC topology support at the kernel
level. These terms are no longer compatible with the guidelines
adopted by the kernel community [1] and need to change in
backwards-compatible ways.

The main/secondary terms typically suggested in guidelines don't mean
anything for clocks, this patchset suggests instead the use of
'provider' and 'follower' terms, with the 'codec' prefix kept to make
it clear that the codec is the reference. The CM/CF suffixes are also
replaced by CP/CF.

It can be argued that the change of suffix is invasive, but finding a
replacement that keeps the M and S shortcuts has proven difficult in
quite a few contexts.

The previous definitions are kept for backwards-compatibility so this
change should not have any functional impact. It is suggested that new
contributions only use the new terms but there is no requirement to
transition immediately to the new definitions for existing code. Intel
will however update all its past contributions related to bit
clock/frame sync configurations immediately.

This suggestion is easier to review first at the alsa-lib level, and
if agreed follow-up contributions for the Linux kernel [2] and SOF
firmware [3] will be provided.

Feedback welcome
~Pierre

[1] https://lkml.org/lkml/2020/7/4/229
[2] https://github.com/plbossart/sound/tree/fix/inclusing-language-bclk-fsync
[3] https://github.com/plbossart/sof/tree/fix/inclusive-language-bclk-fsync

Pierre-Louis Bossart (3):
  topology: use inclusive language for bclk
  topology: use inclusive language for fsync
  topology: use inclusive language in documentation

 include/sound/uapi/asoc.h | 22 +++++++-----
 include/topology.h        |  8 ++---
 src/topology/pcm.c        | 74 ++++++++++++++++++++++++++++-----------
 3 files changed, 71 insertions(+), 33 deletions(-)

-- 
2.25.1

