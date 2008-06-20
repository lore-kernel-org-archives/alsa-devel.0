From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: looping S/PDIF data
Date: Sat, 21 Jun 2008 01:09:10 +0200
Message-ID: <20080621010910.018f880d@mjolnir.drzeus.cx>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
	<4858B84B.4030800@keyaccess.nl> <s5hej6t91u1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
	<s5hskv97fqk.wl%tiwai@suse.de>
	<20080620214516.28e9d3f3@mjolnir.drzeus.cx>
	<485C0A97.7020909@keyaccess.nl>
	<20080621000050.43160d47@mjolnir.drzeus.cx>
	<485C2DF7.7080408@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7852275522413943295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	by alsa0.perex.cz (Postfix) with ESMTP id B7C9C1038D2
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Jun 2008 01:09:17 +0200 (CEST)
In-Reply-To: <485C2DF7.7080408@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, mulix@mulix.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============7852275522413943295==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-722-1214002850-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-722-1214002850-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jun 2008 00:23:51 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 21-06-08 00:00, Pierre Ossman wrote:
>=20
> > On Fri, 20 Jun 2008 21:52:55 +0200 Rene Herman
> > <rene.herman@keyaccess.nl> wrote:
> >=20
> >> On 20-06-08 21:45, Pierre Ossman wrote:
> >>> Are there any specs on this hardware? I could play around a bit
> >>> myself, but I can't really find any documentation on the
> >>> registers.
> >> At:
> >>=20
> >> ftp://ftp.alsa-project.org/pub/manuals/trident/
> >>=20
> >> there's a 4D-Wave DX technical reference manual and .doc files
> >> which at first glance look useful.
> >>=20
> >=20
> > Ah, thanks. This is an NX, but hopefully they don't differ that much.
>=20
> No idea, but if you come up with something and keep me in CC I'll test=20
> it on a DX. Just acquired one on eBay a few days ago as a coincedence.
>=20

Well aren't things just so much easier with a decent spec. I have this
one solved now. :)

The following patch disables both the S/PDIF output, and the DMA engine
when paused. As for Jaroslav's comment, the documentation seems to
suggest that the DMA disabled by the main code path is just for the
mixer engine, which is not used when feeding the S/PDIF directly. This
is supported by my tests as S/PDIF output is paused when using hw:0.0
(the mixer engine), but not with hw:0.2 (the raw S/PDIF).

Regarding the DX, the docs say that the DX lacks S/PDIF, so it should
be unaffected. For the SiS chip, Takashi's patch might still be needed.

--

trident: pause s/pdif output

Stop the S/PDIF DMA engine and output when the device is told to pause.
It will keep on looping the current buffer contents if this isn't done.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
--

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_m=
ain.c
index bbcee2c..a69b420 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -1590,7 +1590,10 @@ static int snd_trident_trigger(struct snd_pcm_substr=
eam *substream,
        if (spdif_flag) {
                if (trident->device !=3D TRIDENT_DEVICE_ID_SI7018) {
                        outl(trident->spdif_pcm_bits, TRID_REG(trident, NX_=
SPCSTATUS));
-                       outb(trident->spdif_pcm_ctrl, TRID_REG(trident, NX_=
SPCTRL_SPCSO + 3));
+                       val =3D trident->spdif_pcm_ctrl;
+                       if (!go)
+                               val &=3D ~(0x28);
+                       outb(val, TRID_REG(trident, NX_SPCTRL_SPCSO + 3));
                } else {
                        outl(trident->spdif_pcm_bits, TRID_REG(trident, SI_=
SPDIF_CS));
                        val =3D inl(TRID_REG(trident, SI_SERIAL_INTF_CTRL))=
 | SPDIF_EN;

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Use end-to-end encryption where
  possible.

--=_freyr.drzeus.cx-722-1214002850-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhcOJsACgkQ7b8eESbyJLiE/gCdHHBgnKvyoUkWvk0n4gHfSJ+o
fewAn0e8nvNhAlEu5GmLGpKNzBpKTpj2
=9Khl
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-722-1214002850-0001-2--

--===============7852275522413943295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7852275522413943295==--
