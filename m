From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Change SR and WSS computation
Date: Tue, 4 Jun 2019 15:45:17 +0100
Message-ID: <20190604144517.GF2456@sirena.org.uk>
References: <20190604085449.13195-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3270520772289476369=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190604085449.13195-1-maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3270520772289476369==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLVMksexArUZ/iL3"
Content-Disposition: inline


--PLVMksexArUZ/iL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 10:54:49AM +0200, Maxime Ripard wrote:
> The current computation for the SR (sample resolution) and the WSS (word
> slot size) register parameters is based on a switch returning the matching
> parameters for a given params width.

This doesn't build for me with current code:

  CC      sound/soc/sunxi/sun4i-i2s.o
sound/soc/sunxi/sun4i-i2s.c:169:28: warning: =E2=80=98struct sun4i_i2s=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
  s8 (*get_sr)(const struct sun4i_i2s *, int);
                            ^~~~~~~~~
sound/soc/sunxi/sun4i-i2s.c:170:29: warning: =E2=80=98struct sun4i_i2s=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
  s8 (*get_wss)(const struct sun4i_i2s *, int);
                             ^~~~~~~~~

and lots of similar stuff.

--PLVMksexArUZ/iL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz2g/wACgkQJNaLcl1U
h9BCIgf/WLTKo7F+GH5yembRxj+jHQz35TZZPqb9mhx/Hyogn+/+bF5LeqEi8hKq
L7Mpzf0KyzhKz/VDRGc3TlsLihsQ0okqybE+/PlOS3Y7DRvd115KYLsOdfVYOucD
bF48im6bMWWARcoIyK6B2vAYx9y28Z4qUgLcJGOcLVwwCC1K/nq6A9kFul0lXXs6
44SRqWz911MOpt3VCP2FHpMnjiHcJP9nZ0pRZTmaV057lQCthPaCNuz+r5nzGy/Z
Oh8Q+0DbkTmOriia5YZ6OY83lRYHBKFEPtc3nf3zuxgesObEJdvPVRur6ZGZSNDL
tKXQOFITXAVWrTfyE+Z809Bz1jgX5g==
=cwPD
-----END PGP SIGNATURE-----

--PLVMksexArUZ/iL3--


--===============3270520772289476369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3270520772289476369==--
