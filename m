From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/10] ASoC: Intel: Add
	sst_ipc_tx_message_nopm
Date: Mon, 31 Oct 2016 03:07:55 +0530
Message-ID: <20161030213755.GJ3000@localhost>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
 <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
 <20161028180534.r6osk4mz253xeuwc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4813118336266619205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A82D2614A0
 for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2016 22:28:47 +0100 (CET)
In-Reply-To: <20161028180534.r6osk4mz253xeuwc@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4813118336266619205==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2016 at 07:05:34PM +0100, Mark Brown wrote:
> On Mon, Sep 26, 2016 at 11:05:29AM +0530, Vinod Koul wrote:
> > Add a IPC API to send IPC without waking up DSP.
> >=20
> > This is helpful when the DSP is already in woken up state(not in any low
> > power mode) and an IPC is to be sent.
>=20
> Why is the IPC API for cases where the DSP needs to be woken not
> implemented in terms of this one?

So driver can send an IPC message but it doesn't know if the device is
active or in low powered mode, so it checks...

But in case of later, the check yields another IPC message to bring up the
DSP, then send the original message. Having same API do both causes circular
dependency, so we ended up doing a nopm variant which is used to only wake
up or put into low power state.

Thanks
--=20
~Vinod

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYFmgzAAoJEHwUBw8lI4NHTh0P/i0sblVjNvjqT0Ouae6YzLDB
LeJIZqogQXXreLAmL+LBjMSDtCsxk8jYqeb2SHurHzT+y6fFMaZugGl8TkmhlQGJ
ZCOhnu/0n1WP02twUZq3usBve9h61H00e6UwU1O8E0dECHfREO3mnJjGCz+PuAn0
5OS+0WIKO5ldRCstmMYzzBzww+NmLuTFvuckzD7bnlK1eeoPZ0l2y9reaEWWcQnI
bv4nvg115jgqF+43sepCWiZ5wrFf6xqSh9QksG+0hI2ZowWlWIH7kORhPmlK43tW
GcejGZ+pwnYJDTog1Rjkvz8QFf3Ry3r90UIXVAGdue3hfs3YtgezwYgamUwRoJ9H
3ve0qe0+HQkx8R3269GmLUpA9TA+hbiGvfKy5e0IuCxSUzfutPtOvcy63/pP0C60
9U+pZ5fob00l1ittuoXWSf4Nr3kBRusWQEL/UZ9U0fR9Fd4t3q8zEG5UwPeZwB0H
BH8SOwluZn8hNinWPPuqdaGNFZpqclbGC7PnW+zEpehrqBej17Do+fKqOn8pjPdJ
UVKqL3vPS2Fcb7P4FUw+wa2to2+pPZZ/NSU5LbHSEdJyquuhwdYQNKu6V34vaQRr
aFvoqWJhgF6y3EyKQn0Fy2xGYOjg5XrXKlNMhkPqBSw05kvlsW+rpvAEzMx+YGsH
7fYS1ErG/XcpDTacMVXg
=f9e6
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

--===============4813118336266619205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4813118336266619205==--
