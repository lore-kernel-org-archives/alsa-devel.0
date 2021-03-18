Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DBC433E6
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:15:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117AC64E89
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117AC64E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ABA21688;
	Thu, 18 Mar 2021 16:14:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ABA21688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616080516;
	bh=iLFk28DPvzp/I8h2KgDztRJxAPC5PLfTufl/idEiQIU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WMrDqWJqR825yS7Q1l+7w0qdq1wKGfu46PjOWNl/C+c3OsyiJoQ+xoZEZGQ+ti3JE
	 oXAsBzRNPwodJXyqj4hLFOAbVLWZGs5seHgyKqkvm76BZ3sUC406XxZNp65/+yPUxk
	 pFulwapeHGybsF7tAemDR/QCm3DeLRLiV4K5LWoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98B74F802E3;
	Thu, 18 Mar 2021 16:13:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 897E7F80163; Thu, 18 Mar 2021 16:13:34 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEC65F800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 16:13:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC65F800C8
IronPort-SDR: gzKa/kotr2dfMDmf0vfxOXfwbJbapWvgzANxBNO6xh2zHygvEN6WvIPXZiC52symw1MVz6NNYt
 okY5ZWQDerYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209702419"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="209702419"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 08:13:23 -0700
IronPort-SDR: +7tVy0F2WWz0kucT/Kq6Rn0ZoNFXx+UenWHwAjc7P/THJMYuhKnp/G9WA1gKV0qaRGtrDuw2T/
 CeiKujchrjUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="606207215"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 08:13:22 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/3] ALSA: hda: Revert "ALSA: hda: Allow setting preallocation
 again for x86"
Date: Thu, 18 Mar 2021 16:11:22 +0100
Message-Id: <20210318151122.2493096-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318151122.2493096-1-amadeuszx.slawinski@linux.intel.com>
References: <20210318151122.2493096-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>,
 alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

This reverts commit f8e4ae10de43fbb7ce85f79e04eca2988b6b2c40.

On systems where there is a lot of FrontEnds, when
CONFIG_SND_HDA_PREALLOC_SIZE != 0  ALSA core allocates memory for each
FE, which may cause out of memory problems due to per card limit. Force
config to 0 on X86, so memory will be allocated on as needed basis.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=201251#c322
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 57595f1552c9..741179ccbd4e 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -21,17 +21,16 @@ config SND_HDA_EXT_CORE
        select SND_HDA_CORE
 
 config SND_HDA_PREALLOC_SIZE
-	int "Pre-allocated buffer size for HD-audio driver"
+	int "Pre-allocated buffer size for HD-audio driver" if !SND_DMA_SGBUF
 	range 0 32768
-	default 2048 if SND_DMA_SGBUF
+	default 0 if SND_DMA_SGBUF
 	default 64 if !SND_DMA_SGBUF
 	help
 	  Specifies the default pre-allocated buffer-size in kB for the
 	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
 	  for systems using PulseAudio.  The default 64 is chosen just
 	  for compatibility reasons.
-	  On x86 systems, the default is 2048 as a reasonable value for
-	  most of modern systems.
+	  On x86 systems, the default is zero as we need no preallocation.
 
 	  Note that the pre-allocation size can be changed dynamically
 	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
-- 
2.25.1

