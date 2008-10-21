From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH3/4] hda: add snd_hda_get_jack* functions
Date: Tue, 21 Oct 2008 13:27:20 -0400
Message-ID: <48FE10F8.1040003@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id E0B2C247EE
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 19:27:46 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add snd_hda_get_jack* functions for reporting jack location, type, and
connectivity type.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9a8adc6..eaa8b56 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -107,6 +107,52 @@ static void hda_keep_power_on(struct hda_codec *codec);
 static inline void hda_keep_power_on(struct hda_codec *codec) {}
 #endif

+const char *snd_hda_get_jack_location(u32 cfg)
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
+const char *snd_hda_get_jack_connectivity(u32 cfg)
+{
+	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
+
+	return jack_locations[(cfg >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3];
+}
+
+const char *snd_hda_get_jack_type(u32 cfg)
+{
+	static char *jack_types[16] = {
+		"Line Out", "Speaker", "HP Out", "CD",
+		"SPDIF Out", "Digital Out", "Modem Line", "Modem Hand",
+		"Line In", "Aux", "Mic", "Telephony",
+		"SPDIF In", "Digitial In", "Reserved", "Other"
+	};
+
+	return jack_types[(cfg & AC_DEFCFG_DEVICE)
+				>> AC_DEFCFG_DEVICE_SHIFT];
+}
+
 /**
  * snd_hda_codec_read - send a command and get the response
  * @codec: the HDA codec
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index a77ba22..0a42034 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -859,6 +859,13 @@ int snd_hda_suspend(struct hda_bus *bus, pm_message_t state);
 int snd_hda_resume(struct hda_bus *bus);
 #endif

+/*
+ * get widget information
+ */
+const char *get_jack_location(u32 cfg);
+const char *get_jack_connectivity(u32 cfg);
+const char *get_jack_type(u32 cfg);
+
 /*
  * power saving
  */
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 64ab19f..b36d4d0 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -145,32 +145,6 @@ static void print_pcm_caps(struct snd_info_buffer *buffer,
 	print_pcm_formats(buffer, stream);
 }

-static const char *get_jack_location(u32 cfg)
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
-
 static const char *get_jack_connection(u32 cfg)
 {
 	static char *names[16] = {
@@ -206,13 +180,6 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 			   int *supports_vref)
 {
 	static char *jack_conns[4] = { "Jack", "N/A", "Fixed", "Both" };
-	static char *jack_types[16] = {
-		"Line Out", "Speaker", "HP Out", "CD",
-		"SPDIF Out", "Digital Out", "Modem Line", "Modem Hand",
-		"Line In", "Aux", "Mic", "Telephony",
-		"SPDIF In", "Digitial In", "Reserved", "Other"
-	};
-	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
 	unsigned int caps, val;

 	caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
@@ -274,9 +241,9 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 	caps = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
 	snd_iprintf(buffer, "  Pin Default 0x%08x: [%s] %s at %s %s\n", caps,
 		    jack_conns[(caps & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT],
-		    jack_types[(caps & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT],
-		    jack_locations[(caps >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3],
-		    get_jack_location(caps));
+		    snd_hda_get_jack_type(caps),
+		    snd_hda_get_jack_connectivity(caps),
+		    snd_hda_get_jack_location(caps));
 	snd_iprintf(buffer, "    Conn = %s, Color = %s\n",
 		    get_jack_connection(caps),
 		    get_jack_color(caps));
