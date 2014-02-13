From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Consistently use unsigned int for
	register values
Date: Thu, 13 Feb 2014 14:14:21 +0100
Message-ID: <1392297261-1366-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-003.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 5154026172D
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2014 14:14:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit f7d3c1709 ("ASoC: dapm: Change prototype of soc_widget_read") changed the
signature of soc_widget_read() so that it, instead of return the register value
as a int, takes a pointer to a unsigned int and stores the register value in
that pointer. There are still a few places that pass a int type value to that
function though. Change these to unsigned int. For more consistency also change
the signature of soc_widget_write() to take a unsigned int instead of an int for
the register value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dc8ff13..2c2d751 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -386,7 +386,8 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
 	return -1;
 }
 
-static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
+static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg,
+	unsigned int val)
 {
 	if (w->codec)
 		return snd_soc_write(w->codec, reg, val);
@@ -506,7 +507,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 	case snd_soc_dapm_mixer_named_ctl: {
-		int val;
+		unsigned int val;
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)
 			w->kcontrol_news[i].private_value;
 		int reg = mc->reg;
@@ -530,7 +531,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_mux: {
 		struct soc_enum *e = (struct soc_enum *)
 			w->kcontrol_news[i].private_value;
-		int val, item;
+		unsigned int val, item;
 
 		soc_widget_read(w, e->reg, &val);
 		item = (val >> e->shift_l) & e->mask;
@@ -559,7 +560,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_value_mux: {
 		struct soc_enum *e = (struct soc_enum *)
 			w->kcontrol_news[i].private_value;
-		int val, item;
+		unsigned int val, item;
 
 		soc_widget_read(w, e->reg, &val);
 		val = (val >> e->shift_l) & e->mask;
-- 
1.8.0
