From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 2/4] ALSA pcm: allow non constant
	snd_pcm_chmap_elem
Date: Wed, 14 Dec 2016 16:16:43 +0100
Message-ID: <1481728605-22781-3-git-send-email-arnaud.pouliquen@st.com>
References: <1481728605-22781-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6F396267002
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 16:17:21 +0100 (CET)
In-Reply-To: <1481728605-22781-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

For HDMI, channel mapping can be retrieved from ELD. In this case mapping
can change during runtime (plug/unplug).
This patch suppresses the 'const' property of the struct chmap.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/pcm.h  | 4 ++--
 sound/core/pcm_lib.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index af1fb37..3b459a3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1355,7 +1355,7 @@ struct snd_pcm_chmap {
 	struct snd_pcm *pcm;	/* assigned PCM instance */
 	int stream;		/* PLAYBACK or CAPTURE */
 	struct snd_kcontrol *kctl;
-	const struct snd_pcm_chmap_elem *chmap;
+	struct snd_pcm_chmap_elem *chmap;
 	unsigned int max_channels;
 	unsigned int channel_mask;	/* optional: active channels bitmask */
 	void *private_data;	/* optional: private data pointer */
@@ -1387,7 +1387,7 @@ extern const struct snd_pcm_chmap_elem snd_pcm_alt_chmaps[];
 #define SND_PCM_CHMAP_MASK_2468	(SND_PCM_CHMAP_MASK_246 | (1U << 8))
 
 int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
-			   const struct snd_pcm_chmap_elem *chmap,
+			   struct snd_pcm_chmap_elem *chmap,
 			   int max_channels,
 			   unsigned long private_value,
 			   struct snd_pcm_chmap **info_ret);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bb12615..252a498 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2489,7 +2489,7 @@ static int pcm_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	struct snd_pcm_substream *substream;
-	const struct snd_pcm_chmap_elem *map;
+	struct snd_pcm_chmap_elem *map;
 
 	if (snd_BUG_ON(!info->chmap))
 		return -EINVAL;
@@ -2519,7 +2519,7 @@ static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			     unsigned int size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	const struct snd_pcm_chmap_elem *map;
+	struct snd_pcm_chmap_elem *map;
 	unsigned int __user *dst;
 	int c, count = 0;
 
@@ -2578,7 +2578,7 @@ static void pcm_chmap_ctl_private_free(struct snd_kcontrol *kcontrol)
  * Return: Zero if successful, or a negative error value.
  */
 int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
-			   const struct snd_pcm_chmap_elem *chmap,
+			   struct snd_pcm_chmap_elem *chmap,
 			   int max_channels,
 			   unsigned long private_value,
 			   struct snd_pcm_chmap **info_ret)
-- 
1.9.1
