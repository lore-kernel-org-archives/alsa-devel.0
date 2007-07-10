From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: RE :  M-Audio Audiophile USB,
	native little endian	 (S16_LE) ?
Date: Tue, 10 Jul 2007 23:22:03 +0200
Message-ID: <20070710232203.kl84d2l85csco88o@webmail.supelec.fr>
References: <20070709103936.2540F5813E@ip2-138.brfsodrahamn.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_5aybnb8j8q04"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 1127B1038C9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 23:22:05 +0200 (CEST)
In-Reply-To: <20070709103936.2540F5813E@ip2-138.brfsodrahamn.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 'Pavel Polischouk' <pavelp@rogers.com>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--=_5aybnb8j8q04
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>
>> > I don't know if this is already known (?), but the M-Audio
>> > Audiophile USB seem to be possible to run in native S16_LE
>> > mode if initialized with device_setup=3D0x01 (possibly with
>> > 0x11 also, have not tested that).
Hakan,

Seems that you're right. After some more tests, I was able to play a =20
raw file  supposed to be S16_BE (recorded from my audiophile usb) to a =20
Little endian only device.

I think we should fix this then, however I think that we should prefer =20
a fix that do not use device_setup too much because it is something =20
that could disapear in the future (see the old thread "[PATCH 1/2] =20
M-Audio USB").

You'll find attached an equivalent fix that checks alt-settings =20
instead of device_setup param: Can you try it Hakan ?

Moreover, it adds an extra reset-to-altset0 call at module =20
initialization time which proves to be useful to switch sample depth =20
modes without having to turn off the device. It is taken from Pavel =20
Polischouk's patch which wasn't really finalized (at least until now). =20
(Pavel are you still reading to this list?)

Takashi, let me know if you want to apply one of the proposed fixes, =20
cause I'll have to update the Documentation as well.

Regards,
Thibault


--=_5aybnb8j8q04
Content-Type: text/x-patch;
	charset=UTF-8;
	name="ma-audiophile-patch.diff"
Content-Disposition: attachment;
	filename="ma-audiophile-patch.diff"
Content-Transfer-Encoding: 7bit

--- orig/alsa-kernel/usb/usbaudio.c	2007-07-10 21:16:07.000000000 +0200
+++ alsa-kernel/usb/usbaudio.c	2007-07-10 21:32:16.000000000 +0200
@@ -2350,7 +2350,9 @@
 			return 1;
 		break;
 	case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-		return 1;
+		if (fp->altsetting==1 || fp->altsetting==2 ||
+                    fp->altsetting==3)
+			return 1;
 	}
 	return 0;
 }
@@ -3251,6 +3253,10 @@
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
 					 int iface, int altno)
 {
+	/* Reset ALL ifaces to 0 altsetting. 
+	Call it for every possible altsetting of every interface. */
+	usb_set_interface(chip->dev, iface, 0); 
+
 	if (device_setup[chip->index] & AUDIOPHILE_SET) {
 		if ((device_setup[chip->index] & AUDIOPHILE_SET_DTS)
 		    && altno != 6)

--=_5aybnb8j8q04
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_5aybnb8j8q04--
