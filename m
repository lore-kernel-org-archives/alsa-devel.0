Return-Path: <SRS0=I1aD=YZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0DECA9ECF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:34:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA1E21897
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CJh0ONUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1E21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3512236A;
	Fri,  1 Nov 2019 18:33:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3512236A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572629671;
	bh=oo4zZGA7SdywJxZBP3rSZdJkMFSfOkr7/ZwxfkvIegg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CJh0ONUujCfZnAXC1HzcRijVu574LbLcGUTadZJRfjfnIYZXH4H8xT6lr9aa+/7BO
	 6XMGL42uHK/hI7tzIIT58b0wJO3S4ubtp0PJfShV1u4ecd4navXeUO8ljhETLHaHOp
	 CjXd940GIg+Q2kFPN1qFvAYMvC9It53f4ttkeTNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5045F80611;
	Fri,  1 Nov 2019 18:31:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 623D9F803D6; Fri,  1 Nov 2019 18:31:17 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC9F6F80444
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2019 18:31:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC9F6F80444
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 10:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; d="scan'208";a="206457416"
Received: from ggarreto-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.92.243])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2019 10:30:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri,  1 Nov 2019 12:30:38 -0500
Message-Id: <20191101173045.27099-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
References: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 04/11] ASoC: SOF: Kconfig: add EXPERT
	dependency for developer options, clarify help
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Some distros select all possible options, despite existing warnings to
be careful. This leads to e.g. user reports that the HDaudio codec and
DMIC are not handled by SOF.

Add an explicit menu item to unlock developer options, and make them
dependent on CONFIG_EXPERT. Hopefully with this double-lock these
options will only be selected by developers.

GitHub issue: https://github.com/thesofproject/sof/issues/1885
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/Kconfig | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 56a3ab66b46b..6435eb531668 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -14,7 +14,6 @@ config SND_SOC_SOF_PCI
 	depends on PCI
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
-	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_PCI if SND_SOC_SOF_INTEL_TOPLEVEL
 	help
 	  This adds support for PCI enumeration. This option is
@@ -27,7 +26,6 @@ config SND_SOC_SOF_ACPI
 	depends on ACPI || COMPILE_TEST
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
-	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
 	select IOSF_MBI if X86 && PCI
 	help
@@ -40,19 +38,23 @@ config SND_SOC_SOF_OF
 	tristate "SOF OF enumeration support"
 	depends on OF || COMPILE_TEST
 	select SND_SOC_SOF
-	select SND_SOC_SOF_OPTIONS
 	help
 	  This adds support for Device Tree enumeration. This option is
 	  required to enable i.MX8 devices.
 	  Say Y if you need this option. If unsure select "N".
 
-config SND_SOC_SOF_OPTIONS
-	tristate
+config SND_SOC_SOF_DEVELOPER_SUPPORT
+	bool "SOF developer options support"
+	depends on EXPERT
 	help
-	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  This option unlock SOF developer options for debug/performance/
+	  code hardening.
+	  Distributions should not select this option, only SOF development
+	  teams should select it.
+	  Say Y if you are involved in SOF development and need this option
+	  If not, select N
 
-if SND_SOC_SOF_OPTIONS
+if SND_SOC_SOF_DEVELOPER_SUPPORT
 
 config SND_SOC_SOF_NOCODEC
 	tristate
@@ -64,6 +66,11 @@ config SND_SOC_SOF_NOCODEC_SUPPORT
 	  option if no known codec is detected. This is typically only
 	  enabled for developers or devices where the sound card is
 	  controlled externally
+	  This option is mutually exclusive with the Intel HDaudio support,
+	  selecting it may have negative impacts and prevent e.g. microphone
+	  functionality from being enabled on Intel CoffeeLake and later
+	  platforms.
+	  Distributions should not select this option!
 	  Say Y if you need this nocodec fallback option
 	  If unsure select "N".
 
@@ -168,7 +175,7 @@ config SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT
 
 endif ## SND_SOC_SOF_DEBUG
 
-endif ## SND_SOC_SOF_OPTIONS
+endif ## SND_SOC_SOF_DEVELOPER_SUPPORT
 
 config SND_SOC_SOF
 	tristate
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
