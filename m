From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 7/7] ALSA: hda - Use snd_hdmi namespace
	prefix for printing ch alloc api
Date: Wed,  2 Mar 2016 17:33:28 +0530
Message-ID: <1456920208-1172-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BDA52614A4
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 13:03:25 +0100 (CET)
In-Reply-To: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdmi_chmap.h | 2 +-
 sound/hda/hdmi_chmap.c     | 6 +++---
 sound/pci/hda/hda_eld.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdmi_chmap.h b/include/sound/hdmi_chmap.h
index 837c6e5..a58c204 100644
--- a/include/sound/hdmi_chmap.h
+++ b/include/sound/hdmi_chmap.h
@@ -69,7 +69,7 @@ struct hdmi_chmap {
 
 void snd_hdmi_register_chmap_ops(struct hdac_device *hdac,
 				struct hdmi_chmap *chmap);
-void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen);
+void snd_hdmi_print_channel_allocation(int spk_alloc, char *buf, int buflen);
 int snd_hdmi_add_chmap_ctls(struct snd_pcm *pcm, int pcm_idx,
 				struct hdmi_chmap *chmap);
 #endif /* __SOUND_HDMI_CHMAP_H */
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index 0685dc2..72d6989 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -243,7 +243,7 @@ static int get_channel_allocation_order(int ca)
 	return i;
 }
 
-void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
+void snd_hdmi_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 {
 	int i, j;
 
@@ -254,7 +254,7 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 	}
 	buf[j] = '\0';	/* necessary when j == 0 */
 }
-EXPORT_SYMBOL_GPL(snd_print_channel_allocation);
+EXPORT_SYMBOL_GPL(snd_hdmi_print_channel_allocation);
 
 /*
  * The transformation takes two steps:
@@ -312,7 +312,7 @@ static int hdmi_channel_allocation_spk_alloc_blk(struct hdac_device *codec,
 		}
 	}
 
-	snd_print_channel_allocation(spk_alloc, buf, sizeof(buf));
+	snd_hdmi_print_channel_allocation(spk_alloc, buf, sizeof(buf));
 	dev_dbg(&codec->dev, "HDMI: select CA 0x%x for %d-channel allocation: %s\n",
 		    ca, channels, buf);
 
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 864d6fe..e05b388 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -416,7 +416,7 @@ void snd_hdmi_show_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e)
 
 	if (e->spk_alloc) {
 		char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
-		snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+		snd_hdmi_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
 		codec_dbg(codec, "HDMI: available speakers:%s\n", buf);
 	}
 
@@ -491,7 +491,7 @@ void snd_hdmi_print_eld_info(struct hdmi_eld *eld,
 	snd_iprintf(buffer, "support_ai\t\t%d\n", e->support_ai);
 	snd_iprintf(buffer, "audio_sync_delay\t%d\n", e->aud_synch_delay);
 
-	snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+	snd_hdmi_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
 	snd_iprintf(buffer, "speakers\t\t[0x%x]%s\n", e->spk_alloc, buf);
 
 	snd_iprintf(buffer, "sad_count\t\t%d\n", e->sad_count);
-- 
1.9.1
