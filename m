From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Thu, 25 Jun 2015 15:49:48 +0100
Message-ID: <20150625144948.GO14071@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6B7kCplWPsCd3Wyv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--6B7kCplWPsCd3Wyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 05:35:03PM +0800, Nicolas Boichat wrote:

> I'm trying to revive Antti's patch [1], as we are hitting similar issue
> with rt5677 driver. I only updated the commit message and documentation,
> I kept both Signed-off-by and From lines, with a small note highlighting
> my changes, let me know if that's not appropriate.

This continues to have the same problems as the previous version of the
patch where I can't really tell how users are supposed to figure out if
they should use this or not.  There will be cases where there is a clear
use within the driver itself but as far as I can tell almost any driver
might be bitten by this if some underlying driver on a given system
happens to use a regmap so should be allocating a class.

> One issue that was raised by Mark at the time is that a per-regmap_config
> lock class might not be enough (Mark mentioned clocks as an example). The
> current implementation should be good enough as long as the clock regmaps
> do not access each other. If this is a problem, maybe we should consider
> replacing lockdep_lock_class_key by a boolean use_own_lock_class that would
> allocate/use a per regmap instance lock class, or have devm_regmap_init
> take an extra parameter specifying the lock class.

I think this is a problem and making this something that every regmap
does by default was my original suggestion, there's also Arjan's
suggestion of just using nested mutexes rather than classes.

--6B7kCplWPsCd3Wyv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjBULAAoJECTWi3JdVIfQ13MH/3dSe3ZQF9GF8jH6+jT+2VuY
j/1ZtPyBdrdf60emFcSbfTSwR8A+STvziNg83zsEGE7/v1/AKkdPSvFcUT9c2SXP
3QMirLtDexKWB/3ZNaFeKy+Xj/mh3ZfSg/W7UdsmHTQSOsQiUUo5C/DLv8xerR65
WMf8H2n9rGDXvEwR3j7cYbLcsIaG/FTG5Qah47f68/6v/1SUd+xZK+L8mAcQsio9
4wEBFnZle6+2L08eA9LKoKF9ZIiR+3cOeq9kU2ECU6QbcKzW5fD/Mlit15pUeSVr
+UXJBwDxPCQm/x21I1wbkCl2fapMF8sS8FWRP7V9z8Yj6uHWjtp5iBKqDwsZ9pc=
=yTqq
-----END PGP SIGNATURE-----

--6B7kCplWPsCd3Wyv--
