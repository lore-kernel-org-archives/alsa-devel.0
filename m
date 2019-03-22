From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v4 10/10] ASoC: tlv320aic32x4: Allow 192000
	Sample Rate
Date: Thu, 21 Mar 2019 17:58:54 -0700
Message-ID: <20190322005854.23360-11-nh6z@nh6z.net>
References: <20190322005854.23360-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp73.ord1d.emailsrvr.com (smtp73.ord1d.emailsrvr.com
 [184.106.54.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32877F8971E
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 01:59:15 +0100 (CET)
In-Reply-To: <20190322005854.23360-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The clocking and processing blocks are now properly set up to
support 192000 sample rates.  Allow drivers to ask for that.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index a5457d3de1b1..75443efeda69 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -857,7 +857,7 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
-#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_96000
+#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_192000
 #define AIC32X4_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
 			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.19.1
