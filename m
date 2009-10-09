From: <LoganLi@viatech.com.cn>
Subject: [PATCH 7/30] ALSA: HDA VIA: Remove unused argument of
	via_new_analog_input
Date: Fri, 9 Oct 2009 18:40:17 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C34@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C00A103AB5
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:11 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Remove unused argument of via_new_analog_input

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -317,8 +317,8 @@
 }
 
 /* create input playback/capture controls for the given pin */
-static int via_new_analog_input(struct via_spec *spec, hda_nid_t pin,
-				const char *ctlname, int idx, int
mix_nid)
+static int via_new_analog_input(struct via_spec *spec, const char
*ctlname,
+				int idx, int mix_nid)
 {
 	char name[32];
 	int err;
@@ -1480,8 +1480,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
labels[i],
-					   idx, 0x17);
+		err = via_new_analog_input(spec, labels[i], idx, 0x17);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -2013,8 +2012,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
labels[i],
-					   idx, 0x18);
+		err = via_new_analog_input(spec, labels[i], idx, 0x18);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -2575,8 +2573,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
labels[i],
-					   idx, 0x16);
+		err = via_new_analog_input(spec, labels[i], idx, 0x16);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -3047,8 +3044,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
labels[i],
-					   idx, 0x16);
+		err = via_new_analog_input(spec, labels[i], idx, 0x16);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -3401,8 +3397,7 @@
 			idx = 3;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
-					   labels[i], idx, 0x1A);
+		err = via_new_analog_input(spec, labels[i], idx, 0x1A);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
