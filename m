From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5670: add clock source
	selection controls
Date: Thu, 4 Sep 2014 20:06:05 +0100
Message-ID: <20140904190605.GM29327@sirena.org.uk>
References: <1409549878-27304-1-git-send-email-bardliao@realtek.com>
 <20140901153433.GD29327@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D76153B1@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7715859661940697561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B24E261A01
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 21:06:23 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D76153B1@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7715859661940697561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jZUYryPdXB7p5neD"
Content-Disposition: inline


--jZUYryPdXB7p5neD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 05:22:49AM +0000, Bard Liao wrote:

> Which clock source should be selected mainly decided by the sampling
> rate and the audio routing path. However, there are some exceptions.
> For example, if the MCLK and I2S clock are asynchronous, we should
> always select "clk_i2s_track" as the clock source. And In some cases,
> we can choice "clk_i2s_track" or "clk_sysy_div_out" as the clock source.
> Users can choose what they want to use.

> Even if we ignore all the exceptions and make choice for users, it is still
> hard to implement it in the driver since we need to read a lot of registers
> to decide the clock source. It will be easier if we open it to user space
> so user can configure it with the audio routing path.

The choice is usually deferred to the machine driver rather than made
entirely automatically within the CODEC driver - where manual control is
required typically the machine driver is then able to offer a bigger,
system-wide choice to the user that controls several settings and makes
sure that any required coordination occurs.

--jZUYryPdXB7p5neD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCLgaAAoJELSic+t+oim9aLYP/3Ve7i6ds3hg9EeE88TuPqsY
Vgk2MCewDWeHlIKSRISxySqMGhxp/u6GyLd0eHJjrOye2LjG0C7WwLqcMgv7C44s
UYF+W/b+BYu7G19X0s8KuZu2leJftqKNk6Q9TOReEkLKS7+FuLZVXqfjrNz59yRC
fd70wNbEiwzHGZG/K5KmnpgB6LPwSDWmztxFs/oVAenRjm9H3Cgr/E/FOpIRf3bD
/Eip0KK23HvSVMKNyvOmvmF2UseXpHLNhuQvvTRTlPqpY/qM49t+I83hW21oI4ji
/gtqrlg3HiU6wP9tdshegeBCbImQ4JW/9NuOLPOBqZLrn7WZXgUUMK7iXG6ls5ON
NA12bJdLaX9I/qntVKUdaDxMi3jf2RJc2TrCZ6msTwD7kDPLTdP1uuda8d/euJ5V
8kb8iuOhyEOb0ps99Im4WW60W+vr8K+jB7rVxoe5wnzhOjEx282TGWvqdU7n9Wz1
WHBynVJx7SupKCPgu8Frbwuu/rk1Gvw3X4I6fPbX32lsgIOIRhDUEGu8OsdPjE79
ROiGdm+Kk6FOuercM3kWtgQmFnQ3Dnp0lSpaISbhTTGBoaYa32ODvtPhijQEmkve
Fqgi/As22EMXN6HzxAuX8x1sampZN2C8fuJ6Gj+tOT6K9xseSR/qKe+QXLk0bYtA
AtQw1Jh7ukMNteKE4xzr
=VyVu
-----END PGP SIGNATURE-----

--jZUYryPdXB7p5neD--

--===============7715859661940697561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7715859661940697561==--
