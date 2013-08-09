From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
Date: Fri, 9 Aug 2013 12:39:40 +0100
Message-ID: <20130809113940.GY6427@sirena.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4174754369311139056=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 70F0926577D
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 13:39:47 +0200 (CEST)
In-Reply-To: <5204CC04.4000401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4174754369311139056==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ce6hu2nuSYv2TQrx"
Content-Disposition: inline


--Ce6hu2nuSYv2TQrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 01:01:24PM +0200, Sebastian Hesselbarth wrote:

> And that is *the only thing* that keeps bugging me in Mark's replies -
> he *insists* on having that virtual audio nodes. I have nothing against
> it, except it should be *required* for every DT we have. DRM doesn't
> _need_ it, media doesn't _need_ it, but audio is so very special that it
> _requires_ you to have it described in DT?

> I understand that it may be required on some boards, especially if you
> create different sound-cards out of the IP available. Just like the
> DRM discussion we had - have a virtual node if there is no other sane
> way to describe it, but there is no strict requirement.

The problem here is that the extra effort comes from the board, not from
the individual components - any component would have to optionally
support having a card binding hanging off it (or the properties for a
simple link) so it's more consistent just to say we link everything from
a board node all the time.  By the time you start adding all the things
like jacks and connected pins I'd expect you'd find you'd want to have
at least a sub node to organise everything.

Even things like buses aren't that clear - an I2S link can be a
fairly simple point to point link but it can also be a multi-master bus
or share some signals with other links.  Things like DRM generally have
interconnects which are much more regular and less open to interesting
board design decisions, though even for media the last time I looked at
the bindings the individual links were getting DT nodes which is another
way to try to deal with things.

Let me once more renew my request that you go and read the previous
discussions on this stuff, we've been through this loop repeatedly.

> That is what I am doing on top of the audio-controller node and except
> that there is no helper to determine the names, yet. If ASoC would
> provide a snd_soc_simple_card_register_from_dt(...,device_node *), I
> wouldn't even have to parse the properties myself.

So extend Morimoto-san's work on the simple card for this - that's what
it's there for, it's doing exactly this job for non-DT systems but it
just didn't get DT support added yet.  All the trivial cards should end
up using this.

--Ce6hu2nuSYv2TQrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBNT5AAoJELSic+t+oim9MOQQAI7AD+z8t+CRIVckyn/1+eR/
VYx+gdeoWkV0FJYL/UwvndD1fCmSbtS73vK4x0fJG+mrDoeoWZ4nVl0JGEjZDRqc
OTHMGX8z1DhEGwD7BgMeEMezs61MCoq1W/OW0X5McVfJ/aOig/iL8KQ7CnYW04jq
6yqYqmqbv1EjwTwkUE+HkS7atpIDf/5u0xVj9tGWZLuBr72x5O9oTxQQMPmn2Kce
mQGnNCaHu/DzqJ1ajvnWkPt2L0fC1TWTwPNkVy4KRDh1AAikAr8Ai/EN814fQp4x
AQ+xAR8c110FJ1OzJPyjTypGFPgETiugoaDG96fdp91b3BDzo/XbLTz7l0FD4iLv
PUAffB3QgjsnCDY5m8uTtMUI/nX5bXH9qIMJ6MVVODc2IcnLn43Iv/+ZYx+xHeqf
W/lbcv6UnhBCGEn7eD8biV9mUpVp7V/BlQNUSaQqaaovKpwV/II+ji58SMHNP703
HdT5kYFKpmRYSE2MG3cfJjp8v1sBfY1oWgQNfyqdcIEvhnuz8mxdE9BqE4tNsD06
PHhsGZeAiTnXoBSEdgTzjQKOlW5WKUjaljaG/eyQaD0ZaL/RY3qZ4O3yiWtWWDJ0
TxUnQIda06WSB68p+CgkfBd0uxTx7i9w91Kp1j93zS5ysemTtpIDRj12P8GbXa+8
TxxcVPxLnchh1oRCiam1
=P+up
-----END PGP SIGNATURE-----

--Ce6hu2nuSYv2TQrx--

--===============4174754369311139056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4174754369311139056==--
