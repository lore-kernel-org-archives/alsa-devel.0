From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove controls from sequenced PGA
	arguments
Date: Tue, 25 Jan 2011 13:42:28 +0000
Message-ID: <1295962948-32599-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9625103951
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 14:42:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We have zero users for PGA controls and the core support for them was
removed a while ago so no point in cut'n'pasting them into new macros,
even if it's too much hassle to update the existing ones.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6c9ae23..6a25e69 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -158,11 +158,11 @@
 	.event = wevent, .event_flags = wflags}
 
 /* additional sequencing control within an event type */
-#define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, wcontrols, \
-	wncontrols, wevent, wflags) \
+#define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, \
+	wevent, wflags) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
-	.event = wevent, .event_flags = wflags, .subseq = wsubseq}
+	.invert = winvert, .event = wevent, .event_flags = wflags, \
+	.subseq = wsubseq}
 #define SND_SOC_DAPM_SUPPLY_S(wname, wsubseq, wreg, wshift, winvert, wevent, \
 	wflags)	\
 {	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
-- 
1.7.2.3
