From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - fix wrong adc_idx in generic
	parser
Date: Wed, 16 Jan 2013 11:45:36 +0100
Message-ID: <1358333137-9415-3-git-send-email-david.henningsson@canonical.com>
References: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F2DE52625F7
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 11:45:36 +0100 (CET)
In-Reply-To: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
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

We use knew->index for adc_idx when we create "Capture Volume" and
"Capture Switch", so use the same to retrieve adc_idx.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 577acc4..aac8eb9 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2426,7 +2426,7 @@ static int mux_enum_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_gen_spec *spec = codec->spec;
-	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	unsigned int adc_idx = kcontrol->id.index;
 
 	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
 	return 0;
@@ -2436,7 +2436,7 @@ static int mux_enum_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	unsigned int adc_idx = kcontrol->id.index;
 	return mux_select(codec, adc_idx,
 			  ucontrol->value.enumerated.item[0]);
 }
@@ -2468,7 +2468,7 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 	int i, adc_idx, err = 0;
 
 	imux = &spec->input_mux;
-	adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	adc_idx = kcontrol->id.index;
 	mutex_lock(&codec->control_mutex);
 	/* we use the cache-only update at first since multiple input paths
 	 * may shared the same amp; by updating only caches, the redundant
-- 
1.7.9.5
