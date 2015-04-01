From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: omap-hdmi-audio: No not use
	IEC958_AES1_PRO_MODE_NOTID
Date: Wed, 1 Apr 2015 20:35:57 +0300
Message-ID: <1427909757-19483-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A4D6265383
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 19:36:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, linux@arm.linux.org.uk, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com
List-Id: alsa-devel@alsa-project.org

No IEC958_AES?_PRO_* macros should be used in HDMI consumer audio mode
and IEC958_AES1_PRO_MODE_NOTID should be applied to byte 1 when
applicable. However IEC958_AES1_PRO_MODE_NOTID is defined as 0 so this
fix does not affect the functionality in any way.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
When I refactored the OMAP HDMI audio functionality I intentionally
wanted to keep all the HW bits identical to the earlier implementation
so that I could compare the register values of the old and the new
implementations one to one. One of these days I should go trough and
check all the bits now that new implementation has settled in.

Best regards,
Jyri

 sound/soc/omap/omap-hdmi-audio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index f7eb42a..4775da4 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -142,8 +142,6 @@ static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 
 	iec->status[0] |= IEC958_AES0_CON_EMPHASIS_NONE;
 
-	iec->status[0] |= IEC958_AES1_PRO_MODE_NOTID;
-
 	iec->status[1] = IEC958_AES1_CON_GENERAL;
 
 	iec->status[2] |= IEC958_AES2_CON_SOURCE_UNSPEC;
-- 
1.9.1
