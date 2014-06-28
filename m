From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: fix debugfs directory creation
	bug
Date: Sat, 28 Jun 2014 13:46:42 +0100
Message-ID: <20140628124642.GR2520@sirena.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
 <E1X0AZe-0003i7-0z@rmk-PC.arm.linux.org.uk>
 <53ACDAB7.5080703@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2758822820161653377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E382610B1
 for <alsa-devel@alsa-project.org>; Sat, 28 Jun 2014 14:47:33 +0200 (CEST)
In-Reply-To: <53ACDAB7.5080703@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2758822820161653377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/1XGRQlv2BMqnS3"
Content-Disposition: inline


--W/1XGRQlv2BMqnS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2014 at 04:45:11AM +0200, Lars-Peter Clausen wrote:
> On 06/26/2014 04:22 PM, Russell King wrote:
> >Avoid creating duplicate directories by prefixing codecs and platforms
> >with their separate identifiers.  This avoids snd-soc-dummy (which can
> >appear both as a dummy platform and a dummy codec on the same card)
> >from clashing.

> Do we actually want to create debugfs entries for the snd-soc-dummies? There
> shouldn't be any meaningful information in there.

On the one hand they're virtual things that we probably should be hiding
but then again part of what we're trying to do is stub things out as
they would be normally so special casing potentically causes problems.

> If we want to and if we change the naming scheme of the debugfs entries
> anyway we should also add the component name to the entry name. This fixes a
> issue with devices that register multiple components.

> The other thing is that we are working on generalizing the ASoC code and
> getting rid of the distinction between CODECs and platforms. Which means
> there won't really a way to get the prefix anymore soon.

Right, these are both issues.  However I think the patch is OK for now,
it does avoid an actual problem so I'll apply it for now - we can
further improve it later.

--W/1XGRQlv2BMqnS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTrrkpAAoJELSic+t+oim9WLIP/2JCQ0qQoS6nC23431U/Jke4
JQm5LcDp0nsLF+WAs7CkHOCMs8gKvGgf4RnBAO8/AOkpvb14Sf57bP/1qsyd8Yaz
8+u4vN4Sr2hEt1BwL6LsziJS1WwjQreGf+aj++g0i0WLQ3vfJf0qLeF/4p2fGjwT
dndsQ2cdwsEr5AM1qD4OOfXJueF6BMUcXaGdHPOFw+thwVtSNNCIcT8JL4J4roL3
zq8myB6u3WgvuiUNXnbK57QpkiPfnpizcqjiAPcqWRgJVUIwjTeNLZRnLCVh7e12
LRoY1JI2aHR5jDwzrvLxeiHeTlzFAcuRrHI/QoHwf7JrZdpV4z9bUzynr1VYHgVI
QaYRYJGLd5wTrkVyXMTDejsUsF5cCPPgOC187RE1/hrlDOvUWDkPkvZwQu9AvmSh
U9hTcTSrdshaL6azRrGHLaL5hS6jN7Nultq9IR01TWLKMWbZP8C0Qt1bVCX+c++G
aF9JLikHwYelTRu7iL5mMVSAbWuD1idXymfF3bz0IU0NPa8Ijz/Uwn99op5FqUQ3
bzVIAxkaIj2bSEGc6m9VNOCRH7FfEPE3FGfyuaDqDzvcmggpAK1ExWxgPTB9dCNg
OFQhAFCfdbJqgCW5+x5bqmvrCJNaxatE8w/NUoaaEoFlMteSmxqK9c0j1Ykb826L
S1m74iC0O3XOuN+gk1vy
=bxCC
-----END PGP SIGNATURE-----

--W/1XGRQlv2BMqnS3--

--===============2758822820161653377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2758822820161653377==--
