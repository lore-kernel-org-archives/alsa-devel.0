From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 1/3] HDA VIA: Fix crash on codecs without
	Headphone
Date: Mon, 15 Sep 2008 22:41:31 +0800
Message-ID: <20080915144131.GB8061@prithivi.gnumonks.org>
References: <20080915144005.GA8061@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 485B624134
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 16:43:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080915144005.GA8061@prithivi.gnumonks.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, Logan Li <loganli@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Fix crash on codecs without Headphone

Don't enumerate via_hp_mixer while hp_mux is null (headphone does not exist),
to fix the crash of via_independent_hp_info (via_hp_mixer's .info), which will
reference hp_mux.

Signed-off-by: Logan Li <LoganLi@viatech.com.cn>
Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

--- a/sound/pci/hda/patch_via.c	2008-09-10 00:55:25.000000000 +0800
+++ b/sound/pci/hda/patch_via.c	2008-09-15 14:07:29.000000000 +0800
@@ -1303,7 +1303,8 @@
 
 	spec->input_mux = &spec->private_imux[0];
 
-	spec->mixers[spec->num_mixers++] = via_hp_mixer;
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -1773,6 +1774,9 @@
 
 	spec->input_mux = &spec->private_imux[0];
 
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
+
 	return 1;
 }
 
@@ -2314,7 +2318,8 @@
 
 	spec->input_mux = &spec->private_imux[0];
 
-	spec->mixers[spec->num_mixers++] = via_hp_mixer;
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -2770,7 +2775,8 @@
 
 	spec->input_mux = &spec->private_imux[0];
 
-	spec->mixers[spec->num_mixers++] = via_hp_mixer;
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -3100,7 +3106,8 @@
 
 	spec->input_mux = &spec->private_imux[0];
 
-	spec->mixers[spec->num_mixers++] = via_hp_mixer;
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }


-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
