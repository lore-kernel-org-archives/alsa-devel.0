Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B0C10F25
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:28:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFF524656
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mznqQyBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFF524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90F8D1614;
	Mon,  9 Mar 2020 20:27:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90F8D1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583782129;
	bh=UWk5tAylU33Arhlk1d+cJpRDgOk6/+vL1LLR1bakjJU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mznqQyBY0d9OzmD1KOzf1H51KCKjjVwmuAfebJv6x4F3pQhyGO8fb3Orb1nxRW2tu
	 uxb4l7pIQ6nLXxGbJFlgwmqusFbzIOxN5a6S1yP51uowWSBrgduaINa4KDRD2n8DZV
	 /5Y6gXR34dR6uFtnHSd+A9GPENWmFiVOJNZnUUu8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DE6BF801A3;
	Mon,  9 Mar 2020 20:27:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18BA8F8021D; Mon,  9 Mar 2020 20:27:56 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDAD8F800DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 20:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDAD8F800DA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 12:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="442858060"
Received: from dmaida-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.17.65])
 by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2020 12:27:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: soc-core: disable checks on dapm_add_routes for
 legacy devices
Date: Mon,  9 Mar 2020 14:27:42 -0500
Message-Id: <20200309192744.18380-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

Since v5.4, the card probe ends when one or more DAPM routes cannot be
added. This is a good thing, but legacy devices have incomplete routes
that cannot practically be fixed by distributing a new topology file,
so users lose all audio functionality by updating their kernel.

Introduce an optional flag to allow for a backwards-compatible
behavior to keep supporting these devices. For now only set this flag
for the one device where an issue was reported. If desired, we could
set it for all SKL machine drivers by default.

Pierre-Louis Bossart (2):
  ASoC: soc-core: disable route checks for legacy devices
  ASoC: Intel: skl_nau88l25_ssm4567: disable route checks

 include/sound/soc.h                           |  1 +
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |  1 +
 sound/soc/soc-core.c                          | 28 ++++++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.20.1

