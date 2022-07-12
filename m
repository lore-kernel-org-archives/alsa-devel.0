Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2941CCCA47C
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jul 2022 15:36:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7033716C9;
	Tue, 12 Jul 2022 17:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7033716C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657640208;
	bh=1wj1Gy8GF/XmQXmZM6ThKfzWjSdr3qtAlVHAsnysHN8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XcGIOGo11O3eBPt1cIhuBTi3UXhJfLQNiqExEkcKzvbuMuuAXLAEOwefSU6lsVtWr
	 Al3+YSji9upgm8712/VTfsX8s5dq1Pjff0PWgLduy5Pmk+R3NJf04/Q8lfVogfxHSi
	 iw7iLMgv+TnqWU/8c2YY0LbU1ey8ImqjCtqoK7Uo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68712F800E8;
	Tue, 12 Jul 2022 17:35:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 546A5F802DB; Tue, 12 Jul 2022 17:35:27 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E401AF8023B
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2022 17:35:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E401AF8023B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="dT3OO4KK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657640125; x=1689176125;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1wj1Gy8GF/XmQXmZM6ThKfzWjSdr3qtAlVHAsnysHN8=;
 b=dT3OO4KKcueHTnQrEjFEH5zX8WJEK3LRf/96P8i4zzGM2VwiRnGDif9o
 RDbVeuV7nen13HLCH0mZ/X+bFkNQgmKt2pBaC0JTfoL0E7nEzpo5vu9lU
 GP4onp4JJ6w7zP6//NJCxU7HqaAvBv8+2pZHeWEaHNjpSVXffeFBh4scp
 vWURIoiJi0+vgrRWuV2mXjSp0mZjG6+ZsPk/iwWC5YJVYI5ltFYr9M9Po
 NaLo+fadypO4MhJaDHh7X5QveatICLypG87D17PCGnJWZnrwsosvC/vDd
 2q+y7udafzruWdJpjXI0ARyXbm9Cpz3001AR1pFekHP69IiR5ED8T5QZc w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268005825"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; d="scan'208";a="268005825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 08:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; d="scan'208";a="595326460"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga002.jf.intel.com with ESMTP; 12 Jul 2022 08:35:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 1634CF1; Tue, 12 Jul 2022 18:35:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
Subject: [PATCH v2 1/4] ALSA: hda: cs35l41: Don't dereference fwnode handle
Date: Tue, 12 Jul 2022 18:35:16 +0300
Message-Id: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, Takashi Iwai <tiwai@suse.com>
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

Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
which is a better coding practice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new change
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 49b25432a9f5..1a1afa0725e0 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -347,7 +347,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	/* To use the same release code for all laptop variants we can't use devm_ version of
 	 * gpiod_get here, as CLSA010* don't have a fully functional bios with an _DSD node
 	 */
-	cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(adev), "reset", cs35l41->index,
 						     GPIOD_OUT_LOW, "cs35l41-reset");
 
 	property = "cirrus,speaker-position";
-- 
2.35.1

