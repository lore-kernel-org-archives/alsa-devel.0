Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5BC63777
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 02:34:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED4D20809
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 02:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p96yN9Oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED4D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A45C1761;
	Tue,  1 Dec 2020 03:33:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A45C1761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606790089;
	bh=ywYU1fgqG64o8+GUhHVQYlzg7XOqIQIa1EwiyLhWS20=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p96yN9Oz72MgIjOu6foX+BIjWqsWi5zySd7NAXmL6gXMtopMCJJxqTs6AssKy8uhD
	 1GpUIHesAP3aqUjucrgY5gZKsw+L5vicIK8FdjxXMgOCDKgFHVUTf6KOw7JSD0W9/g
	 Cim3c+j6/wHJBeQXxZlZVNfB/Rcg90y+zRNWqE/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B4FCF804C1;
	Tue,  1 Dec 2020 03:33:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8E0CF804CA; Tue,  1 Dec 2020 03:33:07 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6373FF80139
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 03:33:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6373FF80139
IronPort-SDR: 9w8n1sa27B0wQGGQeGCVqjMTzRfJoDg1mTBuLPTS2Vh/eMnI/Kejk16msGBiL8Dh6dgHWaxmJq
 XbMUZRyT1uNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="190942202"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="190942202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 18:32:58 -0800
IronPort-SDR: j0B1RUSAEBkCbip2cFPb8qNg6VS4l2ulleh195CRS73FaOPfpWTiNj4eGMJoQkBPmR9aDe52Hn
 BBidhJNssYVw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="549360086"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 18:32:54 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 1/5] soundwire: SDCA: add helper macro to access controls
Date: Mon, 30 Nov 2020 22:40:16 +0800
Message-Id: <20201130144020.19757-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The upcoming SDCA (SoundWire Device Class Audio) specification defines
a hierarchical encoding to interface with Class-defined capabilities.

The specification is not yet accessible to the general public but this
information is released with explicit permission from the MIPI Board
to avoid delays with SDCA support on Linux platforms.

A block of 64 MBytes of register addresses are allocated to SDCA
controls, starting at address 0x40000000. The 26 LSBs which identify
individual controls are set based on the following variables:

- Function Number. An SCDA device can be split in up to 8 independent
  Functions. Each of these Functions is described in the SDCA
  specification, e.g. Smart Amplifier, Smart Microphone, Simple
  Microphone, Jack codec, HID, etc.

- Entity Number.  Within each Function,  an Entity is  an identifiable
  block.  Up   to  127  Entities   are  connected  in   a  pre-defined
  graph  (similar to  USB), with  Entity0 reserved  for Function-level
  configurations.  In  contrast  to  USB, the  SDCA  spec  pre-defines
  Function Types, topologies, and allowed  options, i.e. the degree of
  freedom  is not  unlimited to  limit  the possibility  of errors  in
  descriptors leading to software quirks.

- Control Selector. Within each Entity, the SDCA specification defines
  48 controls such as Mute, Gain, AGC, etc, and 16 implementation
  defined ones. Some Control Selectors might be used for low-level
  platform setup, and other exposed to applications and users. Note
  that the same Control Selector capability, e.g. Latency control,
  might be located at different offsets in different entities, the
  Control Selector mapping is Entity-specific.

- Control Number. Some Control Selectors allow channel-specific values
  to be set, with up to 64 channels allowed. This is mostly used for
  volume control.

- Current/Next values. Some Control Selectors are
  'Dual-Ranked'. Software may either update the Current value directly
  for immediate effect. Alternatively, software may write into the
  'Next' values and update the SoundWire 1.2 'Commit Groups' register
  to copy 'Next' values into 'Current' ones in a synchronized
  manner. This is different from bank switching which is typically
  used to change the bus configuration only.

- MBQ. the Multi-Byte Quantity bit is used to provide atomic updates
  when accessing more that one byte, for example a 16-bit volume
  control would be updated consistently, the intermediate values
  mixing old MSB with new LSB are not applied.

These 6 parameters are used to build a 32-bit address to access the
desired Controls. Because of address range, paging is required, but
the most often used parameter values are placed in the lower 16 bits
of the address. This helps to keep the paging registers constant while
updating Controls for a specific Device/Function.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 0cb1a22685b8..138bec908c40 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -309,4 +309,36 @@
 #define SDW_CASC_PORT_MASK_INTSTAT3		1
 #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
 
+/*
+ * v1.2 device - SDCA address mapping
+ *
+ * Spec definition
+ *	Bits		Contents
+ *	31		0 (required by addressing range)
+ *	30:26		0b10000 (Control Prefix)
+ *	25		0 (Reserved)
+ *	24:22		Function Number [2:0]
+ *	21		Entity[6]
+ *	20:19		Control Selector[5:4]
+ *	18		0 (Reserved)
+ *	17:15		Control Number[5:3]
+ *	14		Next
+ *	13		MBQ
+ *	12:7		Entity[5:0]
+ *	6:3		Control Selector[3:0]
+ *	2:0		Control Number[2:0]
+ */
+
+#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
+						 (((fun) & 0x7) << 22) |	\
+						 (((ent) & 0x40) << 15) |	\
+						 (((ent) & 0x3f) << 7) |	\
+						 (((ctl) & 0x30) << 15) |	\
+						 (((ctl) & 0x0f) << 3) |	\
+						 (((ch) & 0x38) << 12) |	\
+						 ((ch) & 0x07))
+
+#define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
+#define SDW_SDCA_NEXT_CTL(reg)			((reg) | BIT(14))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.17.1

