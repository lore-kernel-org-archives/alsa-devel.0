From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip-i2s: dt: swap tx and rx channed request
 number
Date: Sat, 13 Sep 2014 09:40:32 -0700
Message-ID: <20140913164032.GN7960@sirena.org.uk>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bDDjztrZmyyMv72E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--bDDjztrZmyyMv72E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2014 at 09:04:41AM +0800, Jianqun wrote:
> Reference to RK3288 TRM, fix an error channel id for i2s tx and rx
> Table 10-1 DMAC_BUS Request Mapping Table
> Req number	Source	Polarity
> 0		I2S tx	High level
> 1		I2S rx	High level

Applied, thanks.  The changelog should've just noted that this is an
error in the example rather than the code or the binding, I was a bit
confused about this.

--bDDjztrZmyyMv72E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHN/AAoJECTWi3JdVIfQEKsH/iyNtMEeMqY8VJWj+MMt5UbH
htKSMier02brv/RFLkxwPh83pn2ZkO23jxvQns4uZDjp/zsQ6R94jOdLg1AC7PAu
/aIgc+0VPLqJoyedCmTwWTkabeaELunniwmVNBUsTE2KTadEKCFsV9BmmOSBBAOT
lNErF+98kGgW97jl9goSUgjXYemKr5P9YRK8K/m4Gxk1ta1tD2acPDouuPzvVVYS
a1HFzYF+vQkTG+BAYfE/5FHy8SmjLTedEdaHyQjVjSofY2PpT9YmSx8vaDiqULAZ
O498lKdBS3reNCgd/fUkuyut/GiiTuCNYCGKfBlc6Y4fGSV+i5h4wPcuoY8sLGg=
=eFfQ
-----END PGP SIGNATURE-----

--bDDjztrZmyyMv72E--
