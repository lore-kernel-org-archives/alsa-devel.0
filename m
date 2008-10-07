From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] hda: comment typo fix
Date: Tue, 7 Oct 2008 14:21:41 +0800
Message-ID: <1223360502.567932.9054@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

fix a typo in comment for is_in_nid_list().

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index c742e10..6268667 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2807,7 +2807,7 @@ int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
 }
 
 /*
- * Helper for automatic ping configuration
+ * Helper for automatic pin configuration
  */
 
 static int is_in_nid_list(hda_nid_t nid, hda_nid_t *list)
