From: Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: SB Live 24 Ext (was: [ALSA - driver 0000955]:
	CN-126 - USB 5.1 Audio adapter)
Date: Fri, 04 Mar 2005 12:55:52 +0100
Message-ID: <1109937352.16108.21.camel@ghanima>
References: <Pine.HPX.4.33n.0503041206101.8579-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T3nrDdH6OteWuABX3VVl"
In-Reply-To: <Pine.HPX.4.33n.0503041206101.8579-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-T3nrDdH6OteWuABX3VVl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-04 at 12:09 +0100, Clemens Ladisch wrote:
> Fruhwirth Clemens wrote:

> > I wonder, how the audio signal flow looks like..
>=20
> The bTerminalID/bUnitID field identifies each unit.  Start at the
> output terminals and go back through the bSourceID's.

I really start to like USB.

That's how the Creative box should look internal.

Host -> [IT1] -> [FU2] -> [OT3] -> Speaker
Line-in -> [IT4] -> [FU5] -> [OT6] -> Host

That's _very_ minimal. It looks like there is no way to Route Line-In
back to Speaker. Just digitally and sampled.. bad. Don't buy that box.

The only thing nice is, that it's really 24-bit.

      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             4
        bSubframeSize           3
        bBitResolution         24
                               ^^

--=20
http://clemens.endorphin.org, for robots sp4mtrap@endorphin.org

--=-T3nrDdH6OteWuABX3VVl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCKEzIbjN8iSMYtrsRApckAKCHAheLwG46cFgsko4r3A1zujfZDACgl+bV
C3ZGrhUaKp58IIBs9Iy6eSU=
=ff7O
-----END PGP SIGNATURE-----

--=-T3nrDdH6OteWuABX3VVl--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
