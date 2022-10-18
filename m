Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647FDC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Oct 2022 01:22:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9103F90C4;
	Tue, 18 Oct 2022 03:21:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9103F90C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666056160;
	bh=FXA05px7X76gyjkgLbBng6UcJndy1PxSGx75pNZdX/8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RT1cL46365MVFt/lpBozRg8Cw3loUq+Kn+zJW0t8X1lixiWeR3ytS3rT+L2BMhFxQ
	 krnLEyMIRBOteRvh/wJpQ6lQ/0mGW/CTvIgTJ+3EPwC6N6LyaQbvn+6K1NZbiHP0yx
	 k3h5uBJKlslYPPqpQ4xm1rWwW7RSyER44llgyYMU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D9B4F8024C;
	Tue, 18 Oct 2022 03:21:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD8C8F8024C; Tue, 18 Oct 2022 03:21:48 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6B91F800AB
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2022 03:21:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6B91F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="K1TQgwTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666056106; x=1697592106;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FXA05px7X76gyjkgLbBng6UcJndy1PxSGx75pNZdX/8=;
 b=K1TQgwTUzMEol1ASHKqicPIpsl0AEGJW/3WWhxFAVrPQMgRIZzuNh/bI
 Ek58joyIeXbeljbrD1DLsByhxkX4XNhEnHxyrjA2IwML+JSvCoY4NFYvf
 elnXFmpM2GmOerTTpJnGjLIIEqDkOH0bC9Mj8eSKJgkGLL6qnw0ylCOn4
 j9hEWP0EroQNWmZARQb5LD3+B9D1TqSJctLqRVSUoBZuN1NIp82MPnP7t
 Cwy6+yL4lDlkRwCN5rzTh4MrusKbFppLtFSN/slLp7j/hGdgZ9hVdFnhA
 zngrkSJhKvpQAnlwrp4JR0i1LxwEnQ8Fnd7boigUpYek3BmUgKpDCgM7D w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307626067"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; d="scan'208";a="307626067"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2022 18:21:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606334938"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; d="scan'208";a="606334938"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2022 18:21:37 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: dmi-quirks: add quirk variant for LAPBC710 NUC15
Date: Tue, 18 Oct 2022 09:25:00 +0800
Message-Id: <20221018012500.1592994-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Some NUC15 LAPBC710 devices don't expose the same DMI information as
the Intel reference, add additional entry in the match table.

BugLink: https://github.com/thesofproject/linux/issues/3885
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index f81cdd83ec26..7969881f126d 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -90,6 +90,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/* quirk used for NUC15 LAPBC710 skew */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "LAPBC710"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
-- 
2.25.1

