From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/10] ASoC: dapm: Implement mixer input
	auto-disable
Date: Fri, 2 Aug 2013 10:53:16 +0100
Message-ID: <20130802095316.GH9858@sirena.org.uk>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-10-git-send-email-lars@metafoo.de>
 <20130801104800.GO9858@sirena.org.uk> <51FAB5DB.20607@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4064855556045041472=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 218AC265646
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 11:53:20 +0200 (CEST)
In-Reply-To: <51FAB5DB.20607@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4064855556045041472==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qpsuUAk7tqiLFoPW"
Content-Disposition: inline


--qpsuUAk7tqiLFoPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 09:24:11PM +0200, Lars-Peter Clausen wrote:
> On 08/01/2013 12:48 PM, Mark Brown wrote:

> >Equally well I'd expect the value to always be a functioning cache of
> >the real value so I think what I'm really saying here is that I don't
> >think we should really be checking if the control is powered at all.  We
> >do need the I/O path but the power isn't the reason for it, the fact
> >that we have the value stashed locally is.

> There might be some corner cases where the driver directly modifies
> the register value outside of put_volsw() which would break. But
> otherwise I agree.

Yeah, I'd argue that anything doing that is probably broken though.

> >Another thing that's bothering me here is that this only works for mono
> >controls but many of the uses are stereo mutes and/or volumes.  We'd
> >need to add back the support for those.

> But that's a general limitation for DAPM controls. Right now
> snd_soc_dapm_put_volsw() only supports mono controls. If we have a
> left and a right mixer we usually have one mono control for each
> side. But I of course it would be nice to have support for stereo
> controls here. I guess with the shared control infrastructure we
> actually have most of what we need in place. The only thing missing
> is a way to express which channel of the control controls which
> path. E.g. an extra field per path or per mixer widget selecting the
> index.

Yes, or we could just say as a first pass that as soon as any one of the
paths gets enabled the whole control gets enabled which should cover a
large propoprtion of use cases (headphones or stereo speakers of which
only one might be connected).

--qpsuUAk7tqiLFoPW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+4GJAAoJELSic+t+oim9YUQQAIJFPZg1VUq9lAeHX8k+q/r+
MH/lpeG2uYpS9Tge7uG4tyhab4xDSpWNWxHwWVG8iKhOKGNEWEnCAV6O9y2xxHGq
rNgSbpBzuv3H3FbQYTB5tI5AQXuyBjHEwuUpOgcPzSn/vQR0B7ACPJv9dLDjw0a0
uvxIn+6PaqY7/KjSnqsfqVCeA8LSR23sIX1T5D3xZP+NwGdCVDMYyRQw0eaAA+o7
91nYp5+SiWGt3jWMvCZeCQxxXv+cwb8LepN/zWuHBko6E7MAPmHZX1cbALjI/hdf
LhWDfcGIguTAK3L7Qk9evb6watrBP473C7gmLjnaIF5NDL1KjnD6Dyvf/8WJhq+6
3h1FWO/9dbIDHnu19jwzjJAfYc0TmQylD4rlWkDZGxBVDEPPMXBr+JA0hQNO/D4k
m8tQsWbARpOqZ2Jj8MnXS12Do7YjBEpGV0bM9m+0d5nuQOPVlt3aax46cIgj1lJ4
EM+NCtCUYi2ftctHFjbLUXds2Ietk5q2bX3m9xAP+zi+fiYwxWBn5qHfLb2j97JA
lKv6kGYg9eiiNp5p0IdezHkXvKoyObPDwGNEAbfEfpwJNqDKD3eTTZJQ5nSKl8mQ
MFBZG6O4xkPPTZ3WR3gWT0ugK/IF/pkhkdDUiVwQjHzsfarqvtWsBTNLHV+/zsgd
Np+dDLhAIa59O3hMOkns
=MmKM
-----END PGP SIGNATURE-----

--qpsuUAk7tqiLFoPW--

--===============4064855556045041472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4064855556045041472==--
