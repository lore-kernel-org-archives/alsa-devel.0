Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D8C3A59B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 03:56:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301352168B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 03:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HrtIzQjZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9yjCxOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301352168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6ABBE166A;
	Mon,  2 Sep 2019 05:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6ABBE166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567396569;
	bh=uzv6DzpPwvL3tNqC8iHgBn+ssKipaCaIW0GVeFPULRk=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HrtIzQjZBy8P0zdNzZ5rZTeswE5GbTw3RZW3d1mzdj4+IE5H2zJUvX0tHnuSZkqhW
	 94a8usekoljGB75EHTGvl76dgLGJtlStk9bMs5O2Tev8oPWi2epCWqG96iDY+PPl7q
	 sCaSymAhHSpAeIa04iPKR4+AgeCBRAOe2dyFiCYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E609BF80394;
	Mon,  2 Sep 2019 05:55:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E643F803D0; Mon,  2 Sep 2019 05:54:54 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81043F8011E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 05:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81043F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="D9yjCxOs"
Received: by mail-pf1-x444.google.com with SMTP id y22so2576990pfr.3
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 20:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OH1ekUs0bAkwdIcXuhIeBy1Fe7rzwyed9i4anOS+QSk=;
 b=D9yjCxOsKpxC2MY18oXKvPMh45HPOOO/2e6rqJimjQ57JSKfThLSfjFt2TWGoleJYA
 E0AElnWelyQ7JaAGl2mZzXl5pOrn4anpOQ00XxONWEggwisR/j5HvuSMs+qD8B5HkkrJ
 pDcjEHJYYMW/VQhxlYQREAnlnIwtdaxV6E5qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OH1ekUs0bAkwdIcXuhIeBy1Fe7rzwyed9i4anOS+QSk=;
 b=k2+bFiadxFbp0swcFNP8ceCWcCsfdomcmSj8nBJGM3COdDMdg4S5AuPm3G0DAGpkIq
 KWK/ANSQEOyg1jw+/wQOGxleRhK/QXK7MdtcLSJ6LzA6Tu5Y6h7pWfs8tuqsRFF1tg6U
 GjAw5v6XjcaZzPxwUusg5C0AIDtYkBECR0Ay+Nfqix0Q/dkykYiZ8A3nC8yfWw5WDDjR
 spfFb+/x3WJownNAY9/p3q9pGG5GfPvwd16BPkqMihHPELHqB98v6OAuNMUk7RcaQNr6
 Bl5hhKs6BKlFQ+Mn/nhewKVxNsP0oTiMSwC5N32gha0b1tITt9Ex4EWY/XKmpuG9YlD/
 vM1g==
X-Gm-Message-State: APjAAAUg/Kb/7jGRaeFgEJ/yAUtEUI6006tVyA1wtL1J+JWwnCaDyXWj
 TNfdKrYf81eWtFeHfLg8qapOOA==
X-Google-Smtp-Source: APXvYqyLLTVcLzaki/zpgHyUnP83/ENMttMFuYtnXoMrj+6ZqRMI+e1TuQ0iyviYJx0zTEuLTNFtzg==
X-Received: by 2002:a63:f401:: with SMTP id g1mr24388291pgi.314.1567396489069; 
 Sun, 01 Sep 2019 20:54:49 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
 by smtp.gmail.com with ESMTPSA id y16sm14382217pfn.173.2019.09.01.20.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2019 20:54:48 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Mon,  2 Sep 2019 11:54:35 +0800
Message-Id: <20190902035435.44463-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, zhengxing@rock-chips.com,
 kuninori.morimoto.gx@renesas.com, a.hajda@samsung.com, airlied@linux.ie,
 jeffy.chen@rock-chips.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, cain.cai@rock-chips.com,
 linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>,
 eddie.cai@rock-chips.com, Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
 enric.balletbo@collabora.com, dgreid@chromium.org, sam@ravnborg.org,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
Subject: [alsa-devel] [PATCH v2] drm: dw-hdmi-i2s: enable audio clock in
	audio_startup
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190902035435.McgwA6e7s_5u47kgCIBw4XmazxvPh42GaXvUuyMHBdM@z>

In the designware databook, the sequence of enabling audio clock and
setting format is not clearly specified.
Currently, audio clock is enabled in the end of hw_param ops after
setting format.

On some monitors, there is a possibility that audio does not come out.
Fix this by enabling audio clock in audio_startup ops
before hw_param ops setting format.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
 Changes from v1:
 1. Move audio_startup to the front of audio_shutdown.
 2. Fix the indentation of audio_startup equal sign using tab.
 3. Rebase the patch on linux-next/master.
 4. Add Reviewed-by and Tested-by fields from dianders@chromium.org.
 5. Add Reviewed-by field from jonas@kwiboo.se.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 1d15cf9b6821..34d8e837555f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -109,6 +109,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
 	hdmi_write(audio, conf1, HDMI_AUD_CONF1);
 
+	return 0;
+}
+
+static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
 	dw_hdmi_audio_enable(hdmi);
 
 	return 0;
@@ -153,6 +161,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
+	.audio_startup  = dw_hdmi_i2s_audio_startup,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_eld	= dw_hdmi_i2s_get_eld,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
