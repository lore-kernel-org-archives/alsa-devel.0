From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 073/112] ALSA: hda - Fix PCM name string for
	generic parser
Date: Tue,  8 Jan 2013 12:39:06 +0100
Message-ID: <1357645185-7645-74-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C95265207
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 77879A532A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

When a PCM name string is generated from the chip name, it might
become strange like "CX20549 (Venice) Analog".  In this patch, the
parser tries to drop the invalid words like "(Venice)" in the PCM name
string.  Also, when the name string is given beforehand by the caller,
respect it and use it as is.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f4b5043..d4cb9df 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/sort.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include "hda_codec.h"
@@ -3230,6 +3232,25 @@ static const struct hda_pcm_stream dyn_adc_pcm_analog_capture = {
 	},
 };
 
+static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
+				 const char *chip_name)
+{
+	char *p;
+
+	if (*str)
+		return;
+	strlcpy(str, chip_name, len);
+
+	/* drop non-alnum chars after a space */
+	for (p = strchr(str, ' '); p; p = strchr(p + 1, ' ')) {
+		if (!isalnum(p[1])) {
+			*p = 0;
+			break;
+		}
+	}
+	strlcat(str, sfx, len);
+}
+
 /* build PCM streams based on the parsed results */
 int snd_hda_gen_build_pcms(struct hda_codec *codec)
 {
@@ -3245,8 +3266,9 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 	if (spec->no_analog)
 		goto skip_analog;
 
-	snprintf(spec->stream_name_analog, sizeof(spec->stream_name_analog),
-		 "%s Analog", codec->chip_name);
+	fill_pcm_stream_name(spec->stream_name_analog,
+			     sizeof(spec->stream_name_analog),
+			     " Analog", codec->chip_name);
 	info->name = spec->stream_name_analog;
 
 	if (spec->multiout.num_dacs > 0) {
@@ -3286,9 +3308,9 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
  skip_analog:
 	/* SPDIF for stream index #1 */
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
-		snprintf(spec->stream_name_digital,
-			 sizeof(spec->stream_name_digital),
-			 "%s Digital", codec->chip_name);
+		fill_pcm_stream_name(spec->stream_name_digital,
+				     sizeof(spec->stream_name_digital),
+				     " Digital", codec->chip_name);
 		codec->num_pcms = 2;
 		codec->slave_dig_outs = spec->multiout.slave_dig_outs;
 		info = spec->pcm_rec + 1;
-- 
1.8.0.1
