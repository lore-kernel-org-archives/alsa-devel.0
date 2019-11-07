Return-Path: <SRS0=kTGd=ZB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10353C43331
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:45:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD2E2196F
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qeIjervG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="jrvjIlQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD2E2196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC06E1680;
	Sat,  9 Nov 2019 10:44:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC06E1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573292730;
	bh=rpNNL6EFxMx9hEfVMrQbCzbQ2uCtxnI712Q7RHjigDc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qeIjervGimGJPWlYdu9vThZCXto+ZS8X4vCxn2e8CqjsPvnrRor1LbmlMc31RZUCM
	 kc6qWivamqpRPZFewPCDwjSUkeoKEaUluNjxMF82uOS85ndhH4eMTu0JBzBgL7vF0/
	 KgXOKu72uECWyOs1TOV0r3mBTJYWMb62qCAidnZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 286A7F80534;
	Sat,  9 Nov 2019 10:44:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81F95F8049B; Fri,  8 Nov 2019 00:16:21 +0100 (CET)
Received: from ssl.serverraum.org (ssl.serverraum.org
 [IPv6:2a01:4f8:151:8464::1:2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C80DF80291
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 00:16:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C80DF80291
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc
 header.b="jrvjIlQw"
Received: from apollo.fritz.box (unknown
 [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 1652E23E23;
 Fri,  8 Nov 2019 00:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1573168576;
 bh=3QkA7fpgg84g1/OjnwpVpOMBMUXMQKKIxrO3kIEdhKM=;
 h=From:To:Cc:Subject:Date:From;
 b=jrvjIlQwgiKG2vNPYy4NoV61k6XP/VM39t578SoTDO4Rut4Zns+IhCirGvlk7yYk7
 k05I346rQTqeApSM1RWfhkwf1aqE11kx0naQKHf6LBoo9XJ4kx5s6qIjn4gtkByCxv
 9+AKh23qR8Xk5j2J/64s8D+vwcnN3+mCT/Vc0Q0c=
From: Michael Walle <michael@walle.cc>
To: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Date: Fri,  8 Nov 2019 00:15:48 +0100
Message-Id: <20191107231548.17454-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 09 Nov 2019 10:43:39 +0100
Cc: patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Michael Walle <michael@walle.cc>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH] ASoC: wm8904: configure sysclk/FLL
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
requested clock.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Unfortunately, I had to move wm8904_sys_sysclk() below wm8904_set_fll(). So
that makes this patch a bit ugly. The added part is the WM8904_CLK_AUTO
branch.

 sound/soc/codecs/wm8904.c | 72 ++++++++++++++++++++++++---------------
 sound/soc/codecs/wm8904.h |  1 +
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bcb3c9d5abf0..2dd7addfd1a8 100644
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
+					     clk_get_rate(priv->mclk), freq);
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
