Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CEC35254
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 03:21:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1B920838
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 03:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lTSnRH7u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ueuYkYfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1B920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF6E6168F;
	Thu,  6 Feb 2020 04:20:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF6E6168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580959295;
	bh=uzq0zuDqOYCJ90ejD0z8FRESahyYoUZEm6jpVbv5GDg=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lTSnRH7umgV9DfN1nqufvg9gwzm69/WDVyphsl0Pna1h1nWkzU69nIgXcm6jgh0V4
	 ixMZPT+k2cy6mEA9Bq+OOsn4eyfek7ZCOi40ESL+6B/+82AGUnW8KT7UckvT+fTs6N
	 AcyDP7IYQNffaVKY/fQxGtCEn3IfsRZjCocd1i8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78980F8028B;
	Thu,  6 Feb 2020 04:18:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10BD4F80278; Thu,  6 Feb 2020 04:18:32 +0100 (CET)
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com
 [IPv6:2607:f8b0:4864:20::f49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A33FF8025F
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 04:18:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A33FF8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ueuYkYfz"
Received: by mail-qv1-xf49.google.com with SMTP id f17so2859758qvi.6
 for <alsa-devel@alsa-project.org>; Wed, 05 Feb 2020 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=3xSqtFmkuhmH7fZvAamf8hbYq+ufSxebJYVWVye4C7Y=;
 b=ueuYkYfzd1J7mUX84rods+zZPBEDPeQEpjWo1fKgNXmmkJRjFmQ57clQ25FbxVrB81
 0BoeuWRSAlLi4ikcBydPblOqMIIYdUZlWt96IlppvTopxt4MrWxe1NJNb00pEILdALIL
 mwP9m3shNI4otFS5JNL2mDva9EvmqHjaLpSPV+4fWAoYFTZp1nvG0CRMuMvaQQpiTocd
 RdQCWBIwo+BGVgpp3NbIEtfA/GO13BcJrwl9r2EoO9jqfv5ogBgO5W/6Q7nyLCxted8+
 Q/tls29mCNiLAHzFozF2uSg8V5VCuOfUUjtgXE6vmEdrV5rvwC9qaa9Tedzul30Dx9L2
 FkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=3xSqtFmkuhmH7fZvAamf8hbYq+ufSxebJYVWVye4C7Y=;
 b=G0o0MlGXKR3A8zvpUIGMzU2mJWypkQtkW202BT3top5JHP84swKate+y42HtS8qGQv
 nRJ+W+ONnkJRmJZZ/IxFap/Hw3g9I3R0aAhdwb6pGccxlZrNYKsncJiz3f711KwD/JUe
 D0N6aLjRIhsDOC/aIC426stcWvY3pp8bUWNmxPmvpsVkkq4YAQtZpHDAHtMer0iaJhy4
 hRye11V52SfRGFNSRqTH9UwW+2tT0bpEQCcom3SrcaxEPR1T2CDnylTXq7lzysQmopyK
 f8I84ncqfMLSQfE31bx88Kwr8sZ3eMeSo2779BCldvji5s0VARPGj/4gCzkYIkWbtkfm
 TFwA==
X-Gm-Message-State: APjAAAVDvXv5YGKNq27cmADdcDk77KNIQQ9h5ZFHtrfEvkPC7nfP3SYW
 08/hDoDbLrfqyd8G53rahTQZYMrJYOER
X-Google-Smtp-Source: APXvYqz/fAMuYGvIwuayOCKaf8jH3Jt4uA2sxWoRh0ciqFGB/O4svWNUa/d29O7qRqPWaudemfa9s6lehhZc
X-Received: by 2002:a0c:fe8e:: with SMTP id d14mr705336qvs.106.1580959106204; 
 Wed, 05 Feb 2020 19:18:26 -0800 (PST)
Date: Thu,  6 Feb 2020 11:17:52 +0800
In-Reply-To: <20200206031752.193298-1-tzungbi@google.com>
Message-Id: <20200206102509.3.I253f51edff62df1d88005de12ba601aa029b1e99@changeid>
Mime-Version: 1.0
References: <20200206031752.193298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v2 3/3] ASoC: mediatek: mt8173-rt5650: support
	HDMI jack reporting
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

Uses hdmi-codec to support HDMI jack reporting.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ef6f23675286..849b050a54d1 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -11,6 +11,7 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+#include <sound/hdmi-codec.h>
 #include "../../codecs/rt5645.h"
 
 #define MCLK_FOR_CODECS		12288000
@@ -98,7 +99,7 @@ static const struct snd_soc_ops mt8173_rt5650_ops = {
 	.hw_params = mt8173_rt5650_hw_params,
 };
 
-static struct snd_soc_jack mt8173_rt5650_jack;
+static struct snd_soc_jack mt8173_rt5650_jack, mt8173_rt5650_hdmi_jack;
 
 static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 {
@@ -144,6 +145,19 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 				      &mt8173_rt5650_jack);
 }
 
+static int mt8173_rt5650_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &mt8173_rt5650_hdmi_jack, NULL, 0);
+	if (ret)
+		return ret;
+
+	return hdmi_codec_set_jack_detect(rtd->codec_dai->component,
+					  &mt8173_rt5650_hdmi_jack);
+}
+
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
@@ -222,6 +236,7 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.name = "HDMI BE",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
+		.init = mt8173_rt5650_hdmi_init,
 		SND_SOC_DAILINK_REG(hdmi_be),
 	},
 };
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
