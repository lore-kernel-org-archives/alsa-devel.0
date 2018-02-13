From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] ASoC: wm9712: Use empty struct
	initializer
Date: Tue, 13 Feb 2018 17:37:50 -0200
Message-ID: <1518550671-16359-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D26B26775A
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 20:37:58 +0100 (CET)
Received: by mail-qt0-f194.google.com with SMTP id d8so4961515qtm.0
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 11:37:57 -0800 (PST)
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
and writing 0 to a pointer results in the following sparse warning:

sound/soc/codecs/wm9712.c:229:47: warning: Using plain integer as NULL pointer

Use the empty struct initializer that clears all the struct members
and fixes the sparse warning.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Fix typos in commit log

 sound/soc/codecs/wm9712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 7aeeeec..953d94d 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -226,7 +226,7 @@ static int wm9712_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, mask, shift, old;
-	struct snd_soc_dapm_update update = { 0 };
+	struct snd_soc_dapm_update update = {};
 	bool change;
 
 	mixer = mc->shift >> 8;
-- 
2.7.4
