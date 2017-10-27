From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fixes for v4.14
Date: Fri, 27 Oct 2017 08:39:16 +0200
Message-ID: <20171027063916.xkhmpk673eqh7424@sirena.org.uk>
References: <20171026141314.f7bckpfhy5p2ipmw@sirena.org.uk>
 <s5hinf1lmv8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0048103971086401636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C4B3266AF8
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 08:39:33 +0200 (CEST)
In-Reply-To: <s5hinf1lmv8.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Chintan Patel <chintan.m.patel@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0048103971086401636==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhpqommthy5lcozy"
Content-Disposition: inline


--xhpqommthy5lcozy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 26, 2017 at 09:39:39PM +0200, Takashi Iwai wrote:

> IMO, my PCM unbind workaround can be postponed to 4.15, as the unbind
> is still broken even with this.  It can be combined with other unbind
> fixes.

> Also, topology fixes are only potential issues, and no urgent fixes
> for the bugs we're hitting now.  So they can be postponed, too.

For me I'd prioritize getting things into the core over other things
(and both fixes are small) but these are the ones you want to drop.  I'd
say the topology bugs are just straight up bugs, someone with the
ability to replace the topology file can readily trigger them (as could
disk corruption) and the null pointer dereference is definitely severe
enough that we should just fix it.

I guess we could try to drop all the resource leak fixes but several of
them are in with other patches in branches.

> One Skylake jack name fix is actually wrong.
> It sets "HDMI/DP, pcm=%d Jack", but the right name is without space,
> i.e. "HDMI/DP,pcm=%d Jack".

So how did they test that fix then...  bah.

> All others seem device-specific small fixes, so we can take them, I
> suppose, as long as they are a kind of stable-targeted fixes.
> (Basically the fixes with Fixes tag are candidates for stable.)

I'm not insisting people add fixes tags for everything, that way lies
madness.

--xhpqommthy5lcozy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlny1JQACgkQJNaLcl1U
h9CkKgf/cAFk3o2N3IXj1EfVmE7ZMw4tbCb9pFeWZvwOQsLZVpujmLrS8jtTMnvo
73YpcvmZtRl1ncnGCXs5NbEs7qEET6EQempZpVbfZLGbaqkywQvQnVd57G/LNTga
/LG60uNjV495I0lFxEQW+CSgkQ7d5CguKKci448Yu6Y9OlLQzg2nmrDu32tPM2f6
sveAtFKf2fp/O/tRXzLfJpH0V9UQqKycPFdtF4lIis34husBDPKHV8hPuJQMEjDB
PTjBzmAGDyB6n8vWO23dwT7OkvlmkQjAtUy1EIUpZAo30YjaGJHgxbbAME9W/5Uv
IwHKOUFkaR/T9el4aTasecUklxmGOw==
=hpwC
-----END PGP SIGNATURE-----

--xhpqommthy5lcozy--

--===============0048103971086401636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0048103971086401636==--
