Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D4C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:22:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2082620786
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LmpZ2RbB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wqluUxci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2082620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A136574C;
	Tue, 16 Jun 2020 18:22:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A136574C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592324571;
	bh=NR6ahzTNv1ieUWE7AOaToTgXp6Hy0HbPS7DMknb6DaA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LmpZ2RbBfBtG33l1Sx0GW9w7DEtxaZuyG8hHKokpPGfwnZ+SEQSQpgW7AkyLjD6b5
	 +xpkUbB5VsvWcSIq5KyFdk7TFAh7rrLYalpWUKIUME40F77FR+7qu4lvgBQOmUG9HG
	 xbN9ivgeJaaQKrUbIz9GOTYdT8lwF4EYPofV48OA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25FACF80217;
	Tue, 16 Jun 2020 18:22:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 467FEF8022B; Tue, 16 Jun 2020 18:22:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D8AFF80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 18:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D8AFF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wqluUxci"
Received: from localhost.localdomain (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A049F208B3;
 Tue, 16 Jun 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592324514;
 bh=NR6ahzTNv1ieUWE7AOaToTgXp6Hy0HbPS7DMknb6DaA=;
 h=From:To:Cc:Subject:Date:From;
 b=wqluUxciBtaOIKYINOaHBdwsYeI1hEKWJbiyMarlyVyYHW5uOeVD+OcuFss1I729f
 AUbzlEN4J2urdDIbNuuzJuW85Cz2RHTc2qYxnM7V1Qur2doEP+HvxkGjNYwGs6Psrt
 gnlEp7DQiYX+EfrqLnq/LYM318NnpAY84Z1Crico=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] soundwire: Replace 'objs' by 'y'
Date: Tue, 16 Jun 2020 21:51:40 +0530
Message-Id: <20200616162140.2563535-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

`-objs` is designed for building host programs, change to `-y`,
more straightforward for device drivers.

See Documentation/kbuild/makefiles.rst

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index b5871612613b..7c53ffae9f50 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,22 +4,22 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o  \
+soundwire-bus-y := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o  \
 			sysfs_slave.o sysfs_slave_dpn.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 ifdef CONFIG_DEBUG_FS
-soundwire-bus-objs += debugfs.o
+soundwire-bus-y += debugfs.o
 endif
 
 #Cadence Objs
-soundwire-cadence-objs := cadence_master.o
+soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-objs :=	intel.o intel_init.o
+soundwire-intel-y :=	intel.o intel_init.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
 #Qualcomm driver
-soundwire-qcom-objs :=	qcom.o
+soundwire-qcom-y :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
-- 
2.26.2

