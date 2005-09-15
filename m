From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0 modem
Date: Thu, 15 Sep 2005 23:25:40 +0200
Message-ID: <200509152325.42883.alien999999999@users.sourceforge.net>
References: <20050911124530.GA16795@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <4329946B.9030407@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1785134.pa4RifCyA1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4329946B.9030407@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1785134.pa4RifCyA1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Op donderdag 15 september 2005 17:34, schreef Raymond:
> Sasha Khapyorsky wrote:
> > Great, the secondary modem codec is there. The valid codec id bits are
> > 24:25 (AC97 interface supports up to four codecs):
> >
> > #define VORTEX_CODEC_ID_SHIFT 24
> >
> > I will send cleaned codec access patch separately and will look what is
> > next.
>
> It would be more easy to debug/maintain the driver if using different
> read/write routines for audio and modem codec.
>
> Audio codec is always primary in sound card and audio/modem combo
>
> The existing vortex_codec_read() and vortex_codec_write() can remain
> unchanged.
>
> Just add new routine vortex_modem_codec_read() vortex_modem_code_write()
> to handle secondary/primary modem codec for audio/modem combo and PCI
> modem card.
>
> http://www.nix.ru/autocatalog/modems/AurVcomPCIV90RTL_5817.html
>
> Make sure your patch is 32bits/64bits compatible
>
> AMD64 user may use the  PCI audio/modem combo card and PCI modem card.

does that mean that PCI sound card is broken on AMD64 ?

cause, maybe that's why my snd-au8810 card gives problems...

--nextPart1785134.pa4RifCyA1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKebWuBWKXETrtdcRAjNeAJwNFDG8MffwTq0ees3jf2E8r2Ng1QCeNEYk
GPz6KHaHS4NbuoCbTuwrusg=
=HB1s
-----END PGP SIGNATURE-----

--nextPart1785134.pa4RifCyA1--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
