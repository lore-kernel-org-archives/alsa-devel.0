From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Don't issue ipc when
	processing response
Date: Fri, 1 Aug 2014 19:12:48 +0100
Message-ID: <20140801181248.GG30458@sirena.org.uk>
References: <1406905784-31182-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4641784825948403305=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 883E326569B
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 20:14:27 +0200 (CEST)
In-Reply-To: <1406905784-31182-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, pawel.piskorski@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4641784825948403305==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wVZWOnidjbeavOSq"
Content-Disposition: inline


--wVZWOnidjbeavOSq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 11:09:44PM +0800, Jie Yang wrote:
> From: Pawe=C5=82 Piskorski <pawel.piskorski@intel.com>
>=20
> Make sure we dont issue IPC when we are processing a response.

Applied, thanks.

--wVZWOnidjbeavOSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT29idAAoJELSic+t+oim98DIP/3Zt61rm/CBQAlPvzB0tO6nd
Ix4WnrS3PT6mF+rf9Ga9GrmVriMxmi+TLn+eiIKbahbW0Umb0mTrYkJc+WOrk3TS
sZ8vSg9VNFiXRiiLNUUIY4tl/ytiOUfYvImafLA68ON6NQW/Fjpyc/ph+vMk6qCe
9Q72ies+zY60B46NQ+HYv1IqJ1/rga/pWELZFTHUIh18N6O6oHOXbmLo7dEWOybF
qKQyN8Aqte1QVNMTYQOX0qCGH7MdJhBpy6tvfllGQBLN7OcHGV4GswiuMt4PXBfb
Zj/veWru3D0ZPAmXtqlpk8Qu7fzmCQdqapTd35N9eeu0gcNxQ6hUCDlNffHqR1dd
xsHJ/Epc0hs7dagflWAk1QxBnTsdH5FYhCjNXp42eFkfHQ2H3rh10jkeZH57Ke08
I0rJqKUKvSBMZPdp/SFAnmbw5a3xYQwHggi/yDn02t5rtH9u0qArvQDlN4BorVQ5
pjnhyUQRMgbjIAo7Kqf5b55ix1h0NrXR9HWFsKly9z1aKxBUyQAbQ6fivQtx3h1H
w1gBzYLbiHfXHy6/70b+DK+1Zyu0DJ2P4tC8QqGB2Ms0cY73WNXFbTs9VtTqYTuP
mS5izX1gB4jQO1OQs9z2AeQEYIDB+woEgo4zzyBuo7HxRx17+M168waVAlURnKj1
S7XBLSEdqUon/+JZXWMw
=Uiho
-----END PGP SIGNATURE-----

--wVZWOnidjbeavOSq--

--===============4641784825948403305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4641784825948403305==--
