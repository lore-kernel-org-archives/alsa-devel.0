From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] ASoC: Intel: Add helper to poll
 register for DSP status
Date: Wed, 8 Jul 2015 19:36:21 +0100
Message-ID: <20150708183621.GZ11162@sirena.org.uk>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3671420938465637035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B0622650AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:36:26 +0200 (CEST)
In-Reply-To: <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, "Kp, Jeeja" <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3671420938465637035==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VnCKLxguT6BBzdXa"
Content-Disposition: inline


--VnCKLxguT6BBzdXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2015 at 04:04:02PM +0530, Vinod Koul wrote:

> +	for (time = 0; time < timeout; time++) {
> +		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == expected_value)
> +			break;
> +
> +		mdelay(1);
> +	}

mdelay() not msleep()?  If we're waiting for multiple miliseconds that
could be lots of busy waiting.

--VnCKLxguT6BBzdXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnW2lAAoJECTWi3JdVIfQs3IH/2ZNfbYbuFj8yugiqnfGOy+W
SDvD1xXgERKNE+MZWed8PDi//jyXbiJ+ouVMOc3OiPCO1PrKetpiUrcNjSEtEMBT
MqM5uJj6wxroqVb707bYJAlrV9uOafgJYXwj6J1HplSreX6TPgdaCSifyAga0WIQ
UbTJKKiKsThcr+EocbIJ6icAxpZMx4Jc0bxPQ+pa88WUR7adqomAvaJKphLUTPkb
itcCeqw0TLFYDQqPtRrooYAS/rkVAib/9Vz7tNVVTYxo4WmbNbKgnphJif7U/CnL
VFiyGlg9gaEKCrh0I1tci89Z6do2kfGQyG82r3xjk4qsbI/iCK0WtuURZTibEiM=
=B5bX
-----END PGP SIGNATURE-----

--VnCKLxguT6BBzdXa--

--===============3671420938465637035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3671420938465637035==--
