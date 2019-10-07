Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57594C47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:22:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421C9206BB
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nOw4q/lg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Iu8Ed9H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421C9206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80B7C82C;
	Mon,  7 Oct 2019 20:21:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80B7C82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570472544;
	bh=eLWFI2RU00j9sI9WVHqUM9FvK/o6Lc61Uy4+fwQgj1s=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nOw4q/lgweWS+Dv2LfrOH26VtfKUMVOn5VqtyiVrzTZTMcsN6KTmH1Gz6ge4CK502
	 4ft2VCbGe3Horcm/t9cuhtbkvtGE3AELMfT4myFzjyuoaaJvrGSx8Y4AWMvl8e8Trv
	 DdklG59mwG7+rCLPakZoDzmk22bArz9tu1rjlO4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0962EF802BD;
	Mon,  7 Oct 2019 20:21:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74093F802BE; Mon,  7 Oct 2019 20:21:32 +0200 (CEST)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 247CEF800BF
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 20:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 247CEF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="Iu8Ed9H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570472487;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=niAYvrs9RamXh+uW6Dcvtw08yy8ElpEViqKy5gQWBUA=;
 b=Iu8Ed9H3ItAI0An9mRiqrgi7Sz1H1T3JiW5i+yonn2IWcyTZ8wMGU4qVT3e9sv3xhj
 +HOHG5wkPOYJyXyg2WH8LR7FXPsC4sEIfe+6YWBpF3cnAaMXQJuhFqYUgbkltUt70zbE
 RnyC/9brfNi5j90cT2PR3xdaEiUvwdmI2AW5cnO4YsjTkKb5+qivqaFd2Oy4pIr0lT1R
 TaeE9ERmDBAUlg1O1VKx6EhGM/iVDDR0K8NJuetvXUQ/rToXq4t4feRe4O8tDUWJQbo7
 kvcxoSV5aQduNDAi8wlXvz44A9VWPsxMQM+t5uodyd3OKQeJjacn6JI+nNUMTmJc0mYO
 7Lbg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXt87vtBtcfg=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 44.28.0 AUTH)
 with ESMTPSA id L0811cv97ILQ3g7
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 7 Oct 2019 20:21:26 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Date: Mon,  7 Oct 2019 20:19:52 +0200
Message-Id: <20191007181952.34786-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH] ASoC: msm8916-wcd-digital: Remove broken MIX2
	DAPM routes
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

Since 5.3-rc1, the kernel (correctly) complains about missing
widgets when loading msm8916-wcd-digital:

	ASoC: no sink widget found for RX1 MIX2 INP1
	ASoC: Failed to add route IIR1 -> IIR1 -> RX1 MIX2 INP1
	ASoC: no sink widget found for RX2 MIX2 INP1
	ASoC: Failed to add route IIR1 -> IIR1 -> RX2 MIX2 INP1
	ASoC: no sink widget found for RX1 MIX2 INP1
	ASoC: Failed to add route IIR2 -> IIR2 -> RX1 MIX2 INP1
	ASoC: no sink widget found for RX2 MIX2 INP1
	ASoC: Failed to add route IIR2 -> IIR2 -> RX2 MIX2 INP1

This happens because RX1/2 MIX2 INP1 is not actually supported by
msm8916-wcd-digital for some reason. There were some traces of it
in the initial patch, but the last remnants were removed in
commit fecd5c09ddf8 ("ASoC: msm8916-wcd-digital: remove few unused variables").

On 5.3 everything seemingly worked even with that error, but on 5.4-rc1
the sound card is no longer successfully registered:

	qcom-apq8016-sbc 7702000.sound: ASoC: failed to instantiate card -19

This happens because a check for the return code of
snd_soc_dapm_add_routes() was added in
commit daa480bde6b3 ("ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()").

Avoid the error by removing the routes that reference the missing widgets.

Fixes: ef8a4757a6db ("ASoC: msm8916-wcd-digital: Add sidetone support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 9fa5d44fdc79..36d8f619e298 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1022,11 +1022,6 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX3 MIX1 INP2", "IIR1", "IIR1"},
 	{"RX3 MIX1 INP2", "IIR2", "IIR2"},
 
-	{"RX1 MIX2 INP1", "IIR1", "IIR1"},
-	{"RX2 MIX2 INP1", "IIR1", "IIR1"},
-	{"RX1 MIX2 INP1", "IIR2", "IIR2"},
-	{"RX2 MIX2 INP1", "IIR2", "IIR2"},
-
 	{"IIR1", NULL, "IIR1 INP1 MUX"},
 	{"IIR1 INP1 MUX", "DEC1", "DEC1 MUX"},
 	{"IIR1 INP1 MUX", "DEC2", "DEC2 MUX"},
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
