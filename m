From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8903: Fix the bypass to HP/LINEOUT
 when no DAC or ADC is running
Date: Tue, 9 Apr 2013 17:44:38 +0100
Message-ID: <20130409164438.GR9243@opensource.wolfsonmicro.com>
References: <1365520439-15659-1-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6871098085970718316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1365520439-15659-1-git-send-email-alban.bedel@avionic-design.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org


--===============6871098085970718316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tbn31orTZdSAVHoc"
Content-Disposition: inline


--tbn31orTZdSAVHoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2013 at 05:13:59PM +0200, Alban Bedel wrote:
> The Charge Pump needs the DSP clock to work properly, without it the
> bypass to HP/LINEOUT is not working properly. This requirement is not
> mentioned in the datasheet but has been confirmed by Mark Brown from
> Wolfson.

Applied, thanks.

--tbn31orTZdSAVHoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZEVrAAoJELSic+t+oim9SFEP/3Tmad5GOfC0hxR1y1emyWZn
R4mMDI8FMWG0+RmyewXvotT0MquezHg4s8aZ1yFoRwPGyjMP6dDal9Gcoz1Fk5jt
BtyI4aHTMJuI1zMcbDnaoiymJ8xJpRw93kDjSUTl5ECo/I24Oj1ErXyFS9t2RDwC
nBs7m0PvuYNaf1JOcfX5si4aj8gACgsYD+WhQ7DRVBfTPZQvjzJT9ac9ELTTtKTC
X395utBLM2JvUxmEPxQvLzPxZQXjTfIt/njNXuohcnvjwNp7LE4YnlOLj6VBqF6V
2bxyJ+xE92WG98bOKN2y60cjYgqGP6YSP3kwcEza91WJLttebe5ydeGd0/qRoF2H
rl4BOikgG0vYuvrdfICKq6FxaGeydUe4oFTOlsH2Px0gZYyURgWvkPBbPZI5zgo+
woFFKcZdKl478VmTjJx4PTQije2xg7z4ALS0A3LEmzeuXY5MubfGsU/eXUgF6p3j
yFw0Ru6yO7020K5CwFJgb3lU8JgNhcwwJvIKevhMbmHiD9Gxvq1Qe6owPK71UA86
wANzZanaOagYj4pC412KCBt32pShIARe6PD7rN1kZiVcnom48SsvnvVEyRGAtro9
gsbS9ibW0HDLYR0qgrEf7KIJWCagyzqCqDSMrjk0lufFI/RP5ADndz9PR1FK/N/n
mi61K0SOjF78h+C0utah
=Y8sU
-----END PGP SIGNATURE-----

--tbn31orTZdSAVHoc--

--===============6871098085970718316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6871098085970718316==--
