From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/2] ALSA: hda - hdmi: Use TFx channel
	positions instead of FxH
Date: Sun, 10 Nov 2013 21:24:04 +0200
Message-ID: <1384111445-16751-1-git-send-email-anssi.hannula@iki.fi>
References: <527FB20E.2010606@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 70926261B26
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 20:24:12 +0100 (CET)
In-Reply-To: <527FB20E.2010606@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Channel map positions FLH, FCH, FRH duplicate positions TFL, TFC, TFR.
Both are the speakers above the front speakers (CEA uses "high" and USB
audio uses "top" nomenclature).

Since the USB audio code has used the TFx positions since v3.8
(04324ccc75f96, "ALSA: usb-audio: add channel map support") but the HDMI
code only just started using FxH in a5b7d510b2220cccb ("ALSA: hda -
hdmi: Fix channel maps with less common speakers") which is not yet in
any released kernel, standardize on TFx instead.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index fe3b150f97d9..4ad8c055c221 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -763,12 +763,12 @@ static struct channel_map_table map_tables[] = {
 	{ SNDRV_CHMAP_RC,	RC },
 	{ SNDRV_CHMAP_FLC,	FLC },
 	{ SNDRV_CHMAP_FRC,	FRC },
-	{ SNDRV_CHMAP_FLH,	FLH },
-	{ SNDRV_CHMAP_FRH,	FRH },
+	{ SNDRV_CHMAP_TFL,	FLH },
+	{ SNDRV_CHMAP_TFR,	FRH },
 	{ SNDRV_CHMAP_FLW,	FLW },
 	{ SNDRV_CHMAP_FRW,	FRW },
 	{ SNDRV_CHMAP_TC,	TC },
-	{ SNDRV_CHMAP_FCH,	FCH },
+	{ SNDRV_CHMAP_TFC,	FCH },
 	{} /* terminator */
 };
 
-- 
1.8.1.5
