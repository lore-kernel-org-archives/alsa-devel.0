From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Sat, 18 May 2013 12:25:05 +0100
Message-ID: <20130518112505.GS1627@sirena.org.uk>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
 <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1774499795030084379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD8626170F
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 13:25:10 +0200 (CEST)
In-Reply-To: <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1774499795030084379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Content-Disposition: inline


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 18, 2013 at 07:03:24PM +0800, Barry Song wrote:
> 2013/5/17 Mark Brown <broonie@kernel.org>:

> > Otherwise this looks OK for ASoC though I'd expect to see a change to
> > registration of the OpenMoko BT device (perhaps I missed it though).

> sorry. i don't understand. i would think OpenMOKO can also use this driver?

If you change the names the driver uses to bind you need to also update
the users so that they use the new name.

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRl2UNAAoJELSic+t+oim98VoP/0Q3soC0ewnfonrM0nt4B8OM
olkiLXiQAcjWLSMqxQz4lX4ptOhORbBDFmnsQZfJg2A8yY1Qu7Rbct0HZih6wreS
YHV70Icd9FNfggo8rn1LlU9E0Rsmw/ZE8u0R5IYnO3mqDsj41Aw+GUVxuut5idpa
32sxSK+fqHFI8tHxW5dr6GmRYh0gH5ywnNc0bDAGd2BFCP6yJ0Ibo9kAFmjiU1cq
KhN4Si+vEExfhC6VVJLGicwVHPS5T15Dms2dbp/viaXd9HQ/TeUZSrcrtB/s0sJL
HEtcTGpSgz/QDc3raWq3Pdyas8iPhGuv8zFF4z/ZPC/VvEkdhHx7LpqVkDY+lZPl
4bCFZrhPGGFuyKOzxoQtNR2R9rqlucH9pyTNjMu3UuVorkE9xmFpb3U2Kv6+Eurt
6Izf7sPctnk9PT1tBMxuj3SQAk9Ze4qJ+e4MO70zdTo0x52H7n8FFiQv28q84QV+
zat5ALx6sP1T+P7s+QuK8WU7jTqyRyOx0E/Ph4BkOG7rC4oynR2t0Yu256+I4c8A
/cIeTAh/miUnt/77m3Rt3p4zQj+5i+Rmi7h4RciZCU9Ehv4Q1lwaBK0QmBDUqv0G
7W35Z90wITlgvLdcNxikgdd7CWo4SyH/+YlzROs3AswXYlOl5uJf3r15/5r1s1E9
NHkVmLHo/LWt7kQydUvi
=cMXh
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--

--===============1774499795030084379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1774499795030084379==--
