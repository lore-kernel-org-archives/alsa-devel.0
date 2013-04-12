From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] ASoC: define playback and capture streams
 in dummy codec
Date: Fri, 12 Apr 2013 18:19:43 +0400
Message-ID: <20130412181943.0338083b@stas>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tdcp.lfEuHkOwu1IxSHHVe."
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp16.mail.ru (smtp16.mail.ru [94.100.176.153])
 by alsa0.perex.cz (Postfix) with ESMTP id C682B2616B4
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 16:20:05 +0200 (CEST)
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

--MP_/tdcp.lfEuHkOwu1IxSHHVe.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 12 Apr 2013 11:59:44 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > This patch adds a playback and capture streams to the dummy codec DAI
> > configuration. Most permissive set of sampling rates and formats is used.
> The changelog ought to explain why this is required...
I can only tell that without this patch I am not getting any
sound at all... which is probably a rather poor statement for
the changelog. Could you please correct the changelog with the
better knowledge of the details?

> > Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
> Please send patches as documented in SubmittingPatches - even as an
> attachment this isn't coming out as plain text for me.
OK, now it should be as a plain text.
--MP_/tdcp.lfEuHkOwu1IxSHHVe.
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-ASoC-define-playback-and-capture-streams-in-dummy-co.patch

>From 22813b2124d81d8de5cde19a4e2f9490bd23baab Mon Sep 17 00:00:00 2001
From: Stas Sergeev <stsp@users.sourceforge.net>
Date: Thu, 11 Apr 2013 19:07:20 +0400
Subject: [PATCH] ASoC: define playback and capture streams in dummy codec

This patch adds a playback and capture streams to the dummy codec DAI
configuration. Most permissive set of sampling rates and formats is used.

Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
---
 sound/soc/soc-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index fe4541d..bf1f92a 100644
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
+	.playback 	= {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates		= STUB_RATES,
+		.formats	= STUB_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates = STUB_RATES,
+		.formats = STUB_FORMATS,
+	 },
 };
 
 static int snd_soc_dummy_probe(struct platform_device *pdev)
-- 
1.7.11.7


--MP_/tdcp.lfEuHkOwu1IxSHHVe.
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/tdcp.lfEuHkOwu1IxSHHVe.--
