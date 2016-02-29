From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ASoC: pxa: magician: Fix enum ctl accesses
	in a wrong type
Date: Mon, 29 Feb 2016 17:23:50 +0100
Message-ID: <1456763033-2900-3-git-send-email-tiwai@suse.de>
References: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 456202659FE
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:23:57 +0100 (CET)
In-Reply-To: <1456763033-2900-1-git-send-email-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

"Input Select" ctl in magician driver is an enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

(Meanwhile "Headphone Switch" and "Speaker Switch" are boolean, so
 they should stay to access via value.integer.value[] as is.)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/pxa/magician.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 241d0be42d7a..62b8377a9d2b 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -308,17 +308,17 @@ static int magician_set_spk(struct snd_kcontrol *kcontrol,
 static int magician_get_input(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = magician_in_sel;
+	ucontrol->value.enumerated.item[0] = magician_in_sel;
 	return 0;
 }
 
 static int magician_set_input(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	if (magician_in_sel == ucontrol->value.integer.value[0])
+	if (magician_in_sel == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	magician_in_sel = ucontrol->value.integer.value[0];
+	magician_in_sel = ucontrol->value.enumerated.item[0];
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
-- 
2.7.2
