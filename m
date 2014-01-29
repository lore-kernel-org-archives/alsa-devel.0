From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add parameter for dumping
	processing coefficients
Date: Wed, 29 Jan 2014 10:37:10 +0100
Message-ID: <1390988230-3228-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C2A265290
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 10:37:13 +0100 (CET)
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
Cc: hui.wang@canonical.com, kailang@realtek.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Processing coefficients are often a vital part of the codec's configuration,
so dumping them can be important. However, because they are undocumented and
secret, we do not want to enable this for all codecs by default.

Therefore instead add this as a debugging parameter.

I have prepared for codecs that want to enable this by default by the extra
dump_coef bitfield, but unsure if we want to do that as long as the
(unlikely, but still) race remains.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.h |    1 +
 sound/pci/hda/hda_proc.c  |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 2b5d19e..ab2a444 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -361,6 +361,7 @@ struct hda_codec {
 	unsigned int epss:1;		/* supporting EPSS? */
 	unsigned int cached_write:1;	/* write only to caches */
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
+	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 #ifdef CONFIG_PM
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index a8cb22e..ce5a6da 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -24,9 +24,14 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <linux/module.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 
+static int dump_coef = -1;
+module_param(dump_coef, int, 0644);
+MODULE_PARM_DESC(dump_coef, "Dump processing coefficients in codec proc file (-1=auto, 0=disable, 1=enable)");
+
 static char *bits_names(unsigned int bits, char *names[], int size)
 {
 	int i, n;
@@ -488,14 +493,39 @@ static void print_unsol_cap(struct snd_info_buffer *buffer,
 		    (unsol & AC_UNSOL_ENABLED) ? 1 : 0);
 }
 
+static inline bool can_dump_coef(struct hda_codec *codec)
+{
+	switch (dump_coef) {
+	case 0: return false;
+	case 1: return true;
+	default: return codec->dump_coef;
+	}
+}
+
 static void print_proc_caps(struct snd_info_buffer *buffer,
 			    struct hda_codec *codec, hda_nid_t nid)
 {
+	unsigned int i, ncoeff, oldindex;
 	unsigned int proc_caps = snd_hda_param_read(codec, nid,
 						    AC_PAR_PROC_CAP);
+	ncoeff = (proc_caps & AC_PCAP_NUM_COEF) >> AC_PCAP_NUM_COEF_SHIFT;
 	snd_iprintf(buffer, "  Processing caps: benign=%d, ncoeff=%d\n",
-		    proc_caps & AC_PCAP_BENIGN,
-		    (proc_caps & AC_PCAP_NUM_COEF) >> AC_PCAP_NUM_COEF_SHIFT);
+		    proc_caps & AC_PCAP_BENIGN, ncoeff);
+
+	if (!can_dump_coef(codec))
+		return;
+
+	/* Note: This is racy - another process could run in parallel and change
+	   the coef index too. */
+	oldindex = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_COEF_INDEX, 0);
+	for (i = 0; i < ncoeff; i++) {
+		unsigned int val;
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, i);
+		val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PROC_COEF,
+					 0);
+		snd_iprintf(buffer, "    Coeff 0x%02x: 0x%04x\n", i, val);
+	}
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, oldindex);
 }
 
 static void print_conn_list(struct snd_info_buffer *buffer,
-- 
1.7.9.5
