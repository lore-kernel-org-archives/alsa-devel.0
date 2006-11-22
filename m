From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/3] echoaudio, add TLV support
Date: Wed, 22 Nov 2006 23:14:17 +0100
Message-ID: <20061122231417.1cdcd775.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


This patch adds TLV support to the echoaudio driver (controls).


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-kernel/pci/echoaudio__orig/echoaudio.c alsa-kernel/pci/echoaudio/echoaudio.c
--- alsa-kernel/pci/echoaudio__orig/echoaudio.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/echoaudio.c	2006-11-22 22:47:48.000000000 +0100
@@ -34,6 +34,7 @@ module_param_array(enable, bool, NULL, 0
 MODULE_PARM_DESC(enable, "Enable " ECHOCARD_NAME " soundcard.");
 
 static unsigned int channels_list[10] = {1, 2, 4, 6, 8, 10, 12, 14, 16, 999999};
+static DECLARE_TLV_DB_SCALE(db_scale_output_gain, -12800, 100, 1);
 
 static int get_firmware(const struct firmware **fw_entry,
 			const struct firmware *frm, struct echoaudio *chip)
@@ -1011,17 +1012,21 @@ static int snd_echo_output_gain_put(stru
 static struct snd_kcontrol_new snd_echo_line_output_gain __devinitdata = {
 	.name = "Line Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_output_gain_info,
 	.get = snd_echo_output_gain_get,
 	.put = snd_echo_output_gain_put,
+	.tlv = {.p = db_scale_output_gain},
 };
 #else
 static struct snd_kcontrol_new snd_echo_pcm_output_gain __devinitdata = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_output_gain_info,
 	.get = snd_echo_output_gain_get,
 	.put = snd_echo_output_gain_put,
+	.tlv = {.p = db_scale_output_gain},
 };
 #endif
 
@@ -1080,12 +1085,16 @@ static int snd_echo_input_gain_put(struc
 	return changed;
 }
 
+static DECLARE_TLV_DB_SCALE(db_scale_input_gain, -2500, 50, 0);
+
 static struct snd_kcontrol_new snd_echo_line_input_gain __devinitdata = {
 	.name = "Line Capture Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_input_gain_info,
 	.get = snd_echo_input_gain_get,
 	.put = snd_echo_input_gain_put,
+	.tlv = {.p = db_scale_input_gain},
 };
 
 #endif /* ECHOCARD_HAS_INPUT_GAIN */
@@ -1277,9 +1286,11 @@ static int snd_echo_mixer_put(struct snd
 static struct snd_kcontrol_new snd_echo_monitor_mixer __devinitdata = {
 	.name = "Monitor Mixer Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_mixer_info,
 	.get = snd_echo_mixer_get,
 	.put = snd_echo_mixer_put,
+	.tlv = {.p = db_scale_output_gain},
 };
 
 #endif /* ECHOCARD_HAS_MONITOR */
@@ -1343,9 +1354,11 @@ static int snd_echo_vmixer_put(struct sn
 static struct snd_kcontrol_new snd_echo_vmixer __devinitdata = {
 	.name = "VMixer Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_vmixer_info,
 	.get = snd_echo_vmixer_get,
 	.put = snd_echo_vmixer_put,
+	.tlv = {.p = db_scale_output_gain},
 };
 
 #endif /* ECHOCARD_HAS_VMIXER */
@@ -1753,9 +1766,12 @@ static int snd_echo_vumeters_get(struct 
 static struct snd_kcontrol_new snd_echo_vumeters __devinitdata = {
 	.name = "VU-meters",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |
+		  SNDRV_CTL_ELEM_ACCESS_VOLATILE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 	.info = snd_echo_vumeters_info,
 	.get = snd_echo_vumeters_get,
+	.tlv = {.p = db_scale_output_gain},
 };
 
 

--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
