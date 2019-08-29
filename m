From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 4/7] ALSA: hda/hdmi - allow control
	creation without a linked pcm
Date: Thu, 29 Aug 2019 16:53:45 +0300
Message-ID: <20190829135348.23569-5-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C55CCF8988E
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:19 +0200 (CEST)
In-Reply-To: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Fix the logic in generic_hdmi_build_controls() to identify
unused hda_pcm entries by searching for SNDRV_PCM_INVALID_DEVICE.
This matches with logic in snd_hda_codec_build_pcms().

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 83b8b9d27711..f2022f75afb6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2174,11 +2174,13 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hda_pcm *hda_pcm;
 	int dev, err;
 	int pin_idx, pcm_idx;
 
 	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
-		if (!get_pcm_rec(spec, pcm_idx)->pcm) {
+		hda_pcm = get_pcm_rec(spec, pcm_idx);
+		if (hda_pcm->device == SNDRV_PCM_INVALID_DEVICE) {
 			/* no PCM: mark this for skipping permanently */
 			set_bit(pcm_idx, &spec->pcm_bitmap);
 			continue;
-- 
2.17.1
