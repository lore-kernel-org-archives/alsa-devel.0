Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF9C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:28:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71112339E
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71112339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E083D167F;
	Thu,  7 Jan 2021 17:27:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E083D167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610036922;
	bh=u8kgKBczVBgnvJnevallwPPB3GMohenDbMIEK34jf4M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ehem4g/0gRx5tDBIQdsRmhIsnhHrX9QjGbIDC5Ex2Dvx0o1+wWR28sDvVsGatKSpa
	 L/hE3EcZLPdjtHYJO0ecrsGCyXCaCAh15NCiJ+CpRqREhAEyq2XaX+vMHT4lN+jRBn
	 7gO4mI2NAinCa7wWIxHdhnadqvidupj3gPZ46FAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 734BFF801F5;
	Thu,  7 Jan 2021 17:27:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCEAFF801F5; Thu,  7 Jan 2021 17:27:48 +0100 (CET)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A333F801F5
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 17:27:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A333F801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="B1noEAuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610036860;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
 bh=5hRoxiP4naYVQgFQNhwNCg2/fV1DbaF6iZykNS5b7Yc=;
 b=B1noEAuPCZAmIlo4zuHKPWMQ4Z7zQgFh6Utrg8KQnY6MWMV+5TtkAWWJqPrWqN2k8i
 eEH3tg5IPYA+zdbtOdk9cGoHP4Xpu67lXGUWKM6DTyF8oQGMWE8302RIl41BWsFeTfbG
 1PIO7hK/Ce2ViF1W+20oxQpcYsVvF2uArpRr6h7Y4+dEndJOGdxjfZ0GDJxHOKtkrOWv
 MfMmvdMXWI+X1lD60YWaGB+IyevTaw3GoGdhjRc3Tj5XkW/S+e82OWOKEaeHOwTj3Qh3
 w6o607QgslzdadbgN7i4rxs6LX1LLBJP1Mo2E/xwqsdWkvd/KS0JCse7EAYmVQfLgGVZ
 Iw0Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB6m6NPwkA"
X-RZG-CLASS-ID: mo00
Received: from droid.. by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
 with ESMTPSA id R0a218x07GRc5y4
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 7 Jan 2021 17:27:38 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: hdmi-codec: Fix return value in hdmi_codec_set_jack()
Date: Thu,  7 Jan 2021 17:26:40 +0100
Message-Id: <20210107162640.313859-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

Sound is broken on the DragonBoard 410c (apq8016_sbc) since 5.10:

  hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: error at snd_soc_component_set_jack on hdmi-audio-codec.1.auto: -95
  qcom-apq8016-sbc 7702000.sound: Failed to set jack: -95
  ADV7533: ASoC: error at snd_soc_link_init on ADV7533: -95
  hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: error at snd_soc_component_set_jack on hdmi-audio-codec.1.auto: -95
  qcom-apq8016-sbc: probe of 7702000.sound failed with error -95

This happens because apq8016_sbc calls snd_soc_component_set_jack() on
all codec DAIs and attempts to ignore failures with return code -ENOTSUPP.
-ENOTSUPP is also excluded from error logging in soc_component_ret().

However, hdmi_codec_set_jack() returns -E*OP*NOTSUPP if jack detection
is not supported, which is not handled in apq8016_sbc and soc_component_ret().
Make it return -ENOTSUPP instead to fix sound and silence the errors.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 55c5cc63ab32 ("ASoC: hdmi-codec: Use set_jack ops to set jack")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d5fcc4db8284..0f3ac22f2cf8 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -717,7 +717,7 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 			       void *data)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
-	int ret = -EOPNOTSUPP;
+	int ret = -ENOTSUPP;
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
-- 
2.30.0

