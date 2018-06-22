From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/16] ALSA: hda/realtek - Add GPIO data update
	helper
Date: Fri, 22 Jun 2018 11:53:39 +0200
Message-ID: <20180622095352.19451-4-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DF5A2676CA
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:54 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 63431AF80
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

For updating GPIO bits dynamically, provide a new helper, and use it
from the alc260 automute hook.  This helper will be used by other
places in future, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 489075b23652..bd54d9e25440 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -241,6 +241,20 @@ static void alc_write_gpio_data(struct hda_codec *codec)
 			    spec->gpio_data);
 }
 
+static void alc_update_gpio_data(struct hda_codec *codec, unsigned int mask,
+				 bool on)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int oldval = spec->gpio_data;
+
+	if (on)
+		spec->gpio_data |= mask;
+	else
+		spec->gpio_data &= ~mask;
+	if (oldval != spec->gpio_data)
+		alc_write_gpio_data(codec);
+}
+
 static void alc_write_gpio(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -1577,8 +1591,8 @@ enum {
 static void alc260_gpio1_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-			    spec->gen.hp_jack_present);
+
+	alc_update_gpio_data(codec, 0x01, spec->gen.hp_jack_present);
 }
 
 static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
-- 
2.17.1
