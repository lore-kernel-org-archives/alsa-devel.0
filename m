From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Modify the behavior that
 updates the PLL parameter.
Date: Fri, 9 Jan 2015 17:22:04 +0000
Message-ID: <20150109172204.GL2634@sirena.org.uk>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
 <20150108183539.GY2634@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F4A5E5@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4308664617592219462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B50D4260714
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 18:22:09 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F4A5E5@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4308664617592219462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ImS0aneW9wZRUrNW"
Content-Disposition: inline


--ImS0aneW9wZRUrNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2015 at 02:20:37AM +0000, Oder Chiou wrote:

> > This looks like it's a bug fix?

> Actually, the previous version had be verified, but our HW engineer recommended
> to this kind of sequence, thanks.

That does sound like a hardware correctness fix then - something that
will fail in some use cases or based on factors like timing.

--ImS0aneW9wZRUrNW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsA47AAoJECTWi3JdVIfQzskH/1nz9hvG8yuUZqkhwAsAqgaR
yl53xfaVe1dCPY9mhKDdOMXTUvMmA+UkNyrNIYi8EjqCsF9i2+DnxFK+xvKtS2nv
ksCQxpbjR/diOkxx0OYjssS7097N4WBH70xZhdbmUqJO4lcD3u3kSOxw6kYFYFzz
e6zziOn3mvFSeWlagJKhjWr18Xr+Yik70mJpu1eaujezYOiIyDitdPnzSH331sLq
XyknX8jQVs6bJ0Q/6c34o+7DRfeHxBJnvmPiQ8nIr1ikCqqu4gkUB/FrDefzw3dt
rg7ldUC133qErHuzrl5Cj/CTmeXzd1C7TyN+JF06P86YSuWdN40xIqITqeB1mEg=
=SJz5
-----END PGP SIGNATURE-----

--ImS0aneW9wZRUrNW--

--===============4308664617592219462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4308664617592219462==--
