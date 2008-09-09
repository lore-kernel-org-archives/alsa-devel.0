From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 1/7] HDA patch_via.c: cleanup
Date: Tue, 9 Sep 2008 15:40:38 +0800
Message-ID: <20080909074038.GD9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 1359810383F
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBO-0007uX-Ig
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:42 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcxq2-0004y0-3s
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:40:38 +0800
Content-Disposition: inline
In-Reply-To: <20080909073717.GC9638@prithivi.gnumonks.org>
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
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: various cleanup

* add extra parenthesis to make code more readable
* use kzalloc() for alloc+zero rather than kcalloc()
* ensure that AUTO_SEQ_* starts at 0 

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -77,7 +77,7 @@
 };
 
 enum {
-	AUTO_SEQ_FRONT,
+	AUTO_SEQ_FRONT = 0,
 	AUTO_SEQ_SURROUND,
 	AUTO_SEQ_CENLFE,
 	AUTO_SEQ_SIDE
@@ -283,11 +283,11 @@
 		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 					     0x18, &spec->cur_mux[adc_idx]);
 	else if ((IS_VT1709_10CH_VENDORID(vendor_id) ||
-		  IS_VT1709_6CH_VENDORID(vendor_id)) && adc_idx == 0)
+		  IS_VT1709_6CH_VENDORID(vendor_id)) && (adc_idx == 0))
 		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 					     0x19, &spec->cur_mux[adc_idx]);
 	else if ((IS_VT1708B_8CH_VENDORID(vendor_id) ||
-		  IS_VT1708B_4CH_VENDORID(vendor_id)) && adc_idx == 0)
+		  IS_VT1708B_4CH_VENDORID(vendor_id)) && (adc_idx == 0))
 		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 					     0x17, &spec->cur_mux[adc_idx]);
 	else
@@ -897,7 +898,7 @@
 	int err;
 
 	/* create a codec specific record */
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -1360,7 +1362,7 @@
 	int err;
 
 	/* create a codec specific record */
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -1451,7 +1453,7 @@
 	int err;
 
 	/* create a codec specific record */
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -1890,7 +1893,7 @@
 	int err;
 
 	/* create a codec specific record */
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -1939,7 +1942,7 @@
 	int err;
 
 	/* create a codec specific record */
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
