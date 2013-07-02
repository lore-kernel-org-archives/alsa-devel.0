From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: brownstone: add .owner to struct
	snd_soc_card
Date: Tue, 2 Jul 2013 19:13:31 +0100
Message-ID: <20130702181331.GU27646@sirena.org.uk>
References: <CAPgLHd-VN4BiM=cEkFF4EgbL7iqR1XrhEzBiKyoJBVnzKspHJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7178140751244729580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 613DD2654B3
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 20:13:53 +0200 (CEST)
In-Reply-To: <CAPgLHd-VN4BiM=cEkFF4EgbL7iqR1XrhEzBiKyoJBVnzKspHJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, yongjun_wei@trendmicro.com.cn, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7178140751244729580==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Bm0M7I+ZJ5WKh7s"
Content-Disposition: inline


--7Bm0M7I+ZJ5WKh7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:26:21PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.

--7Bm0M7I+ZJ5WKh7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0xhIAAoJELSic+t+oim90TQP/3t1NZvLnMQn0HXkttqbQ8qr
viErAc+/cLzqsU1Q77C8Vg2O3FZpOEhc15ru7E0pGi22LkDD9iqacypPYBvGOkys
7tlelniz+xpZywTVnaMS44NZ04tiMKIAhpXcA6N7l2ZBY3hBKmDtg2i/a6vVFswH
oldyoDDaXKHJ1EqlI/p3VYLUb7WXaKAFNp8bBLc1Cof9dxk5S8rdTQxAAohCRTw5
tHEGgW6+GkQfXEww1GUEKpvrkaLS9h1MY9KiASUUygpPpCYCHKQXcveWYh0bHR3O
r4MrzOFDQ2uTefwC7K+RvVmnCtM/zL811lZtJSwQ+MQSDW/OPy+3e8sIBUE6Fmu0
BzjDAQlYN3jmXy6dpKdZFsxZN3zdL2OSIq6oXCXlsnkmgyNc7AzcNHoXaqMz8XwG
olxInVU6Ihi9JaG2PfW3xgnrm70tUt0/Ssl/AhFoYpVqe8iGCplWmgWUvSdFrHMf
63HF/qK7dA6LWeGSsDwVrIpVLlFbjF4NzSSBNvTdfX21lBhuxXQMpobwaXc1hrBL
xKiuVV9Ndm+7YxiFj1K5CG8FmrxMRAfwptDW0FqWmmcl71qygPRjdsuBcMqnB/fD
e0bcRcasWHiywrWKYpWFSJERAVzpNJTx6LJEvhcoJk86ldETN3CzcAfL0e7DlLng
qs76lDhmDgU4fuughvtk
=YRCW
-----END PGP SIGNATURE-----

--7Bm0M7I+ZJ5WKh7s--

--===============7178140751244729580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7178140751244729580==--
