From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: add register setting for TDM
Date: Wed, 12 Nov 2014 22:47:36 +0000
Message-ID: <20141112224736.GZ3815@sirena.org.uk>
References: <1415792303-7728-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4754839233268214391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D764E265A25
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 23:48:57 +0100 (CET)
In-Reply-To: <1415792303-7728-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4754839233268214391==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LlfqcAVf8KvGQgdk"
Content-Disposition: inline


--LlfqcAVf8KvGQgdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 07:38:23PM +0800, Bard Liao wrote:
> We need to set extra register to avoid a recording issue in TDM
> mode.

Reverted since it didn't build in x86_64 allmodconfig.

--LlfqcAVf8KvGQgdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY+OHAAoJECTWi3JdVIfQgMEH/0f+w7wACuQSejZwjq7dWGjR
cFKu4POXZLyTbjR949RGrXVBh5OdToUR4TW3S6HVQMDOhUFuYuTHIOPwcvDw/jqG
XffGaPmin2HgjxTvY/+Thpraur+EYPt1nXjOnd11RnLBdTT/JerwqKzzkHnNnywk
/qXNkg93LKKMVgXRVlxz/VObK32gtBoLe+slWt8dBuOLRtzRmbc24ObnLvUl5BRd
htrpbhjAV6FhT7QiL12xyVvpDCPSdYWSItzZJS6JPeJx9moDNG7sL80wkVYkZcW3
rDLW/fIWeZ6esZYqGXWcuVrHHD+YcU5whLDaV3td4cUaBqrBS6t5ukQWIhlTS3k=
=u/Cz
-----END PGP SIGNATURE-----

--LlfqcAVf8KvGQgdk--

--===============4754839233268214391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4754839233268214391==--
