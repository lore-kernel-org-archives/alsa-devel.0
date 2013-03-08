From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Fri, 8 Mar 2013 20:30:08 +0800
Message-ID: <20130308123006.GH28481@opensource.wolfsonmicro.com>
References: <1362740833-15704-1-git-send-email-zonque@gmail.com>
 <20130308114251.GF28481@opensource.wolfsonmicro.com>
 <5139D8FB.4070500@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4724017197874857916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13F5A26170F
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 13:30:40 +0100 (CET)
In-Reply-To: <5139D8FB.4070500@gmail.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4724017197874857916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 01:26:35PM +0100, Daniel Mack wrote:
> On 08.03.2013 12:42, Mark Brown wrote:

> > Please avoid the ternery operator.  It'd be nice to switch over to
> > mute_stream() too.

> I wasn't aware of steam_mute. How's that supposed to be used? I'm asking
> because when using 4-channel playback, the driver gets this callback for
> stream == 0 only. Am I supposed to (un)mute all channels here,
> regardless of the stream parameter passed in?

The stream parameter is _PLAYBACK or _CAPTURE - it's just the same as
digital_mute() except it can be applied to a capture stream too.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROdnBAAoJELSic+t+oim9LnAP/RLOFu90IfLKWv9o8sL6Ljc4
6Y2GPPeImoofhXVA+Bv2slS0zmgzSR23APgkfEYyGCPG3FFAV+OoZvNZ4im7+Xi/
A3VCuVGR0kCKQmcvjTSkTGB6pwH6/U12xINLYObWrOX0bDITUIIWYwI3VybtVeVM
rhI5Fh38TAO1ph3Iz4BQYgnqYcv+vY2+fGpNe842AY358yPpnSEu12q/c7vio6Nj
WqCBK/ptgw7x9UVR1qdxtVgLOk4h4WDGjNmoT4ldJOVN8WUPDum1RcXM2gRzpU2Z
Myp55E72fevxaKzHzSAx3mnX9+sJMCrBZp0Lud68mIAvkKRU+kf+tTYbov7WYIvW
8KGmELrVG2ggL39jGq+rvfzcvhwiKJD8XP2/ogOFx6JOo4qx9dpsg5+V73vLyxyy
MtJL8dR9Q7m6y6DYQFCNJz4Z/zTisd34D/jnjW9ZfkAAzNMjkMsgG651usl7qDhu
Ewu4uSBOXQoKA8BxtQV7EEpF2E6xKNhMB6gLvMF0ltvdXni6rRNZ7efv4Jb0HW7p
93DwniCL4prb3ei0C2WM3sNfbTuw1SEjARWTgHlMtVdfa0i7Tw47+8VCxqTCl71p
r7eAaCZ5Tvhkhh7rlUat2GAvQeSl5RPTbESvF6RedYUDZSl2GT4d5txZgMAERR6U
DIqLbaZNGXzKynq4QbWb
=BgRl
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--

--===============4724017197874857916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4724017197874857916==--
