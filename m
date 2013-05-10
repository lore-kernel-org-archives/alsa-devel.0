From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] tegraalc5632: add UCM config from
	Ubuntu
Date: Fri, 10 May 2013 21:53:30 +0100
Message-ID: <20130510205330.GT3200@sirena.org.uk>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
 <1368190270-29647-6-git-send-email-marcin@juszkiewicz.com.pl>
 <518D1EE3.10205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8706942410369501502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D6A72616A6
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 22:53:49 +0200 (CEST)
In-Reply-To: <518D1EE3.10205@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============8706942410369501502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline


--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 10:22:59AM -0600, Stephen Warren wrote:

> "alc5632" is the name of the audio CODEC, which could be used in a
> variety of different boards, each of which might require a different UCM
> configuration. Shouldn't the file be named based on the board name. At

Yes, it should.

> I also notice that this file doesn't define any use-cases/verbs/...
> Presumably a Linux-based OS would expect a certain set of them to exist,
> and they'd be implemented/named consistently across all UCM configs?

I'd expect them to at least fall back to assuming some default thing is
available - having a model that is more "do I need to do something
special for this mode".  Being able to give at least some basic
functionality from a minimal starting point seems sensible.

--eNjIDde0W37E3OQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjV4nAAoJELSic+t+oim9A90P/3nHr/VcCPqS9qXEVMpEvD2x
aXA7dYCmJB+olmiAb5sDwb2rf/xVFrPUj18HK9HgXZmVqhnN9pNgRYgx4EHkk3QJ
ZFHJcDlIOSr9vVi538RnGs1el2XKg9ompOule9+UstCArM0OPR3+VFfqPvu4ed4e
d9jfHu5Us8IzJyxqH0z2YpF9tal6R1yU6UXqYwL2xjAgQAukmTq18JqEHc7VCipe
MnF5lvOTag+niVBqDhhDL5BA9qmYw6oKnZEfEhYr7sDSOTtnb0+ehzVd08I0kFWG
vF1K8emzYUT/n+bskTFyjVMCyUYpc4rrXR/3Haz38veveWsjURr6zenFUl8K/uut
G/ut+hoXZTBW/idnxIl/cznxOF0SHEgtaoKXd8U7rjyRKF4sMBzuRlUBQlB/b5yK
1xuNXRagMqIlGfDtzxtbxpee7dKWOmpEB62ynguT4g2G5C9mddG2t+cQc68lRIN2
2cv5l2DZepQus2eNPod9zz9NLW2tCyNBPUVCXilR/gHBm45V5FD59oUjdgOSDJ6U
khnXF/BFUycLlbBgSlbd2r39+iUkoigfd852MX7NXYfBf+TS4NcwoRj7t3hwthuV
2FL+cRqX0rO2fvKpWHsSvR4CoJsrPpb/Ams6N7f5w7ywh4MNqhB+9Xnx3OGU4XeH
KDH9mrRmhY5wMVuTLCoH
=Jczt
-----END PGP SIGNATURE-----

--eNjIDde0W37E3OQP--

--===============8706942410369501502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8706942410369501502==--
