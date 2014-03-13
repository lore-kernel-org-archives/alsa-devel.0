From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Add support for DAI multicodec
Date: Thu, 13 Mar 2014 19:22:30 +0000
Message-ID: <20140313192230.GJ366@sirena.org.uk>
References: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
 <20140312225125.GZ28112@sirena.org.uk>
 <53219AA3.2060305@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6576638025072091291=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7AC26545F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 20:22:40 +0100 (CET)
In-Reply-To: <53219AA3.2060305@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6576638025072091291==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPQPFrYXiKmg9EuQ"
Content-Disposition: inline


--CPQPFrYXiKmg9EuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 12:46:43PM +0100, Benoit Cousson wrote:
> On 12/03/2014 23:51, Mark Brown wrote:
> >On Tue, Mar 11, 2014 at 12:17:24PM +0100, Benoit Cousson wrote:

> >is handy.  Instead of having a fixup function if we specified a TDM
> >and channel map configuration then the core core could override the
> >params so that the channel count was clamped by how many channels are
> >actually being sent to the device - so if there's two TDM slots active
> >the device would be told to play stereo.  Would that work for your use
> >cases?

> Yes, I think so. My current setup is pretty basic: 2 mono Class D amplifiers
> connected to the same I2S link to build a stereo card.

> OK, so I'll rebase the patch to asoc/next. I'll try to split the huge patch
> at least into a series of 2 or 3 patches, and I'll remove the fixup part.

Sounds good.  We will need some configuration here so I think adding TDM
parameters to the various structs (I guess slot size and overall counts
should go in the link rather than per CODEC) but we could probably even
get away with doing this after the core patch.

--CPQPFrYXiKmg9EuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIgVzAAoJELSic+t+oim9reYP/jY/wdQS1s/hzeKmxe0DKZ6g
uo+BRNJ358csTaBoO03hATusiHbtNbqZB0zFDiqHexPvD4FUmi0h5yiF+w6zxB2H
IzZdtfTrDyxZt1DKdyVOdIhShoo9OiaGfn1YqttlbueyWzq7MiropanbuRHQgngy
7RVJE9Ifnr+WYplV9o0euXRoWGQP/KNOiuPphI+uSZzYOmWP9Z8tu1A0Te7wrxhw
UbWXdH6frHdOcuRk2eILJR80ED/Scxid4MDh2qoh6jkzJyhWNkJ6GmQIeV49ecud
toeYQNHljZay6AJ1txm8gJip1mbK0cZIw7D1FMuMyRQ+vtZd7q3fq8JGKEEOqUow
uEErBCHLTvkZAr3t2iSKsc58ie8bV4CDE1lgERua9lJrTeiDKk/O/VRFtHLL7KRA
KtIrxAEJOlyxVZ/OZzx5RGAxShPG1Q2CHoC4Yt7AZJjLmoJO85XrpxbTRdu/nPHH
tSJRxFwEj/EuHVQtf33rixxFWcva1qWiz51pdxGTsit22JhEU4PrHqVVhQ1j0hFg
um4shKryu86JZAy74nDM0qsUPyRrPdnPZrooVUvFdTwggzVBi9AMqKAUF5J0lp65
/5+g6/NKXMU6AgjXKng+/285FWuEXrn106MvZzngMKbnbEAowwGC+yXfCNNswTS7
gTNu4PIXo+w0cZ6wdA3G
=y4ze
-----END PGP SIGNATURE-----

--CPQPFrYXiKmg9EuQ--

--===============6576638025072091291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6576638025072091291==--
