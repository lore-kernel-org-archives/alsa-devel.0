From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: adau17x1: Use empty struct
	initializer
Date: Wed, 14 Feb 2018 13:39:03 -0200
Message-ID: <1518622745-12162-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C23D4267194
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 16:39:12 +0100 (CET)
Received: by mail-qk0-f193.google.com with SMTP id i184so16041676qkf.10
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 07:39:12 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

{ 0 } only clears the first member of the structure.

The first member of the snd_soc_dapm_update struct is a pointer,
and writing 0 to a pointer results in a sparse warning.

Use the empty struct initializer that clears all the struct members
and fixes the sparse warning.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/adau17x1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index df34349..80c2a06 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -181,7 +181,7 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct adau *adau = snd_soc_component_get_drvdata(component);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	struct snd_soc_dapm_update update = { 0 };
+	struct snd_soc_dapm_update update = {};
 	unsigned int stream = e->shift_l;
 	unsigned int val, change;
 	int reg;
-- 
2.7.4
