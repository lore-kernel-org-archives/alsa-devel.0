From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: move the jack creation to
 Braswell machine driver
Date: Wed, 11 Mar 2015 11:53:54 +0000
Message-ID: <20150311115354.GZ28806@sirena.org.uk>
References: <1426055081-10295-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2738334564381625754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD6E26057F
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 12:54:00 +0100 (CET)
In-Reply-To: <1426055081-10295-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2738334564381625754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OqXX2KyyhehiiWxy"
Content-Disposition: inline


--OqXX2KyyhehiiWxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 02:24:41PM +0800, Jin Yao wrote:
> The jack creation code was in rt5670 codec driver before due to the
> jack resources (gpio/irq) were defined under the node of codec device
> in ACPI on Braswell. We used the snd_soc_jack_new() to create a jack
> instance.

Applied, thanks.

--OqXX2KyyhehiiWxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVACzSAAoJECTWi3JdVIfQtYIIAIMN+eGIRKRljnQ0c6Cziteb
MbB5ACVGOKMRBYmYoiz47jaclNpxCOYAYT5RTd3z1k90QS9KSYpMQyYjkRMofHw7
wix9HM8yMQlMqKrs4Mk7x3O0dcV1zZLb+h6HDdWuktGtjDRcglY56uvJsuuuLd0D
QGhLAGQ7K08ARLNgyFjI7arojq/QfTRzG1ylO8SMIyiR2JwAxKTSjwKAVWk3slQI
bB3b5DNCMq6YGLxDP4NdFWzk01ssjeWxDzaczfwr9rvQQyV7giCkPf2tvGMvADd1
zzAxRlC6hHfADecWSLl7XtOdOZvyiyhVgPa13cI/clUtrnwPFk1TP6O9IE1Vnrs=
=UaIN
-----END PGP SIGNATURE-----

--OqXX2KyyhehiiWxy--

--===============2738334564381625754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738334564381625754==--
