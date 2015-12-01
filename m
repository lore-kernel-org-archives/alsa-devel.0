From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Replace siggen widget type with
	mic widgets
Date: Tue, 1 Dec 2015 17:32:08 +0000
Message-ID: <1448991128-22784-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 62361261AFF
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 18:32:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The siggen widget type doesn't really require its own special handling.
It can be handled identically to a mic widget, ie. it is a source of a
signal and causes things to power up when an output is connected.

Additionally, several places (cs42l52, cs42l56, wm8962, arizona_haptics)
tie siggens in to the input framework and the pattern for this is
usually to use snd_soc_dapm_enable_pin/disable_pin on the siggen widget.
However, as siggen widgets present as always on (the power check always
returns 1), this leads to some odd interactions with DAPM.
Enabling/disabling the widget then connecting it to a path works as
expected, however once in a path enabling the widget has no effect.
dapm_widget_set_power will return immediately as the current power state
of the widget will return 1, meaning we never check peer power states.
Treating the widget as a mic widget causes the expected behaviour in all
cases.

This does cause a minor cosmetic side effect that siggen widgets no
longer show as always on through debugfs, although in the case described
above that is more representive of their behaviour.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-dapm.c     | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9706946..67f176f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -47,7 +47,7 @@ struct device;
 
 /* platform domain */
 #define SND_SOC_DAPM_SIGGEN(wname) \
-{	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
+{	.id = snd_soc_dapm_mic, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_SINK(wname) \
 {	.id = snd_soc_dapm_sink, .name = wname, .kcontrol_news = NULL, \
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a8156b5..ea6f477 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1817,12 +1817,9 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 			/* Supplies and micbiases only bring the
 			 * context up to STANDBY as unless something
 			 * else is active and passing audio they
-			 * generally don't require full power.  Signal
-			 * generators are virtual pins and have no
-			 * power impact themselves.
+			 * generally don't require full power.
 			 */
 			switch (w->id) {
-			case snd_soc_dapm_siggen:
 			case snd_soc_dapm_vmid:
 				break;
 			case snd_soc_dapm_supply:
@@ -3354,7 +3351,6 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_vmid:
-	case snd_soc_dapm_siggen:
 		w->is_ep = SND_SOC_DAPM_EP_SOURCE;
 		w->power_check = dapm_always_on_check_power;
 		break;
-- 
2.1.4
