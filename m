From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 071/102] ASoC: wm5100: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:27 +0100
Message-ID: <1392723517-12772-44-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B56DE2655E3
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
 sound/soc/codecs/wm5100.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4e3e31aaf509..14beefd7e58c 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -506,21 +506,21 @@ static const char *wm5100_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
 
-static const struct soc_enum wm5100_lhpf1_mode =
-	SOC_ENUM_SINGLE(WM5100_HPLPF1_1, WM5100_LHPF1_MODE_SHIFT, 2,
-			wm5100_lhpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm5100_lhpf1_mode,
+			    WM5100_HPLPF1_1, WM5100_LHPF1_MODE_SHIFT,
+			    wm5100_lhpf_mode_text);
 
-static const struct soc_enum wm5100_lhpf2_mode =
-	SOC_ENUM_SINGLE(WM5100_HPLPF2_1, WM5100_LHPF2_MODE_SHIFT, 2,
-			wm5100_lhpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm5100_lhpf2_mode,
+			    WM5100_HPLPF2_1, WM5100_LHPF2_MODE_SHIFT,
+			    wm5100_lhpf_mode_text);
 
-static const struct soc_enum wm5100_lhpf3_mode =
-	SOC_ENUM_SINGLE(WM5100_HPLPF3_1, WM5100_LHPF3_MODE_SHIFT, 2,
-			wm5100_lhpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm5100_lhpf3_mode,
+			    WM5100_HPLPF3_1, WM5100_LHPF3_MODE_SHIFT,
+			    wm5100_lhpf_mode_text);
 
-static const struct soc_enum wm5100_lhpf4_mode =
-	SOC_ENUM_SINGLE(WM5100_HPLPF4_1, WM5100_LHPF4_MODE_SHIFT, 2,
-			wm5100_lhpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm5100_lhpf4_mode,
+			    WM5100_HPLPF4_1, WM5100_LHPF4_MODE_SHIFT,
+			    wm5100_lhpf_mode_text);
 
 static const struct snd_kcontrol_new wm5100_snd_controls[] = {
 SOC_SINGLE("IN1 High Performance Switch", WM5100_IN1L_CONTROL,
-- 
1.8.5.2
