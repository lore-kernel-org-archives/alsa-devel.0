From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: x86: Don't return an error from
	chmap ctl at disconnected
Date: Wed, 15 Feb 2017 22:29:32 +0100
Message-ID: <20170215212936.697-5-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2D0266E4F
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:42 +0100 (CET)
In-Reply-To: <20170215212936.697-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

It's not wise to return an error at info/get callback when
disconnected, which happens at any time.
The chmap ctl is supposed to fill zero for such a case, instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5f2445389716..71f01204a590 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -504,11 +504,6 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 static int had_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	struct snd_intelhad *intelhaddata = info->private_data;
-
-	if (!intelhaddata->connected)
-		return -ENODEV;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = HAD_MAX_CHANNEL;
 	uinfo->value.integer.min = 0;
@@ -524,13 +519,12 @@ static int had_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	int i;
 	const struct snd_pcm_chmap_elem *chmap;
 
-	if (!intelhaddata->connected)
-		return -ENODEV;
-
+	memset(ucontrol->value.integer.value, 0,
+	       sizeof(long) * HAD_MAX_CHANNEL);
 	mutex_lock(&intelhaddata->mutex);
 	if (!intelhaddata->chmap->chmap) {
 		mutex_unlock(&intelhaddata->mutex);
-		return -ENODATA;
+		return 0;
 	}
 
 	chmap = intelhaddata->chmap->chmap;
-- 
2.11.1
