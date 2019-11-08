Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293CFC6196
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:33:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA34E20674
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jfRM0DIc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="mTqgr/zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA34E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0C191666;
	Fri,  8 Nov 2019 21:32:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0C191666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573245187;
	bh=In6JDmPQVBVRjwcZuMjvoOWBw7H1ITT7OUzQC2andHM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jfRM0DIcEMFt6ktgv4NUpXcx0S8qowB/d8TkDQCLZ4ojyM74jMSLV98g4A4eyE9VZ
	 lukxzNuYVRUjdzmlCnf0syRN0zm3Mv3Vub4ZiDa4JDMF37hblbpUMNZ8lL0jBuvr/k
	 Lo1FrH/hPpTkosEHzB7nNv2gwd4JX4ntAStEj6kU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58F68F80321;
	Fri,  8 Nov 2019 21:32:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E6D2F803D0; Fri,  8 Nov 2019 21:32:15 +0100 (CET)
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA152F800D3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 21:32:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA152F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc
 header.b="mTqgr/zo"
Received: from apollo.fritz.box (unknown
 [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 7C2142335B;
 Fri,  8 Nov 2019 21:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1573245130;
 bh=6OR+Z5KfeblJ083HHiSeWa7E3WTa5ngobt1H+ZARamA=;
 h=From:To:Cc:Subject:Date:From;
 b=mTqgr/zojO6QfmKK52aioToRdveSx81BkWNxzWlpWzbqO0A39kt9/PpRamxsOy4Wh
 w8H02irm/xprzXQ38HU5sG30kBOqlYSokyWxvZr6AeqtehzJ2+UYtP+aHamUFwhJ5i
 zc2/RHwqa+HtNqKv6zg2oWzfLdJ3G/YL9NScWQfM=
From: Michael Walle <michael@walle.cc>
To: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Date: Fri,  8 Nov 2019 21:31:52 +0100
Message-Id: <20191108203152.19098-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Michael Walle <michael@walle.cc>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH v2] ASoC: wm8904: configure sysclk/FLL
	automatically
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

This adds a new mode WM8904_CLK_AUTO which automatically enables the FLL
if a frequency different than the MCLK is set.

These additions make the codec work with the simple-card driver in
general and especially in systems where the MCLK doesn't match the
required clock.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - replaced second clk_get_rate() with mclk_freq

Please note that the v1 patch might still be pending for moderator
approval.

 sound/soc/codecs/wm8904.c | 72 ++++++++++++++++++++++++---------------
 sound/soc/codecs/wm8904.h |  1 +
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bcb3c9d5abf0..2a7d23a5daa8 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1410,34 +1410,6 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-
-static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
-			     unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = dai->component;
-	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
-
-	switch (clk_id) {
-	case WM8904_CLK_MCLK:
-		priv->sysclk_src = clk_id;
-		priv->mclk_rate = freq;
-		break;
-
-	case WM8904_CLK_FLL:
-		priv->sysclk_src = clk_id;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
-
-	wm8904_configure_clocking(component);
-
-	return 0;
-}
-
 static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1824,6 +1796,50 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	return 0;
 }
 
+static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned long mclk_freq;
+	int ret;
+
+	switch (clk_id) {
+	case WM8904_CLK_AUTO:
+		mclk_freq = clk_get_rate(priv->mclk);
+		/* enable FLL if a different sysclk is desired */
+		if (mclk_freq != freq) {
+			priv->sysclk_src = WM8904_CLK_FLL;
+			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
+					     WM8904_FLL_MCLK,
+					     mclk_freq, freq);
+			if (ret)
+				return ret;
+			break;
+		}
+		clk_id = WM8904_CLK_MCLK;
+		/* fallthrough */
+
+	case WM8904_CLK_MCLK:
+		priv->sysclk_src = clk_id;
+		priv->mclk_rate = freq;
+		break;
+
+	case WM8904_CLK_FLL:
+		priv->sysclk_src = clk_id;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
+
+	wm8904_configure_clocking(component);
+
+	return 0;
+}
+
 static int wm8904_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_component *component = codec_dai->component;
diff --git a/sound/soc/codecs/wm8904.h b/sound/soc/codecs/wm8904.h
index c1bca52f9927..de6340446b1f 100644
--- a/sound/soc/codecs/wm8904.h
+++ b/sound/soc/codecs/wm8904.h
@@ -10,6 +10,7 @@
 #ifndef _WM8904_H
 #define _WM8904_H
 
+#define WM8904_CLK_AUTO 0
 #define WM8904_CLK_MCLK 1
 #define WM8904_CLK_FLL  2
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
