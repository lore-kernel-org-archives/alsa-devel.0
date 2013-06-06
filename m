From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Drop hard dependency on
	CONFIG_SND_DYNAMIC_MINORS
Date: Thu,  6 Jun 2013 15:02:19 +0200
Message-ID: <1370523739-28479-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF027261AAB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:01:42 +0200 (CEST)
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

Currently HDMI codec driver sets the hard dependency (reverse
selection) on CONFIG_SND_DYNAMIC_MINORS because the recent codecs may
support more than two PCMs.  But, this doesn't mean that we need
always this option, since there can be a single PCM stream even with
the modern codecs.

This patch drops the hard dependency again but give more sensible
error message when no enough PCMs are available due to the lack of
this option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig     |  1 -
 sound/pci/hda/hda_codec.c | 19 +++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 80a7d44..0c5371a 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -140,7 +140,6 @@ config SND_HDA_CODEC_VIA
 
 config SND_HDA_CODEC_HDMI
 	bool "Build HDMI/DisplayPort HD-audio codec support"
-	select SND_DYNAMIC_MINORS
 	default y
 	help
 	  Say Y here to include HDMI and DisplayPort HD-audio codec
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 55108b5..679fba4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4461,12 +4461,13 @@ const char *snd_hda_pcm_type_name[HDA_PCM_NTYPES] = {
 
 /*
  * get the empty PCM device number to assign
- *
- * note the max device number is limited by HDA_MAX_PCMS, currently 10
  */
-static int get_empty_pcm_device(struct hda_bus *bus, int type)
+static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 {
 	/* audio device indices; not linear to keep compatibility */
+	/* assigned to static slots up to dev#10; if more needed, assign
+	 * the later slot dynamically (when CONFIG_SND_DYNAMIC_MINORS=y)
+	 */
 	static int audio_idx[HDA_PCM_NTYPES][5] = {
 		[HDA_PCM_TYPE_AUDIO] = { 0, 2, 4, 5, -1 },
 		[HDA_PCM_TYPE_SPDIF] = { 1, -1 },
@@ -4480,18 +4481,28 @@ static int get_empty_pcm_device(struct hda_bus *bus, int type)
 		return -EINVAL;
 	}
 
-	for (i = 0; audio_idx[type][i] >= 0 ; i++)
+	for (i = 0; audio_idx[type][i] >= 0; i++) {
+#ifndef CONFIG_SND_DYNAMIC_MINORS
+		if (audio_idx[type][i] >= 8)
+			break;
+#endif
 		if (!test_and_set_bit(audio_idx[type][i], bus->pcm_dev_bits))
 			return audio_idx[type][i];
+	}
 
+#ifdef CONFIG_SND_DYNAMIC_MINORS
 	/* non-fixed slots starting from 10 */
 	for (i = 10; i < 32; i++) {
 		if (!test_and_set_bit(i, bus->pcm_dev_bits))
 			return i;
 	}
+#endif
 
 	snd_printk(KERN_WARNING "Too many %s devices\n",
 		snd_hda_pcm_type_name[type]);
+#ifndef CONFIG_SND_DYNAMIC_MINORS
+	snd_printk(KERN_WARNING "Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y\n");
+#endif
 	return -EAGAIN;
 }
 
-- 
1.8.3
