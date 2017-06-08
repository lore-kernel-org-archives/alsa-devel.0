From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/31] ALSA: hda: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:40 +0200
Message-ID: <20170608210852.13058-20-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EBC52673C4
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B4949ADB7
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 21:08:56 +0000 (UTC)
In-Reply-To: <20170608210852.13058-1-tiwai@suse.de>
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

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c   | 10 +++++-----
 sound/pci/hda/patch_si3054.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 90e4ff87445e..0d7955eec201 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2782,21 +2782,21 @@ static int nvhdmi_7x_init_8ch(struct hda_codec *codec)
 	return 0;
 }
 
-static unsigned int channels_2_6_8[] = {
+static const unsigned int channels_2_6_8[] = {
 	2, 6, 8
 };
 
-static unsigned int channels_2_8[] = {
+static const unsigned int channels_2_8[] = {
 	2, 8
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_2_6_8_channels = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_2_6_8_channels = {
 	.count = ARRAY_SIZE(channels_2_6_8),
 	.list = channels_2_6_8,
 	.mask = 0,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_2_8_channels = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_2_8_channels = {
 	.count = ARRAY_SIZE(channels_2_8),
 	.list = channels_2_8,
 	.mask = 0,
@@ -2807,7 +2807,7 @@ static int simple_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				    struct snd_pcm_substream *substream)
 {
 	struct hdmi_spec *spec = codec->spec;
-	struct snd_pcm_hw_constraint_list *hw_constraints_channels = NULL;
+	const struct snd_pcm_hw_constraint_list *hw_constraints_channels = NULL;
 
 	switch (codec->preset->vendor_id) {
 	case 0x10de0002:
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index ffda38c45509..f63acb1b965c 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -169,8 +169,8 @@ static int si3054_pcm_open(struct hda_pcm_stream *hinfo,
 			   struct hda_codec *codec,
 			    struct snd_pcm_substream *substream)
 {
-	static unsigned int rates[] = { 8000, 9600, 16000 };
-	static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	static const unsigned int rates[] = { 8000, 9600, 16000 };
+	static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 		.count = ARRAY_SIZE(rates),
 		.list = rates,
 		.mask = 0,
-- 
2.13.0
