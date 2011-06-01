From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/6] ALSA: hda: Gate ELD usage only by whether
	ELD is valid
Date: Wed,  1 Jun 2011 11:14:16 -0600
Message-ID: <1306948461-2402-2-git-send-email-swarren@nvidia.com>
References: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C70591038BC
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:35 +0200 (CEST)
In-Reply-To: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, wfg@linux.intel.com
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>, ndaga@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's perfectly valid for an ELD to contain no SADs. This simply means that
only basic audio is supoprted.

In this case, we still want to limit a PCM's capabilities based on the ELD.

History:

* Originally, ELD application was limited solely by sad_count>0, which
  was used to check that an ELD had been read.
* Later, eld_valid was added to the conditions to satisfy.

This change removes the original sad_count>0 check, which when squashed
with the above two changes ends up replacing if (sad_count) with
if (eld_valid).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bd0ae69..8ccec72 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -816,7 +816,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 		*codec_pars = *hinfo;
 
 	eld = &spec->sink_eld[idx];
-	if (!static_hdmi_pcm && eld->eld_valid && eld->sad_count > 0) {
+	if (!static_hdmi_pcm && eld->eld_valid) {
 		hdmi_eld_update_pcm_info(eld, hinfo, codec_pars);
 		if (hinfo->channels_min > hinfo->channels_max ||
 		    !hinfo->rates || !hinfo->formats)
-- 
1.7.0.4
