From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 1/9] ASoC: hdac_hdmi: parse eld for channel
	map capability
Date: Tue, 12 Apr 2016 15:26:09 +0530
Message-ID: <1460454977-30057-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EA147265177
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 11:57:11 +0200 (CEST)
In-Reply-To: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch parses ELD speaker allocation data block to find
sink's chmap capability.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index aaa038f..81ac173 100644
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
1.9.1
