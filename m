From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 16:08:12 +0100
Message-ID: <20160518150812.GK8104@sirena.org.uk>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5075097909693158345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B722B260526
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:08:26 +0200 (CEST)
In-Reply-To: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5075097909693158345==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 18, 2016 at 03:41:29PM +0200, Alexander Stein wrote:
> In case there is no DAI (yet), do not print an error, this might happen
> a lot of times. Print a notice instead.

This is changing *all* error reports which isn't OK.

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPIVbAAoJECTWi3JdVIfQaWUH+wZqW/SCVi8a0/5eD7/eBC5z
guyaeXvqwRkkLQy/CotKKZKIJ469qkPTgN+Lcz/CaGeGVQlJ06tiLgAXaMrTt3Vg
EvSw/soAjqY22HRMUdSvJoypB8kA5MoKt1ZmEfMqXCAdeHQIsXkBXjRdq17RkZYj
KuuHpOiNdYZ3ho7EH75jR1zRaaOUY+L12eGPzkki2QxzTA5hpd34Qn/drX2173iQ
bt1jUu8chWc3ZIRDTfRZGPI+fhADPU7kIIV42X+aAWmd+IujftdckRXTHeSPN7ZC
bKcVaw7P7MkKVICH2Qerc64EiLZMkV7tjVnhUa+LpQ0xPyrpjKEONawc3MErpDs=
=dlqF
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--

--===============5075097909693158345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5075097909693158345==--
