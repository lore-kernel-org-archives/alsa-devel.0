Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE232C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 21:59:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 363D71B22;
	Thu, 16 Jun 2022 23:58:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 363D71B22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655416750;
	bh=70GOy9VMpa4gGW2poNdUtXxc+2VarK7oIZ4x8VeuV0k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tY1Vg9jkoWe7E5UrmnkhEPYZ6zGFL3Dcj/SlbfUBWE90ZHkS6Awxx0KLmgePPo5uU
	 Y2dyLpuTZx0fA45Clg4Wty/Rb5Rf05sBMIJiuO2n2FUJw4i/hKYU1XbG4Lzo8ETOXK
	 yosF2tW0B4VvEwWXO3i61CNs3DMGe4tbRIpm4seE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2207F8057C;
	Thu, 16 Jun 2022 23:55:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B50F6F80549; Thu, 16 Jun 2022 23:54:55 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7963F8052D
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 23:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7963F8052D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="YRMF/8KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655416489; x=1686952489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=70GOy9VMpa4gGW2poNdUtXxc+2VarK7oIZ4x8VeuV0k=;
 b=YRMF/8KQh68TznYXSlil7t/rDVOhkZS29DOhl254nqxh4/agTN9sJvc6
 GTt7gScjrzbBiUd4nILLCc3aEkWtL50Gw43BjDCCV8uQKP5M/x0KNzyTp
 7N3MsvJ3qaRVhRtylE0gXrdfBUdvblTRAdQ2yfMHA3FBIasXNotgqWZRw
 dD3ZZwNPtoKp3BWaxzoH4hrMQ/znDHYuQZHRLP/dd81saJzOnGIMVIwp6
 /nzCfUW2QfMZO2mDXykRXRMPEsLvru8scRIM8V7zBeGb+58YpWc1KD7/C
 h5OA317XPDKnv4hFVcCTGOu6msHKziu7mOjrRltLQoc8/uac3WUIbTuuK Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268047844"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="268047844"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 14:54:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="675212722"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 14:54:23 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/13] ASoC: Intel: boards: sof_sdw: remove use of __func__ in
 dev_dbg
Date: Thu, 16 Jun 2022 16:53:51 -0500
Message-Id: <20220616215351.135643-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616215351.135643-1-pierre-louis.bossart@linux.intel.com>
References: <20220616215351.135643-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

The module and function information can be added with
'modprobe foo dyndbg=+pmf'

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d23846572543b..0c47d76a79e26 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1447,7 +1447,7 @@ static int mc_probe(struct platform_device *pdev)
 	int amp_num = 0, i;
 	int ret;
 
-	dev_dbg(&pdev->dev, "Entry %s\n", __func__);
+	dev_dbg(&pdev->dev, "Entry\n");
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
-- 
2.34.1

