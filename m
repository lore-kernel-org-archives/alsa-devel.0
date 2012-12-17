From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Set codec->single_adc_amp flag
	for Realtek codecs
Date: Mon, 17 Dec 2012 20:13:40 +0100
Message-ID: <1355771621-11086-2-git-send-email-tiwai@suse.de>
References: <1355771621-11086-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E6B09260310
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 20:13:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B08A9A50E4
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 20:13:47 +0100 (CET)
In-Reply-To: <1355771621-11086-1-git-send-email-tiwai@suse.de>
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

It turned out that Realtek codecs (ALC260, etc) with input amps in
audio-input widgets don't handle the multiple individual input amps.
Thus we need to set codec->single_adc_amp flag for them in general.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7743775..16d210a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4373,6 +4373,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
+	codec->single_adc_amp = 1;
 	spec->mixer_nid = mixer_nid;
 	snd_hda_gen_init(&spec->gen);
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
-- 
1.8.0.1
