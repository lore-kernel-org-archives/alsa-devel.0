From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/14] ASoC: Export dapm_reg_event() fully
Date: Tue, 29 Jul 2008 11:42:23 +0100
Message-ID: <1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C6A624839
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:40 +0200 (CEST)
In-Reply-To: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

dapm_reg_event() is used by devices using SND_SOC_DAPM_REG() so needs to
be exported to support building them as modules and prototyped to avoid
sparse warnings and potential build issues.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    3 +++
 sound/soc/soc-dapm.c     |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3030fdc..c1b26fc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -202,6 +202,9 @@ struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
 
+int dapm_reg_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event);
+
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 820347c..f9d100b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -470,6 +470,7 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dapm_reg_event);
 
 /*
  * Scan each dapm widget for complete audio path.
-- 
1.5.6.3
