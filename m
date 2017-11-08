From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix possible memory leak on
	parse and map nid failure" to the asoc tree
Date: Wed, 08 Nov 2017 21:32:33 +0000
Message-ID: <E1eCXxZ-0005R4-HZ@debutante>
References: <20171107104626.25800-12-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BCD5F267668
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:45 +0100 (CET)
In-Reply-To: <20171107104626.25800-12-guneshwor.o.singh@intel.com>
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

   ASoC: hdac_hdmi: Fix possible memory leak on parse and map nid failure

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

>From 1c0a7de226660b0306b54aaf2cb52312e74723eb Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 7 Nov 2017 16:16:26 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix possible memory leak on parse and map
 nid failure

During failure, widgets in cvt_list and pin_list are not freed. So fix
the possible memory leak by freeing them when failure occurs.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0c0aa6182502..f3b4f4dfae6a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1453,6 +1453,8 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 	int i, num_nodes;
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_cvt *temp_cvt, *cvt_next;
+	struct hdac_hdmi_pin *temp_pin, *pin_next;
 	int ret;
 
 	hdac_hdmi_skl_enable_all_pins(hdac);
@@ -1482,32 +1484,54 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		case AC_WID_AUD_OUT:
 			ret = hdac_hdmi_add_cvt(edev, nid);
 			if (ret < 0)
-				return ret;
+				goto free_widgets;
 			break;
 
 		case AC_WID_PIN:
 			ret = hdac_hdmi_add_pin(edev, nid);
 			if (ret < 0)
-				return ret;
+				goto free_widgets;
 			break;
 		}
 	}
 
 	hdac->end_nid = nid;
 
-	if (!hdmi->num_pin || !hdmi->num_cvt)
-		return -EIO;
+	if (!hdmi->num_pin || !hdmi->num_cvt) {
+		ret = -EIO;
+		goto free_widgets;
+	}
 
 	ret = hdac_hdmi_create_dais(hdac, dais, hdmi, hdmi->num_cvt);
 	if (ret) {
 		dev_err(&hdac->dev, "Failed to create dais with err: %d\n",
 							ret);
-		return ret;
+		goto free_widgets;
 	}
 
 	*num_dais = hdmi->num_cvt;
+	ret = hdac_hdmi_init_dai_map(edev);
+	if (ret < 0)
+		goto free_widgets;
 
-	return hdac_hdmi_init_dai_map(edev);
+	return ret;
+
+free_widgets:
+	list_for_each_entry_safe(temp_cvt, cvt_next, &hdmi->cvt_list, head) {
+		list_del(&temp_cvt->head);
+		kfree(temp_cvt->name);
+		kfree(temp_cvt);
+	}
+
+	list_for_each_entry_safe(temp_pin, pin_next, &hdmi->pin_list, head) {
+		for (i = 0; i < temp_pin->num_ports; i++)
+			temp_pin->ports[i].pin = NULL;
+		kfree(temp_pin->ports);
+		list_del(&temp_pin->head);
+		kfree(temp_pin);
+	}
+
+	return ret;
 }
 
 static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
-- 
2.15.0
