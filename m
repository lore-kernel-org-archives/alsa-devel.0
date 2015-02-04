From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: add irq enable/disable APIs
	and export
Date: Wed, 4 Feb 2015 12:58:56 +0000
Message-ID: <20150204125856.GZ21293@sirena.org.uk>
References: <1423053895-24342-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3782184347589516792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA16B2605AB
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 13:59:03 +0100 (CET)
In-Reply-To: <1423053895-24342-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3782184347589516792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xmg83RGVS/t1FIqP"
Content-Disposition: inline


--Xmg83RGVS/t1FIqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 08:44:55PM +0800, Jie Yang wrote:
> Some platforms, e.g. WSB, don't need irq handler and jack detection when
> system is in Suspend, for power save reason.
>=20
> Here add irq enable/disable APIs and export them, also disable LDO1,
> which is used for jack detection when headphone is plugged in.

> +int rt286_enable_irq(struct snd_soc_codec *codec)
> +{

This isn't a great idiom for the API - the machine driver isn't working
with the interrupt, it's working with the jack detection so it should do
the disable and reenable in terms of the jack detection too.  Otherwise
it's not clear that this won't interfere with other interrupt functions
the device has and that it'll disable the jack detection hardware in the
device rather than just ignoring the interrupt (which is presumably
desired and appears to be actually happening in the code).

--Xmg83RGVS/t1FIqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0hePAAoJECTWi3JdVIfQdjsIAIbf/O87wJG43913Y8R/rl8p
xS1YFO6ALxblCMXUZ7joUia5ytLGeSh+GEpQm5ynSOVKMLmRKCTBhSFMYVuU6O5x
pqOEs3Sa/mHkORDi2GdzJcl8J0W5Y+HXBWgqUvDY6pI1wjRNJJewAugD3laxUdG8
aCgdLpJ9RGckuCCX7FYcqV3l5kkD2t65xwAUn6EVA4HQQgIEzIZ2nIMTAxy9eHLW
gumNMTGO9sI51IdTs1HRZT/fbgsiaf3l0jvMX/79oMNpKHm74XUhecYkCNGUSG/Y
ayyYR2U6xPm0hPNMmzVrt6Bkg2QUQy4hqclmoOQu9puM+G/8Z4DJTDZukIVbqbs=
=xRtO
-----END PGP SIGNATURE-----

--Xmg83RGVS/t1FIqP--

--===============3782184347589516792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3782184347589516792==--
