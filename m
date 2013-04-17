From: Stas Sergeev <stsp@list.ru>
Subject: [PATCH] ASoC: define playback and capture streams in
	dummy codec
Date: Wed, 17 Apr 2013 16:34:06 +0400
Message-ID: <20130417163406.4a3b339c@stas>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/UOWkm7JrtEwIB2/qV7HjICt"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.mail.ru (smtp5.mail.ru [94.100.176.132])
 by alsa0.perex.cz (Postfix) with ESMTP id E88C5261645
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 14:34:25 +0200 (CEST)
In-Reply-To: <20130412105943.GU9243@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--MP_/UOWkm7JrtEwIB2/qV7HjICt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

This patch adds a playback and capture streams to the dummy codec DAI
configuration. Most permissive set of sampling rates and formats is used.

This patch is needed for playback and capturing on a codec-less systems,
as otherwise the PCM device nodes are not even created.

Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
--MP_/UOWkm7JrtEwIB2/qV7HjICt
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-ASoC-define-playback-and-capture-streams-in-dummy-co.patch

>From 9a498275e59c2c6ef933fe7d0cff79a13ba790ff Mon Sep 17 00:00:00 2001
From: Stas Sergeev <stsp@users.sourceforge.net>
Date: Thu, 11 Apr 2013 19:07:20 +0400
Subject: [PATCH] ASoC: define playback and capture streams in dummy codec

This patch adds a playback and capture streams to the dummy codec DAI
configuration. Most permissive set of sampling rates and formats is used.

This patch is needed for playback and capturing on a codec-less systems,
as otherwise the PCM device nodes are not even created.

Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
---
 sound/soc/soc-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index fe4541d..4b3be6c 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -90,8 +90,33 @@ static struct snd_soc_platform_driver dummy_platform = {
 };
 
 static struct snd_soc_codec_driver dummy_codec;
+
+#define STUB_RATES	SNDRV_PCM_RATE_8000_192000
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
+			SNDRV_PCM_FMTBIT_U8 | \
+			SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_U16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_U24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE | \
+			SNDRV_PCM_FMTBIT_U32_LE | \
+			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 static struct snd_soc_dai_driver dummy_dai = {
 	.name = "snd-soc-dummy-dai",
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates		= STUB_RATES,
+		.formats	= STUB_FORMATS,
+	},
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates = STUB_RATES,
+		.formats = STUB_FORMATS,
+	 },
 };
 
 static int snd_soc_dummy_probe(struct platform_device *pdev)
-- 
1.7.11.7


--MP_/UOWkm7JrtEwIB2/qV7HjICt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/UOWkm7JrtEwIB2/qV7HjICt--
