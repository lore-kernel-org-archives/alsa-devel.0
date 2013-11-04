From: Mark Brown <broonie@kernel.org>
Subject: Re: What about symmetric_channels and
	symmetric_samplebits?
Date: Mon, 4 Nov 2013 08:17:03 -0800
Message-ID: <20131104161703.GJ2493@sirena.org.uk>
References: <20131104110250.GA2652@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4409186481023593987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (unknown [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B70E5262629
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:17:55 +0100 (CET)
In-Reply-To: <20131104110250.GA2652@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4409186481023593987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vFj1JTFBn4Zx1dEI"
Content-Disposition: inline


--vFj1JTFBn4Zx1dEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2013 at 07:02:51PM +0800, Nicolin Chen wrote:

> In soc-pcm.c, we have soc_pcm_apply_symmetry() to solve unmatched
> sample rates situation for simultaneous playback and capture. But
> we don't have one for channels. Is that reasonable to add a similar
> one for it?

Yes.

> Likewise, we can treat symmetric_rate as a solution for those SoCs
> or CODECs which can not handle asymmetrical LRCLK. But it's also
> impossible for them to handle asymmetrical BCLK. And accodring to
> BCLK = LRCLK * channel number * slot size(fixed or sample bits),
> sample bits might also be a problem if they are not using a fixed
> slot size.

We could add core support for that constraint too, yes.

--vFj1JTFBn4Zx1dEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSd8h8AAoJELSic+t+oim9UYwP/3fbU2D07UmfILfzznqllj/N
HDsvLm5zDlWikOvbA+yzsreGKrgrc7WFOkzxVDdvuqnSkeCkjgFBV7JCV9Muf8cd
+5NTV7+7saMySiFK+fDltCcWWrOw4Rxntz4+FMQ8GkzKvP18knQpPEEZFXdeSdLg
RRCPAmMvpM9OnkrJSvFzAg6TOY10Dqp2+q4Do3He12aoxQwY/UaDFeQm1LeOEry0
znKIrtG2bGvR8WVL/FbrjMRq+ZoqI8XPyQCjtNaeYdkURKt40Gsy/bM3i9uCkqhM
71yMOij5SJNSJH65i5F7hO7Bppi1HNLtc0SXIuJUWVBjRpmhiKVH3yvUd2J+clXv
IAR37E3Vb6YhBKZANRrVhOOIdx3zENE0QWsITBa7LEbKoSmCLFJmbxErRcNiZfVM
MvETmdafv4gjyZgW8imVLmMSwKVxtOIK0QCqKWLPMoiUoxo8zEq6OG3hTqXeSibu
m82QAf9kIi88CcspXrgupouzGqG9FHxhFMy/pDR2s/BHzPy2ziDiHZ/aUlYP30cx
Kp3+QJtrcfA/YJAHM4iCEkm9q1YXAATNoLhOZLP+6iiP+EgZvrJNAVr7dY6Fm+hq
ui00zhmUBleXX7JfKFTWcgMAaWTsyjs9GF1ahDUTt2FukRw0mZVmLsa57QzRTiBt
Yw/YbUgKQ81OOBGB8MH/
=xwUh
-----END PGP SIGNATURE-----

--vFj1JTFBn4Zx1dEI--

--===============4409186481023593987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4409186481023593987==--
