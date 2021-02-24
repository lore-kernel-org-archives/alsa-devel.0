Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3AEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:57:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179D064F24
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D064F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DB521682;
	Wed, 24 Feb 2021 13:56:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DB521682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614171432;
	bh=UcHg/Dv0cv5MjX11LSzuItK7fmfEFvA5gy4oMj1tj4U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HX4czb/hlgZSW+Gpt9sLPDooZV41eUq4c++zxIMd/AATLQ7A0BmkwY2QYAjkVS/J0
	 5mT8s73b+TDUxdOgSE38l+464TlJibVlRstvD12gZxTavG29GY+RezeiOnSzUEaD4Q
	 wz+74NXwtJMIpEE8ClENwSlI0S8MSxOQRgMflC8g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD6B3F80234;
	Wed, 24 Feb 2021 13:53:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40054F8022B; Wed, 24 Feb 2021 13:53:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 353A0F80129
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:53:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 353A0F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KM5kDhCv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9701A64F45;
 Wed, 24 Feb 2021 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171188;
 bh=UcHg/Dv0cv5MjX11LSzuItK7fmfEFvA5gy4oMj1tj4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KM5kDhCvTMeSwaTn0zizPIZ53S2lZrJw/BlnIH2AlBjk9N8NSs1+5L7Zc5sbYvAaD
 wgaB47J/vUyKyOxsZQ30Qv0md2at/KJCwzvF6za1MzubXFMZJZ5dckcvSi9SFaQXoG
 NHpm8EVuknK29LVoQAnUiqFtzDH5rjweYVS7m4Shciqvuw4YSqt0Y7ot0UHUjJZuo+
 0AL9g5ZLM/HfgDTbM4Hk4ruCgpj/Tt5SV1UZ7oDJqkCVLYvrUfoUq/NhiaZ4pY4m7P
 xuxrkqoNBr9lZi6VgmK0ttdyZTZB846oLDvoA9BYUri2dXEUupovVj3NWTrlMtJlK6
 893KGZhp3o8wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 42/56] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Date: Wed, 24 Feb 2021 07:51:58 -0500
Message-Id: <20210224125212.482485-42-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125212.482485-1-sashal@kernel.org>
References: <20210224125212.482485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8ade6d8b02b1ead741bd4f6c42921035caab6560 ]

Some Bay Trail systems:
1. Use a non CR version of the Bay Trail SoC
2. Contain at least 6 interrupt resources so that the
   platform_get_resource(pdev, IORESOURCE_IRQ, 5) check to workaround
   non CR systems which list their IPC IRQ at index 0 despite being
   non CR does not work
3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5

Add a DMI quirk table to check for the few known models with this issue,
so that the right IPC IRQ index is used on these systems.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20210120214957.140232-5-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-intel-quirks.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index b07df3059926d..a93987ab7f4d7 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,6 +11,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 
+#include <linux/dmi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
@@ -38,12 +39,36 @@ SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
 
 static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 {
+	/*
+	 * List of systems which:
+	 * 1. Use a non CR version of the Bay Trail SoC
+	 * 2. Contain at least 6 interrupt resources so that the
+	 *    platform_get_resource(pdev, IORESOURCE_IRQ, 5) check below
+	 *    succeeds
+	 * 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
+	 *
+	 * This needs to be here so that it can be shared between the SST and
+	 * SOF drivers. We rely on the compiler to optimize this out in files
+	 * where soc_intel_is_byt_cr is not used.
+	 */
+	static const struct dmi_system_id force_bytcr_table[] = {
+		{	/* Lenovo Yoga Tablet 2 series */
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
+			},
+		},
+		{}
+	};
 	struct device *dev = &pdev->dev;
 	int status = 0;
 
 	if (!soc_intel_is_byt())
 		return false;
 
+	if (dmi_check_system(force_bytcr_table))
+		return true;
+
 	if (iosf_mbi_available()) {
 		u32 bios_status;
 
-- 
2.27.0

