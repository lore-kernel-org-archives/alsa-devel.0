From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 7/31] HDA patch_via.c: Remove unused
	argument of via_new_analog_input
Date: Thu, 8 Oct 2009 13:43:15 +0800
Message-ID: <16685ee0910072243gbb1ae8fu8c42d0ef67afcedf@mail.gmail.com>
References: <16685ee0910050725i2274722bg22f57bf0d8061e6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 88CF8103962
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:43:15 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so1534448fga.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:43:15 -0700 (PDT)
In-Reply-To: <16685ee0910050725i2274722bg22f57bf0d8061e6b@mail.gmail.com>
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Remove unused argument of via_new_analog_input

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -317,8 +317,8 @@
 }

 /* create input playback/capture controls for the given pin */
-static int via_new_analog_input(struct via_spec *spec, hda_nid_t pin,
-				const char *ctlname, int idx, int mix_nid)
+static int via_new_analog_input(struct via_spec *spec, const char *ctlname,
+				int idx, int mix_nid)
 {
 	char name[32];
 	int err;
@@ -1480,8 +1480,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i], labels[i],
-					   idx, 0x17);
+		err = via_new_analog_input(spec, labels[i], idx, 0x17);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -2014,8 +2013,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i], labels[i],
-					   idx, 0x18);
+		err = via_new_analog_input(spec, labels[i], idx, 0x18);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -2576,8 +2574,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i], labels[i],
-					   idx, 0x16);
+		err = via_new_analog_input(spec, labels[i], idx, 0x16);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -3048,8 +3045,7 @@
 			idx = 1;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i], labels[i],
-					   idx, 0x16);
+		err = via_new_analog_input(spec, labels[i], idx, 0x16);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
@@ -3402,8 +3398,7 @@
 			idx = 3;
 			break;
 		}
-		err = via_new_analog_input(spec, cfg->input_pins[i],
-					   labels[i], idx, 0x1A);
+		err = via_new_analog_input(spec, labels[i], idx, 0x1A);
 		if (err < 0)
 			return err;
 		imux->items[imux->num_items].label = labels[i];
