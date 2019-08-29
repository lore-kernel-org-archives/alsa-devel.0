From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 6/7] ALSA: hda/hdmi - complete
	pcm_setup_pin without snd_pcm link
Date: Thu, 29 Aug 2019 16:53:47 +0300
Message-ID: <20190829135348.23569-7-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1937DF89893
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:24 +0200 (CEST)
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

When used with e.g. SOF, the PCM entity is handled by ASoC and
there is no direct link from the HDA codec to the snd_pcm_t
object. Remaining configuration steps of hdmi_pcm_setup_pin()
should still be done in this case.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4372c87c48f0..65afb833c125 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1386,8 +1386,6 @@ static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
 		pcm = get_pcm_rec(spec, per_pin->pcm_idx);
 	else
 		return;
-	if (!pcm->pcm)
-		return;
 	if (!test_bit(per_pin->pcm_idx, &spec->pcm_in_use))
 		return;
 
@@ -1408,8 +1406,10 @@ static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
 	snd_hda_spdif_ctls_assign(codec, per_pin->pcm_idx, hinfo->nid);
 
 	non_pcm = check_non_pcm_per_cvt(codec, hinfo->nid);
-	if (substream->runtime)
-		per_pin->channels = substream->runtime->channels;
+	if (pcm->pcm) {
+		if (substream->runtime)
+			per_pin->channels = substream->runtime->channels;
+	}
 	per_pin->setup = true;
 	per_pin->mux_idx = mux_idx;
 
-- 
2.17.1
