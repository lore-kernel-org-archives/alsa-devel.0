From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH1/2] hda: add access to jack functions
Date: Mon, 20 Oct 2008 17:40:08 -0400
Message-ID: <48FCFAB8.9030407@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id AF99824651
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 23:40:34 +0200 (CEST)
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

Removed 'static' declaration from get_jack_location() to be accessed via the
codec patches. Also added jack location and type reporting functions for use in
the jack abstraction layer implementations.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4a08c31..10f26e0 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -383,6 +383,9 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
 /*
  * get widget capabilities
  */
+const char *get_jack_connectivity(u32 cfg);
+const char *get_jack_type(u32 cfg);
+const char *get_jack_location(u32 cfg);
 static inline u32 get_wcaps(struct hda_codec *codec, hda_nid_t nid)
 {
 	if (nid < codec->start_nid ||
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 64ab19f..b77c1b1 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -145,7 +145,7 @@ static void print_pcm_caps(struct snd_info_buffer *buffer,
 	print_pcm_formats(buffer, stream);
 }

-static const char *get_jack_location(u32 cfg)
+const char *get_jack_location(u32 cfg)
 {
 	static char *bases[7] = {
 		"N/A", "Rear", "Front", "Left", "Right", "Top", "Bottom",
@@ -171,6 +171,26 @@ static const char *get_jack_location(u32 cfg)
 	return "UNKNOWN";
 }

+const char *get_jack_connectivity(u32 cfg)
+{
+	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
+
+	return jack_locations[(cfg >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3];
+}
+
+const char *get_jack_type(u32 cfg)
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
 static const char *get_jack_connection(u32 cfg)
 {
 	static char *names[16] = {
@@ -206,13 +226,6 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
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
@@ -274,8 +287,8 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 	caps = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
 	snd_iprintf(buffer, "  Pin Default 0x%08x: [%s] %s at %s %s\n", caps,
 		    jack_conns[(caps & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT],
-		    jack_types[(caps & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT],
-		    jack_locations[(caps >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3],
+		    get_jack_type(caps),
+		    get_jack_connectivity(caps),
 		    get_jack_location(caps));
 	snd_iprintf(buffer, "    Conn = %s, Color = %s\n",
 		    get_jack_connection(caps),
