From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v3 13/14] ASoC: SOF:
 Add xtensa support
Date: Mon, 17 Dec 2018 14:24:40 +0000
Message-ID: <20181217142440.GB27909@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-14-pierre-louis.bossart@linux.intel.com>
 <20181211230813.GM10650@smile.fi.intel.com>
 <33d6f056-efce-6855-3d71-34649482ed58@linux.intel.com>
 <93aff9af-c693-c951-4821-e9e334133ed0@linux.intel.com>
 <9d4269b0-baca-fd4e-a8a2-5da7ea5a851a@linux.intel.com>
 <s5hva3sfer6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1074611834827874589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hva3sfer6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, "rander.wang" <rander.wang@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1074611834827874589==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 02:45:49PM +0100, Takashi Iwai wrote:
> rander.wang wrote:

> > > [=A0=A0=A0 3.250889] sof-audio sof-audio: 0x0049fbcc: 0x80005ac5
> > > 0x0049fc60 0x00000000 0x00000000

> > Add more details: we use another tool to analysis the hex numbers with
> > a ELF file to get the correct information, so we do it by ourself.

> If the format is intentional and shouldn't be changed to the generic
> one, this has to be mentioned in the code as some proper comment.

> The use of hex_dump_to_buffer() or whatever the standard macro is a
> "right thing" in general.  From what I can see, the home-baked code
> does nothing but writing in 32bit words, so without the explanation,
> no one can see the reason to stick with it.

Or alternatively can the tool be changed to parse the more standard
format if it's not too hard to get people to update?

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXsacACgkQJNaLcl1U
h9CmQAf/dyBeOQnNlvf2C8xwKdCwxhnk+phZhA/6vevOkYKzWp+WYC5DWFBzBIJ0
VBdsmBokfFV15AS4coxCyboTh1p1oz7VpJN3lm+S7Pmx5hJyPa4NKMjr/Ns+J1xx
Dxwgt785cGVo3/E1hmSqL+y8nIw9KmG7u01ar5n6gSnQ4pRRvm4RILeUzIcbcrWh
1Vj74gpiwlsOZq349exjXwovK/Nlpd3XG6jWozMBBq2DlJj8ecYoT92UTYijDNjN
prn+EJEtCzwgPh0Sw+MyYwnyeYukqsxLbpR8WKb2PRG87LIf8i80E83/XTv8zQ2k
DbxxeodrE/Aw3WpFrVT22wT6JQdlmw==
=ze1z
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============1074611834827874589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1074611834827874589==--
