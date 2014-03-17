From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Mon, 17 Mar 2014 16:52:14 +0000
Message-ID: <20140317165214.GT11706@sirena.org.uk>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
 <532588A3.4050301@metafoo.de> <5326F891.7090906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7885323032904473115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B362619F7
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 17:52:19 +0100 (CET)
In-Reply-To: <5326F891.7090906@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7885323032904473115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ScUgq5oMe+fJq4F1"
Content-Disposition: inline


--ScUgq5oMe+fJq4F1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2014 at 03:28:49PM +0200, Peter Ujfalusi wrote:
> On 03/16/2014 01:18 PM, Lars-Peter Clausen wrote:

> > Hm... the sound like there is still a bug somewhere. We constrain the buffer
> > size to be a multiple of the period size. If the period size is constraint to
> > be a multiple of a constant then the buffer size should automatically be
> > constrained to be a multiple of constant * period count. And just constraining
> > the buffer size to be a multiple of the burst size still allows buffer sizes
> > that are not a multiple of burst size * period count.

> Yeah, aplay, PA is fine. mplayer however does things in a different manner. I
> use mplayer mainly to test PA (with -ao pulse) but sometimes I use it through
> ALSA and this is where I noticed the issue.

> If I constrain only period_size mplayer will fail to set hw_params. If I only
> constrain the buffer_size than we can have period_size which does not allign
> with the FIFO settings.

> I also tried to have snd_pcm_hw_rule_add() and using the snd_interval_step() -
> which need to be exported but mplayer fails with that also. It fails even if I
> add the rule for period and buffer size.

> Also the constraint as it is currently is not optimal since it does not take
> into account the number of channels as you pointed out.

This is all sounding like the thing that needs to be looked at here is
mplayer so we understand what's going wrong with regard to the buffer
sizes.  It's sounding like if we should be doing it this is a general
thing which we should be constraining presumably it'd apply to all
drivers, not just this one, and so shouldn't be being fixed in the
driver but it's not obvious to me why the period constraint isn't
sufficient.

--ScUgq5oMe+fJq4F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyg6AAoJELSic+t+oim9cG4QAJkSKcLjfgds0KxxeUDsbO4D
6LkUGrN7ReWZewXvYUbGP/KoW8sBmWjGR76vgKgqbv9qy6hCTH+kv0aOU4L4SFsY
lUwOe2KoRD9DbszMBpD9hZWxKeQwu13BLAHIjziDn7CAGHZqogMhL2xwl4hey+eb
ZW+24RYPFe1LrNM7oqj6hcqUVc/tDytqSdLDH32LE+JwScCj5XY3JCSyM8JdiUt1
FnX6/WVNnRmVLZPJr8h+gIeplwFLDFLtmDHPcnyVec+NjrWfiDuwNNcseg1p/68P
62nlsUV4tOMnKnGYACwoOnlAmg7ORedWYbyoyoP4GZOh8uCXYaWtnucOjRvcsQom
YdjaFXMdetV2dfYP9xn3cIVJRc7L+500h8Jq3LubkhHeho18K5eIhayJQNods2QQ
HUisJqnYsMfgHMktQzebnxLXO2tgcQ1CvBAzsF0Q9r+jdVU8lGzzMQI1rdnTQpSy
1kzcC0b7ruDT+PX3g6snz8+qQ12A8tJOov8GSFHJQayMWgHqdmX5RDOspGIAFvxK
jt2pYk5zxES0KI+G1qCxpg0Q8WuNInpaqkr5Q197DxspkyZdloDsJV0PKbRwcF4H
ososY8st6c0Vyhu/E+3PfkzUYSqF6bnAHqsIfrk8mBXoIuQB4iJbQGZYsWqEDRyk
SxEtutjgrtfY6LDTuPz5
=3un1
-----END PGP SIGNATURE-----

--ScUgq5oMe+fJq4F1--

--===============7885323032904473115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7885323032904473115==--
