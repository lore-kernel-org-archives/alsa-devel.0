Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099D6C56201
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:33:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A26F20B80
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mUt/1UZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A26F20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B107182B;
	Thu, 12 Nov 2020 17:32:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B107182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605198827;
	bh=b9I8yJO7Qu8bnv8bur/ZsC3EYSMB8uG01IpvvCVUdUI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mUt/1UZfmieRNpeW/+n1f0QBfBpKRdOf9SBm4wr8oAF+sZuubruqqtS9YqMN8OFGk
	 b8LKJXfnhpDXXi9yKlbb1gqgY8DrNzVAzr3yO1dVDK0TyomLiTIFkkm7qyj1r2IKE7
	 3BLB/1fwbLTad87ESekndLiglYRObRB4OrCtPDuw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65267F804EB;
	Thu, 12 Nov 2020 17:31:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A11A9F804EB; Thu, 12 Nov 2020 17:31:27 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28C11F80212
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 17:31:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28C11F80212
IronPort-SDR: MOEHvYkvbn6KRVQoYw5LLcn1pTAcZIE5iWWhIqYlRLPMvIZXKWFNFdrsvxwQlbHH/7K+OzmNfp
 +we5PRXbnohA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="231956989"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="231956989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:31:14 -0800
IronPort-SDR: KY3P9mNOcJxwNlbAuF/9CWljVtIruIkckN6RY5Vsptu5p/vgGzaz6TsCWHmlY6HrFD1VWE41qa
 y5jBJlXYi00g==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="532228309"
Received: from nsalmulx-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.36.117])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:31:10 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: use inclusive language for bclk/fsync/topology
Date: Thu, 12 Nov 2020 10:30:56 -0600
Message-Id: <20201112163100.5081-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, broonie@kernel.org,
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
adopted by the kernel community [1], standard organizations, and need
to change in backwards-compatible ways.

The main/secondary terms typically suggested in guidelines don't mean
anything for clocks, this patchset suggests instead the use of
'provider' and 'consumer' terms, with the 'codec' prefix kept to make
it clear that the codec is the reference. The CM/CS suffixes are also
replaced by CP/CC.

It can be argued that the change of suffix is invasive, but finding a
replacement that keeps the M and S shortcuts has proven difficult in
quite a few contexts.

The previous definitions are kept for backwards-compatibility so this
change should not have any functional impact. It is suggested that new
contributions only use the new terms but there is no requirement to
transition immediately to the new definitions for existing code. Intel
will however update all its past contributions related to bit
clock/frame sync configurations immediately.

This patchset contains the kernel changes only, the alsa-lib changes
were shared separately.

Feedback welcome
~Pierre

[1] https://lkml.org/lkml/2020/7/4/229

Pierre-Louis Bossart (4):
  ASoC: topology: use inclusive language for bclk and fsync
  ASoC: SOF: use inclusive language for bclk and fsync
  ASoC: Intel: atom: use inclusive language for SSP bclk/fsync
  ASoC: Intel: keembay: use inclusive language for bclk and fsync

 include/sound/soc-dai.h                  | 32 +++++++++++++++---------
 include/sound/sof/dai.h                  | 16 ++++++++----
 include/uapi/sound/asoc.h                | 22 ++++++++++------
 sound/soc/intel/atom/sst-atom-controls.c | 12 ++++-----
 sound/soc/intel/atom/sst-atom-controls.h |  4 +--
 sound/soc/intel/keembay/kmb_platform.c   | 22 ++++++++--------
 sound/soc/intel/keembay/kmb_platform.h   |  8 +++---
 sound/soc/soc-topology.c                 | 24 +++++++++---------
 sound/soc/sof/topology.c                 | 18 ++++++-------
 9 files changed, 89 insertions(+), 69 deletions(-)

-- 
2.25.1

