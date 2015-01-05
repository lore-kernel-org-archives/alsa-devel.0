From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Clean data after SST fw fetch
Date: Mon, 5 Jan 2015 15:11:21 +0000
Message-ID: <20150105151121.GS11764@sirena.org.uk>
References: <1420334720-8112-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4125052482932338142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26549260411
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 16:11:31 +0100 (CET)
In-Reply-To: <1420334720-8112-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: libin.yang@intel.com
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4125052482932338142==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sePW6jt3Xq+S2rdo"
Content-Disposition: inline


--sePW6jt3Xq+S2rdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2015 at 09:25:20AM +0800, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
>=20
> The BDW audio firmware DSP manages the DMA and the DMA cannot be
> stopped exactly at the end of the playback stream. This means
> stale samples may be played at PCM stop unless the driver copies
> silence to the subsequent periods.

Applied, thanks.

--sePW6jt3Xq+S2rdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqqmZAAoJECTWi3JdVIfQPtgH/jQiJmgNwfdiNO3/xpxRSYKk
4u3Q25KiQdpvzbPLaRFdg9lffQB8ofuUet1o8nIdrzObPA0eNfiq8fbd/qeHLnOR
Rzh5fyoNAMPILM5EVbruroNzvg2FPmW1RyK/SBPbMoy53KSZzGvoojkKsoVr8JDB
Y0aIO15wrcUDCrLT7Gfk4D7U/n8qDzHpKJm0f5WJtn9hhFTSnuV6/kHBHeecuJzL
PJDUGvg9bRDtm2akTp6Cw6EDQ4B3scdcOuFKNJglmT3+bpVdumA78hoUs8SjSq+3
Jku5HKVwxnYWQ2Y83b9bS4oGltMEQFv8F5WSRYjEfLYTGYXR40vNQcC1jPHxYCM=
=cn3U
-----END PGP SIGNATURE-----

--sePW6jt3Xq+S2rdo--

--===============4125052482932338142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4125052482932338142==--
