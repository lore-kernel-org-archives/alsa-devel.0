From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda/proc - Add const to possible
	places
Date: Mon, 17 Aug 2015 15:44:09 +0200
Message-ID: <1439819051-32166-3-git-send-email-tiwai@suse.de>
References: <1439819051-32166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A05260474
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 15:44:26 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BB5E6ADDF
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

Many arrays in hda_proc.c are string arrays that should be covered by
const prefix for increasing the safety and reducing the size.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_proc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 3a470f7b9f41..5efcffc32c50 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -36,7 +36,7 @@ MODULE_PARM_DESC(dump_coef, "Dump processing coefficients in codec proc file (-1
 #define param_read(codec, nid, parm) \
 	snd_hdac_read_parm_uncached(&(codec)->core, nid, parm)
 
-static char *bits_names(unsigned int bits, char *names[], int size)
+static char *bits_names(unsigned int bits, const char * const names[], int size)
 {
 	int i, n;
 	static char buf[128];
@@ -53,7 +53,7 @@ static char *bits_names(unsigned int bits, char *names[], int size)
 
 static const char *get_wid_type_name(unsigned int wid_value)
 {
-	static char *names[16] = {
+	static const char * const names[16] = {
 		[AC_WID_AUD_OUT] = "Audio Output",
 		[AC_WID_AUD_IN] = "Audio Input",
 		[AC_WID_AUD_MIX] = "Audio Mixer",
@@ -241,7 +241,7 @@ static void print_pcm_caps(struct snd_info_buffer *buffer,
 
 static const char *get_jack_connection(u32 cfg)
 {
-	static char *names[16] = {
+	static const char * const names[16] = {
 		"Unknown", "1/8", "1/4", "ATAPI",
 		"RCA", "Optical","Digital", "Analog",
 		"DIN", "XLR", "RJ11", "Comb",
@@ -256,7 +256,7 @@ static const char *get_jack_connection(u32 cfg)
 
 static const char *get_jack_color(u32 cfg)
 {
-	static char *names[16] = {
+	static const char * const names[16] = {
 		"Unknown", "Black", "Grey", "Blue",
 		"Green", "Red", "Orange", "Yellow",
 		"Purple", "Pink", NULL, NULL,
@@ -275,15 +275,15 @@ static const char *get_jack_color(u32 cfg)
  */
 static const char *get_jack_location(u32 cfg)
 {
-	static char *bases[7] = {
+	static const char * const bases[7] = {
 		"N/A", "Rear", "Front", "Left", "Right", "Top", "Bottom",
 	};
-	static unsigned char specials_idx[] = {
+	static const unsigned char specials_idx[] = {
 		0x07, 0x08,
 		0x17, 0x18, 0x19,
 		0x37, 0x38
 	};
-	static char *specials[] = {
+	static const char * const specials[] = {
 		"Rear Panel", "Drive Bar",
 		"Riser", "HDMI", "ATAPI",
 		"Mobile-In", "Mobile-Out"
@@ -306,7 +306,9 @@ static const char *get_jack_location(u32 cfg)
  */
 static const char *get_jack_connectivity(u32 cfg)
 {
-	static char *jack_locations[4] = { "Ext", "Int", "Sep", "Oth" };
+	static const char * const jack_locations[4] = {
+		"Ext", "Int", "Sep", "Oth"
+	};
 
 	return jack_locations[(cfg >> (AC_DEFCFG_LOCATION_SHIFT + 4)) & 3];
 }
@@ -317,7 +319,7 @@ static const char *get_jack_connectivity(u32 cfg)
  */
 static const char *get_jack_type(u32 cfg)
 {
-	static char *jack_types[16] = {
+	static const char * const jack_types[16] = {
 		"Line Out", "Speaker", "HP Out", "CD",
 		"SPDIF Out", "Digital Out", "Modem Line", "Modem Hand",
 		"Line In", "Aux", "Mic", "Telephony",
@@ -332,7 +334,9 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 			   struct hda_codec *codec, hda_nid_t nid,
 			   int *supports_vref)
 {
-	static char *jack_conns[4] = { "Jack", "N/A", "Fixed", "Both" };
+	static const char * const jack_conns[4] = {
+		"Jack", "N/A", "Fixed", "Both"
+	};
 	unsigned int caps, val;
 
 	caps = param_read(codec, nid, AC_PAR_PIN_CAP);
@@ -537,7 +541,7 @@ static const char *get_pwr_state(u32 state)
 static void print_power_state(struct snd_info_buffer *buffer,
 			      struct hda_codec *codec, hda_nid_t nid)
 {
-	static char *names[] = {
+	static const char * const names[] = {
 		[ilog2(AC_PWRST_D0SUP)]		= "D0",
 		[ilog2(AC_PWRST_D1SUP)]		= "D1",
 		[ilog2(AC_PWRST_D2SUP)]		= "D2",
-- 
2.5.0
