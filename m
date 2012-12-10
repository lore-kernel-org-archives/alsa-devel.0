From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 2/2]: ALSA: VIA HDA: Add support for codec
	VT1808
Date: Mon, 10 Dec 2012 16:23:46 +0800
Message-ID: <50C59C12.8020400@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
 by alsa0.perex.cz (Postfix) with ESMTP id B481C265266
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 09:23:49 +0100 (CET)
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
Cc: tiwai@suse.de, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Add support for codec VT1808.

Add support for new codec VT1808, which is similiar with VT1705CF.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound/sound/pci/hda/patch_via.c
===================================================================
--- sound.orig/sound/pci/hda/patch_via.c	2012-12-10 15:09:52.000000000 +0800
+++ sound/sound/pci/hda/patch_via.c	2012-12-10 15:12:50.000000000 +0800
@@ -77,6 +77,7 @@
  	VT1812,
  	VT1802,
  	VT1705CF,
+	VT1808,
  	CODEC_TYPES,
  };
  
@@ -300,6 +301,8 @@
  		codec_type = VT1802;
  	else if (dev_id == 0x4760)
  		codec_type = VT1705CF;
+	else if (dev_id == 0x4761 || dev_id == 0x4762)
+		codec_type = VT1808;
  	else
  		codec_type = UNKNOWN;
  	return codec_type;
@@ -1112,6 +1115,7 @@
  		parm = enable ? 0x00 : 0xe0; /* 0x00: 4/40x, 0xe0: 1x */
  		break;
  	case VT1705CF:
+	case VT1808:
  		verb = 0xf82;
  		parm = enable ? 0x00 : 0xe0;  /* 0x00: 4/40x, 0xe0: 1x */
  		break;
@@ -4061,6 +4065,10 @@
  		.patch = patch_vt2002P},
  	{ .id = 0x11064760, .name = "VT1705CF",
  		.patch = patch_vt3476},
+	{ .id = 0x11064761, .name = "VT1708SCE",
+		.patch = patch_vt3476},
+	{ .id = 0x11064762, .name = "VT1808",
+		.patch = patch_vt3476},
  	{} /* terminator */
  };
  
