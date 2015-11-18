From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/4] topology: Change variable type to fix gcc
	warning
Date: Wed, 18 Nov 2015 02:23:07 -0500
Message-ID: <52b9413a02fff6e7edb4541023fe53bb495bbf91.1447825540.git.mengdong.lin@linux.intel.com>
References: <cover.1447825540.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1D0265382
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 08:07:21 +0100 (CET)
In-Reply-To: <cover.1447825540.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Fix warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

ABI objects use type _le32, which is converted to host unsigned integer.
So the iterator 'i' in a loop as below should also be unsigned.
for (i = 0; i < pcm->num_streams; i++)
                ^
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 7d8787f..6dc3b3d 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -676,7 +676,8 @@ int tplg_add_mixer(snd_tplg_t *tplg, struct snd_tplg_mixer_template *mixer,
 	struct snd_soc_tplg_private *priv = mixer->priv;
 	struct snd_soc_tplg_mixer_control *mc;
 	struct tplg_elem *elem;
-	int ret, i;
+	int ret;
+	unsigned int i;
 
 	tplg_dbg(" Control Mixer: %s\n", mixer->hdr.name);
 
@@ -743,7 +744,8 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 {
 	struct snd_soc_tplg_enum_control *ec;
 	struct tplg_elem *elem;
-	int ret, i;
+	int ret;
+	unsigned int i;
 
 	tplg_dbg(" Control Enum: %s\n", enum_ctl->hdr.name);
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 9b7e402..4b7c058 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -522,7 +522,7 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	struct snd_tplg_pcm_template *pcm_tpl = t->pcm;
 	struct snd_soc_tplg_pcm *pcm;
 	struct tplg_elem *elem;
-	int i;
+	unsigned int i;
 
 	tplg_dbg("PCM: %s, DAI %s\n", pcm_tpl->pcm_name, pcm_tpl->dai_name);
 
@@ -564,7 +564,7 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	struct snd_tplg_link_template *link = t->link;
 	struct snd_soc_tplg_link_config *lk;
 	struct tplg_elem *elem;
-	int i;
+	unsigned int i;
 
 	if (t->type != SND_TPLG_TYPE_BE && t->type != SND_TPLG_TYPE_CC)
 		return -EINVAL;
-- 
2.5.0
