From: mengdong.lin@intel.com
Subject: [PATCH 1/3] [ALSA] hda - Support rereading widgets
	under the function group
Date: Fri,  8 Feb 2013 17:09:31 -0500
Message-ID: <1360361371-4337-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 24E96265346
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 10:09:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

A codec may allow software to hide some unused pin/cvt widgets.

Sometimes BIOS does not enable the hidden widgets properly although they are
needed for the board. Thus the driver need to enable them as a board-specific
fixup and the whole tree will change.

This patch implements a common code for rereading codec widgets. So the fixup
code can call it after enabling the hidden widgets.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3c92514..e80f835 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1441,6 +1441,30 @@ int snd_hda_codec_new(struct hda_bus *bus,
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_new);
 
+int snd_hda_codec_update_widgets(struct hda_codec *codec)
+{
+	hda_nid_t fg;
+	int err;
+
+	/* Assume the function group node does not change,
+	 * only the widget nodes may change.
+	 */
+	kfree(codec->wcaps);
+	fg = codec->afg ? codec->afg : codec->mfg;
+	err = read_widget_caps(codec, fg);
+	if (err < 0) {
+		snd_printk(KERN_ERR "hda_codec: cannot malloc\n");
+		return err;
+	}
+
+	snd_array_free(&codec->init_pins);
+	err = read_pin_defaults(codec);
+
+	return err;
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_update_widgets);
+
+
 /**
  * snd_hda_codec_configure - (Re-)configure the HD-audio codec
  * @codec: the HDA codec
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 0be1826..e8c9442 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -935,6 +935,7 @@ int snd_hda_bus_new(struct snd_card *card, const struct hda_bus_template *temp,
 int snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
 		      struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
+int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
 /*
  * low level functions
-- 
1.7.10.4
