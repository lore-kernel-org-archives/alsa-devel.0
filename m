Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5153C33CA1
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:40:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601222082E
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="on2THQ0u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ixbOIq8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601222082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D501F168F;
	Wed,  5 Feb 2020 10:39:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D501F168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580895640;
	bh=+5N8E4CrJ0ai8w33IhMT1EmedU/3ZFPPuNSH5vBnQEw=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=on2THQ0uYW+dz/pOWRcTEDtJK3x0AByad7BYuuKMVrtH7xkbJY75r9xaQ7hx7hSZG
	 zM0dif8GYzBvo51PTuYiIgikc1H3B0KjS9Z+4Uoba8xHYhOaQJq/bNGYL/bG1iO9Zb
	 KomQ8savbqRVsTESg3DM26+BOTJwcRGtGhm3NgP0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1746FF80273;
	Wed,  5 Feb 2020 10:38:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 277CEF80274; Wed,  5 Feb 2020 10:38:16 +0100 (CET)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55704F80051
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 10:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55704F80051
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ixbOIq8m"
Received: by mail-qk1-x749.google.com with SMTP id b23so872005qkg.17
 for <alsa-devel@alsa-project.org>; Wed, 05 Feb 2020 01:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cX29gQ3Pe2nYNSmOPNFjk0KmvqrTptDWTP83/iCAsdA=;
 b=ixbOIq8maNz1diHMn2lwgN76Wks4PKPS2JD5s1qhsxg+f4Lw0HcqZx/CFcJ9zvGF4J
 LdRZO6zI4PrghmZbrzhz9Pbwie595/SdQzw5i15qqaE+duNoGAAqdtlsNeC6JHyhuEIZ
 wY/1FPuOwOsaQX0vF2Mfr2OBuD+Bo41BB4mt/scYJFiZO46DLSj63t3xkl6x4wvV0mlR
 eALP5NYK254rYDixapJgUG0dE8WxxHbbwmH81ICXVqOr03qEWAbgmbb0Vima2BWBTg3c
 tknLYkEmLkGeT7M35AhA0k5pSX9LfGwnO3rPNRi2+iDmLmtm7GOpv+gWKnrTdCr6XaVk
 1Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cX29gQ3Pe2nYNSmOPNFjk0KmvqrTptDWTP83/iCAsdA=;
 b=dNykrmStq6fg4nNdUzyBili+TeGgr30MxjFPC1SqaSMrOcqzGYHMNLEoqioWysOuEy
 eJw5UVaXuCLc+N9lqDBxZEVBM4kExGO5S0+NszI/BYRX5m4T/90A9cSaHuH42CYIBxNt
 cVcwqSZEGzvcRs0DoeqNKnEZndkA4DPoZJg2Bthxte30eGo1BRRAjg7TEQQHjD2PT8wW
 UHWh0ZXKcDc8+5NSvrMra8TY7yMKLq3gZ/pqtSLT/55FN7FPYLPjw8DnxEOuW5NjQdvZ
 yh7Cj8P4231NvcCHTVZBpndLeiCnRT1pAOeJcfY0X2DztDhN6uZXEGeQsfxr6Bgnog0p
 o3zQ==
X-Gm-Message-State: APjAAAVmItgZ8rPiarJVrOitNRfpOYY0UEukUcqWEPdJefHxVetGIB/w
 kEnKJT6/qc15lyEeKog99v7alJtBJlDn
X-Google-Smtp-Source: APXvYqzvqZ+I6q7rsrnsbANQ2Td41uSXPBSKwBl8ZrPWLMClutzjKDkU8rsrWO96kwNDsFR8NBUJJAomYVqM
X-Received: by 2002:a0c:fe0d:: with SMTP id x13mr31660627qvr.88.1580895491114; 
 Wed, 05 Feb 2020 01:38:11 -0800 (PST)
Date: Wed,  5 Feb 2020 17:37:44 +0800
In-Reply-To: <20200205093745.79298-1-tzungbi@google.com>
Message-Id: <20200205170416.2.I230fd59de28e73934a91cb01424e25b9e84727f4@changeid>
Mime-Version: 1.0
References: <20200205093745.79298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 2/3] drm/mediatek: support HDMI jack status
	reporting
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

