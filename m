From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 9/9] ALSA: compress: use rate values for
 passing sampling rates
Date: Tue, 27 Aug 2013 14:29:59 +0100
Message-ID: <20130827132959.GI10783@sirena.org.uk>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1776326487454377943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DA8CA260863
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:30:06 +0200 (CEST)
In-Reply-To: <1377585639-29516-10-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1776326487454377943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 12:10:39PM +0530, Vinod Koul wrote:
> Clarify that its better to use the rate values like 8000, 12000, 11025, 44100,
> 48000 etc to send sampling rate values to driver. The changes kernel ABI but no
> drivers exist upstream so okay to change now
> Tinycompress to be fixed as well

> - * @sampling_rate: sampling rate of audio
> + * @sampling_rate: sampling rate value of audio,  eg 12000, 48000

It's not clear why this is a change in the ABI - the values written and
the types don't change.  Personally I'd not change the ABI - it's a bit
late now that the code has been in the kernel for several releases.

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHKnUAAoJELSic+t+oim9ddoP/iEwBGOj1c4EYh6fWxtE30ri
rKhXY4a8EPEy0HJN7DRTzNKenbBgDVKQPz7oaU4bLqs4GTlySly/hhUG+paHzvOG
5InfNj0d1z+e7Ts/6TMiQVzqAhl27jiEsizjLt+FGYmwMj4yXzBsHdkagn8QtdGK
dFcf15mHQl9MlXBFKD11jUbtGePr3yyJdUAFAudr4kf4shQSldIxs5Bkjv4qPTOP
H4IWvwi8Sp16xF8jlIywDttlnTkqRtDteBJx8B3DyrS4HOHmwZV/Rf02j1YtifEl
bZ+UROLIdFDZu3BrWqRBXt6Uuc/1usMfhi3h8KFZ6l5LLhlTG4PrtuwEg76T2+DS
lfiBdRJpuPmpt8xf1BixEgWxeRxBQrRlOBtjCqOuFYff2HKqeNkaXSOmz2z6FdIy
lefxJ2cGbcLCI1Ouetx0L06awNkxDdmKL5MqTX4j7my27ykRuEdbd1EfYliqV29c
HnJ/zHGbnpaQzJis27dwYJqaMuS7/uG1PQVOQsUMhvCvgCFkvrLGzlkRYjTs5mft
jNpDIMxP9zglUNlsI7rYVdpVHPmE+tpATGDsJ3H+WN0EafrnsPy0X7QD3dXjqdfg
ljNClQONF2RMQsMMwbrF/JD4auybMt/GXkRJ+g2FUcfOG4lWYYSy46dHk8sMwlt5
bXv/+n1U55e9GH4pV/W6
=84br
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--

--===============1776326487454377943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1776326487454377943==--
