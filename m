From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be mixer
	widgets rather the PGAs
Date: Wed, 18 Dec 2013 10:53:44 +0000
Message-ID: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42AEB26163C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:00:36 +0100 (CET)
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

PGAs often control the output from a chip and if the DSP is also marked
as a PGA it may be powered up after the output has been enabled. This
patch changes the ADSP2 cores to be marked as snd_soc_dapm_mixer widgets
so they are powered up before any PGAs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Hi,

Was also considering if it would be worth adding an
additional snd_soc_dapm_dsp id? That could sit between
mixers and pgas, but I can't really see any obvious issue
with treating the DSP as a mixer and it is a much simpler
change. Although I am open to writing the other change if it
is preferred?

Thanks,
Charles

 sound/soc/codecs/wm_adsp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index d018dea..795a3b2 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -66,7 +66,7 @@ struct wm_adsp {
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
 #define WM_ADSP2(wname, num) \
-	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
+	SND_SOC_DAPM_MIXER_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp2_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
 extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
-- 
1.7.2.5
