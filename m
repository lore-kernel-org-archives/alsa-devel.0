From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix powermap for external mics on
	IDT codecs
Date: Mon, 28 Jan 2013 11:29:17 +0100
Message-ID: <1359368957-11874-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF78265207
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 11:29:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a regression of the external mic not working on
HP Probook 4520s.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    8 ++++++++
 1 file changed, 8 insertions(+)

This is why my external mic stopped working; I now had some time to track it down.
Alsa-info at http://paste.ubuntu.com/1579993/

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 1c49861..951fc0d 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -502,6 +502,13 @@ static void stac_line_automute(struct hda_codec *codec,
 	jack_update_power(codec, jack);
 }
 
+static void stac_mic_autoswitch(struct hda_codec *codec,
+				struct hda_jack_tbl *jack)
+{
+	snd_hda_gen_mic_autoswitch(codec, jack);
+	jack_update_power(codec, jack);
+}
+
 static void stac_vref_event(struct hda_codec *codec, struct hda_jack_tbl *event)
 {
 	unsigned int data;
@@ -3509,6 +3516,7 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 	spec->gen.automute_hook = stac_update_outputs;
 	spec->gen.hp_automute_hook = stac_hp_automute;
 	spec->gen.line_automute_hook = stac_line_automute;
+	spec->gen.mic_autoswitch_hook = stac_mic_autoswitch;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
-- 
1.7.9.5
