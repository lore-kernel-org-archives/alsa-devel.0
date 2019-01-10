From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 5/5] ALSA: hda: program stripe control for codec
Date: Thu, 10 Jan 2019 22:33:25 +0530
Message-ID: <1547139805-1904-5-git-send-email-spujar@nvidia.com>
References: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0574A26754E
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 18:04:01 +0100 (CET)
In-Reply-To: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Program codec stripe through AC_VERB_SET_STRIPE_CONTROL to use multiple
sdo lines if supported. Audio needs to be striped across number of sdo
lines for simultaneous playbacks of higher resolutions to work.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 46f88dc..855e526 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1865,7 +1865,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	hda_nid_t pin_nid;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	bool non_pcm;
-	int pinctl;
+	int pinctl, stripe;
 	int err = 0;
 
 	mutex_lock(&spec->pcm_lock);
@@ -1909,6 +1909,10 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	per_pin->channels = substream->runtime->channels;
 	per_pin->setup = true;
 
+	stripe = snd_hdac_get_stream_stripe_ctl(&codec->bus->core, substream);
+	snd_hda_codec_write(codec, cvt_nid, 0, AC_VERB_SET_STRIPE_CONTROL,
+			    stripe);
+
 	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
 	mutex_unlock(&per_pin->lock);
 	if (spec->dyn_pin_out) {
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
