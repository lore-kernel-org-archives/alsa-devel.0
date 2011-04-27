From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/1] ALSA: VIA HDA: Fix Smart5.1 isn't useful
 for 6 audio jacks motherboard
Date: Wed, 27 Apr 2011 17:44:16 +0800
Message-ID: <4DB7E570.5060503@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id E975E24154
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 11:44:33 +0200 (CEST)
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, haraldwelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Fix Smart5.1 isn't  useful for 6 audio jacks motherboard.

For some motherboards with 5 or 6 audio jacks which had six or eight multiple
channels output, smart5.1 item is no useful and should be removed.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c    2011-04-27 16:48:03.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c    2011-04-27 17:01:22.000000000 +0800
@@ -1021,6 +1021,10 @@
     hda_nid_t nid;
     int i;
 
+    if (!cfg)
+        return 0;
+    if (cfg->line_outs > 2)
+        return 0;
     knew = via_clone_control(spec, &via_smart51_mixer[0]);
     if (knew == NULL)
         return -ENOMEM;
