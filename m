Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3864C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 07:14:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D5F207D3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 07:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SPnLdBTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D5F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AD661793;
	Wed, 20 May 2020 09:14:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AD661793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589958890;
	bh=U2uj/DgKwauLR6IhGfQia8fsZv3t2oBm+JAvAC4qHnY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SPnLdBTrdJH/mut+SPLyy5xKarZmVUYV9Hhl9s8uau8dNLb7SfCYMOXgH5NJ6grLp
	 tBRr4lS7qoVoI2OVO9gVvCPHrul5eKYB1GiIYmJ7bsd18flt/lPUQb2dY/fsC8gsQC
	 vmFmJQeYi9oAiKkHmUo8zYRvmdlSUmCjYM36Q+rs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA7ADF801F9;
	Wed, 20 May 2020 09:13:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 629F4F80132; Wed, 20 May 2020 09:13:57 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E69DDF80132
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 09:13:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E69DDF80132
IronPort-SDR: Umekako9Jw88mjzKUj6csSnXpQDceM9cORsp4wGmkoYTAXAoKCVnUiACw1OChCho2cl5t1pJ7C
 6Qjpar0Nng1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 00:13:46 -0700
IronPort-SDR: 1I4Md1o/u325pnWQMRQ3X79EeTBosykvzJPYwMnXYMhD0Jvyg9TpV494VcD529MpfSn6Je8ttg
 MPYvcYD4VoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; d="scan'208";a="253596937"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 00:13:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/2] soundwire: intel: use a single module
Date: Wed, 20 May 2020 03:19:02 +0800
Message-Id: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Rander Wang <rander.wang@intel.com>

It's not clear why we have two modules for the Intel controller/master
support when there is a single Kconfig. This adds complexity for no
good reason, the two parts need to work together anyways.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 7319918e0aec..4f6094767212 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -16,12 +16,9 @@ soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-objs :=	intel.o
+soundwire-intel-objs :=	intel.o intel_init.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
-soundwire-intel-init-objs := intel_init.o
-obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel-init.o
-
 #Qualcomm driver
 soundwire-qcom-objs :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
-- 
2.17.1

