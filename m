From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice712 -set mpu401 info flags from card info, patch
Date: Fri, 26 May 2006 16:14:11 +0100
Message-ID: <200605261609.16610.gineera@aspect135.co.uk>
References: <200605242235.31408.gineera@aspect135.co.uk>
	<s5hodxlqbw8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DtxdEFfApaEYzme"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodxlqbw8.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_DtxdEFfApaEYzme
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 26 May 2006 12:11, you wrote:
> At Wed, 24 May 2006 22:35:31 +0100,
>
> Alan Horstmann wrote:
> > @@ -2736,9 +2737,10 @@
> >  		}
> >
> >  	if (! c->no_mpu401) {
> > +		c->mpu401_1_info_flags |=3D MPU401_INFO_INTEGRATED;
>
> Don't change the contents of card info here, instead...
>
> >  		if ((err =3D snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
> > -					       ICEREG(ice, MPU1_CTRL),
> > -					       MPU401_INFO_INTEGRATED,
> > +					       ICEREG(ice, MPU1_CTRL),
> > +					       c->mpu401_1_info_flags,
>
> ... add "| MPU401_INFO_INTEGRETED" at this point.
> (Ditto for mpu401_2_info_flags)
>
> Could you repost the fixed patch?

=46air comment, I shouldn't use it as a variable.  Revised patch attached.

Alan

ice1712-mpu401-infoflags-2.patch

Summary: in ice1712, set mpu401 info flags from _card_info

To permit use, in ice1712, of the mpu401 info flags recently added to=20
mpu401_uart, adds info_flags in snd_ice1712_card_info so that additional=20
flags can be set, if desired. =A0'MPU401_INFO_INTEGRATED' is always set wit=
h=20
the ice1712. =A0The flags are passed on to snd_mpu401_uart_new(). =A0_INFO_=
OUTPUT=20
is set for DMX6fire mpu2.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>



--Boundary-00=_DtxdEFfApaEYzme
Content-Type: text/x-diff; charset="iso-8859-1";
	name="ice1712-mpu401-infoflags-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712-mpu401-infoflags-2.patch"

diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ews.c alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ews.c
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ews.c	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ews.c	2006-05-24 22:13:56.000000000 +0100
@@ -1033,6 +1033,7 @@
 		.build_controls = snd_ice1712_ews_add_controls,
 		.mpu401_1_name = "MIDI-Front DMX6fire",
 		.mpu401_2_name = "Wavetable DMX6fire",
+		.mpu401_2_info_flags = MPU401_INFO_OUTPUT,
 	},
 	{ } /* terminator */
 };
diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.c alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.c	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c	2006-05-26 15:51:05.000000000 +0100
@@ -61,7 +61,6 @@
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
-#include <sound/mpu401.h>
 #include <sound/initval.h>
 
 #include <sound/asoundef.h>
@@ -2737,8 +2738,8 @@

 	if (! c->no_mpu401) {
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
-					       ICEREG(ice, MPU1_CTRL),
-					       MPU401_INFO_INTEGRATED,
+					       ICEREG(ice, MPU1_CTRL),
+					       c->mpu401_1_info_flags | MPU401_INFO_INTEGRATED,
 					       ice->irq, 0,
 					       &ice->rmidi[0])) < 0) {
 			snd_card_free(card);
@@ -2749,8 +2751,8 @@

 		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {  /*  2nd port used  */
 			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
-						       ICEREG(ice, MPU2_CTRL),
-						       MPU401_INFO_INTEGRATED,
+						       ICEREG(ice, MPU2_CTRL),
+						       c->mpu401_2_info_flags | MPU401_INFO_INTEGRATED,
 						       ice->irq, 0,
 						       &ice->rmidi[1])) < 0) {
 				snd_card_free(card);
diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.h alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.h
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.h	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.h	2006-05-24 16:27:57.000000000 +0100
@@ -29,6 +29,7 @@
 #include <sound/ak4xxx-adda.h>
 #include <sound/ak4114.h>
 #include <sound/pcm.h>
+#include <sound/mpu401.h>


 /*
@@ -495,6 +496,8 @@
 	int (*chip_init)(struct snd_ice1712 *);
 	int (*build_controls)(struct snd_ice1712 *);
 	unsigned int no_mpu401: 1;
+	unsigned int mpu401_1_info_flags;
+	unsigned int mpu401_2_info_flags;
 	const char *mpu401_1_name;
 	const char *mpu401_2_name;
 	unsigned int eeprom_size;

--Boundary-00=_DtxdEFfApaEYzme
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_DtxdEFfApaEYzme
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_DtxdEFfApaEYzme--
