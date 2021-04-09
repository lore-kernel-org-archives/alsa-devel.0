Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B2C433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:14:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7CB61181
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7CB61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30E401679;
	Sat, 10 Apr 2021 00:13:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30E401679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618006456;
	bh=aRDsZUylmtXViXiAkdF5bGS5c0n/29kO1KhfUtVNThY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hrpXzP9hdfM+TYLLk5RnIyGs1sfA/q2WLocvvn5UFGUy9RDII0SJL2ZFvOvKh3X+A
	 PTy2QdpVVEUNMHLAEXQ+XncydYo3A5bfZMDzUc69DA8pcBMVKzoV3ZdcG7xkIBXQlG
	 NPW8RbGyKY7xgUvitE64yTzo/fv/18U2NavwlI6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B931DF80168;
	Sat, 10 Apr 2021 00:13:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA21FF8016A; Sat, 10 Apr 2021 00:13:23 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C2DAF800EE
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C2DAF800EE
IronPort-SDR: 9YS5t+tJ5OSCCnAgrY5MckT5mU3zQicGRCidz2p5EUbiZyMRkj+tZ40A8quoknMk64Ai8AG/OA
 WIMSu3OEwwwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="173932922"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="173932922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:13:13 -0700
IronPort-SDR: GUxam000rX4VdGEJtV/oBIypmQGpCZzBhTJuvSlgRaej0MhL1Dqbn0aYQRfZ8qj5dhh0OMhRed
 krdY9p5Vyzdg==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599293407"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:13:12 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Kconfig: fix typo of SND_SOC_SOF_PCI
Date: Fri,  9 Apr 2021 15:13:08 -0700
Message-Id: <20210409221308.1544000-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

From: Libin Yang <libin.yang@intel.com>

It should be 'endif ## SND_SOC_SOF_PCI' instead of
'endif ## SND_SOC_SOF_INTEL_PCI'

Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index da1c396f529d..4bce89b5ea40 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -293,6 +293,6 @@ config SND_SOC_SOF_INTEL_SOUNDWIRE
 	  Say Y if you want to enable SoundWire links with SOF.
 	  If unsure select "N".
 
-endif ## SND_SOC_SOF_INTEL_PCI
+endif ## SND_SOC_SOF_PCI
 
 endif ## SND_SOC_SOF_INTEL_TOPLEVEL
-- 
2.25.1