1.
Provides a callback (i.e. mtk_hdmi_audio_hook_plugged_cb) to hdmi-codec.
When ASoC machine driver calls hdmi_codec_set_jack_detect(), the
callback will be invoked to save plugged_cb and codec_dev parameters.

+---------+  set_jack_  +------------+ plugged_cb  +----------+
| machine | ----------> | hdmi-codec | ----------> | mtk-hdmi |
+---------+  detect()   +------------+ codec_dev   +----------+

2.
When there is any jack status changes, mtk-hdmi will call the
plugged_cb() to notify hdmi-codec.  And then hdmi-codec will call
snd_soc_jack_report().

+----------+ plugged_cb  +------------+
| mtk-hdmi | ----------> | hdmi-codec | -> snd_soc_jack_report()
+----------+ codec_dev   +------------+
             connector_status

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 41 +++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 23c2b0e8693d..15736ed0a96a 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -169,6 +169,8 @@ struct mtk_hdmi {
 	bool audio_enable;
 	bool powered;
 	bool enabled;
+	hdmi_codec_plugged_cb plugged_cb;
+	struct device *codec_dev;
 };
 
 static inline struct mtk_hdmi *hdmi_ctx_from_bridge(struct drm_bridge *b)
@@ -1194,13 +1196,27 @@ static void mtk_hdmi_clk_disable_audio(struct mtk_hdmi *hdmi)
 	clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_AUD_SPDIF]);
 }
 
+static void mtk_hdmi_update_plugged_status(struct mtk_hdmi *hdmi,
+					   enum drm_connector_status status)
+{
+	if (hdmi->plugged_cb && hdmi->codec_dev)
+		hdmi->plugged_cb(hdmi->codec_dev,
+				 status == connector_status_connected);
+}
+
 static enum drm_connector_status hdmi_conn_detect(struct drm_connector *conn,
 						  bool force)
 {
 	struct mtk_hdmi *hdmi = hdmi_ctx_from_conn(conn);
+	enum drm_connector_status status;
 
-	return mtk_cec_hpd_high(hdmi->cec_dev) ?
-	       connector_status_connected : connector_status_disconnected;
+	if (mtk_cec_hpd_high(hdmi->cec_dev))
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+	mtk_hdmi_update_plugged_status(hdmi, status);
+	return status;
 }
 
 static void hdmi_conn_destroy(struct drm_connector *conn)
@@ -1648,20 +1664,41 @@ static int mtk_hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 	return 0;
 }
 
+static int mtk_hdmi_audio_hook_plugged_cb(struct device *dev, void *data,
+					  hdmi_codec_plugged_cb fn,
+					  struct device *codec_dev)
+{
+	struct mtk_hdmi *hdmi = data;
+
+	hdmi->plugged_cb = fn;
+	hdmi->codec_dev = codec_dev;
+
+	if (mtk_cec_hpd_high(hdmi->cec_dev))
+		mtk_hdmi_update_plugged_status(
+				hdmi, connector_status_connected);
+	else
+		mtk_hdmi_update_plugged_status(
+				hdmi, connector_status_disconnected);
+	return 0;
+}
+
 static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
 	.hw_params = mtk_hdmi_audio_hw_params,
 	.audio_startup = mtk_hdmi_audio_startup,
 	.audio_shutdown = mtk_hdmi_audio_shutdown,
 	.digital_mute = mtk_hdmi_audio_digital_mute,
 	.get_eld = mtk_hdmi_audio_get_eld,
+	.hook_plugged_cb = mtk_hdmi_audio_hook_plugged_cb,
 };
 
 static int mtk_hdmi_register_audio_driver(struct device *dev)
 {
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 	struct hdmi_codec_pdata codec_data = {
 		.ops = &mtk_hdmi_audio_codec_ops,
 		.max_i2s_channels = 2,
 		.i2s = 1,
+		.data = hdmi,
 	};
 	struct platform_device *pdev;
 
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
