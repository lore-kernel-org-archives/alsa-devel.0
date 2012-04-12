From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Ensure power gets managed for line
	widgets
Date: Thu, 12 Apr 2012 17:30:06 +0100
Message-ID: <1334248206-17959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6588124375
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 18:30:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Line widgets had not been included in either the power up or power down
sequences so if a widget had an event associated with it that event would
never be run. Fix this minimally by adding them to the sequences, we
should probably be doing away with the specific widget types as they all
have the same priority anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 922e693..1cde549 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -68,6 +68,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_out_drv] = 10,
 	[snd_soc_dapm_hp] = 10,
 	[snd_soc_dapm_spk] = 10,
+	[snd_soc_dapm_line] = 10,
 	[snd_soc_dapm_post] = 11,
 };
 
@@ -76,6 +77,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_adc] = 1,
 	[snd_soc_dapm_hp] = 2,
 	[snd_soc_dapm_spk] = 2,
+	[snd_soc_dapm_line] = 2,
 	[snd_soc_dapm_out_drv] = 2,
 	[snd_soc_dapm_pga] = 4,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
-- 
1.7.9.1
