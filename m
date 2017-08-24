From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 16:52:35 +0100
Message-ID: <20170824155235.2nrqjiwlo3afk4ei@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <s5hk21tjb02.wl-tiwai@suse.de> <s5hinhdjav6.wl-tiwai@suse.de>
 <20170824144152.GC17193@bill-the-cat>
 <s5h60ddj7l8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6417015682429266463=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84085266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 17:52:41 +0200 (CEST)
In-Reply-To: <s5h60ddj7l8.wl-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Tom Rini <trini@konsulko.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============6417015682429266463==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oxaw5iyr3sdqsz3p"
Content-Disposition: inline


--oxaw5iyr3sdqsz3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 05:42:11PM +0200, Takashi Iwai wrote:

> OK, so the fix for 4.13 would be either to cherry-pick this commit, or
> just to re-add "RT5677CE:00" to i2c_id temporarily as a quick band-aid
> fix (and remove again in 4.14).

> The former is cleaner, but it's bigger, while the latter is a safer
> oneliner at the late RC stage.

> I leave the decision to Mark.

I'm happier with the oneline change TBH, like you say it's pretty late
in the release cycle.  Can you just apply the patch directly and send it
to Linus with my ack or should I put together a pull request?

--oxaw5iyr3sdqsz3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlme9kMACgkQJNaLcl1U
h9AfPwf/YeEoAwYEF9+nyF2H6Z6aILhdceUFq9nsWj5LvgAGpxUXlUe3hSHsqokp
Utnk6iU9qA14U6AtruimTlxI/WUy/KBxR1mrtYZkb9N6AASJnLtcPF3/TzmAfAVW
n2IKrO5N7icLwRaDpxYZo4bQc+oPujA2ZQNgnNc6ReFcFCVMXvSYMTcuWMiaiQy6
5KGUNeogreInG6OqosnBMY10aXWczeC7vveKaQfhHwZBNGL/5FAC6y5NRkJGkwhd
btNyKFUpYJtNYEVKZIB95mB81HvNRkhOFk7kaof/AU54tihX19vjAQ7W39lTaVsY
qNPzdqReYprmU7Yrnq+tsUVNdfBkhA==
=vOuK
-----END PGP SIGNATURE-----

--oxaw5iyr3sdqsz3p--

--===============6417015682429266463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6417015682429266463==--
