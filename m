From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sti: correction for HBRA support
Date: Tue, 1 Dec 2015 11:35:11 +0000
Message-ID: <20151201113510.GF1929@sirena.org.uk>
References: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
 <1448370996-30224-3-git-send-email-moise.gergaud@st.com>
 <20151130163057.GA1929@sirena.org.uk> <565D6DCE.50906@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7207690055862650600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24181261A34
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 12:35:19 +0100 (CET)
In-Reply-To: <565D6DCE.50906@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7207690055862650600==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hf72EjeiW3qFOybB"
Content-Disposition: inline


--Hf72EjeiW3qFOybB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2015 at 10:52:14AM +0100, Moise Gergaud wrote:
> On 11/30/2015 05:30 PM, Mark Brown wrote:
> >On Tue, Nov 24, 2015 at 02:16:36PM +0100, Moise Gergaud wrote:
> >>Detect HBRA based on rate and channels used in the pcm session
> >>In case of HBRA:
> >>   - CH_STS repeat is disabled
> >>   - channel status sampling freq is not set if already set (because it can
> >>     be a multiple of the runtime rate)

> >You might want to expand HBRA...

> you mean in term of frequency?

No, I mean tell people what the acronym means.  It's probably *not*
Herefordshire Breech-Loading Rifle Association which is the first hit on
Google for me and even adding iec958 to the search term mostly just
turns up this driver.

--Hf72EjeiW3qFOybB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXYXuAAoJECTWi3JdVIfQNCQIAIG/yjM9QUOP+8AMMgVU4K9I
Y9Hf6rorU/iOHYD+eIhdKRz0tamhvaDAs3bpXic/4aiIwgaAolDKlUxy7gT9TuLA
juw8lydt0IrC98+6AL+Qjkbi4cCvnYt3e7un8ZM1/Xsmu85gjXkkoc8fS8CvUGB8
XJtm5FMl37AP/4C/PfXQey3XkIyoERSk4qHYvsX7mV7m6ycAVUJBmgMapYUb9+Bd
CQKYHodDLxGOmrZw3+3PNzFL20FEzR/kI7Bv/MvAfRpWXrYGmx0btnp8OVdJl12Y
Lkact8u7jgq8XdKoHmu5W9dVwajvDC3+Xr/z0hgAxibWvLtcXG/Qc4+cr84HLOU=
=L3MJ
-----END PGP SIGNATURE-----

--Hf72EjeiW3qFOybB--

--===============7207690055862650600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7207690055862650600==--
