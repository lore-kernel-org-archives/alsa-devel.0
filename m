Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C869C38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 09:43:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C494120870
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U0ySn9Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2708C1817;
	Fri,  8 May 2020 11:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2708C1817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588930995;
	bh=tlkCjAszH2EmzFnLOsNfjy/8YsyXHcd6euJ7blREeno=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U0ySn9MuHnxknAi8OWtY3pfeymby0snox/spfDSVhuKUeu0PDpHfqydxzt4rZDRjV
	 /v837N4P0kacoiDVkMsOxJfbcOmCbLegWAmzJ24Dj7HjDI5gK0d+vPMlCGlNXKCFw9
	 gse9kq7UN4JGVWusTsrLcTmMvtCjHmcJWXoF26qc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6863F80258;
	Fri,  8 May 2020 11:42:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93FA4F80253; Fri,  8 May 2020 11:42:21 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1B64F800AD;
 Fri,  8 May 2020 11:42:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1B64F800AD
IronPort-SDR: Uk6K/jMRw2V1yqfGmohFUVovEyX4SmEemdA00mp3qnY3VqwwifIW1Poct5d5+3I0P4rPt/62S1
 j+4A6qJM6tTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2020 02:42:13 -0700
IronPort-SDR: ijOb0DX+Rg2ipWts7P+vL37TgR+yoOYjTHNGYmaqfsdl9YTSv+sWuwb5TIJxWcbdUArlcAxIsT
 4G4K/wTnHTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; d="scan'208";a="435619128"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.34.170])
 by orsmga005.jf.intel.com with ESMTP; 08 May 2020 02:42:12 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] soundwire: remove multiple superfluous "else"
 statements
Date: Fri,  8 May 2020 02:30:44 +0200
Message-Id: <20200508003046.23162-1-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

Two patches cleaning up the same issue for soundwire core and Intel-
specific code.

v2: split into 2 for core and Intel code

Guennadi Liakhovetski (2):
  soundwire: (cosmetic) remove multiple superfluous "else" statements
  soundwire: intel: (cosmetic) remove multiple superfluous "else"
    statements

 drivers/soundwire/bus.c            | 17 ++++++++++-------
 drivers/soundwire/cadence_master.c |  8 ++++++--
 drivers/soundwire/intel_init.c     |  4 +++-
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
1.9.3

