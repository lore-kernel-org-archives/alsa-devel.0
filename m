From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/3] ASoC: OMAP: HDMI: Update codec name
Date: Sat, 11 Feb 2012 18:23:16 -0600
Message-ID: <1329006197-28332-3-git-send-email-ricardo.neri@ti.com>
References: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EF08103A81
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 01:23:54 +0100 (CET)
In-Reply-To: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Update codec name in the machine driver. This is required as the
driver name of the HDMI ASoC codec has changed.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap4-hdmi-card.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
index 28d689b..c320148 100644
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link omap4_hdmi_dai = {
 	.stream_name = "HDMI",
 	.cpu_dai_name = "hdmi-audio-dai",
 	.platform_name = "omap-pcm-audio",
-	.codec_name = "omapdss_hdmi",
+	.codec_name = "omap-hdmi-codec",
 	.codec_dai_name = "hdmi-audio-codec",
 	.ops = &omap4_hdmi_dai_ops,
 };
-- 
1.7.0.4
