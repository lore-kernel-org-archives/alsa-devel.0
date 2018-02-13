From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Use empty struct
	initializer
Date: Tue, 13 Feb 2018 17:35:36 -0200
Message-ID: <1518550536-16279-2-git-send-email-festevam@gmail.com>
References: <1518550536-16279-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 848512679A2
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 20:35:45 +0100 (CET)
Received: by mail-qk0-f194.google.com with SMTP id z197so6955963qkb.6
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 11:35:45 -0800 (PST)
In-Reply-To: <1518550536-16279-1-git-send-email-festevam@gmail.com>
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

The first member of the snd_soc_dapm_update struct is pointer,
so wrting 0 to a pointer results in the following sparse warning:

sound/soc/codecs/tlv320aic3x.c:175:47: warning: Using plain integer as NULL pointer

Use the empty struct initializer that clears all the struct members
and fixes the sparse warning.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/tlv320aic3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index dbfa0d8..6a271e6 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -172,7 +172,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned short val;
-	struct snd_soc_dapm_update update = { 0 };
+	struct snd_soc_dapm_update update = {};
 	int connect, change;
 
 	val = (ucontrol->value.integer.value[0] & mask);
-- 
2.7.4
