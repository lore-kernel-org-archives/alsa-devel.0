From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix possible NULL pointer
	dereference" to the asoc tree
Date: Wed, 08 Nov 2017 21:32:41 +0000
Message-ID: <E1eCXxh-0005SB-Ql@debutante>
References: <20171107104626.25800-11-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A5C267665
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:45 +0100 (CET)
In-Reply-To: <20171107104626.25800-11-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix possible NULL pointer dereference

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eb50fa1739a63cc4b202b40a62d71055a2d7b80c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 7 Nov 2017 16:16:25 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix possible NULL pointer dereference

Pointers hdac_hdmi_pcm and hda_device_id can be NULL, so add check for
valid pointer to avoid NULL pointer dereference.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 6f3ff15c0962..0c0aa6182502 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1895,6 +1895,9 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_port *port;
 
+	if (!pcm)
+		return;
+
 	if (list_empty(&pcm->port_list))
 		return;
 
@@ -1913,6 +1916,9 @@ static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 
+	if (!pcm)
+		return false;
+
 	if (list_empty(&pcm->port_list))
 		return false;
 
@@ -1926,6 +1932,9 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_port *port;
 
+	if (!pcm)
+		return 0;
+
 	if (list_empty(&pcm->port_list))
 		return 0;
 
@@ -1979,6 +1988,9 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
 	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
 
+	if (!hdac_id)
+		return -ENODEV;
+
 	if (hdac_id->driver_data)
 		hdmi_priv->drv_data =
 			(struct hdac_hdmi_drv_data *)hdac_id->driver_data;
-- 
2.15.0
