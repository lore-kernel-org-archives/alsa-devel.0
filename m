From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 3/7] HDA patch_via.c: Fix inversion of surround
	and side	channels
Date: Tue, 9 Sep 2008 15:53:36 +0800
Message-ID: <20080909075336.GF9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 545BB10384E
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBO-0007ue-VU
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:43 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcy2a-0004yd-7I
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:53:36 +0800
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

[ALSA] HDA VIA: Fix inversion of Surround and Side Channels

In the current driver, there is a consistent mistake between the SURROUND and
the SIDE channels.  This patch fixes it.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -30,6 +30,7 @@
 /* 2007-09-12  Lydia Wang  Add EAPD enable during driver initialization      */
 /* 2007-09-17  Lydia Wang  Add VT1708B codec support                        */
 /* 2007-11-14  Lydia Wang  Add VT1708A codec HP and CD pin connect config    */
+/* 2008-02-03  Lydia Wang  Fix Rear channels and Back channels inverse issue */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -661,10 +662,10 @@
 				spec->multiout.dac_nids[i] = 0x12;
 				break;
 			case AUTO_SEQ_SURROUND:
-				spec->multiout.dac_nids[i] = 0x13;
+				spec->multiout.dac_nids[i] = 0x11;
 				break;
 			case AUTO_SEQ_SIDE:
-				spec->multiout.dac_nids[i] = 0x11;
+				spec->multiout.dac_nids[i] = 0x13;
 				break;
 			}
 		}
@@ -689,7 +690,7 @@
 			continue;
 		
 		if (i != AUTO_SEQ_FRONT)
-			nid_vol = 0x1b - i + 1;
+			nid_vol = 0x18 + i;
 
 		if (i == AUTO_SEQ_CENLFE) {
 			/* Center/LFE */
@@ -1120,11 +1121,11 @@
 					break;
 				case AUTO_SEQ_SURROUND:
 					/* AOW3 */
-					spec->multiout.dac_nids[i] = 0x27;
+					spec->multiout.dac_nids[i] = 0x11;
 					break;
 				case AUTO_SEQ_SIDE:
 					/* AOW1 */
-					spec->multiout.dac_nids[i] = 0x11;
+					spec->multiout.dac_nids[i] = 0x27;
 					break;
 				default:
 					break;
@@ -1233,26 +1234,26 @@
 		} else if (i == AUTO_SEQ_SURROUND) {
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
-					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			sprintf(name, "%s Playback Switch", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
-					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 		} else if (i == AUTO_SEQ_SIDE) {
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
-					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			sprintf(name, "%s Playback Switch", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
-					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
@@ -1693,10 +1694,10 @@
 				spec->multiout.dac_nids[i] = 0x24;
 				break;
 			case AUTO_SEQ_SURROUND:
-				spec->multiout.dac_nids[i] = 0x25;
+				spec->multiout.dac_nids[i] = 0x11;
 				break;
 			case AUTO_SEQ_SIDE:
-				spec->multiout.dac_nids[i] = 0x11;
+				spec->multiout.dac_nids[i] = 0x25;
 				break;
 			}
 		}
@@ -1711,7 +1712,7 @@
 {
 	char name[32];
 	static const char *chname[4] = { "Front", "Surround", "C/LFE", "Side" };
-	hda_nid_t nid_vols[] = {0x16, 0x27, 0x26, 0x18};
+	hda_nid_t nid_vols[] = {0x16, 0x18, 0x26, 0x27};
 	hda_nid_t nid, nid_vol = 0;
 	int i, err;
 
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
