From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] Make internal speaker work on Acer C20x tablets
Date: Mon, 27 Nov 2006 09:38:03 +1030 (CST)
Message-ID: <200611262308.kAQN837C030042@turbo.physics.adelaide.edu.au>
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
To: alsa-devel@lists.sourceforge.net, valemie@yahoo.com.sg, 017623780966@o2online.de
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Takashi

The following patch creates a new "Mono speaker" control in alsamixer 
when the Realtek "acer" model is used with hda_intel.  This is needed so
the internal mono speaker (when present) can be controlled.

This new control won't do anything in Acer laptops which are not fitted with
a mono speaker. Acer models which are known to have a mono speaker are the
C20x tablet series but there may be others.  I guess we could define a new
model specifically for Acers with mono speakers but this seems a bit silly
given that such a model will be identical to the normal "acer" model except
for this added control.

This patch also adds the C20x tablets to the list of PCI ids associated with
the "acer" model.  This means that owners of C20x machines will no longer
have to supply "model=acer" when loading hda_intel.

The patch is against ALSA 1.0.13 and applies to patch_realtek.c in the
hda/ driver directory.

Regards
  jonathan

--- patch_realtek.c-orig	2006-11-20 11:52:16.000000000 +1030
+++ patch_realtek.c	2006-11-20 12:57:01.000000000 +1030
@@ -3090,11 +3090,18 @@
  * and the output jack.  If this turns out to be the case for all such
  * models the "Line Jack Mode" mode could be changed from ALC_PIN_DIR_INOUT
  * to ALC_PIN_DIR_INOUT_NOMICBIAS.
+ *
+ * The C20x Tablet series have a mono internal speaker which is controlled
+ * via the chip's Mono sum widget and pin complex, so include the necessary
+ * controls for such models.  On models without a "mono speaker" the control
+ * won't do anything.
  */
 static struct snd_kcontrol_new alc260_acer_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
 	ALC_PIN_MODE("Headphone Jack Mode", 0x0f, ALC_PIN_DIR_INOUT),
+	HDA_CODEC_VOLUME_MONO("Mono Speaker Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Mono Speaker Playback Switch", 0x0a, 1, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
@@ -3409,11 +3416,11 @@
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
 	/* Line In jack is connected to Line1 pin */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* Some Acers (eg: C20x Tablets) use Mono pin for internal speaker */
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
 	/* Ensure all other unused pins are disabled and muted. */
 	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
@@ -3441,6 +3448,8 @@
 
 	/* Unmute Line-out pin widget amp left and right (no equiv mixer ctrl) */
 	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Unmute mono pin widget amp output (no equiv mixer ctrl) */
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	/* Unmute Mic1 and Line1 pin widget input buffers since they start as
 	 * inputs. If the pin mode is changed by the user the pin mode control
 	 * will take care of enabling the pin's input/output buffers as needed.
@@ -3950,6 +3959,7 @@
 	{ .modelname = "fujitsu", .config = ALC260_FUJITSU_S702X },
 	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702X },
 	{ .modelname = "acer", .config = ALC260_ACER },
+	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x007b, .config = ALC260_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x008f, .config = ALC260_ACER },
 #ifdef CONFIG_SND_DEBUG
 	{ .modelname = "test", .config = ALC260_TEST },

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
