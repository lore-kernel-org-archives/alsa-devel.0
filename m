From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: DAPM: fix build errors for missing
	snd_soc_dapm_new_control symbol
Date: Mon, 15 Jun 2015 17:47:51 +0100
Message-ID: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A51A62652E9
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:48:01 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Fix the following error:-

All error/warnings (new ones prefixed by >>):
>
>    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 92d57a9..1b4a6eb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -53,7 +53,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink));
 
-static struct snd_soc_dapm_widget *
+struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget);
 
@@ -3270,7 +3270,7 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-static struct snd_soc_dapm_widget *
+struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
-- 
2.1.4
