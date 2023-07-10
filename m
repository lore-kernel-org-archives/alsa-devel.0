Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEFFEB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 04:17:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FE9D847;
	Mon, 10 Jul 2023 06:16:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FE9D847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688962620;
	bh=XFOtVT3CTOUuPvE7bSFvU2DC+OdLSIu0VDJ6JxokxYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WZeOwUYHk28bHjTuI9sbRYnTpOlgXQ5fyUNuJ+wrHo1lSRkSbfPghNBf+x64WyPoc
	 tGwevXGfFB6jrRhT/vwiqcAl2mMuLBAV78344tAqGto4XmkKlwpbDOgHzmFfBtMB8w
	 LUlQuyM1so0o/33QsfrCLT991NeDXPZqzBfmmdqA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40643F80557; Mon, 10 Jul 2023 06:15:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69D36F80552;
	Mon, 10 Jul 2023 06:15:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28D7AF80290; Mon, 10 Jul 2023 06:14:19 +0200 (CEST)
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8F4EF80093
	for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2023 06:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8F4EF80093
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[183.194.159.125])
	by rmsmtp-lg-appmail-26-12031 (RichMail) with SMTP id 2eff64ab852fc25-b3e08;
	Mon, 10 Jul 2023 12:12:37 +0800 (CST)
X-RM-TRANSID: 2eff64ab852fc25-b3e08
From: Shenghao Ding <13916275206@139.com>
To: broonie@kernel.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com
Cc: kevin-lu@ti.com,
	shenghao-ding@ti.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	mengdong.lin@intel.com,
	x1077012@ti.com,
	peeyush@ti.com,
	navada@ti.com,
	tiwai@suse.de,
	Shenghao Ding <13916275206@139.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entries for TEXAS INSTRUMENTS AUDIO
 (ASoC/HDA) DRIVERS
Date: Mon, 10 Jul 2023 12:12:17 +0800
Message-Id: <20230710041217.151099-3-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710041217.151099-1-13916275206@139.com>
References: <20230710041217.151099-1-13916275206@139.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KMKQ6JT6XLSZ3RUGVW3VEESCK7KFESJ7
X-Message-ID-Hash: KMKQ6JT6XLSZ3RUGVW3VEESCK7KFESJ7
X-MailFrom: 13916275206@139.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KMKQ6JT6XLSZ3RUGVW3VEESCK7KFESJ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add the MAINTAINERS entries for TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v2:
Add maintian team members to support TEXAS INSTRUMENTS AUDIO DRIVER
---
 MAINTAINERS | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..42a3694f3064 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21049,6 +21049,39 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
+TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+M:	Shenghao Ding <shenghao-ding@ti.com>
+M:	Kevin Lu <kevin-lu@ti.com>
+M:	Baojun Xu <x1077012@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/tas2552.txt
+F:	Documentation/devicetree/bindings/sound/tas2562.yaml
+F:	Documentation/devicetree/bindings/sound/tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/tas27xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
+F:	include/sound/tas2*.h
+F:	include/sound/tlv320*.h
+F:	include/sound/tpa6130a2-plat.h
+F:	sound/pci/hda/tas2781_hda_i2c.c
+F:	sound/soc/codecs/pcm1681.c
+F:	sound/soc/codecs/pcm1789*.*
+F:	sound/soc/codecs/pcm179x*.*
+F:	sound/soc/codecs/pcm186x*.*
+F:	sound/soc/codecs/pcm3008.*
+F:	sound/soc/codecs/pcm3060*.*
+F:	sound/soc/codecs/pcm3168a*.*
+F:	sound/soc/codecs/pcm5102a.c
+F:	sound/soc/codecs/pcm512x*.*
+F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/tlv320*.*
+F:	sound/soc/codecs/tpa6130a2.*
+
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	dmaengine@vger.kernel.org
-- 
2.34.1


