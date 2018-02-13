From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/wm9705 1/1]
 sound/soc/codecs/wm9705.c:330:18: error: implicit declaration of function
 'snd_soc_new_ac97_component'; did you mean 'snd_soc_new_ac97_codec'?
Date: Tue, 13 Feb 2018 12:05:29 +0000
Message-ID: <20180213120529.GD5988@sirena.org.uk>
References: <201802122255.cGsOCM1z%fengguang.wu@intel.com>
 <20180212144911.GD12976@sirena.org.uk>
 <87d119lobw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9188820737255294009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3927267716
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:05:42 +0100 (CET)
In-Reply-To: <87d119lobw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============9188820737255294009==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 12:36:20AM +0000, Kuninori Morimoto wrote:

> Oops, I didn't mention (?) but ac97 related code were
> modified, and its related driver needs to be based on it.
> Now, mark/topic/ac97 branch has it

Hrm, wonder why that didn't turn up in my grepping.  Anyway, I moved
them all onto one branch.

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqC1IkACgkQJNaLcl1U
h9CVrgf+Kig2yz3J2n6925J77Tjdl/VK/GBwa4vU74R7o6+Rd6UqwMX+KBLusGff
H+KW1LuF6daUPTgUZwdFAo+gHy430Bknevqlw6mKGKxjmvN1OFqu7FbKi7s1u19i
SPALsdwS4iqZqANbLz21fIXzNml+CI80TXxUDboxs8MAeL7kZyjtlPMKYCE4tAAC
QvXnXobvd2XX0AxnGBJB0ur8eovD2TFmcvx20sEnE3fH0MvHI4hwfSW3ua3oVnj+
cCI3rTlf1LZm9xyQjJPmSZ9UZfjC8kRh04GYuPPR5TGLnHtP3IoXJ5jaHaV76GHD
KoR4zgSvkSph4R+XDGv1/194xuvIjQ==
=0Pop
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

--===============9188820737255294009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9188820737255294009==--
