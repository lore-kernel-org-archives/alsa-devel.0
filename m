From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: soc-pcm: Use format size instead
	physical for sample_bits symmetry
Date: Thu, 25 Jul 2019 13:22:26 +0300
Message-ID: <20190725102226.781-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4F89F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 12:22:32 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

For DAIs the format size in bits matters when it comes to symmetry.
The physical width is the in-memory format size which matters mostly for
the platform drivers.

If for example a DAI requests symmetric_samplebits and the first stream is
using S24_LE then the second stream would not be allowed to use S24_3LE
despite both S24_LE and S24_3LE would need the same clocking on the bus.
But S32_LE would be allowed (S24_LE and S32_LE is both physically 32 bits
in memory) which would not be compatible with S24_LE on the bus.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/soc-pcm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1406f935af22..c70722dc1f4f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -243,7 +243,7 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 
 	rate = params_rate(params);
 	channels = params_channels(params);
-	sample_bits = snd_pcm_format_physical_width(params_format(params));
+	sample_bits = snd_pcm_format_width(params_format(params));
 
 	/* reject unmatched parameters when applying symmetry */
 	symmetry = cpu_dai->driver->symmetric_rates ||
@@ -932,7 +932,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 		codec_dai->rate = params_rate(&codec_params);
 		codec_dai->channels = params_channels(&codec_params);
-		codec_dai->sample_bits = snd_pcm_format_physical_width(
+		codec_dai->sample_bits = snd_pcm_format_width(
 						params_format(&codec_params));
 
 		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
@@ -945,8 +945,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* store the parameters for each DAIs */
 	cpu_dai->rate = params_rate(params);
 	cpu_dai->channels = params_channels(params);
-	cpu_dai->sample_bits =
-		snd_pcm_format_physical_width(params_format(params));
+	cpu_dai->sample_bits = snd_pcm_format_width(params_format(params));
 
 	snd_soc_dapm_update_dai(substream, params, cpu_dai);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
