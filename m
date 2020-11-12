Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF95FC56201
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:47:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D981521D91
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pYZ0lAsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D981521D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47D941850;
	Thu, 12 Nov 2020 17:46:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47D941850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605199645;
	bh=gcgxg8XsC/0BjW+D9B0kM3ZhN7SwJejkRguTndlWcfY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYZ0lAsbPITth4B+to2quO2tPWpEGkHVVaXK87eElc16eoCu3z4jfU/c4MWM838i+
	 ZM1C2G8xdQq2OobdksZjGupbZp3ZXzrd2XvmgxE8Hb1zIunsRUPUUvOcPGSRLzNIkt
	 N2dpj8r0kK0LtYn6KWjwib/uGa6WvtBwX5mFFYRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EDBCF804E1;
	Thu, 12 Nov 2020 17:45:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C452F804E2; Thu, 12 Nov 2020 17:45:10 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5663F804E0
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 17:45:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5663F804E0
IronPort-SDR: FQmPtPGoXTozhHRc7+4qR2+A9zkNYEShXoNsfc9u6QG5vl4JpgtftoZm+v540J0C5OrNd1HdBX
 yIr8XEWr9Q3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170508868"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="170508868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:44:41 -0800
IronPort-SDR: 7nH3k3cGJaGoq2NcuzTDDUks8onGl0dAVdC98zL1LLQWVRnTpwB199sPTBZfN/J6IUxI1zYcOg
 WvKIqoylABdA==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="355251430"
Received: from uikram-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.213.181.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:44:40 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 4/4] ASoC: SOF: Intel: fix Kconfig dependency for
 SND_INTEL_DSP_CONFIG
Date: Thu, 12 Nov 2020 10:44:25 -0600
Message-Id: <20201112164425.25603-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112164425.25603-1-pierre-louis.bossart@linux.intel.com>
References: <20201112164425.25603-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

SND_INTEL_DSP_CONFIG is selected by the HDaudio, Skylake and SOF
drivers. When the HDaudio link is not selected as a option, this
Kconfig option is not touched and will default to whatever other
drivers selected. In the case e.g. where HDaudio is compiled as
built-in, the linker will complain:

ld: sound/soc/sof/sof-pci-dev.o: in function `sof_pci_probe':
sof-pci-dev.c:(.text+0x5c): undefined reference to
`snd_intel_dsp_driver_probe'

Adding the select for all HDaudio platforms, regardless of whether
they rely on the HDaudio link or not, solves the problem.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 82d9d54a6c0ee ('ALSA: hda: add Intel DSP configuration / probe code')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 75018e61fdda..b233302f05e4 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -271,6 +271,7 @@ config SND_SOC_SOF_JASPERLAKE
 
 config SND_SOC_SOF_HDA_COMMON
 	tristate
+	select SND_INTEL_DSP_CONFIG
 	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_HDA_LINK_BASELINE
 	help
@@ -330,7 +331,6 @@ config SND_SOC_SOF_HDA
 	tristate
 	select SND_HDA_EXT_CORE if SND_SOC_SOF_HDA_LINK
 	select SND_SOC_HDAC_HDA if SND_SOC_SOF_HDA_AUDIO_CODEC
-	select SND_INTEL_DSP_CONFIG
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level.
-- 
2.25.1

