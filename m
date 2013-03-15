From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 2/3] ALSA: hda/ca0132 - Check download state of
	DSP.
Date: Thu, 14 Mar 2013 17:27:45 -0700
Message-ID: <1363307266-30055-3-git-send-email-dgreid@chromium.org>
References: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f74.google.com (mail-qe0-f74.google.com
 [209.85.128.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 93DCF261629
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 01:27:57 +0100 (CET)
Received: by mail-qe0-f74.google.com with SMTP id 9so291818qea.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:27:57 -0700 (PDT)
In-Reply-To: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, chee_kin@ctl.creative.com, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

Instead of using the dspload_is_loaded() function, check the dsp_state
that is kept in the spec.  The dspload_is_loaded() function returns
true if the DSP transfer was never started.  This false-positive leads
to multiple second delays when ca0132_setup_efaults() times out on
each write.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cf24b75..225d1d5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3239,7 +3239,7 @@ static int ca0132_set_vipsource(struct hda_codec *codec, int val)
 	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
 
-	if (!dspload_is_loaded(codec))
+	if (spec->dsp_state != DSP_DOWNLOADED)
 		return 0;
 
 	/* if CrystalVoice if off, vipsource should be 0 */
@@ -4267,11 +4267,12 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
  */
 static void ca0132_setup_defaults(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
 	int num_fx;
 	int idx, i;
 
-	if (!dspload_is_loaded(codec))
+	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
 	/* out, in effects + voicefx */
-- 
1.8.1.3.605.g02339dd
