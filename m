From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Mixer control names out of control?
Date: Sun, 28 Nov 2004 12:54:26 +0300
Message-ID: <20041128095426.GA2317@sirius.home>
References: <41A84850.5000604@developers.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <41A84850.5000604@developers.dk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Christensen <peter@developers.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 27, 2004 at 10:26:40AM +0100, Peter Christensen wrote:
> First of all, the AC97 driver uses the name "IEC958 Playback SPSA". What'=
s=20
> wrong with "IEC958 Playback Volume"?

Because it is not a volume.  This control sets the SPSA bits in the
AC'97 Extended Audio Status and Control Register (0x2a):

- SPSA[1,0] =3D 00 S/PDIF source data assigned to AC-link slots 3&4
- SPSA[1,0] =3D 01 S/PDIF source data assigned to AC-link slots 7&8
  [2-ch Primary Codec default]
- SPSA[1,0] =3D 10 S/PDIF source data assigned to AC-link slots 6&9
  [4-ch Primary Codec default]
- SPSA[1,0] =3D 11 S/PDIF source data assigned to AC-link slots 10&11
  [6-ch Primary Codec default]

So you can set routing of some other channel (front, rear, center/LFE)
to SPDIF with this control.

However, representing SPSA as volume is really confusing.  What about
making it an enumeration instead?

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBqaBSW82GfkQfsqIRApaLAJwPJTURhre3Zi5cq1v4M0AM2/YyJACdEs4I
9jpMVfUJTSEnChDK1zDnuIU=
=/RLt
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
