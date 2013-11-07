From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Thu, 7 Nov 2013 11:51:58 +0000
Message-ID: <20131107115158.GX2493@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-14-git-send-email-tiwai@suse.de>
 <20131106184422.GI30879@opensource.wolfsonmicro.com>
 <s5hk3gle0tt.wl%tiwai@suse.de>
 <20131107104725.GS2493@sirena.org.uk>
 <s5h38n8v5ac.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1205898311461908119=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AFDEE261722
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 12:52:11 +0100 (CET)
In-Reply-To: <s5h38n8v5ac.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1205898311461908119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s3puAW9DMBtS2ARW"
Content-Disposition: inline


--s3puAW9DMBtS2ARW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 12:07:39PM +0100, Takashi Iwai wrote:

> Yes, and think that this is the first step.  At least, we can refuse
> the use of BUG*() in any of merged materials in future.  Leaving
> BUG*() is a bad sign of lazy error handling.

Send patches to remove the definition of BUG then...

> And, actually your vendor-lock assumption doesn't look valid any
> longer.  There are more and more ARM-based systems that can install
> OS later relatively easily.  Most of distros (openSUSE, Ubuntu,

Practically speaking those systems are all in the same class, the
general purpose end user ARM systems don't have audio hardware (things
like the Chromebook are still closed boxes with a developer mode which
isn't quite the same thing).  We certainly don't have anyone actually
working on any of the stuff that would make such environments viable,
the people trying are focusing on servers.

> Fedora, etc) already provide the installation images, and I know many
> users of Chromebooks running such.  (And I know some of them burned
> speakers due to the incorrect UCM setup or usage :-)

Right, there's a whole bunch more stuff to do if you actually want to
handle this stuff in production - the health and safety issues from
excessive volume are even more of a concern for me than the issues with
physical damage to the systems.

--s3puAW9DMBtS2ARW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe37bAAoJELSic+t+oim92IMP/31BZXbbrpPzqiJGsAgl414P
5D1Yq1zPXAKSfLKdY6smDvWseXX5LyEgd6muugbqiXNPe02mVe3XS6q3MiKIQGmM
CRk7QMG+27rd6PELHzcbRUOlZCDu5Vd2lvqWSzrjX9zI0XqQ1ZHCsWTuTYXe44e7
TojZqJ6zEmKkxiJr3C8ORj+ELzqJCjc1ZjdNEgY7dAxRQk8OTj92T+d4IBCnavex
+0HPfTX1dAxDBykBppAh8yzXB3VFfBi3HVDUoPVDlhxnXk8QrxmRpN6tlxpOgLgN
bH51V+FUjZeBiLbQRpcpUKDkl5RRDLbBRjMfcaSicXZfGjIWlr+8v23vjrdaonZU
KXH7cmu9tj9kwiJ+Uj7x8XfSP79+g8VQBMD+pFZOCnijWMKi4p41HVLZUzmwe3a8
e9AdLF3oGlieHkoLTdmoubbMxc4o3JdwN5MeImMOJ9suQCTD6xl0sc2OuQiFJo2e
5iTvXSx8bZIGNk+6QZCW2TRYFfSNN2RAvKuRZtZLpQMrZ/QEfzYcpAjWt7I93j6N
hrkDaLzApfXm5y8Y2gkKjv/mAhR+NC5To0zgUvtpN6ICfTlkOPqJ1cUPh8gj2Gvd
yqctOh+zpLdoUEDbkh+7ySOichV2yXLR8ouTMZxJXx2sfgc3SUSJkKZrQeHkmK6P
p2MeuNHEV2JmQwL1MVJe
=DOhW
-----END PGP SIGNATURE-----

--s3puAW9DMBtS2ARW--

--===============1205898311461908119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1205898311461908119==--
