From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 18:16:22 +0000
Message-ID: <20131113181622.GZ878@sirena.org.uk>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
 <1485256.GGQxcSNhvH@flatron> <20131113164328.GW878@sirena.org.uk>
 <1783157.vhfWvslFgW@flatron>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2427103298150034790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4252602F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 19:16:31 +0100 (CET)
In-Reply-To: <1783157.vhfWvslFgW@flatron>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, rob.herring@calxeda.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2427103298150034790==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2+IDmuKgu0wSQZlt"
Content-Disposition: inline


--2+IDmuKgu0wSQZlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 05:47:07PM +0100, Tomasz Figa wrote:
> On Wednesday 13 of November 2013 16:43:28 Mark Brown wrote:

> > The best practice on this one seems to vary somewhat randomly -
> > sometimes it's a requirement, sometimes it isn't.

> AFAIR we decided on ARM Mini Summit to mandate this, but maybe my memory
> is misleading me.

OK, I hadn't heard that - it's good that folks made their mind up.

> > Is this a constructive thing from a style point of view?  We're not
> > allowed to actually do anything useful with the value at runtime so
> > people may as well choose what they like.

> This is what ePAPR says and I believe this is reasonable, because looking
> at device tree sources you don't need to think what kind of hardware
> a cs42l52 is. The information that it's a cs42l52 is still contained
> inside compatible string.

Given that a meaningful name was already specified for the handle it's
really not going to help anything - it's just going to duplicate that
most likely.  Given that it can't be actually used for anything it seems
better to just let people write whatever they feel like in there (even
if it's just a single letter to keep the parser happy) rather than
nitpick over their choices.

Really it looks like one of those silly things standards makers do where
they start specifying a feature (in this case device classes) but don't
define any useful behaviour for it.

--2+IDmuKgu0wSQZlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg8HuAAoJELSic+t+oim9gSMP+gPoEBGquJuKG+teTLTJJwPf
9obX0Xl9Kskx/D52l4NL5EWINnN6KWauV41BT4k5p8OYEeaGZ7ypqEp3bAvaZcK+
s1drK3JredTRbEcRZUJB/qB5aHUY1+no/AmalxpX589nN0lrO4ykBDPb0Ncg1Edt
XrOymDkvOgrnoeAoRspxBdM/VNWbo4/LckP3COFmOo5llhdD2kdDhZmeGWyeuhdx
JpB1wss1vpbbZNHzKo9NSTeisSZKsWMLThgAgNBLkj4va/34QjKSvDvhHn0e6qwl
l9LZLLoQqa/xpQTwPL53FZrN+UM8M5/hvNSUZH3OWho37rCMzf9eLTcdB0OyeTXq
qFCJN8CyzLs9uOlDllnyhC33uFD+O+iHbuJvw6dtMlxW76jeESawUrziedbaVFmP
ISc3ib+qxY/BqaY+eeppY1gIQmmzq6PGfZM693tzQoaiRLb55V7/c9A4vWgF0/Ir
WAC+ziwh4msDe75cDkn2Oa1Knq5VafWj/FYM44V6TPECQcydNR8HAiUIx3NIITp6
wgm1VPdx2VGnHsVSN0vtt7FTJ61w3E5+Hfw/hsWuleDO9Rdb0RdQ46F11AzbAOKg
EM4MdWKojANAA/6drbRR9RMEj8AM1Mnr/e6r9y4Ul12UGNDLZbvv5jvTS/6LK2Su
FtHt+w8N2gV7s0X7wnbq
=eNrW
-----END PGP SIGNATURE-----

--2+IDmuKgu0wSQZlt--

--===============2427103298150034790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2427103298150034790==--
