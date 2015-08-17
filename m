From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda/proc - Fix racy string access
	for power states
Date: Mon, 17 Aug 2015 15:44:10 +0200
Message-ID: <1439819051-32166-4-git-send-email-tiwai@suse.de>
References: <1439819051-32166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E991926046B
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 15:44:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B1142ADC2
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 13:44:25 +0000 (UTC)
In-Reply-To: <1439819051-32166-1-git-send-email-tiwai@suse.de>
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

The power states in a proc file are printed in a racy manner on a
single static string buffer.  Fix it by calling snd_iprintf() directly
for each state instead of processing on a temporary buffer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_proc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 5efcffc32c50..033aa84365b9 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -36,21 +36,6 @@ MODULE_PARM_DESC(dump_coef, "Dump processing coefficients in codec proc file (-1
 #define param_read(codec, nid, parm) \
 	snd_hdac_read_parm_uncached(&(codec)->core, nid, parm)
 
-static char *bits_names(unsigned int bits, const char * const names[], int size)
-{
-	int i, n;
-	static char buf[128];
-
-	for (i = 0, n = 0; i < size; i++) {
-		if (bits & (1U<<i) && names[i])
-			n += snprintf(buf + n, sizeof(buf) - n, " %s",
-				      names[i]);
-	}
-	buf[n] = '\0';
-
-	return buf;
-}
-
 static const char *get_wid_type_name(unsigned int wid_value)
 {
 	static const char * const names[16] = {
@@ -555,9 +540,16 @@ static void print_power_state(struct snd_info_buffer *buffer,
 	int sup = param_read(codec, nid, AC_PAR_POWER_STATE);
 	int pwr = snd_hda_codec_read(codec, nid, 0,
 				     AC_VERB_GET_POWER_STATE, 0);
-	if (sup != -1)
-		snd_iprintf(buffer, "  Power states: %s\n",
-			    bits_names(sup, names, ARRAY_SIZE(names)));
+	if (sup != -1) {
+		int i;
+
+		snd_iprintf(buffer, "  Power states: ");
+		for (i = 0; i < ARRAY_SIZE(names); i++) {
+			if (sup & (1U << i))
+				snd_iprintf(buffer, " %s", names[i]);
+		}
+		snd_iprintf(buffer, "\n");
+	}
 
 	snd_iprintf(buffer, "  Power: setting=%s, actual=%s",
 		    get_pwr_state(pwr & AC_PWRST_SETTING),
-- 
2.5.0
