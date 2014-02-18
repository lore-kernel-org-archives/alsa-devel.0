From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 072/102] ASoC: wm8955: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:28 +0100
Message-ID: <1392723517-12772-45-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B98DA2655E7
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8955.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 82c8ba975720..d4dcaecc8a5f 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -416,22 +416,21 @@ static const char *bass_mode_text[] = {
 	"Linear", "Adaptive",
 };
 
-static const struct soc_enum bass_mode =
-	SOC_ENUM_SINGLE(WM8955_BASS_CONTROL, 7, 2, bass_mode_text);
+static SOC_ENUM_SINGLE_DECL(bass_mode, WM8955_BASS_CONTROL, 7, bass_mode_text);
 
 static const char *bass_cutoff_text[] = {
 	"Low", "High"
 };
 
-static const struct soc_enum bass_cutoff =
-	SOC_ENUM_SINGLE(WM8955_BASS_CONTROL, 6, 2, bass_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(bass_cutoff, WM8955_BASS_CONTROL, 6,
+			    bass_cutoff_text);
 
 static const char *treble_cutoff_text[] = {
 	"High", "Low"
 };
 
-static const struct soc_enum treble_cutoff =
-	SOC_ENUM_SINGLE(WM8955_TREBLE_CONTROL, 6, 2, treble_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(treble_cutoff, WM8955_TREBLE_CONTROL, 2,
+			    treble_cutoff_text);
 
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(atten_tlv, -600, 600, 0);
-- 
1.8.5.2
