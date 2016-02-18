From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/4] Add support for DAI link addition
 dynamically
Date: Thu, 18 Feb 2016 13:39:10 +0000
Message-ID: <20160218133910.GC7129@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <56C1DF0F.4080503@metafoo.de> <56C40AA9.4050008@linux.intel.com>
 <56C42E71.8030805@linux.intel.com>
 <CANQOkFEnNn8JVeFfgFzBd+-SdFB6jF4fbNHo64ArmDcXypJNAg@mail.gmail.com>
 <56C5554F.6060800@linux.intel.com>
 <CANQOkFHMEeSQY1hVBrQX_YFTf48pD3yBsecG79C1qT1=5=2PMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3599858370797234280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BA3F26062B
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 14:39:22 +0100 (CET)
In-Reply-To: <CANQOkFHMEeSQY1hVBrQX_YFTf48pD3yBsecG79C1qT1=5=2PMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============3599858370797234280==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 18, 2016 at 01:27:26PM +0530, Vaibhav Agarwal wrote:

> Yes, I agree machine driver is the real owner of soc card & should
> decide/choose on possible capabilities of codec. Also, codec may wish
> to choose from different soc cards registered based on the
> functionality supported. Say, performance mode using I2S interface,
> otherwise feature mode (supporting multichannel, etc.) using PCM
> interface or may be via USB interface.

No, the driver should offer whatever the hardware is capable of doing
and let userspace make any policy decisions.

> In case we are using generic codec driver (existing in
> sound/soc/codecs), it would need a helper driver to glue it to soc
> card dynamically. Otherwise, for a specific platform, we can have a
> wrapper codec driver that can fetch capabilities of removable codec
> (may be via binary data) and expose them to already known soc cards
> for that device.

It sounds like there might be some review concerns with some of this
stuff...

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxcl9AAoJECTWi3JdVIfQ5j8H/2irQuHM8omhorD3Rt8bp3JG
WhSSDskO1fzrREX9NwOxW9zD8DBIK5hfyQ4LKwFDByJF5s+OBN05/cut3J7zyZin
7fY+WoAMttMtXwxXc1e4GFitzIXTeuO2+nMoIjDiKWFt9WXG/jYr+MxOjzPlBWkQ
R2mrqJxBsZcFhlaCZChspT5PWAd2J0lgKTbxsODAJhTBM5B4kznullPsky7KbkEr
j1n/UAzxpHICBe6wkFlo6EO/1Q+jURUruPosCtNIHI/bL5XMr/8cz/eFdIRJt6cl
v8dB7NCW+cHEi7IXWXvr6DHeOQkE07xECaNDyjEgbA44GBL80Hdtm7ynv+cqeyk=
=CHkC
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

--===============3599858370797234280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3599858370797234280==--
