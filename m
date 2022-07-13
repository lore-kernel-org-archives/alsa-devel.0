Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E0FC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 14:27:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CE6E1726;
	Wed, 13 Jul 2022 16:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CE6E1726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657722427;
	bh=IPnnb0fU/qVJlOwgD1izgy0CaO2aldoMjVq4ZHg4Azw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PYrY5CbBJxV6sDVwhSL/NhibGvAmMHUDinHuGwwJYW+mZWs+IVDyOp0HgaX+ZSLuL
	 jWZWRIenDkwfeDoNr9lY1o4tcmCK8jQj5znUy3eCKF4CxIgRb3R06p33yYgjzaSQ9S
	 38ZwHT0KU9vLIXvUvLnsxB6H0Hz/pQ2kOAafGe9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B44DAF804CA;
	Wed, 13 Jul 2022 16:25:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7840EF804EC; Wed, 13 Jul 2022 16:25:50 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 980A6F8019B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 16:25:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 980A6F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MAEfEydS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657722344; x=1689258344;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IPnnb0fU/qVJlOwgD1izgy0CaO2aldoMjVq4ZHg4Azw=;
 b=MAEfEydSIluoT5gPe/VkPzAvzI3CPCeCYiBbOxvSMD7eHMRRsR1Ps6YR
 oTIJEjKaEjKkrqYHpH9nGF7alBlVvllDJkq4coFYuGDKVg/MwgkG62l9Y
 YwyCBlAt+BjB/iTt/STOdzUUc2FGcFOoPOzUr/toPQC9RwRabnPFZVrV+
 ivpcoXGluwH41PLfY4XsjxvSBjGI4WJ6cWG/G+g/FenKNs1LN3gNJBTJd
 QyrXLfqx8wI4b6zpAcVbn76q5aGUDXTFkOrcji/C3EMF7aUsIJVs2BxLJ
 yB7LdIRnuzseLg0zQ2ZDHHE/afNcoaOJ+b7nCa+ZVAYPOl1u8I7Yisv/O Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349195668"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="349195668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 07:25:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="570643753"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 07:25:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/3] soundwire: bus: rename sdw_ida as sdw_bus_ida
Date: Wed, 13 Jul 2022 22:25:27 +0800
Message-Id: <20220713142529.17323-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
References: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 bard.liao@intel.com, linux-kernel@vger.kernel.org
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

To avoid confusions with follow-up patches using a IDA mechanism for
peripheral 'device number' allocation, rename sdw_ida as sdw_bus_ida.

Pure rename, no functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8d4000664fa3..37638c20c804 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -11,11 +11,11 @@
 #include "bus.h"
 #include "sysfs_local.h"
 
-static DEFINE_IDA(sdw_ida);
+static DEFINE_IDA(sdw_bus_ida);
 
 static int sdw_get_id(struct sdw_bus *bus)
 {
-	int rc = ida_alloc(&sdw_ida, GFP_KERNEL);
+	int rc = ida_alloc(&sdw_bus_ida, GFP_KERNEL);
 
 	if (rc < 0)
 		return rc;
@@ -179,7 +179,7 @@ void sdw_bus_master_delete(struct sdw_bus *bus)
 	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
-	ida_free(&sdw_ida, bus->id);
+	ida_free(&sdw_bus_ida, bus->id);
 }
 EXPORT_SYMBOL(sdw_bus_master_delete);
 
-- 
2.25.1

