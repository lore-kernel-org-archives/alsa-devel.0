Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5686DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 12:12:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD2F518C4;
	Mon,  9 May 2022 14:11:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD2F518C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652098338;
	bh=WqEYfTtuozBNA5qrjR/G5GyXUn5xxE8msXTGh3lZLoI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PRlRzvvCknb4+OPqlATB0OTersUuSMGZuN7gyjBwB1dnrAkFsrvMeV1IZyVc2jdZS
	 6pPXI9XQXVfcQ3U+yzuYGzjk0Ycyp9a5BpF071Mib1pQPNcvCXPOhsmdz8B9mwOkE3
	 waDoO+klDqwttds3mFHFzwra8forkjSLqIkDwaq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63F2DF8025D;
	Mon,  9 May 2022 14:11:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB700F80269; Mon,  9 May 2022 14:11:26 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62BEFF800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 14:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62BEFF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="Sw6BYO5b"
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4F1C483A79;
 Mon,  9 May 2022 14:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1652098279;
 bh=IVzAp6mLcI5fjIjVSE0UrbrRh7utWQXvE4kL+Mmi6mg=;
 h=From:To:Cc:Subject:Date:From;
 b=Sw6BYO5bLJuvXdSDJyowlWgLu5sQkCcAUtk27KOyW/VgZH+YDRs7sfzGEkQ6xn70/
 wcyDtPEYcxZBpJqbCHw5L2RLAZDO+2T4OF9RBOzo3gC8+aulshR8BxHj82/YHLShan
 hp7EADvCeRp8J1oGiZ+NpGLWRJrxPrEYiL9uS7Mx0X9/eQHHcCWR/m0Ik8TSHx9NWn
 TIf/4ohapp35wP3VW+BQdQnGeC/JUE3D5grlvtm2kTacsJTGwykaO2RVQldiSt5Pc/
 Q+reqQ7uHZ3GVFNtNBEPSyIKcOfYaiQm/c2y8evsZx8NC08aVyyuJH/b9FRqB+A/zi
 VfKsX0yFlp6qQ==
From: Lukasz Majewski <lukma@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: wm8940: add devicetree support
Date: Mon,  9 May 2022 14:10:55 +0200
Message-Id: <20220509121055.31103-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Lukasz Majewski <lukma@denx.de>
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

This adds devicetree support to the wm8940 codec driver.
With a DT-based kernel, there is no board-specific setting
to select the driver so allow it to be manually chosen.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/codecs/Kconfig  | 2 +-
 sound/soc/codecs/wm8940.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f46a22660103..5120b15139bc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1811,7 +1811,7 @@ config SND_SOC_WM8904
 	depends on I2C
 
 config SND_SOC_WM8940
-	tristate
+	tristate "Wolfson Microelectronics WM8940 codec"
 	depends on I2C
 
 config SND_SOC_WM8955
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 440d048ef0c0..8615a55f84dd 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -779,9 +779,16 @@ static const struct i2c_device_id wm8940_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8940_i2c_id);
 
+static const struct of_device_id wm8940_of_match[] = {
+	{ .compatible = "wlf,wm8940", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8940_of_match);
+
 static struct i2c_driver wm8940_i2c_driver = {
 	.driver = {
 		.name = "wm8940",
+		.of_match_table = wm8940_of_match,
 	},
 	.probe =    wm8940_i2c_probe,
 	.id_table = wm8940_i2c_id,
-- 
2.35.1

