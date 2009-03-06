From: Jo Shields <directhex@apebox.org>
Subject: Re: ALC889A (Gigabyte EX58-UD5) pin support
Date: Fri, 06 Mar 2009 02:18:49 +0000
Message-ID: <1236305929.7464.1.camel@desire>
References: <1236302368.7568.21.camel@desire>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6551424731305309072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from woodbine.london.02.net (woodbine.london.02.net [87.194.255.145])
	by alsa0.perex.cz (Postfix) with ESMTP id C5E00103842
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 03:18:49 +0100 (CET)
Received: from [192.168.1.71] (78.105.105.80) by woodbine.london.02.net
	(8.5.016.1) id 4979BCBF00CE1901 for alsa-devel@alsa-project.org;
	Fri, 6 Mar 2009 02:18:49 +0000
In-Reply-To: <1236302368.7568.21.camel@desire>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6551424731305309072==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pHaYuEtMoCqoOHx4DNdD"


--=-pHaYuEtMoCqoOHx4DNdD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-03-06 at 01:19 +0000, Jo Shields wrote:
> I've got a pretty new Gigabyte board, using snd-hda-intel and an ALC889A
> chip. Whilst the chip seems to be detected fine, I have no functional
> audio out - no sound on any of the ports.
>=20
> dmesg shows that ALSA has no idea about the specific model:
> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
>=20
> If I'm reading the source correctly, the default pin layout is
> 3stack-digout. I tried 6stack-digout, but it didn't help.
>=20
> Linked is output from the diagnostic script:
> http://www.alsa-project.org/db/?f=3D3938bc16481f549203e373e303c4b1c1dfb30=
3dd
>=20
> I'm happy enough to try things out in an effort to get the onboard sound
> to behave

Scratch that - it seems to have decided to start working after I messed
with some of the switches. Oddly, it's identical to one time when it was
merely popping and clicking (plugging something into the front-panel
audio helped, but the fix seems to hold between cold-boots)

--=-pHaYuEtMoCqoOHx4DNdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmwiAUACgkQWQvNUd/Cr8HWvgCggD6WgsZ8z9K1xmoeceF05NuD
aJUAn3ES0qcAdw9YyKF/Q/sfE+vNcwS4
=ZEek
-----END PGP SIGNATURE-----

--=-pHaYuEtMoCqoOHx4DNdD--


--===============6551424731305309072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6551424731305309072==--
