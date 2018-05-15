From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: hda/ca0132: constify templates for
	control element set
Date: Tue, 15 May 2018 22:12:57 +0900
Message-ID: <20180515131300.24315-2-o-takashi@sakamocchi.jp>
References: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DF621267021
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:13:32 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id v7-v6so35555pgs.0
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 06:13:32 -0700 (PDT)
In-Reply-To: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

An array of templates for control element set is passed as an
argument for snd_hda_add_new_ctls(). This argument has 'const'
qualifier therefore the passed array can have the qualifier.

This commit adds this optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 1cc4f5133645..d18022d72e83 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -892,7 +892,7 @@ enum dsp_download_state {
  */
 
 struct ca0132_spec {
-	struct snd_kcontrol_new *mixers[5];
+	const struct snd_kcontrol_new *mixers[5];
 	unsigned int num_mixers;
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
@@ -5705,7 +5705,7 @@ static void ca0132_alt_add_chmap_ctls(struct hda_codec *codec)
  * When changing Node IDs for Mixer Controls below, make sure to update
  * Node IDs in ca0132_config() as well.
  */
-static struct snd_kcontrol_new ca0132_mixer[] = {
+static const struct snd_kcontrol_new ca0132_mixer[] = {
 	CA0132_CODEC_VOL("Master Playback Volume", VNID_SPK, HDA_OUTPUT),
 	CA0132_CODEC_MUTE("Master Playback Switch", VNID_SPK, HDA_OUTPUT),
 	CA0132_CODEC_VOL("Capture Volume", VNID_MIC, HDA_INPUT),
@@ -5732,7 +5732,7 @@ static struct snd_kcontrol_new ca0132_mixer[] = {
  * controls. Also sets both the Front Playback and Capture Volume controls to
  * alt so they set the DSP's decibel level.
  */
-static struct snd_kcontrol_new sbz_mixer[] = {
+static const struct snd_kcontrol_new sbz_mixer[] = {
 	CA0132_ALT_CODEC_VOL("Front Playback Volume", 0x02, HDA_OUTPUT),
 	CA0132_CODEC_MUTE("Front Playback Switch", VNID_SPK, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x04, 0, HDA_OUTPUT),
@@ -5754,7 +5754,7 @@ static struct snd_kcontrol_new sbz_mixer[] = {
  * Same as the Sound Blaster Z, except doesn't use the alt volume for capture
  * because it doesn't set decibel levels for the DSP for capture.
  */
-static struct snd_kcontrol_new r3di_mixer[] = {
+static const struct snd_kcontrol_new r3di_mixer[] = {
 	CA0132_ALT_CODEC_VOL("Front Playback Volume", 0x02, HDA_OUTPUT),
 	CA0132_CODEC_MUTE("Front Playback Switch", VNID_SPK, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x04, 0, HDA_OUTPUT),
-- 
2.14.1
