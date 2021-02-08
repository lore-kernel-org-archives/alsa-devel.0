Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636ECC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 09:39:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9957464E6D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 09:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957464E6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFD06167A;
	Mon,  8 Feb 2021 10:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFD06167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612777194;
	bh=8lKLoVqufu5iFzKrx1gnfRNMLEylfunqXZbIH641JnE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJddddxpY1X4Mi64oGnxmVwXwFnj5GRPZ+Sz0Ki2j2CxGg+L4dpIG295tHvqT4WjG
	 5xuwuiVtKohs1wPyuGUFTYdeE5vWSiNu/XBDMOpzQriU71YYJnl8Ph7i3c6+xyWsa6
	 oVzfeWjtGcZ6FGc1OhiR6KH5j4I6XX3OSr2ovZL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18F5AF80240;
	Mon,  8 Feb 2021 10:38:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B38CCF80240; Mon,  8 Feb 2021 10:38:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC46FF80240
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 10:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC46FF80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Z89lYQCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612777090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU/ZWscP/S5es+kf89K3sc+FvqdRmHskjaeif48/6cU=;
 b=Z89lYQCuud1/CZyIyR+yox4UsDPh/Jf0X/LYOc8thirwRllGbc1mwWKuYUvoMKRkJSD3nU
 yTJM/RzWF7qstxH74aMV5+Z6KmCVW+A/IiXzWzmCpoCc2J9peSE/XaCkiIqTv3xP0nTHSu
 ruY9hgCz4qttgxZgC4QWqpf0dotAxAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-QcEz9TcKNXWRaswu2N2gQA-1; Mon, 08 Feb 2021 04:38:06 -0500
X-MC-Unique: QcEz9TcKNXWRaswu2N2gQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545AF85B6D6;
 Mon,  8 Feb 2021 09:38:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-119.ams2.redhat.com
 [10.36.115.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB79F5D9D5;
 Mon,  8 Feb 2021 09:38:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/2] ALSA: hda: intel-dsp-config: Add SND_INTEL_BYT_PREFER_SOF
 Kconfig option
Date: Mon,  8 Feb 2021 10:38:00 +0100
Message-Id: <20210208093800.62099-2-hdegoede@redhat.com>
In-Reply-To: <20210208093800.62099-1-hdegoede@redhat.com>
References: <20210208093800.62099-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

The kernel has 2 drivers for the Low Power Engine audio-block on
Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
driver. If both drivers are enabled then the kernel will default
to using the old SST driver, unless told otherwise through the
snd_intel_dspcfg.dsp_driver module-parameter.

Add a boolean SND_INTEL_BYT_PREFER_SOF Kconfig option, which when set to Y
will make the kernel default to the new SOF driver instead.

Making this configurable will help distributions such as Fedora:
https://fedoraproject.org/w/index.php?title=Changes/SofDefaultForIntelLpe
to test using SOF on BYT/CHT during the transition phase where we
have both drivers (eventually the old driver and this option will
be removed).

Note the option defaults to n, preserving the current behavior.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/hda/Kconfig            | 14 ++++++++++++++
 sound/hda/intel-dsp-config.c |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 3bc9224d5e4f..9ed5cfa3c18c 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -46,3 +46,17 @@ config SND_INTEL_DSP_CONFIG
 	select SND_INTEL_NHLT if ACPI
 	# this config should be selected only for Intel DSP platforms.
 	# A fallback is provided so that the code compiles in all cases.
+
+config SND_INTEL_BYT_PREFER_SOF
+	bool "Prefer SOF driver over SST on BY/CHT platforms"
+	depends on SND_SST_ATOM_HIFI2_PLATFORM_ACPI && SND_SOC_SOF_BAYTRAIL
+	default n
+	help
+	  The kernel has 2 drivers for the Low Power Engine audio-block on
+	  Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
+	  driver. If both drivers are enabled then the kernel will default
+	  to using the old SST driver, unless told otherwise through the
+	  snd_intel_dspcfg.dsp_driver module-parameter.
+
+	  Set this option to Y to make the kernel default to the new SOF
+	  driver instead.
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 2201a1e6944e..fd288df7ede9 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -454,8 +454,13 @@ EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
 
 /* FLAG_BYT_FIRST / _SECOND determine which driver is preferred on BYT/CHT when both are enabled */
 #if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+#ifdef CONFIG_SND_INTEL_BYT_PREFER_SOF
+#define FLAG_BYT_FIRST		FLAG_SOF
+#define FLAG_BYT_SECOND		FLAG_SST
+#else
 #define FLAG_BYT_FIRST		FLAG_SST
 #define FLAG_BYT_SECOND		FLAG_SOF
+#endif
 #elif IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
 #define FLAG_BYT_FIRST		FLAG_SST
 #elif IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
-- 
2.30.0

