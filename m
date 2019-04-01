From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] Documentation: soundwire: Ensure that code
 is inside the code blocks
Date: Tue, 2 Apr 2019 00:52:11 +0200
Message-ID: <20190401225211.GE2095@latitude>
References: <20190331223423.29855-1-j.neuschaefer@gmx.net>
 <20190401154003.7eddc9e9@lwn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6087380232174640784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F974F8075C
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 00:52:23 +0200 (CEST)
In-Reply-To: <20190401154003.7eddc9e9@lwn.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6087380232174640784==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:40:03PM -0600, Jonathan Corbet wrote:
> On Mon,  1 Apr 2019 00:34:22 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > The way the document is written now, Sphinx renders empty code blocks
> > followed by the lines that should be inside them.
> >=20
> > Unindent the code-block directives to fix this.
> >=20
> > Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup w=
arnings")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> That definitely makes things better.  Applied, thanks.
>=20
> I'm going to take out the Fixes tag, though, since the named commit did
> not, in fact, introduce that problem.

Ah, true, the wrong indentation didn't come from that commit.

> It's also good to copy authors of patches named in Fixes tags so they
> can defend themselves :)

Good idea, I'll try to remember that.


Jonathan Neusch=C3=A4fer

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyilhIACgkQCDBEmo7z
X9vZ8A//Ubr9LUXRv3XHqbcvLtsVzW1M+qSredcJrMbpgR86ynQnBKQH1tM0Z7UE
CE910vJTtwKogXfB/ohMwb1mOUlumajBuhCPO4MRKj6kO4et6g8kgNU3rUJj2Eh8
9OB1rOyWADqOJLbxZq/W+FPt217NMNry/BrWu9JSXak4Y7pax3cJOuSTt1IHuSzx
+h7AcudAKgiAvnYC3hVh2FZdSScQIpEf/G6oP5uvv2YvF1QOnGXhShGBzBKxZGp7
hjOWwJLZ1hTnMgV6eIGYackJMMqPSnAfjtLLn7YZH90z1T9ehorUOvVFp5fd/6j9
duakvKusP4ED6llf7LiXmanOhbqq1M74qtD5eUVwmexsW1omGYXV48dQzElgrO6B
K0v8LML3g0m7L1wsWrdOYwCXReEWjTdGU5gVgfmi0O7PSRPy0sW1/vTqOctSGSfZ
1o6+n6E6RZ9vnq1IzyPZw7cNojn+vU7zr8bhF4a+jFGiDsuZJB83wXLOgoupajhO
az+Y2QvDXq8E4U5U+4pAuv1K9XEvoDcrG5D2CsJxgA0Z+Xifp3NN5Qwa4XyTUkSj
ia3NXHW+BtNcOBUnNa37kFLiVkokER7wwvxqD2nMB4ujI7QzYlQFZfuSKOIP6TRk
GlE5Gh6AC4USqRXAyPa3ZkqqSEoaCz+6AOrcX+yXYBZ1BuSAHNw=
=0pIl
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--

--===============6087380232174640784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6087380232174640784==--
