From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: intel: skl_hda_dsp_common: create HDMI
	jack kctl
Date: Thu,  8 Aug 2019 14:27:34 -0500
Message-ID: <20190808192734.18286-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70EE2F800E3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 21:27:40 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch call snd_jack_add_new_kctl() to create the HDMI jack kctls.
Userspace needs these kctls to detect the hdmi monitor hotplug.

In /usr/share/alsa/ucm, the config file needs to assign a jack kctl to
"JackControl" to let PA get the jack hotplug status.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

This patch has been used by SOF-based solutions delivered in Q2 but
due to a confusion on my side was not upstreamed. Both Libin and Kai
confirmed it's required for PulseAudio to track jack events.

 sound/soc/intel/boards/skl_hda_dsp_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 55fd82e05e2c..58409b6e476e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -147,6 +147,11 @@ int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
 		if (err)
 			return err;
 
+		err = snd_jack_add_new_kctl(pcm->hdmi_jack.jack,
+					    jack_name, SND_JACK_AVOUT);
+		if (err)
+			dev_warn(component->dev, "failed creating Jack kctl\n");
+
 		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
 					  &pcm->hdmi_jack);
 		if (err < 0)
-- 
2.20.1
