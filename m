From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/intel 4/4]
 sound/soc/codecs/hdac_hdmi.c:725:42: error: 'struct hdac_ext_device' has no
 member named 'hdac'; did you mean 'hdev'?
Date: Thu, 15 Feb 2018 17:22:20 +0000
Message-ID: <20180215172220.GG8374@sirena.org.uk>
References: <201802160039.DQJdakQc%fengguang.wu@intel.com>
 <460034f7-dfbe-6df0-6eb5-ef7b1d707f31@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7029271650399080796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F353267CAE
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:22:36 +0100 (CET)
In-Reply-To: <460034f7-dfbe-6df0-6eb5-ef7b1d707f31@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============7029271650399080796==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 10:19:55PM +0530, Kumar, Abhijeet wrote:

> >     sound/soc/codecs/hdac_hdmi.c: In function 'hdac_hdmi_set_power_stat=
e':
> > > > sound/soc/codecs/hdac_hdmi.c:725:42: error: 'struct hdac_ext_device=
' has no member named 'hdac'; did you mean 'hdev'?

> My bad i missed it. Shared v2 for this.

=46rom the patch applied mail:

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

I'll do the incremental patch.

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFwcsACgkQJNaLcl1U
h9CoFwgAhbLxJMUKX5LjOprr27RqPaCKbk7FzemFWAHC8abf8fIBW017TIH3x0Lr
/VQYreWK3ySvt8K+mvFr1XmgyEFzEPrCcru4KdKD6OMHlu2/Ih0uehgMRKhiq57C
DGGjlkorl2CBQ1IuTxO2LRmJ+FlVKcS2XueWYQ6Kr4eRuPtCz/G3Cgct6NS7AJVN
HCPwJHwvLIe/oFpWzatZFEcfwJVyjiwm5rXbXJNR/HPiP2scJmwxyWdNvGIjltsp
ZfGoz7NDKPTdZusTuQXv3FE2qIUYBrFZOqJp578sElZCaSoj8KGbPVTwa7n2qC/3
2Uomjfry4Tnrz8iFTYlNbHxQphHrbg==
=nKFp
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

--===============7029271650399080796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7029271650399080796==--
