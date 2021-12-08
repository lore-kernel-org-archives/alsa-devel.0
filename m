Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D033C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 11:13:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54BE62375;
	Wed,  8 Dec 2021 12:13:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54BE62375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638962032;
	bh=gqdw4CeBemOk6jiRSN0//8sL7hfIn+9UDsA/rkwzCDU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=py06P7hxK4GTsylFNCwruZvWm/NFq0J9ER6FjDVSpMUzJv/jsHXZtbbpp7vBQ7ZOd
	 gTYJ5+47fORXYyk6rPdcVaxu0E7l9kU3rifivsZ85yTS7VFQdiqiw36EE8+BP4l42T
	 6PTVd2Qn2OvaijjWkpfiP1rEYm4Sx1yHJ9wc+4DY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD1DBF8051A;
	Wed,  8 Dec 2021 12:11:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05E4EF804FE; Wed,  8 Dec 2021 12:11:11 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 229A7F804FE
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 12:11:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 229A7F804FE
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301192825"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; d="scan'208";a="301192825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 03:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; d="scan'208";a="600600096"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2021 03:11:02 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC 05/37] ALSA: hda: Add helper macros for DSP capable devices
Date: Wed,  8 Dec 2021 12:12:29 +0100
Message-Id: <20211208111301.1817725-6-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208111301.1817725-1-cezary.rojewski@intel.com>
References: <20211208111301.1817725-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 harshapriya.n@intel.com, yung-chuan.liao@linux.intel.com, rad@semihalf.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 broonie@kernel.org, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 peter.ujfalusi@linux.intel.com, lma@semihalf.com
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

HDAudio drivers make heavy use of I/O operations. Declare a range of
update, read and write helpers similar to those available for HDAudio
legacy driver. These macros are used by AVS driver to improve code
readability.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/hdaudio.h     |  2 ++
 include/sound/hdaudio_ext.h | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 22af68b01426..629a83aa98df 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -448,6 +448,8 @@ static inline u16 snd_hdac_reg_readw(struct hdac_bus *bus, void __iomem *addr)
 
 #define snd_hdac_reg_writel(bus, addr, val)	writel(val, addr)
 #define snd_hdac_reg_readl(bus, addr)	readl(addr)
+#define snd_hdac_reg_writeq(bus, addr, val)	writeq(val, addr)
+#define snd_hdac_reg_readq(bus, addr)		readq(addr)
 
 /*
  * macros for easy use
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 8b7ee918f540..40e448383355 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -2,6 +2,7 @@
 #ifndef __SOUND_HDAUDIO_EXT_H
 #define __SOUND_HDAUDIO_EXT_H
 
+#include <linux/iopoll.h>
 #include <sound/hdaudio.h>
 
 int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
@@ -145,6 +146,54 @@ void snd_hdac_ext_bus_link_power(struct hdac_device *codec, bool enable);
 	writew(((readw(addr + reg) & ~(mask)) | (val)), \
 		addr + reg)
 
+#define snd_hdac_adsp_writeb(chip, reg, value) \
+	snd_hdac_reg_writeb(chip, (chip)->adsp_ba + (reg), value)
+#define snd_hdac_adsp_readb(chip, reg) \
+	snd_hdac_reg_readb(chip, (chip)->adsp_ba + (reg))
+#define snd_hdac_adsp_writew(chip, reg, value) \
+	snd_hdac_reg_writew(chip, (chip)->adsp_ba + (reg), value)
+#define snd_hdac_adsp_readw(chip, reg) \
+	snd_hdac_reg_readw(chip, (chip)->adsp_ba + (reg))
+#define snd_hdac_adsp_writel(chip, reg, value) \
+	snd_hdac_reg_writel(chip, (chip)->adsp_ba + (reg), value)
+#define snd_hdac_adsp_readl(chip, reg) \
+	snd_hdac_reg_readl(chip, (chip)->adsp_ba + (reg))
+#define snd_hdac_adsp_writeq(chip, reg, value) \
+	snd_hdac_reg_writeq(chip, (chip)->adsp_ba + (reg), value)
+#define snd_hdac_adsp_readq(chip, reg) \
+	snd_hdac_reg_readq(chip, (chip)->adsp_ba + (reg))
+
+#define snd_hdac_adsp_updateb(chip, reg, mask, val) \
+	snd_hdac_adsp_writeb(chip, reg, \
+			(snd_hdac_adsp_readb(chip, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatew(chip, reg, mask, val) \
+	snd_hdac_adsp_writew(chip, reg, \
+			(snd_hdac_adsp_readw(chip, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatel(chip, reg, mask, val) \
+	snd_hdac_adsp_writel(chip, reg, \
+			(snd_hdac_adsp_readl(chip, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updateq(chip, reg, mask, val) \
+	snd_hdac_adsp_writeq(chip, reg, \
+			(snd_hdac_adsp_readq(chip, reg) & ~(mask)) | (val))
+
+#define snd_hdac_adsp_readb_poll(chip, reg, val, cond, delay_us, timeout_us) \
+	readb_poll_timeout((chip)->adsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readw_poll(chip, reg, val, cond, delay_us, timeout_us) \
+	readw_poll_timeout((chip)->adsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readl_poll(chip, reg, val, cond, delay_us, timeout_us) \
+	readl_poll_timeout((chip)->adsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readq_poll(chip, reg, val, cond, delay_us, timeout_us) \
+	readq_poll_timeout((chip)->adsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_stream_readb_poll(strm, reg, val, cond, delay_us, timeout_us) \
+	readb_poll_timeout((strm)->sd_addr + AZX_REG_ ## reg, val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_stream_readl_poll(strm, reg, val, cond, delay_us, timeout_us) \
+	readl_poll_timeout((strm)->sd_addr + AZX_REG_ ## reg, val, cond, \
+			   delay_us, timeout_us)
 
 struct hdac_ext_device;
 
-- 
2.25.1

