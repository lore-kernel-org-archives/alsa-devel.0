From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt298: remove idle_bias_off = true
Date: Fri, 3 Jun 2016 00:40:19 +0100
Message-ID: <20160602234019.GV2282@sirena.org.uk>
References: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6789426429833446452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFB5266BF6
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 01:40:39 +0200 (CEST)
In-Reply-To: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, ramesh.babu@intel.com, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6789426429833446452==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U8v/hV883cEE9JJG"
Content-Disposition: inline


--U8v/hV883cEE9JJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2016 at 02:51:52PM +0800, Bard Liao wrote:

> Codec will not go into suspend if there is any widget forced on with
> idle_bias_off true. We want codec go into suspend when the system is
> suspend. Also, we don't do anything in bias level OFF case. So it is
> actually no different in bias level STANDBY or OFF case.

Hrm.  This feels like something that the framework might be doing wrong
here.  We should either suspend the CODEC all the time even if there are
widgets enabled or we should never suspend the CODEC even if there are
widgets enabled but having it depend on idle_bias_off seems like the
wrong thing here.  My expectation would be that we would not suspend
with widgets on since the widgets being on implies the CODEC being on
and we'd expect suspend to do things like cutting the device level
power. =20

Could you talk through the use case in more detail - what's the widget
and why is it still OK for suspend to run even with widgets on?

--U8v/hV883cEE9JJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUMPiAAoJECTWi3JdVIfQOJYH/As5FPNXrN0C7bvwDg0/5tOc
51Yvmtma2i7SJN2F7JgYnDkYp4IDp4x+JTd7zxwIACIcCbFGjm4a5yQXHNfpcEXi
hU17u+N5I/6Y2/uXXdzKgu/kmrIE4nncSJGc9cfsRCobSur+IfRpWB4B8peVg8Ql
KehFQTkyQmgE2BOkDBSTN4T65IMK8rt2UmU8okuDbv3oXh4EWB7w4TFWez9uBwb1
NtCnvstgz3fQBSS3JjNDWVn+kCU0cj7vQ3GNpbNk1UqIQ+T1omV/L5gHnqpJZ3f7
+7RUh2DHveq6y4Zn/Q/7e2liEDHPp8Fgu/n3M/MhUsATT3DvXRmtmT7BPojwALQ=
=cZQp
-----END PGP SIGNATURE-----

--U8v/hV883cEE9JJG--

--===============6789426429833446452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6789426429833446452==--
