From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 103/112] ALSA: hda - Add brief comments to
	exported snd_hda_gen_*_() functions
Date: Tue,  8 Jan 2013 12:39:36 +0100
Message-ID: <1357645185-7645-104-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 53226265234
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 07923A53E5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 68024ad..7c76a00 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3899,6 +3899,10 @@ static void clear_unsol_on_unused_pins(struct hda_codec *codec)
 	}
 }
 
+/*
+ * initialize the generic spec;
+ * this can be put as patch_ops.init function
+ */
 int snd_hda_gen_init(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -3935,7 +3939,10 @@ int snd_hda_gen_init(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_init);
 
-
+/*
+ * free the generic spec;
+ * this can be put as patch_ops.free function
+ */
 void snd_hda_gen_free(struct hda_codec *codec)
 {
 	snd_hda_gen_spec_free(codec->spec);
@@ -3945,6 +3952,10 @@ void snd_hda_gen_free(struct hda_codec *codec)
 EXPORT_SYMBOL_HDA(snd_hda_gen_free);
 
 #ifdef CONFIG_PM
+/*
+ * check the loopback power save state;
+ * this can be put as patch_ops.check_power_status function
+ */
 int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct hda_gen_spec *spec = codec->spec;
-- 
1.8.0.1
