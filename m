From: Mark Brown <broonie@kernel.org>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 18:47:03 +0100
Message-ID: <20130716174703.GW22506@sirena.org.uk>
References: <51E55925.5080208@gmail.com> <20130716162043.GS22506@sirena.org.uk>
 <51E575E3.3040409@gmail.com> <20130716165708.GT22506@sirena.org.uk>
 <51E57DD5.5040307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120020381747187408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2923E2651A8
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 19:47:06 +0200 (CEST)
In-Reply-To: <51E57DD5.5040307@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2120020381747187408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJhwK4DKf9Unwzgv"
Content-Disposition: inline


--iJhwK4DKf9Unwzgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 07:07:33PM +0200, Daniel Mack wrote:
> On 16.07.2013 18:57, Mark Brown wrote:

> >>> No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
> >>> virtual DAI for the second link.

> >> That would still require userspace to open and configure both
> >> subdevices, right?

> > Shouldn't.

> How so? As each link exposes its own PCM subdevice, how would codec of
> link #1 get a hw_params call if an application just opens PCM subdevice
> #0 for playback? This is the case I want to address.

Half the point of soc-pcm is to decouple the streams seen by the
application layer from the DAIs that the driver sees so I'd expect us to
be able to map a single application layer/memory stream onto multiple
CODEC DAIs.  One front end connected to two back ends.

> > In principal yet but we want better DAPM integration I think - having an
> > unused device on the link probably ought not have any impact on other
> > devices for example.

> Well, if a link references two codecs, then both would be used in
> parallel, and none of it is unused. But maybe I don't get your point :)

If one of them has no active outputs or inputs then it shouldn't do
anything.

> By naive approach atm would be to just add .codec_names,
> .codec_dai_names and .codec_of_node to snd_soc_dai_link, and make their
> use mutually exclusive to the existing ones. That way, we don't need to
> touch any existing user.

May as well bite the bullet and do the refactoring, it should be
automatable.  There's also the fun of handling what happens when you
want to stream from one CODEC to another but I think that's second
stage...

--iJhwK4DKf9Unwzgv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5YcUAAoJELSic+t+oim9UQoP/jTF6aXJ0CdCsNemxxmYjz1i
JO99EkMlvWHd9JwuwLrcHtcloU0VHA6HX4AirfU5d61lDBWa008CNUKW21vuhHGr
KuBu+j4xL8KWISvtgMNZ+RYa+03/jylIf0CT3c8tBtTsd+nkvFIS4m1EyPQiYA3H
1CHLBzLzN/BVYFWNc0TPgfx3lBT+pb2i0VjG1DzALOIF7idsc8G5d1HV8F1bEV1O
x46pNCf7FdsmeNHl4G92JiNksgRl2v9ulI7yVPX7fkYpu9y1BnDKUZEI6xlkNfMg
HBqskQ3oRFnMaeQwd9dTZ05tYGG5IXYHn8zXpWgMlUHXTrclng5Ue2rFIXMG3j/h
L2SD5bRuZK/IxiCopapHyIK8XIAa7EG8wPqlZFwgQyzIPJxiIQ/r9Ivj6O+iSe3z
qSxWf/zBVvPvHtHeP9qHTu3zZxSt4EixI2qETe9ayk6OBBsQHgZF1uf/lytfmps7
iNQ97LakzaXnrNlI+zlY8q4llAWKIxWFVuMLXPZNs+bO5XnSAcc08Lh9G1Ykrr0a
d+yl9sSVbKyJ5FpqO+Sm1qkQ/2w4oLyToaWKwv5/uewiUjxbw7WhV41DqGvQRkqc
dfVUrAiLGJtaR1ZlhA5wjzX9H5Dzae5h0+MRq2wI8OT4ukkb8vQIyeD3dF5LNIUx
dEleVMEmieWTTLbOmmP0
=1l4H
-----END PGP SIGNATURE-----

--iJhwK4DKf9Unwzgv--

--===============2120020381747187408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2120020381747187408==--
