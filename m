From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Make some helper functions
	local
Date: Mon, 17 Aug 2015 15:44:08 +0200
Message-ID: <1439819051-32166-2-git-send-email-tiwai@suse.de>
References: <1439819051-32166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DCCD1260464
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 15:44:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A8E13AD9E
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 13:44:25 +0000 (UTC)
In-Reply-To: <1439819051-32166-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

A few helper functions to convert the pin information to strings have
been exported with assumption that they were used by other drivers.
But they are referred only in the proc interface in the end.

Let's make them local so that we can get rid of a few exports.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 70 -----------------------------------------------
 sound/pci/hda/hda_codec.h |  7 -----
 sound/pci/hda/hda_proc.c  | 65 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 80 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d78fa713c103..00c9a42af656 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -53,76 +53,6 @@
 #define codec_has_clkstop(codec) \
 	((codec)->core.power_caps & AC_PWRST_CLKSTOP)
 
-/**
- * snd_hda_get_jack_location - Give a location string of the jack
- * @cfg: pin default config value
- *
- * Parse the pin default config value and returns the string of the
- * jack location, e.g. "Rear", "Front", etc.
- */
-const char *snd_hda_get_jack_location(u32 cfg)
-{
-	static char *bases[7] = {
-		"N/A", "Rear", "Front", "Left", "Right", "Top", "Bottom",
-	};
-	static unsigned char specials_idx[] = {
-		0x07, 0x08,
-		0x17, 0x18, 0x19,
-		0x37, 0x38
-	};
-	static char *specials[] = {
-		"Rear Panel", "Drive Bar",
-		"Riser", "HDMI", "ATAPI",
-		"Mobile-In", "Mobile-Out"
-	};
-	int i;
-	cfg = (cfg & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT;
-	if ((cfg & 0x0f) < 7)
-		return bases[cfg & 0x0f];
-	for (i = 0; i < ARRAY_SIZE(specials_idx); i++) {
-		if (cfg == specials_idx[i])
-			return specials[i];
-	}
-	return "UNKNOWN";
-}
-EXPORT_SYMBOL_GPL(snd_hda_get_jack_location);
-
-/**
- * snd_hda_get_jack_connectivity - Give a connectivity string of the jack
- * @cfg: pin default config value
- *
- * Parse the pin default config value and returns the string of the
- * jack connectivity, i.e. external or internal connection.
- */
-const char *snd_hda_get_jack_connectivity(u32 cfg)
-{
-	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
-
-	return jack_locations[(cfg >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3];
-}
-EXPORT_SYMBOL_GPL(snd_hda_get_jack_connectivity);
-
-/**
- * snd_hda_get_jack_type - Give a type string of the jack
- * @cfg: pin default config value
- *
- * Parse the pin default config value and returns the string of the
- * jack type, i.e. the purpose of the jack, such as Line-Out or CD.
- */
-const char *snd_hda_get_jack_type(u32 cfg)
-{
-	static char *jack_types[16] = {
-		"Line Out", "Speaker", "HP Out", "CD",
-		"SPDIF Out", "Digital Out", "Modem Line", "Modem Hand",
-		"Line In", "Aux", "Mic", "Telephony",
-		"SPDIF In", "Digital In", "Reserved", "Other"
-	};
-
-	return jack_types[(cfg & AC_DEFCFG_DEVICE)
-				>> AC_DEFCFG_DEVICE_SHIFT];
-}
-EXPORT_SYMBOL_GPL(snd_hda_get_jack_type);
-
 /*
  * Send and receive a verb - passed to exec_verb override for hdac_device
  */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 12837abbbbe5..2970413f18a0 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -469,13 +469,6 @@ int hda_call_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 }
 
 /*
- * get widget information
- */
-const char *snd_hda_get_jack_connectivity(u32 cfg);
-const char *snd_hda_get_jack_type(u32 cfg);
-const char *snd_hda_get_jack_location(u32 cfg);
-
-/*
  * power saving
  */
 #define snd_hda_power_up(codec)		snd_hdac_power_up(&(codec)->core)
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index baaf7ed06875..3a470f7b9f41 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -269,6 +269,65 @@ static const char *get_jack_color(u32 cfg)
 		return "UNKNOWN";
 }
 
+/*
+ * Parse the pin default config value and returns the string of the
+ * jack location, e.g. "Rear", "Front", etc.
+ */
+static const char *get_jack_location(u32 cfg)
+{
+	static char *bases[7] = {
+		"N/A", "Rear", "Front", "Left", "Right", "Top", "Bottom",
+	};
+	static unsigned char specials_idx[] = {
+		0x07, 0x08,
+		0x17, 0x18, 0x19,
+		0x37, 0x38
+	};
+	static char *specials[] = {
+		"Rear Panel", "Drive Bar",
+		"Riser", "HDMI", "ATAPI",
+		"Mobile-In", "Mobile-Out"
+	};
+	int i;
+
+	cfg = (cfg & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT;
+	if ((cfg & 0x0f) < 7)
+		return bases[cfg & 0x0f];
+	for (i = 0; i < ARRAY_SIZE(specials_idx); i++) {
+		if (cfg == specials_idx[i])
+			return specials[i];
+	}
+	return "UNKNOWN";
+}
+
+/*
+ * Parse the pin default config value and returns the string of the
+ * jack connectivity, i.e. external or internal connection.
+ */
+static const char *get_jack_connectivity(u32 cfg)
+{
+	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
+
+	return jack_locations[(cfg >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3];
+}
+
+/*
+ * Parse the pin default config value and returns the string of the
+ * jack type, i.e. the purpose of the jack, such as Line-Out or CD.
+ */
+static const char *get_jack_type(u32 cfg)
+{
+	static char *jack_types[16] = {
+		"Line Out", "Speaker", "HP Out", "CD",
+		"SPDIF Out", "Digital Out", "Modem Line", "Modem Hand",
+		"Line In", "Aux", "Mic", "Telephony",
+		"SPDIF In", "Digital In", "Reserved", "Other"
+	};
+
+	return jack_types[(cfg & AC_DEFCFG_DEVICE)
+				>> AC_DEFCFG_DEVICE_SHIFT];
+}
+
 static void print_pin_caps(struct snd_info_buffer *buffer,
 			   struct hda_codec *codec, hda_nid_t nid,
 			   int *supports_vref)
@@ -340,9 +399,9 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 	caps = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
 	snd_iprintf(buffer, "  Pin Default 0x%08x: [%s] %s at %s %s\n", caps,
 		    jack_conns[(caps & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT],
-		    snd_hda_get_jack_type(caps),
-		    snd_hda_get_jack_connectivity(caps),
-		    snd_hda_get_jack_location(caps));
+		    get_jack_type(caps),
+		    get_jack_connectivity(caps),
+		    get_jack_location(caps));
 	snd_iprintf(buffer, "    Conn = %s, Color = %s\n",
 		    get_jack_connection(caps),
 		    get_jack_color(caps));
-- 
2.5.0
