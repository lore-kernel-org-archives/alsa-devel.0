From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 10/11] hda - show EPSS capability in proc
Date: Sun, 15 Nov 2009 19:32:29 +0800
Message-ID: <20091115114440.582244270@intel.com>
References: <20091115113219.606666087@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B931910387F
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:44 +0100 (CET)
Content-Disposition: inline; filename=hda-power-epss.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.h |    4 ++++
 sound/pci/hda/hda_proc.c  |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_codec.h	2009-11-15 19:28:28.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.h	2009-11-15 19:28:57.000000000 +0800
@@ -286,6 +286,10 @@ enum {
 #define AC_PWRST_D1SUP			(1<<1)
 #define AC_PWRST_D2SUP			(1<<2)
 #define AC_PWRST_D3SUP			(1<<3)
+#define AC_PWRST_D3COLDSUP		(1<<4)
+#define AC_PWRST_S3D3COLDSUP		(1<<29)
+#define AC_PWRST_CLKSTOP		(1<<30)
+#define AC_PWRST_EPSS			(1U<<31)
 
 /* Power state values */
 #define AC_PWRST_SETTING		(0xf<<0)
--- sound-2.6.orig/sound/pci/hda/hda_proc.c	2009-11-15 19:28:28.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_proc.c	2009-11-15 19:31:44.000000000 +0800
@@ -26,6 +26,21 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 
+static char *bits_names(unsigned int bits, char *names[], int size)
+{
+       int i, n;
+       static char buf[128];
+
+       for (i = 0, n = 0; i < size; i++) {
+               if (bits & (1U<<i) && names[i])
+                       n += snprintf(buf + n, sizeof(buf) - n, " %s",
+                                                               names[i]);
+       }
+       buf[n] = '\0';
+
+       return buf;
+}
+
 static const char *get_wid_type_name(unsigned int wid_value)
 {
 	static char *names[16] = {
@@ -363,8 +378,24 @@ static const char *get_pwr_state(u32 sta
 static void print_power_state(struct snd_info_buffer *buffer,
 			      struct hda_codec *codec, hda_nid_t nid)
 {
+	static char *names[] = {
+		[ilog2(AC_PWRST_D0SUP)]		= "D0",
+		[ilog2(AC_PWRST_D1SUP)]		= "D1",
+		[ilog2(AC_PWRST_D2SUP)]		= "D2",
+		[ilog2(AC_PWRST_D3SUP)]		= "D3",
+		[ilog2(AC_PWRST_D3COLDSUP)]	= "D3cold",
+		[ilog2(AC_PWRST_S3D3COLDSUP)]	= "S3D3cold",
+		[ilog2(AC_PWRST_CLKSTOP)]	= "CLKSTOP",
+		[ilog2(AC_PWRST_EPSS)]		= "EPSS",
+	};
+
+	int sup = snd_hda_param_read(codec, nid, AC_PAR_POWER_STATE);
 	int pwr = snd_hda_codec_read(codec, nid, 0,
 				     AC_VERB_GET_POWER_STATE, 0);
+	if (sup)
+		snd_iprintf(buffer, "  Power states: %s\n",
+			    bits_names(sup, names, ARRAY_SIZE(names)));
+
 	snd_iprintf(buffer, "  Power: setting=%s, actual=%s\n",
 		    get_pwr_state(pwr & AC_PWRST_SETTING),
 		    get_pwr_state((pwr & AC_PWRST_ACTUAL) >>
