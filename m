Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C5EC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 11:54:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 812FE290A;
	Mon, 10 Oct 2022 13:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 812FE290A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665402853;
	bh=jtW0eXebvQ2OpHqjN+yasCvxH7LVfYklxPV1iT6TSJo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SknSGuYjyZV/7T7n/6qfdBvXP2rEmuj3COM/2yfg1OkLA+42YAg9B2cINGuJrD/A2
	 Ew2VOWpV2rZvK2ogVPIaUfoKSG1KER4sAvr5a4JtsmLzySii7tAJplVPsqIFxvn8cO
	 D4ydzkFttXUqLo3XOGg1NSxNALN2oqDw+s91fCgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20E13F8054A;
	Mon, 10 Oct 2022 13:51:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33BD9F8054A; Mon, 10 Oct 2022 13:51:56 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A301AF8054A
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 13:51:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A301AF8054A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="lGF2N9R+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665402710; x=1696938710;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jtW0eXebvQ2OpHqjN+yasCvxH7LVfYklxPV1iT6TSJo=;
 b=lGF2N9R+O4sznmzSyRjIFWFVF9OKNZ4UDVZNqbbmgOExLMNr+Kdkf/ev
 IatkT49YRYmZP4ejnrx6mqqEMbE+3tZPgIBn5JOOxsXwHFN/PWy+epPic
 OQGXWE5GmtTpLHfTyjsYxHHpzfjYardRuNtc4+vIWnwGCc0t17fhrt5Nc
 FQaFTIGJPVNslXDk8Fx48XVS1f+01KdXmYccYYaU8F+nH5owj2zqJR0Pe
 hZ7fVbHOQMCT4c4VYtJAQlbGahtOOZr4u5juaos+5/SUj4Nt85C8r+le/
 Vnw3SX4sIBSp5b00fWcehhA2qE8j6T0vwVLaZuZ8ZsHJ6l5WLZtqYU5n9 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="390513241"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="390513241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 04:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="954889062"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="954889062"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2022 04:51:47 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 07/15] ASoC: Intel: avs: Add missing SKL-based device IDs
Date: Mon, 10 Oct 2022 14:07:41 +0200
Message-Id: <20221010120749.716499-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010120749.716499-1-cezary.rojewski@intel.com>
References: <20221010120749.716499-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

Enable additional SKL-based configurations by filling device ID table
with new entries.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 58db13374166..6503c5bfd63d 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -667,7 +667,11 @@ static const struct avs_spec apl_desc = {
 
 static const struct pci_device_id avs_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9d70), (unsigned long)&skl_desc }, /* SKL */
+	{ PCI_VDEVICE(INTEL, 0xa170), (unsigned long)&skl_desc }, /* SKL-H */
 	{ PCI_VDEVICE(INTEL, 0x9d71), (unsigned long)&skl_desc }, /* KBL */
+	{ PCI_VDEVICE(INTEL, 0xa171), (unsigned long)&skl_desc }, /* KBL-H */
+	{ PCI_VDEVICE(INTEL, 0xa2f0), (unsigned long)&skl_desc }, /* KBL-S */
+	{ PCI_VDEVICE(INTEL, 0xa3f0), (unsigned long)&skl_desc }, /* CML-V */
 	{ PCI_VDEVICE(INTEL, 0x5a98), (unsigned long)&apl_desc }, /* APL */
 	{ PCI_VDEVICE(INTEL, 0x3198), (unsigned long)&apl_desc }, /* GML */
 	{ 0 }
-- 
2.25.1

