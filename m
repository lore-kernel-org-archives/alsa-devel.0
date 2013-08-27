From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC;
 wm8904: Remove unnecessary call to snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:36:45 +0100
Message-ID: <20130827143645.GP10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6226919876529555027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2E2265288
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:37:02 +0200 (CEST)
In-Reply-To: <1377611461-3638-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6226919876529555027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpcCHpaCAbC4X43d"
Content-Disposition: inline


--LpcCHpaCAbC4X43d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:57PM +0200, Lars-Peter Clausen wrote:
> The core will call snd_soc_dapm_new_widgets() once all components of the card
> have been initialized, so there is no need to do this manually in the driver.
> Calling it earlier also might result in a partially instantiated system being
> powered up which cause undesired side effects.

Applied, thanks.

--LpcCHpaCAbC4X43d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLl6AAoJELSic+t+oim93/sQAJSwMKcfunibnecoiof8I/FB
+OOF5INQUmT+aCU5FXQGgwVQzJxR6lgLJZFSrExPHJ6fagdqvnHK9Tczn8ZPRe2z
DK62ZWQzaxB3aqLZPnB1RWdd4hzfxm2N0xDklOMo8v63KZM5QXI/dZDaqdpncWfw
k1oNM1FHp8+AFhzlrTGa4CgymjwCp3hUZ55J5LXw9ZA6VyJgilh7+h1ezvRPT8Cq
CxVioC0ahQzx7jDcFm6Ppl+hGvmxYSqSI+B1FeNzUF/oQQbkZNLNPhYl+j4KpcUr
W3FsfEXKSWYriuJNdQ4jmpQciIGhMwnm1TNaVuqrE9+XXAGg+3RkDZme8rElGjl0
Ej9SbLgt8JBLbPH92aFOwa6ddwUYF45+BoveEhE1wRHJ6CliCxFDd0D/v61MA19B
sKnGW54F4agRNWhz6kZ8RQdXsWjNHczkZCi+3+BWL2lr0M+4XCcZLvbwh/teyzcd
tPQuGRjArd6DAepN+Nr1U1Vo6YlsgTsvInDeNVD+wYdm3IU6gD1Duys8UHVcMJHS
AHuv+vcxsOX8uZY382EWz6jwQGeoOShDaIDSOcujj+moTy/8SJ7dlVUx6w8etpBe
HUG+ibAdBpOeUM1FD3sq7wTaZds0ezx5fD8oMigWtTDYQyecFGZvUwMuZ7fnC2Je
b+Sz+R2ssKd1ZTLxY6hV
=u2Q8
-----END PGP SIGNATURE-----

--LpcCHpaCAbC4X43d--

--===============6226919876529555027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6226919876529555027==--
