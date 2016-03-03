From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: cht_bsw_rt5645: Fix writing to
	string literal
Date: Thu, 3 Mar 2016 17:02:56 +0530
Message-ID: <20160303113255.GL11154@localhost>
References: <1456217420-9327-1-git-send-email-carlo@caione.org>
 <20160226021210.GE18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0712450879011265409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CE78726519F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 12:28:51 +0100 (CET)
In-Reply-To: <20160226021210.GE18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org


--===============0712450879011265409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 11:12:10AM +0900, Mark Brown wrote:
> On Tue, Feb 23, 2016 at 09:50:20AM +0100, Carlo Caione wrote:
> > From: Carlo Caione <carlo@endlessm.com>
> >=20
> > We cannot use strcpy() to write to a const char * location. This is
> > causing a 'BUG: unable to handle kernel paging request' error at boot
> > when using the cht-bsw-rt5645 driver.
> >=20
> > With this patch we also fix a wrong indexing in the driver where the
> > codec_name of the wrong dai_link is being overwritten.
>=20
> So how was the original code tested then...?

I know systems using this are shipping so surprised to see this.

Carlo cna you please tell me the configuration where it is seen.

Also would be worth mentioning here that Pierre is working on a super fix
for this which involves removing this code and getting the right IDs from
BIOS, so we wont need this code.

Thanks
--=20
~Vinod

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2CDnAAoJEHwUBw8lI4NHAQ4QAKL8kpkhGh5jFZIfjXhlm8Fy
A42szP0hbq/ujd6JfWAaz1vNpyMB5iRT1D7UjKaOMbqwFFqXIZYXCN6mcKj87fMH
Ith3akMPH4UG4xCaam7mEyN1zaG0CHnCtxOPhbdNJUljCIai/WL+eBGMjalI6Gy7
6npkyoxiZsiJlyGqEtOlph/DYgnBwtS8o8QLux6Apc2R+5s3tiwBojcyG3vufNh3
jucD0LwzqyvnVzb8HqJh0wnD42Zq+cNv3yW0xGjQaXQdXXivv3eDevLZDdvkDbXl
jAP+mVXIG9prFyf4Uw1+RNhjIY6k1+G/qgxwm3icfbzzv87nXyhXAAHqiMG/pXJK
fKu2fz89ism1JB5KzMwq4LSINqNCsPbBYAfoFe5BrEUiokkbyyePt5hvKFmiGU4X
u4WEooKAjAB3mmAL2WF+ZH9IoopW0G1HGuakIHaYPmczSI/54FEgBi1zF+2qcls7
g2IRb65ooDQ2zb7cyCSn+04QmFm7rEOKfZnKsHlwUsnH0dOma21g4tRl5c2pLX5f
KofWF8q+ls7sKbE8wtQR+PLoNIA9VHEEBrcS2gOI6keSEFkrdFM/PKrMK0vllsdN
Rssm3FH7CsP27E/NZAafNC6LhLRRIomLFh/xMBV4LCOD275EL0bTFtXChUg9n3m9
B8t4v48pZxWJhNCuBhOG
=w9wJ
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============0712450879011265409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0712450879011265409==--
