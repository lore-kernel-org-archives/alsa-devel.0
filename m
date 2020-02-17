Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76292C3B1BF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:18:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006A021744
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aOTnaduP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XM+8y09N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006A021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52AE71670;
	Mon, 17 Feb 2020 04:18:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52AE71670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581909533;
	bh=FQKPGwq1wz2wHQUB715lqTVSebJU6y3d55ub1+43iPQ=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aOTnaduPKBWmGG+CNU6cYxcbAUz/Xf5Cj0c4Z0aGcModi5L3cbVYGX0e9/CDWIKG7
	 zFPkgYaQrJ8ynW8gNSqR0BBo0sXrb6mJzWSdb9opybDD0a024zFLK9FKvfF7kVfCCf
	 hF75kqgdYPXUhaCtARxRwMZnd6qvhEq8m1CcEyEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B43C6F80214;
	Mon, 17 Feb 2020 04:17:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B816FF80233; Mon, 17 Feb 2020 04:17:11 +0100 (CET)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A386F80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:17:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A386F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="XM+8y09N"
Received: by mail-pf1-x44a.google.com with SMTP id 6so10426709pfv.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=WyY8AR/W9Xhoq+FoZI+JwslnVAFfNuC6P4tiCJpqlNM=;
 b=XM+8y09NmdcBqI5tENuyJPgoZPkNcFlWhBEVm/VyNB+qqCVUPFfySf1XAX9fcSBAQN
 eoRDs7U0lYvGlwNkmFXyFzeq6BdniLjOJdL8ITVb/+H3yghkqT+ZlpKBIGI884IyFMKE
 W+qoM4sYK9ncnSBM1vyoFvhdPR3Y+wXyKIsptwL6L4IBBER1s29g3hi9t7du2SiwtH9a
 ihemetgpwqoBtq8J7DqYEER4KfPtAMXdRYwRUdSF3OwK5AHiXTqky3ZK0LAlUctdGYFs
 xmKWCss+5sKWOwC/dkSf/EEGUoIDUZOJFRfZNiJ+iincRUpl9wM1x5EGjizutSP0ABkC
 De8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=WyY8AR/W9Xhoq+FoZI+JwslnVAFfNuC6P4tiCJpqlNM=;
 b=nk2pfDaevfjfe544MIuZ9XQjeU+08KTBfCcOvYSBJ9MV2sy4NsVC9fcAtOCqqhOLqf
 tBZJCb6PLPH4rbPILKkbTGphet2IuUz0QZo6t3v5+3yqSTn2vVFTbGT6FUrHYV+/Hh3C
 /TZ/XvYRB3oLhRTLLrcrWq/C6GFck8fQPzlqeIuFF7Xiqek2LPgeKah15Yp1YfFdet8w
 pvOt2te2rmy2CUGJJ6PgYXsdliixyZ59hG2YB3v8FzRZpH1dRuxD1minOrHdeKzolW1T
 1QZ1MrTtjy541R7NYcBMJHfmw6Sv0qKDvV5qRh6L+AMm5atg2pzZT/CN9mA5nVazXlOt
 nJ3g==
X-Gm-Message-State: APjAAAVmggj92kbgDY0UhH+XyyJWO4fwnVZ85oYa+cSdxqwc+7JkCR0p
 y9nb0LB63+f8g5r4ECTnSyrqvDIP03yg
X-Google-Smtp-Source: APXvYqyaA0c4C3Cy5dT8KODvRZRHXgVJd5DJOU44ArgLhO1/lknUXh2t3cF80g4vSNUWgNRWhTevS8xJmETl
X-Received: by 2002:a63:ac46:: with SMTP id z6mr13808575pgn.301.1581909425929; 
 Sun, 16 Feb 2020 19:17:05 -0800 (PST)
Date: Mon, 17 Feb 2020 11:16:52 +0800
In-Reply-To: <20200217031653.52345-1-tzungbi@google.com>
Message-Id: <20200217105513.1.Icc323daaf71ad02f191fd8d91136b01b61eca5e3@changeid>
Mime-Version: 1.0
References: <20200217031653.52345-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v2 1/2] ASoC: hdmi-codec: set plugged_cb to
 NULL when component removing
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

Sets plugged_cb to NULL when component removing to notify its consumers
: no further plugged status report is required.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/hdmi-codec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 444cc4e3374e..f005751da2cc 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -779,7 +779,17 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
+static void hdmi_remove(struct snd_soc_component *component)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	if (hcp->hcd.ops->hook_plugged_cb)
+		hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+					      hcp->hcd.data, NULL, NULL);
+}
+
 static const struct snd_soc_component_driver hdmi_driver = {
+	.remove			= hdmi_remove,
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
 	.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
