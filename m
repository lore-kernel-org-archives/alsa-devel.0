Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC85C3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:19:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54128246B5
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pIsCUb35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54128246B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A20AA1698;
	Sat, 29 Feb 2020 00:19:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A20AA1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582931991;
	bh=PL2A75qbINYgID2XuTsKmzi3js+zfY9mLClnGXuzktI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pIsCUb35uRyYfvxxk+YFQaWIh+Yj8Qj6gxbPtMrh+40866jIZ7fB/03o+lqMbvv//
	 WkY6Jxa+PG3Gnw0i2kp8O4y5skqYWSURfVSYHIJ4ttWAD8Fpb+/fZh7Oi9NpFW30P1
	 9IzGFgAI/nyoaZNt1FXEoGSjFWj0V94BxKKbkAGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D36D4F80086;
	Sat, 29 Feb 2020 00:19:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5DCAF8016F; Sat, 29 Feb 2020 00:18:58 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38073F80086
 for <alsa-devel@alsa-project.org>; Sat, 29 Feb 2020 00:18:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38073F80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 15:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="272826517"
Received: from billycla-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.95.100])
 by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2020 15:18:53 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: SOF: updates for 5.7
Date: Fri, 28 Feb 2020 17:18:46 -0600
Message-Id: <20200228231850.9226-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
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

4 unrelated improvements grouped in one bundle.

Jaska Uimonen (1):
  ASoC: SOF: ipc: check ipc return value before data copy

Keyon Jie (2):
  ASoC: SOF: pcm: skip DMA buffer pre-allocation
  ASoC: SOF: Intel: hda-loader: clear the IPC ack bit after FW_PURGE
    done

Tomasz Lauda (1):
  ASoC: SOF: add core id to sof_ipc_comp

 include/sound/sof/topology.h     |  3 ++-
 include/uapi/sound/sof/abi.h     |  2 +-
 sound/soc/sof/intel/hda-loader.c |  6 ++++++
 sound/soc/sof/ipc.c              | 12 +++++++-----
 sound/soc/sof/pcm.c              |  6 ++----
 5 files changed, 18 insertions(+), 11 deletions(-)


base-commit: 6941b0b5f919e9839e8c25efaeb53854efee14e5
-- 
2.20.1

