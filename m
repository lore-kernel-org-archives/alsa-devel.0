From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 23 May 2016 18:04:32 +0100
Message-ID: <20160523170432.GA8206@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
 <20160520110137.GJ8206@sirena.org.uk>
 <5742641A.9070409@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3329540382259843429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0B826043A
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 19:04:38 +0200 (CEST)
In-Reply-To: <5742641A.9070409@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3329540382259843429==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hch1Uz/zGPcHFdv8"
Content-Disposition: inline


--Hch1Uz/zGPcHFdv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2016 at 09:59:54AM +0800, John Hsu wrote:
> On 5/20/2016 7:01 PM, Mark Brown wrote:

> > I understand what it's doing but obviously a biquad filter isn't
> > specialized for this function...

> Yes, the biquad filter is general purpose feature. Could you give us
> suggestion about how to implement the biquad filter for common fea-
> ture and to fix DC offset as well?

The trouble is you'd have to do the configuration in userspace or do
something like only do the DC offset correction if no other filter is
configured.  TBH it's not unreasonable to suggest people should just
configured a high pass filter if they're having issues, though it's a
bit more work :(

--Hch1Uz/zGPcHFdv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQzgfAAoJECTWi3JdVIfQMnoH/1WJ4SrCrl+QFNRr7SCCW53P
IaAxw0H4BzrjbrO4/gRfKhhAMSYdBwdi6r1x4rvuUrxpGU4gBGJllvyak5piNVlE
0TiS3kl6nm5iOrJUzRNrbLPo8F502tjtlJCVguxTngJiMXb4hoectdKVNXCnHp3+
kcA+9GVMjJN6ZXO+UwZY0ZayybJGkDrNCuipIuI+IM3aI27zNzsiD3/WFQlNgP9O
V1B6DhZovTlnRCFzOH2yepjW+afN9RfgssXcNRFZwPNl0vNA1PmE4SQgAI8VFq7i
xTSbs1422YTKTpSwLmzu28x4GgN7iZii7BKctbqXmR2frssDlSq2ilsFASW61Jg=
=bi6v
-----END PGP SIGNATURE-----

--Hch1Uz/zGPcHFdv8--

--===============3329540382259843429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3329540382259843429==--
