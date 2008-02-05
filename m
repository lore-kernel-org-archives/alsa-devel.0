From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: DSP2000 Midi In - Not a correct fix??
Date: Tue, 5 Feb 2008 14:47:30 +0000
Message-ID: <200802051447.30039.gineera@aspect135.co.uk>
References: <200801291029.59425.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0801291202130.11819@tm8103.perex-int.cz>
	<200801292322.29394.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CcHqHmh6XsZWCYF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D2DC243A1
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 15:26:21 +0100 (CET)
In-Reply-To: <200801292322.29394.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_CcHqHmh6XsZWCYF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 29 January 2008 23:22, Alan Horstmann wrote:
> However, things have moved on here, in that I do now have a proposed
> alternative.  One step on from the above approach is to call this function
> only if
> 	ICE1712_STDSP24_BOX_MIDI1
> is set for that particular box, rather than setting the parameter
> 'activate'. This approach does create a complete and effective solution,
> which I have tested here, being able (using the boxconfigs) to set channels
> and Midi In on any box designated 0-3, and Midi out 1 & 2 are active for
> all boxes once set on any.
>
> Soon I will put this together into a patch for review, so that there is at
> least something definite to discuss.

I have now generated this patch, together with a fair amount of testing 
various configurations, and it is attached.

The original MIDI-IN non-functioning is caused because when
	snd_ice1712_stdsp24_box_midi(..)
is called with the 3rd parameter 'activate' set to 0, it messes up any 
previously midi-configured boxes.  Thus the zero configs of [1],[2],[3] in 
the standard code un-set the active midi config of [0] since they happen 
afterwards.  This patch ensures the function is only called to activate a 
config and not to set it off.  As a result configs can be set for any of [0] 
to [3] successfully.

The various bits are clearly not operating as would be expected.  If _MIDI2 is 
not set, midi out2 still functions, but midi in1 (on first 401 uart) does 
not.  However, no other box can use this , as only one can be the midi 
source. And, _MIDI1 actually enables input on the second 401 uart.  Therfore 
there really is no value in the separate _MIDI2 config and function.  It 
would be more logical to combine in a single midi config function (it was 
like this in Alsa 1.0.1, but changed sometime later).

I have included some explanitary text in the code patch which attempts to give 
some idea of the config issues.

However, without extensive re-working (which it seems no-one has an appetite 
for), this patch fixes the problem without reducing functionality in the way 
that January's applied patch does.  The box can be set-up as any of [0] to 
[3].  It might be worth re-opening the 3 related bugs and seeing if the 
others involved can confirm this patch, as I cannot now add it to them as an 
alternative.

In addition, name strings are included for the mpu_401 devices so they have 
unique names.

Regards  Alan

AHhoontech.c-midiIn-boxes.diff

Fixes the problems with Midi In on Hoontech/STA dsp24 cards, for example with 
DSP2000 box, without restricting the box configurations available.  Also adds 
mpu_401 name strings.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>





--Boundary-00=_CcHqHmh6XsZWCYF
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="AHhoontech.c-midiIn-boxes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="AHhoontech.c-midiIn-boxes.diff"

--- alsa-kernel/pci/ice1712/hoontech.c.orig	2008-01-29 08:31:46.000000000 +0000
+++ alsa-kernel/pci/ice1712/hoontech.c	2008-02-05 21:22:42.000000000 +0000
@@ -208,6 +208,19 @@
 			    /* ICE1712_STDSP24_MUTE |
 			       ICE1712_STDSP24_INSEL |
 			       ICE1712_STDSP24_DAREAR; */
+	/*  These boxconfigs have caused problems in the past.
+	 *  The code is not optimal, but should now enable a working config to
+	 *  be achieved.
+	 *  ** MIDI IN can only be configured on one box **
+	 *  ICE1712_STDSP24_BOX_MIDI1 needs to be set for that box.
+	 *  Tests on a ADAC2000 box suggest the box config flags do not
+	 *  work as would be expected, and the inputs are crossed.
+	 *  Setting ICE1712_STDSP24_BOX_MIDI1 and ICE1712_STDSP24_BOX_MIDI2
+	 *  on the same box connects MIDI-In to both 401 uarts; both outputs
+	 *  are then active on all boxes.
+	 *  The default config here sets up everything on the first box.
+	 *  Alan Horstmann  5.2.2008
+	 */
 	spec->boxconfig[0] = ICE1712_STDSP24_BOX_CHN1 |
 				     ICE1712_STDSP24_BOX_CHN2 |
 				     ICE1712_STDSP24_BOX_CHN3 |
@@ -223,14 +236,14 @@
 		(spec->config & ICE1712_STDSP24_MUTE) ? 1 : 0);
 	snd_ice1712_stdsp24_insel(ice,
 		(spec->config & ICE1712_STDSP24_INSEL) ? 1 : 0);
-	for (box = 0; box < 1; box++) {
+	for (box = 0; box < 4; box++) {
 		if (spec->boxconfig[box] & ICE1712_STDSP24_BOX_MIDI2)
                         snd_ice1712_stdsp24_midi2(ice, 1);
 		for (chn = 0; chn < 4; chn++)
 			snd_ice1712_stdsp24_box_channel(ice, box, chn,
 				(spec->boxconfig[box] & (1 << chn)) ? 1 : 0);
-		snd_ice1712_stdsp24_box_midi(ice, box,
-				(spec->boxconfig[box] & ICE1712_STDSP24_BOX_MIDI1) ? 1 : 0);
+		if (spec->boxconfig[box] & ICE1712_STDSP24_BOX_MIDI1)
+			snd_ice1712_stdsp24_box_midi(ice, box, 1);
 	}
 
 	return 0;
@@ -322,6 +335,8 @@
 		.name = "Hoontech SoundTrack Audio DSP24",
 		.model = "dsp24",
 		.chip_init = snd_ice1712_hoontech_init,
+		.mpu401_1_name = "MIDI-1 Hoontech/STA DSP24",
+		.mpu401_2_name = "MIDI-2 Hoontech/STA DSP24",
 	},
 	{
 		.subvendor = ICE1712_SUBDEVICE_STDSP24_VALUE,	/* a dummy id */

--Boundary-00=_CcHqHmh6XsZWCYF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_CcHqHmh6XsZWCYF--
