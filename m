From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm: Mostly constify constraints
Date: Thu, 5 Jul 2012 11:35:28 +0100
Message-ID: <20120705103527.GM4111@opensource.wolfsonmicro.com>
References: <1341423313-9561-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhatm4rgp.wl%tiwai@suse.de>
	<20120705092841.GI4111@opensource.wolfsonmicro.com>
	<s5hehoqleg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8921644340788434140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73B06103F35
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 12:35:30 +0200 (CEST)
In-Reply-To: <s5hehoqleg7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8921644340788434140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhjhOMouxCL2qD2w"
Content-Disposition: inline


--zhjhOMouxCL2qD2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 11:55:36AM +0200, Takashi Iwai wrote:

> The rule->private pointer isn't designed to be always const.  The data
> purely depends on each rule function, thus whether it can be const or
> not also depends on the rule, too.  For simple rules like list take
> indeed the constant list.  But more complex rules may take a struct
> containing variables changed on the fly (e.g. the max rate set by
> user via control API).

Well, it's mostly const - it's const unless the rule itself starts
fiddling with stuff which I'd have expected to be the exception rather
than the rule.

--zhjhOMouxCL2qD2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9W3pAAoJEBus8iNuMP3dFXoP+wQDeEoy/KCTNPsjvY58Vd0W
PdPbhZVuKfk6ew0sDjGGEPlOf+25QLKwY3BpTLcwDJ+/LomRHZfI4qvmXlqKyd/0
ipEegNC04B14EVNV2RnnjEwaMMlk5GS0YQlF7qFfbSgWWCvjvr9r1UN/KiFfkm9H
dn02FMjJ1f9EA0Q7eRo6XEyKTfPlaQsaBvIo9cFQ5w1F8KqREad8VJieZWo35ioD
+ofd6PokrCVctlD781+OYFlCRgs5qm3aBftilD7BDuKa1kUdyOUw/AbMrNzdOfmX
SuS/GcvcNyXXJz9jk1DVwc8MZqZjMbR4S6pC2CayQgwDQB30vo9VyqWioZKrKUC3
xdxOwgyHUAl1uBxyoeSuJyrgFxPfMUN/qgD7484R0JVn18oWtQe/aUwwbAlhNqd7
3nQmi7Otidcv57g4rh0ivpvfm2q3kjKF4ymy7ksQCiBtNDBdiQKeG5zfCNLJzQLw
CuzWBgJ1oZliYPmPU9wpmyyEwsFK42Wtjgr7W0Jl8qZQbY/Oqf3YnDg4tR40XX3G
MY/mDDepTQf4bTqo14ivSNwQpq/bNHNzIK/hh5yQYb0dDwIlIJ8Bfn7rd2/nrdM6
fcYqCUPYDQnOFLDbpjnmFk7SyXXWiLlGSwxjWR8E3K1a2TVtfUNPdxaYJ6M3NDSF
sJ5kSkRN6h8pYooaS/XE
=6ws/
-----END PGP SIGNATURE-----

--zhjhOMouxCL2qD2w--

--===============8921644340788434140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8921644340788434140==--
