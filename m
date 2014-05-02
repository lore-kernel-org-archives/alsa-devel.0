From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix allow hw_params to be
 called more than once.
Date: Fri, 2 May 2014 09:53:48 -0700
Message-ID: <20140502165348.GN3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-6-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3706936916494649052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C05442654D9
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:53:57 +0200 (CEST)
In-Reply-To: <1399046194-5544-6-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3706936916494649052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TP/bj4LqHgxpFBA9"
Content-Disposition: inline


--TP/bj4LqHgxpFBA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:32PM +0100, Liam Girdwood wrote:
> hw_params() can be called multiple times. Make sure we release the DSP
> stream that was allocated on previous hw_params() calls before allocating
> a new DSP stream.

Applied, thanks.

--TP/bj4LqHgxpFBA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY82ZAAoJELSic+t+oim9O/YP/24TmKrusy2qFcCk22tUPYA/
b0Cy/bycS/7a74pmdM5pb3Q1kQjha2aK5cnmpO99/Ar9wWhnZNiuo2fAjFxWwYxn
qqo05DtaK7iUHKmXbHXcxvP1cR8VAEaWXYoXk3S6NJQE3td+evePGL2+CeiOpadl
y2Dhci8JidHZkI6i9iTDQyVjf9fpH3AQQwdwlOG2xeDiJLt95twVwCj5n9NPuBeJ
ufz1FfHBjKLf9mihihmHuf658VTrTd3yT12poHpeClfTUlSzWQEQj/NWoWwpf70c
DYT9M6vpRY22QwcyPMhDTpTj1oePcwDeqHyp4Npj7hkOGf62Rz4p93q6Oa5j15OG
Ils+i5naMn7Y2cxOZzpRGaHmu6VTQoOonsNjH5qBRooZdY1RSPDFimyZhC6e+9y9
pGrE0Pql5OWYuKZ42qRdgH+xOeT+i04BgWer2T3Sj6UjKI5qNiW71mQGzsKODhTe
pG/rVYyix9f1RXK7Mmz9kFkIZ9zgMPlkzAnQJRb2cUUQ4naZSs2bEc7dsXAXGMIR
yMhXd7uLH+g86FuLRRG9JJiyIZ+aXKqG4xMRI80SxYbARF/BIXD6fuJE4RB/tXsN
bycRQNWwUh5OL4uyH9/mYq7vqKpI7gDdDs/nJh3+XOPiBKJeII9iORlGIytWsow2
kZmAMmCTxpm8Mskrqz/Y
=ThXn
-----END PGP SIGNATURE-----

--TP/bj4LqHgxpFBA9--

--===============3706936916494649052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3706936916494649052==--
