From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: parse eld for channel map
	capability" to the asoc tree
Date: Thu, 28 Apr 2016 18:55:29 +0100
Message-ID: <E1avq9x-00033G-Ny@debutante>
References: <1460454977-30057-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46CCF26668F
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:55:34 +0200 (CEST)
In-Reply-To: <1460454977-30057-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: parse eld for channel map capability

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b7756edeb7d03b675e10b4862dccc8deb4b0ca17 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:28 +0530
Subject: [PATCH] ASoC: hdac_hdmi: parse eld for channel map capability

This patch parses ELD speaker allocation data block to find
sink's chmap capability.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 26f9459cb3bc..64ffe93b0f7b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -60,11 +60,17 @@ struct hdac_hdmi_cvt {
 	struct hdac_hdmi_cvt_params params;
 };
 
+/* Currently only spk_alloc, more to be added */
+struct hdac_hdmi_parsed_eld {
+	u8 spk_alloc;
+};
+
 struct hdac_hdmi_eld {
 	bool	monitor_present;
 	bool	eld_valid;
 	int	eld_size;
 	char    eld_buffer[ELD_MAX_SIZE];
+	struct	hdac_hdmi_parsed_eld info;
 };
 
 struct hdac_hdmi_pin {
@@ -1008,6 +1014,12 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
 }
 
+static void hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
+			struct hdac_hdmi_pin *pin)
+{
+	pin->eld.info.spk_alloc = pin->eld.eld_buffer[DRM_ELD_SPEAKER];
+}
+
 static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 {
 	struct hdac_ext_device *edev = pin->edev;
@@ -1065,6 +1077,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 
 				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
 			}
+			hdac_hdmi_parse_eld(edev, pin);
 
 			print_hex_dump_bytes("ELD: ", DUMP_PREFIX_OFFSET,
 					pin->eld.eld_buffer, pin->eld.eld_size);
-- 
2.8.0.rc3
