From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: dapm: Add support for platform and
	CODEC drivers	on same device
Date: Fri, 15 Mar 2013 15:38:21 +0000
Message-ID: <20130315153821.GD2141@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126092020.GH30594@opensource.wolfsonmicro.com>
 <20130315153540.GC2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BCE1D264F40
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 16:38:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130315153540.GC2141@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently DAI playback and capture widgets are created during
soc_probe_codec and soc_probe_platform using the device associated
with the platform/codec to locate the DAI upon which the widgets
should be created. If a device registers both a CODEC and platform
driver this leads the widgets created during CODEC probe being
overwritten by the widgets created during the platform probe.

In general we want to retain the existing playback and capture widgets
because routes may have already been added to them. This patch will
check for existing widgets during snd_soc_dapm_new_dai_widgets and
only create new widgets if none exist.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 33acd8b..6959304 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3351,7 +3351,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 	memset(&template, 0, sizeof(template));
 	template.reg = SND_SOC_NOPM;
 
-	if (dai->driver->playback.stream_name) {
+	if (dai->driver->playback.stream_name && !dai->playback_widget) {
 		template.id = snd_soc_dapm_dai;
 		template.name = dai->driver->playback.stream_name;
 		template.sname = dai->driver->playback.stream_name;
@@ -3369,7 +3369,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		dai->playback_widget = w;
 	}
 
-	if (dai->driver->capture.stream_name) {
+	if (dai->driver->capture.stream_name && !dai->capture_widget) {
 		template.id = snd_soc_dapm_dai;
 		template.name = dai->driver->capture.stream_name;
 		template.sname = dai->driver->capture.stream_name;
-- 
1.7.2.5
