From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] ASoC: soc-dapm: Use empty struct
	initializer
Date: Wed, 14 Feb 2018 13:39:05 -0200
Message-ID: <1518622745-12162-3-git-send-email-festevam@gmail.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B35C3267822
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 16:39:16 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id c4so24839628qkm.2
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 07:39:15 -0800 (PST)
In-Reply-To: <1518622745-12162-1-git-send-email-festevam@gmail.com>
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

{ NULL } only clears the first member of the structure.

Even though the first member of the snd_soc_dapm_update struct is a
pointer,it is more robust to use the empty struct initializer that
clears all the struct members.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 92894d9..2f34590 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3165,7 +3165,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int invert = mc->invert;
 	unsigned int val, rval = 0;
 	int connect, rconnect = -1, change, reg_change = 0;
-	struct snd_soc_dapm_update update = { NULL };
+	struct snd_soc_dapm_update update = {};
 	int ret = 0;
 
 	val = (ucontrol->value.integer.value[0] & mask);
@@ -3292,7 +3292,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int val, change, reg_change = 0;
 	unsigned int mask;
-	struct snd_soc_dapm_update update = { NULL };
+	struct snd_soc_dapm_update update = {};
 	int ret = 0;
 
 	if (item[0] >= e->items)
-- 
2.7.4
