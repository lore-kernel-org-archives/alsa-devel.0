From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 17:03:52 +0100
Message-ID: <20140416160352.GS12304@sirena.org.uk>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
 <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
 <20140416142502.GR12304@sirena.org.uk>
 <CAL_JsqJNs5n8XmRe+-JWAcmunnTAoqeNFUwP2B6OitBd=QtXYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687438279196752172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F6572654A4
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 18:04:12 +0200 (CEST)
In-Reply-To: <CAL_JsqJNs5n8XmRe+-JWAcmunnTAoqeNFUwP2B6OitBd=QtXYQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0687438279196752172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1aBKeCoRrxtQ74y"
Content-Disposition: inline


--+1aBKeCoRrxtQ74y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 09:32:37AM -0500, Rob Herring wrote:
> On Wed, Apr 16, 2014 at 9:25 AM, Mark Brown <broonie@kernel.org> wrote:

> > Is there a branch I can pull into ASoC, or can I apply it there?  This
> > fixes a build failure introduced into there by some recent work.

> I haven't pushed it out yet. You can take it and add my ack if you
> want instead. Otherwise, I do plan to send fixes to Linus this week.

OK, this is needed for new development so I'll apply it temporarily so I
don't break my tree in -next and then discard it once Linus merges -
sound sensible?

--+1aBKeCoRrxtQ74y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTqnlAAoJELSic+t+oim9IsEQAJgza5bXSp9sIDuXuofN8Z/A
Q81eIkQtfbiRDKqX6l7MxiEI/OCUzJ2mIWMWHONF0a/LpGIylMJ3Ao2LMwMExnR1
1pyxbWJnSBNWp5lIifpwLYOVvn4ET4PCOBpDdEVOUFu6EqYWk3yqKBMZJsXMjKkS
8DD134O1V00A+p1IPtH5qo2eWakIjDvZq0s4XWF2tYS6foWzwvsF4uAgRutqgsz8
9gi5TTS4o/Z0QlBbtSsxqgjf6/W17ylq1ariMokfmmWYa43H7h1FzPvK4GOAs1Yo
qVgTozJ84bjre6a0tcCx24NvwZXdD07bo408w3UylDDhOYswxTmVCYAkapNuTVze
5fRwMKPaJUc/egTDLGRpU9k7v//R4KsZmakXzAnWnPcUkflLxw/x/9cHwFE+02Yn
Tp9w8saqlk2vpFQDX9wcTsyN9L6QuMskqbTvUFDgyNF6fTpJIJY1jk6hc0jG1up5
kCgDwyV72IC0S6t6+e68P2GY625b6fvREqs4dSXUu3ObI2vbLe5aRcpoQ6lx20T2
y1EaZtdIohanxYxfbBo7iKAgB+P5J3kkq5OczhPBsDgCgQhKzv4y3VCs9NZxgKqI
xgRFS+MeC/ickVL4ZJtwbIQIWkUUbK/7fT1c4p+Wa3yrAs/ULSWQZKcUR5eSEWB/
PKWEus/Tq7lRnXD51mK6
=VIPF
-----END PGP SIGNATURE-----

--+1aBKeCoRrxtQ74y--

--===============0687438279196752172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687438279196752172==--
