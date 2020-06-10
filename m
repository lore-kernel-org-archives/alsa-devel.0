Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDCC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:34:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D544F206F4
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LKaylQQu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDmTN8g7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D544F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 748B61684;
	Wed, 10 Jun 2020 19:33:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 748B61684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591810455;
	bh=Acf+T5dyquBQ8VzAG9F0OKOhpmbiIh04l8jYronZcPg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKaylQQuUfBKhXnd3ZNNLka1ZWa7yN7hdp5CHlJMzmcE7j8dKBNLWpZSOX3WMR99V
	 M5ArxWEZPe5zu0uw9gEb3Do3ySNwfIaS+ZHajjhnV3MQluS5jFbtxF0YYiIA4O47Su
	 BZ0Rsku+X6IwUj9loqkkz5GfSHWTAGDrcNwEHp40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD19F802F7;
	Wed, 10 Jun 2020 19:30:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5483EF802F8; Wed, 10 Jun 2020 19:30:13 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71958F8021C
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 19:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71958F8021C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mDmTN8g7"
Received: by mail-pl1-x643.google.com with SMTP id t16so1209141plo.7
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YSSqAri9IDFCpU3JjO79asbzoYTG2dNk47iwG0514GI=;
 b=mDmTN8g77fIQ7mXWZiV3RT0B5wwlZzKx6S+wKTcIRN4H5fwCr50Eu8/ixfWH2h65Oh
 NZEIVdGKL/Blz2c3a1qIWjVNej6Z6uG7NSEJtjJE1dVBGOkmhphDE6e5bd3R/YARk4CC
 ViMMVL6aRup/WasNXCSxmwbKgnO28mr4v7jDeGs1YV9t2gzx1Zb/HkiHg6iUtjT6jtgN
 qb+gcTP76RcJX/RHOuCYS5ZkgXOfFFKhLw+cixP0iezh5gaWRFKAUan7nq88xer4ZQ6B
 h3V+sxyEZoK82tPtqKsdXhwmQr/CE7zEK0TaCB+1ppdH+8s6t2XSPbGGQHeMaW09pVhu
 L3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YSSqAri9IDFCpU3JjO79asbzoYTG2dNk47iwG0514GI=;
 b=r3vkbaHoTODHqUV1usNxLy0nto5uyp3BICWXxPEW4skmt4/dRTEapbVXQZ5xVwuE2c
 VtwEONzt0kshdPB1TE/aUkHZDAvEJuO+lSCYdYU93rVcqZo90LVxNddHl4y6cq88qgeU
 /51f6W7TavGW9y68QFoyaw76WsGvI7NSTtP3/OnAgNvuKY6BDpvf/IIDp9Da/jdWeyNG
 xOYeCi9PB+vQ52ZZOicbYMzbziOW35K+nxkGW6FO06jmVdSoCztr4ixMl9x/l9Ehupdd
 7mqDa1HH1USSlJYXa24gDh9vtElBJZ+5yxdxmar+2TQGagCZYLStlIx2PpPbMbeh4p7L
 2c+g==
X-Gm-Message-State: AOAM5323fci0yubjakCpxUQ/mP/FkYEPVC9IRsP76JtaZPXaBdsJKeuE
 hq6A7X+yhCCRsSliAzYAe6EQzYohy0QfqOMr
X-Google-Smtp-Source: ABdhPJzNlj5nhn4pYpEdkNQnoV/L+9+GNHKM52nJxU7AlwWynfm7U5MIiTie1V5Kla8isU83IdExAQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id
 w18mr3704408pll.273.1591810208856; 
 Wed, 10 Jun 2020 10:30:08 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
 by smtp.googlemail.com with ESMTPSA id l83sm490470pfd.150.2020.06.10.10.29.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2020 10:30:08 -0700 (PDT)
From: Vaibhav Agarwal <vaibhav.sr@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
 Mark Greer <mgreer@animalcreek.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 6/6] staging: greybus: audio: Enable GB codec,
 audio module compilation.
Date: Wed, 10 Jun 2020 22:58:30 +0530
Message-Id: <54b188a59687a915f43085db7b5cf05476308cbd.1591802243.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591802243.git.vaibhav.sr@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, linux-kernel@vger.kernel.org,
 greybus-dev@lists.linaro.org
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

Currently you can't enable the Gey Bus Audio Codec because there is no
entry for it in the Kconfig file. Originally the config name was going
to be AUDIO_MSM8994 but that's not correct because other types of
hardware are supported now. I have chosen the name AUDIO_APB_CODEC
instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
make the compile work.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/Kconfig  | 14 +++++++++++++-
 drivers/staging/greybus/Makefile |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index d4777f5a8b90..cbcfcbba239b 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -3,7 +3,7 @@ if GREYBUS
 
 config GREYBUS_AUDIO
 	tristate "Greybus Audio Class driver"
-	depends on SOUND
+	depends on SOUND && SND_SOC
 	---help---
 	  Select this option if you have a device that follows the
 	  Greybus Audio Class specification.
@@ -11,6 +11,18 @@ config GREYBUS_AUDIO
 	  To compile this code as a module, chose M here: the module
 	  will be called gb-audio.ko
 
+config GREYBUS_AUDIO_APB_CODEC
+	tristate "Greybus APBridge Audio codec driver"
+	depends on SND_SOC && GREYBUS_AUDIO
+	help
+	  Select this option if you have a Toshiba APB device that has I2S
+          ports and acts as a Greybus "Dummy codec". This device is a
+          bridge from an APB-I2S port to a Unipro network.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called gb-audio-codec.ko
+
+
 config GREYBUS_BOOTROM
 	tristate "Greybus Bootrom Class driver"
 	---help---
diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
index 3b4b6cabff19..7c5e89622334 100644
--- a/drivers/staging/greybus/Makefile
+++ b/drivers/staging/greybus/Makefile
@@ -40,8 +40,8 @@ gb-audio-manager-y	:= audio_manager.o audio_manager_module.o
 #ccflags-y += -DGB_AUDIO_MANAGER_SYSFS
 #endif
 
-obj-$(CONFIG_GREYBUS_AUDIO_MSM8994)	+= gb-audio-codec.o
-obj-$(CONFIG_GREYBUS_AUDIO_MSM8994)	+= gb-audio-module.o
+obj-$(CONFIG_GREYBUS_AUDIO_APB_CODEC)  	+= gb-audio-codec.o
+obj-$(CONFIG_GREYBUS_AUDIO_APB_CODEC)	+= gb-audio-module.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-gb.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-apbridgea.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-manager.o
-- 
2.26.2

