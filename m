From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ts3a227e: do not report jack
 status when there is i2c read err
Date: Tue, 7 Jul 2015 14:47:22 +0100
Message-ID: <20150707134722.GO2887@sirena.org.uk>
References: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
 <1435793088-25971-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4274805240776219187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F240126536C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:47:33 +0200 (CEST)
In-Reply-To: <1435793088-25971-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4274805240776219187==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 04:24:48PM -0700, yang.a.fang@intel.com wrote:

> after TI resumes. Also We should return if there is read err,the
> interrupt will come again since it is level triggered and we are not yet
> clear the interrupt.

> +	ret = regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to clear interrupt ret=%d\n", ret);
> +		return IRQ_HANDLED;
> +	}

This should return IRQ_NONE not IRQ_HANDLED - we didn't actually
successfully handle the interrupt.  This lets the genirq code error
handling kick in if for some reason things are really broken and we just
can't interact with the device any more, it will eventually disable the
interrupt in that case.

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm9hpAAoJECTWi3JdVIfQCL8H/ArIQs1W0CUtfC/9u79HPymg
JLa0sNRhLq887U0vzEPSQfqSJnl0/A6wHRvyPjyw/CqDIDEw5Gc2yyRk4S8dkSDI
UKjQemRUQUv2pJKs2PRJc9xmACRUVWyEM7i09pOmYU+TmRpSqBv7jid6F5ICzm2u
btH5LEsj35uacxRWLvxgbt4j9tWgZVB3jYZT8U+1PRLioOvl76qdhNkS934DibGm
JuHqyt4WZu3DYgNY2Dp7xyI+r1t73ELyHANbNV33j8tKo8QzhLi668gid1vj0Hdy
1hXDerOHPn9GyJGr92yeh89DcRbGKZrZIW0KbXIoQfO6qss5epwCNtwNaO1YDg8=
=+hBo
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--

--===============4274805240776219187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4274805240776219187==--
