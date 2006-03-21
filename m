From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Any missing patches?
Date: Tue, 21 Mar 2006 23:02:24 +0200
Message-ID: <442069E0.4050409@akl.lt>
References: <s5hmzfl9cql.wl%tiwai@suse.de>	<441FD2E9.2000403@akl.lt> <s5hpskg83uo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A5A2B2A2097A99E29392288"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpskg83uo.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A5A2B2A2097A99E29392288
Content-Type: multipart/mixed;
 boundary="------------060201060202030702010703"

This is a multi-part message in MIME format.
--------------060201060202030702010703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch cleans up the mixer interface by removing
unpractical/non-working features. Applies for ALC260 "acer" model in
hda-intel module. It also adds/changes a few comments in the source.

The patch is tested and works with an Acer Travelmate 4061NLMi.

Rimas Kudelis <rq@akl.lt>





--------------060201060202030702010703
Content-Type: text/plain;
 name="patch_realtek.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch_realtek.c.diff"

--- alsa-kernel/pci/hda/patch_realtek.c.orig	2006-03-12 18:19:50.00000000=
0 +0200
+++ alsa-kernel/pci/hda/patch_realtek.c	2006-03-21 21:11:29.000000000 +02=
00
@@ -2738,16 +2738,14 @@
 	},
 };
=20
-/* Acer TravelMate(/Extensa/Aspire) notebooks have similar configutation=
 to
- * the Fujitsu S702x, but jacks are marked differently. We won't allow
- * retasking the Headphone jack, so it won't be available here.
+/* Capture sources suitable for Acer TravelMate 4060, Aspire 1640 and si=
milar
+ * laptops.
  */
 static struct hda_input_mux alc260_acer_capture_source =3D {
-	.num_items =3D 3,
+	.num_items =3D 2,
 	.items =3D {
 		{ "Mic", 0x0 },
 		{ "Line", 0x2 },
-		{ "CD", 0x4 },
 	},
 };
=20
@@ -2830,16 +2828,18 @@
 static struct snd_kcontrol_new alc260_acer_mixer[] =3D {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x07, 0x0, HDA_INPUT),
-	ALC_PIN_MODE("Mic Jack Mode", 0x12, ALC_PIN_DIR_IN),
+	/* Mic jack works as output too, actually, but it only outputs both ste=
reo
+	 * channels mixed to left channel then. Furthermore, the same pin is
+	 * connected to the internal microphone. So, let's forget it.
+	 */
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x07, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x07, 0x02, HDA_INPUT),
+	/* Line jack doesn't actually preamplify the mic even if set to one of =
the
+	 * Mic modes. However, it doesn't seem like these can be disabled ATM.
+	 */
 	ALC_PIN_MODE("Line Jack Mode", 0x14, ALC_PIN_DIR_INOUT),
-	HDA_CODEC_VOLUME("Beep Playback Volume", 0x07, 0x05, HDA_INPUT),
-	HDA_CODEC_MUTE("Beep Playback Switch", 0x07, 0x05, HDA_INPUT),
 	{ } /* end */
 };
=20
@@ -3128,18 +3128,18 @@
  * similar laptops (adapted from Fujitsu init verbs).
  */
 static struct hda_verb alc260_acer_init_verbs[] =3D {
-	/* On TravelMate laptops, GPIO 0 enables the internal speaker and
-	 * the headphone jack.  Turn this on and rely on the standard mute
-	 * methods whenever the user wants to turn these outputs off.
+	/* On TravelMate 4060, Aspire 1640 and similar laptops, GPIO 0 enables =
the
+	 * internal speaker and the headphone jack. Turn this on and rely on th=
e
+	 * standard mute methods whenever the user wants to turn these outputs =
off.
 	 */
 	{0x01, AC_VERB_SET_GPIO_MASK, 0x01},
 	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
 	{0x01, AC_VERB_SET_GPIO_DATA, 0x01},
-	/* Internal speaker/Headphone jack is connected to Line-out pin */
+	/* Internal speaker and Headphone jack are connected to line-out pin */=

 	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
-	/* Internal microphone/Mic jack is connected to Mic1 pin */
+	/* Internal microphone and Mic jack are connected to mic1 pin */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
-	/* Line In jack is connected to Line1 pin */
+	/* Line In jack is connected to line1 pin */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 	/* Ensure all other unused pins are disabled and muted. */
 	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
@@ -3154,7 +3154,7 @@
 	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
 	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
=20
-	/* Ensure Mic1 and Line1 pin widgets take input from the OUT1 sum=20
+	/* Ensure mic1 and line1 pin widgets take input from the OUT1 sum=20
 	 * bus when acting as outputs.
 	 */
 	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
@@ -3173,10 +3173,10 @@
=20
 	/* Unmute Line-out pin widget amp left and right (no equiv mixer ctrl) =
*/
 	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Unmute Mic1 and Line1 pin widget input buffers since they start as
+	/* Unmute mic1 and line1 pin widget input buffers since they start as
 	 * inputs. If the pin mode is changed by the user the pin mode control
 	 * will take care of enabling the pin's input/output buffers as needed.=

-	 * Therefore there's no need to enable the input buffer at this
+	 * Therefore there's no need to enable the output buffer at this
 	 * stage.
 	 */
 	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
@@ -3184,13 +3184,14 @@
=20
 	/* Mute capture amp left and right */
 	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	/* Set ADC connection select to match default mixer setting - mic
+	/* Set ADC connection select to match default mixer setting - Mic
 	 * (on mic1 pin)
 	 */
 	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
=20
 	/* Do similar with the second ADC: mute capture input amp and
-	 * set ADC connection to line (on line1 pin)
+	 * set ADC connection to Line (on line1 pin)
+	 * FIXME: the connection is still set to Mic for some reason
 	 */
 	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x05, AC_VERB_SET_CONNECT_SEL, 0x02},

--------------060201060202030702010703--

--------------enig7A5A2B2A2097A99E29392288
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIGnnAlYAh8azrv8RAnzLAJ0fckSSqtj9VRAu8wpLuJ3YQfVY5wCfV+og
YUqVuhqZT0bHd2owaUV7tRw=
=YvlJ
-----END PGP SIGNATURE-----

--------------enig7A5A2B2A2097A99E29392288--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
