Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E288C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1574D206E2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hOTYFaoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1574D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A741516FE;
	Thu,  2 Jul 2020 21:41:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A741516FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593718942;
	bh=Kfo82pGXOGOGA4X/SEAso613nPJIPflx6KR6eQr0qKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hOTYFaoz/8bs+G6ywXZgBDZVRId+OxWzVkGc10l6gp101vvkH5QvsFGkTu8RO8lLr
	 as5rXONmv6t2eo5SVgP7OxPaMPkYQigotCa3kpzuZBJYT4dAZ6VZkMeuMIJ7YZmQVd
	 qBcQeWQBOvJx5wxWWmB4RpGnvE1rJ1DiSKV1or30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E750F80321;
	Thu,  2 Jul 2020 21:36:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B7CAF802BC; Thu,  2 Jul 2020 21:36:47 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE0F6F802BC
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE0F6F802BC
IronPort-SDR: Y5nvBu6NphmM2JEQ7R29w6qcQ+dMh0aUVf8XqNlZIN6J35yHEjvPJxt06sZLW8UjhjThToAzPT
 Lw8yZsZgF0rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549348"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:22 -0700
IronPort-SDR: Qu0cebubJsTuV3+Ba0JT1pd04XcnxOxjrlkky4bAM8/feT7HA9DQgSgaANsgYB4FTwHq/021Hg
 l3A1mm0l2QxA==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116372"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 08/23] ALSA: pci/ctxfi/ctatc: fix kernel-doc
Date: Thu,  2 Jul 2020 14:35:49 -0500
Message-Id: <20200702193604.169059-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warnings. Add missing arguments and description.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/ctxfi/ctatc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index e56a230f6a9c..b1898fafc6a9 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1655,6 +1655,10 @@ static const struct ct_atc atc_preset = {
  *  ct_atc_create - create and initialize a hardware manager
  *  @card: corresponding alsa card object
  *  @pci: corresponding kernel pci device object
+ *  @rsr: reference sampling rate
+ *  @msr: master sampling rate
+ *  @chip_type: CHIPTYP enum values
+ *  @ssid: vendor ID (upper 16 bits) and device ID (lower 16 bits)
  *  @ratc: return created object address in it
  *
  *  Creates and initializes a hardware manager.
-- 
2.25.1

