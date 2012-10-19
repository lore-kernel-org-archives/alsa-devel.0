From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 9/9] ALSA: hdspm - Fix coding style in CTL_ELEM
	macros
Date: Fri, 19 Oct 2012 17:42:30 +0200
Message-ID: <1350661350-5000-10-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

checkpatch.pl discourages the use of spaces at the beginning of lines.
Some of the CTL_ELEM defines were not properly indented.

This patch replaces the leading spaces by tabs. No functionality is
changed, the commit is purely cosmetic.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 4bc65ab..35bb213 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2005,14 +2005,14 @@ static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 
 
 #define HDSPM_SYSTEM_SAMPLE_RATE(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE |\
-	SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
-  .info = snd_hdspm_info_system_sample_rate, \
-  .put = snd_hdspm_put_system_sample_rate, \
-  .get = snd_hdspm_get_system_sample_rate \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_info_system_sample_rate, \
+	.put = snd_hdspm_put_system_sample_rate, \
+	.get = snd_hdspm_get_system_sample_rate \
 }
 
 static int snd_hdspm_info_system_sample_rate(struct snd_kcontrol *kcontrol,
@@ -2462,7 +2462,7 @@ static int snd_hdspm_put_clock_source(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_PREF_SYNC_REF(xname, xindex) \
-{.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	.name = xname, \
 	.index = xindex, \
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |\
@@ -2798,12 +2798,12 @@ static int snd_hdspm_put_pref_sync_ref(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_AUTOSYNC_REF(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READ, \
-  .info = snd_hdspm_info_autosync_ref, \
-  .get = snd_hdspm_get_autosync_ref, \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ, \
+	.info = snd_hdspm_info_autosync_ref, \
+	.get = snd_hdspm_get_autosync_ref, \
 }
 
 static int hdspm_autosync_ref(struct hdspm *hdspm)
@@ -2887,12 +2887,12 @@ static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_LINE_OUT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_line_out, \
-  .get = snd_hdspm_get_line_out, \
-  .put = snd_hdspm_put_line_out \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_line_out, \
+	.get = snd_hdspm_get_line_out, \
+	.put = snd_hdspm_put_line_out \
 }
 
 static int hdspm_line_out(struct hdspm * hdspm)
@@ -2944,12 +2944,12 @@ static int snd_hdspm_put_line_out(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_TX_64(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_tx_64, \
-  .get = snd_hdspm_get_tx_64, \
-  .put = snd_hdspm_put_tx_64 \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_tx_64, \
+	.get = snd_hdspm_get_tx_64, \
+	.put = snd_hdspm_put_tx_64 \
 }
 
 static int hdspm_tx_64(struct hdspm * hdspm)
@@ -3000,12 +3000,12 @@ static int snd_hdspm_put_tx_64(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_C_TMS(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_c_tms, \
-  .get = snd_hdspm_get_c_tms, \
-  .put = snd_hdspm_put_c_tms \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_c_tms, \
+	.get = snd_hdspm_get_c_tms, \
+	.put = snd_hdspm_put_c_tms \
 }
 
 static int hdspm_c_tms(struct hdspm * hdspm)
@@ -3056,12 +3056,12 @@ static int snd_hdspm_put_c_tms(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_SAFE_MODE(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_safe_mode, \
-  .get = snd_hdspm_get_safe_mode, \
-  .put = snd_hdspm_put_safe_mode \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_safe_mode, \
+	.get = snd_hdspm_get_safe_mode, \
+	.put = snd_hdspm_put_safe_mode \
 }
 
 static int hdspm_safe_mode(struct hdspm * hdspm)
@@ -3112,12 +3112,12 @@ static int snd_hdspm_put_safe_mode(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_EMPHASIS(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_emphasis, \
-  .get = snd_hdspm_get_emphasis, \
-  .put = snd_hdspm_put_emphasis \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_emphasis, \
+	.get = snd_hdspm_get_emphasis, \
+	.put = snd_hdspm_put_emphasis \
 }
 
 static int hdspm_emphasis(struct hdspm * hdspm)
@@ -3168,12 +3168,12 @@ static int snd_hdspm_put_emphasis(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_DOLBY(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_dolby, \
-  .get = snd_hdspm_get_dolby, \
-  .put = snd_hdspm_put_dolby \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_dolby, \
+	.get = snd_hdspm_get_dolby, \
+	.put = snd_hdspm_put_dolby \
 }
 
 static int hdspm_dolby(struct hdspm * hdspm)
@@ -3224,12 +3224,12 @@ static int snd_hdspm_put_dolby(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_PROFESSIONAL(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_professional, \
-  .get = snd_hdspm_get_professional, \
-  .put = snd_hdspm_put_professional \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_professional, \
+	.get = snd_hdspm_get_professional, \
+	.put = snd_hdspm_put_professional \
 }
 
 static int hdspm_professional(struct hdspm * hdspm)
@@ -3279,12 +3279,12 @@ static int snd_hdspm_put_professional(struct snd_kcontrol *kcontrol,
 }
 
 #define HDSPM_INPUT_SELECT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_input_select, \
-  .get = snd_hdspm_get_input_select, \
-  .put = snd_hdspm_put_input_select \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_input_select, \
+	.get = snd_hdspm_get_input_select, \
+	.put = snd_hdspm_put_input_select \
 }
 
 static int hdspm_input_select(struct hdspm * hdspm)
@@ -3351,12 +3351,12 @@ static int snd_hdspm_put_input_select(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_DS_WIRE(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_ds_wire, \
-  .get = snd_hdspm_get_ds_wire, \
-  .put = snd_hdspm_put_ds_wire \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_ds_wire, \
+	.get = snd_hdspm_get_ds_wire, \
+	.put = snd_hdspm_put_ds_wire \
 }
 
 static int hdspm_ds_wire(struct hdspm * hdspm)
@@ -3423,12 +3423,12 @@ static int snd_hdspm_put_ds_wire(struct snd_kcontrol *kcontrol,
 
 
 #define HDSPM_QS_WIRE(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdspm_info_qs_wire, \
-  .get = snd_hdspm_get_qs_wire, \
-  .put = snd_hdspm_put_qs_wire \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_qs_wire, \
+	.get = snd_hdspm_get_qs_wire, \
+	.put = snd_hdspm_put_qs_wire \
 }
 
 static int hdspm_qs_wire(struct hdspm * hdspm)
@@ -3595,15 +3595,15 @@ static int snd_hdspm_put_madi_speedmode(struct snd_kcontrol *kcontrol,
 }
 
 #define HDSPM_MIXER(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
-  .name = xname, \
-  .index = xindex, \
-  .device = 0, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
-		 SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
-  .info = snd_hdspm_info_mixer, \
-  .get = snd_hdspm_get_mixer, \
-  .put = snd_hdspm_put_mixer \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
+	.name = xname, \
+	.index = xindex, \
+	.device = 0, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_info_mixer, \
+	.get = snd_hdspm_get_mixer, \
+	.put = snd_hdspm_put_mixer \
 }
 
 static int snd_hdspm_info_mixer(struct snd_kcontrol *kcontrol,
@@ -3702,12 +3702,12 @@ static int snd_hdspm_put_mixer(struct snd_kcontrol *kcontrol,
 */
 
 #define HDSPM_PLAYBACK_MIXER \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE | \
-		 SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
-  .info = snd_hdspm_info_playback_mixer, \
-  .get = snd_hdspm_get_playback_mixer, \
-  .put = snd_hdspm_put_playback_mixer \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE | \
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_info_playback_mixer, \
+	.get = snd_hdspm_get_playback_mixer, \
+	.put = snd_hdspm_put_playback_mixer \
 }
 
 static int snd_hdspm_info_playback_mixer(struct snd_kcontrol *kcontrol,
-- 
1.7.10.4
