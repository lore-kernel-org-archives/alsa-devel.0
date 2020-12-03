Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C80C433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 23:06:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2E52245C
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 23:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2E52245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E6AA184C;
	Fri,  4 Dec 2020 00:05:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E6AA184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607036768;
	bh=60yiaDnFrHTxLAZy8CfS32ZXqjeWEVqrv5TqUx60QKg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X3MKds+d9Evh+7BAZOv99ralZgUvCM6VGLqvCzOZNIR5lN4ghHmQg1I/Wh579qa7z
	 OPWyOmeruYAjfUIAyshM3l8MEypdb6i78sOoPDUxMDsFzSNRoJPIs6GEEuxOj/zuuh
	 hWj4sTrIsVRTMLuTvhsVJQd51XHRvGam77Kf4Hvc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CEDAF80158;
	Fri,  4 Dec 2020 00:05:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F018DF8012A; Fri,  4 Dec 2020 00:05:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18F7BF8012A
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 00:05:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18F7BF8012A
From: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] soundwire: intel: fix another unused-function warning
Date: Fri,  4 Dec 2020 00:04:56 +0100
Message-Id: <20201203230502.1480063-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Rander Wang <rander.wang@intel.com>
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

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PM, there is another warning about an unused function:

drivers/soundwire/intel.c:530:12: error: 'intel_link_power_down' defined but not used [-Werror=unused-function]

After a previous fix, the driver already uses both an #ifdef and
a __maybe_unused annotation but still gets it wrong. Remove the
ifdef and instead use __maybe_unused consistently to avoid the
problem for good.

Fixes: f046b2334083 ("soundwire: intel: fix intel_suspend/resume defined but not used warning")
Fixes: ebf878eddbb4 ("soundwire: intel: add pm_runtime support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soundwire/intel.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6a1e862b16c3..66adb258a425 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1585,8 +1585,6 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
  * PM calls
  */
 
-#ifdef CONFIG_PM
-
 static int __maybe_unused intel_suspend(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1641,7 +1639,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_suspend_runtime(struct device *dev)
+static int __maybe_unused intel_suspend_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1796,7 +1794,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	return ret;
 }
 
-static int intel_resume_runtime(struct device *dev)
+static int __maybe_unused intel_resume_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1969,8 +1967,6 @@ static int intel_resume_runtime(struct device *dev)
 	return ret;
 }
 
-#endif
-
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
 	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
-- 
2.27.0

