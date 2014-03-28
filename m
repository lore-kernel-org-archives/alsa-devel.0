From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3 v2] ASoC: tas5086: add regulator
	consumer support
Date: Fri, 28 Mar 2014 11:35:21 +0000
Message-ID: <20140328113521.GA30768@sirena.org.uk>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8192313366882953424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7043A261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:35:33 +0100 (CET)
In-Reply-To: <1395952936-10670-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8192313366882953424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5wOvoHkaccQRDme"
Content-Disposition: inline


--q5wOvoHkaccQRDme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 09:42:16PM +0100, Daniel Mack wrote:
> The TAS5086 has two power domains, DVDD and AVDD. Enable them both as
> long as the codec is in use.

DT binding update for this one as well please.

> While at it, move the device identification from the i2c probe to the
> codec probe, so we do it after the regulators have been enabled.

It'd be better style to enable the regulators during probe to read the
ID register rather than deferring.

--q5wOvoHkaccQRDme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNV51AAoJELSic+t+oim9WjoP/jSxRzVFngvIaVGfd1nwv6jf
jAALQcJiqPKV7spnpOYGovfs7oY+8VLcJzD9qbfvvmrka2pglRN3WsnzoJc/qT88
7rIp9F8nDFaxSR7D2uaBrzk30YNDmFGH5gCuSk0Mz1yPu9U7mMiogPShDGONhC9d
MiYKFPmachs7s8KKRPlZJT3Re8uZc/DmZUypea9NsM07vr7ZkO43MAUqP92W0Kep
JKD7NMTiPh8wK530EJNf/kLQhlyf6qpQyjVE1kDU1XCETuEaadOeHd2SwpBS5ea+
0d9ohYEmQMwbx+WHfy1sX4J/tDcpbs2fnkr+KQPL/X+0OqZdTViZKDVPizBeAFrb
FTp+HJCa7IJmBK9KPW29Omv4rJ8G4WL39mVF80euBOCMiMqK1VM5AL9uqVDwYzg1
8s4VzysYDpPKa6H6+A9ozMAqvvGFrUh8Ol7gdaQ4DgRZ+pzFUctjyr21es3r+Ydo
bBU7LvHWvrOAlwBkL1gB9PRXgzi6pS4tsPPx7mMp/9JE+nc90d/sBYabmyhFM+Pg
8I0cawf5cQEyvx2zReqs2JxqR3igIXnjhkoZBjDtrd2q1FRSaoJKtX06maX1StiO
ilxMh0qXabDdritvqcDxegljrDO+6nOiP6tH8tF1BC+BpKze3tSyow6A9Muh7QqR
2WMPlBr+E7+aGqncQL1Z
=iaWP
-----END PGP SIGNATURE-----

--q5wOvoHkaccQRDme--

--===============8192313366882953424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8192313366882953424==--
