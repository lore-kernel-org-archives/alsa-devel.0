From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm: Add support for platform
 and CODEC drivers on same device
Date: Fri, 15 Mar 2013 18:00:17 +0000
Message-ID: <20130315180017.GE8988@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126092020.GH30594@opensource.wolfsonmicro.com>
 <20130315153540.GC2141@opensource.wolfsonmicro.com>
 <20130315153821.GD2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4589225279448904934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4842264FBA
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 19:00:29 +0100 (CET)
In-Reply-To: <20130315153821.GD2141@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4589225279448904934==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2013 at 03:38:21PM +0000, Charles Keepax wrote:
> Currently DAI playback and capture widgets are created during
> soc_probe_codec and soc_probe_platform using the device associated

Don't bury patches in the middle of threads, especially if it's several
months after the fact - it just makes it more likely that the patch will
be missed or ignored.

Anyway now I remember the full context...

> with the platform/codec to locate the DAI upon which the widgets
> should be created. If a device registers both a CODEC and platform
> driver this leads the widgets created during CODEC probe being
> overwritten by the widgets created during the platform probe.

> In general we want to retain the existing playback and capture widgets
> because routes may have already been added to them. This patch will
> check for existing widgets during snd_soc_dapm_new_dai_widgets and
> only create new widgets if none exist.

This still seems like it's bodging things in the wrong place.  The issue
is that we're trying to instantiate the DAI multiple times because we've
not got a firm idea of the chip as a whole.  Adding checks like this to
the code is just going to make everything more and more complicated to
understand over time without addressing the source of complexity.

This is especially true now that Morimoto-san has added component
objects which exist to provide that sort of grouping, we should be
addressing things like this by pulling them up to the component level
so that we know we're only doing them once per chip.  I think the first
step here is to add the ability to create DAIs based on components, then
to let components sit where CODECs sit in terms of setting up DAIs so we
can start moving CODEC drivers over into components.

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQ2GqAAoJELSic+t+oim9SGoP/RzemUEBVXjFXwrzXmGyQ6yX
daATVCmO0Pc11PC4b4eiU+WhvE5+3E9shdMu74O44sYZ2vAk1xAH+sYe3+CPfYGr
9ISiWjLpudreT0MiKruLyfqLuYtr+d96epqaAGOwE1cmoDtXX6qyp4ipQrCoigei
cRg8NlYacI7kSQe7Y562hq0p7yHx4Eu1iN0pJ80g5YCVLsNR3oCEMOcMIGD7z1tM
OPwl6jAC0TckVPxVJW8aQaAb1yvsdy6Z/msL+perDqiXBYQZhxzOgrP06ZOr63lM
VxW+jG8wrV5nBWPHxxGy2ZZJSXhXcYboCHy+R7tgzADLffWTFayFn0cmGDoTdnah
rfL89qgGn2BZ4XUCybbcbledIa9O2KLa7DZlZwDSRSnOZEIVbQu0Cly0xb0lkLyN
uSLQfdaTPqHe8GtYwEwS/RukHuEy9z/UpCkTkPKs/xv2IKAEaxekoPwnq1YExXoC
zKSQnuutB/RAjvzeX2TdkTj/ThD9/S2gP9ngvgkWWUofM64Mqu9HOpGM6dA2ThpE
oj3pGqJQ6KQOHLMSeYWAVCHmDQq1e9iUZiQBUwFaZjA0lPdSO3IOqb0CRIWIMU+/
024ut9VX3akVeseGFN0J2wV4uunyvBsyJjkr+KgEqWgNEony8Osij23ZxBGGOHdu
FM27P8pTGT3huhWW3XWH
=02yl
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--

--===============4589225279448904934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4589225279448904934==--
