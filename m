From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 15:47:13 +0100
Message-ID: <20130902144713.GR3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831191414.GG6617@n2100.arm.linux.org.uk>
 <20130831193431.GI6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7814990146018720670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0741926518B
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 16:47:18 +0200 (CEST)
In-Reply-To: <20130831193431.GI6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7814990146018720670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjXtncIm5b3tWrFJ"
Content-Disposition: inline


--qjXtncIm5b3tWrFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 08:34:31PM +0100, Russell King - ARM Linux wrote:

> Here's the warning I get - I've left the syslog stamp in these as
> evidence for how long this has been known - and I reported these to
> Mark when I found them:

> Aug 10 15:17:18 cubox kernel: WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0x128()
> Aug 10 15:17:18 cubox kernel: proc_dir_entry 'asound/oss' already registered

You will recall that when you reported this I told you that OSS
emulation is not really supported with ASoC and that I would expect a
large proportion of drivers to fail when used with it.  There was no
remaining interest in OSS, the use cases that did exist were all desktop
based but those all seem to have gone away too now.

To clarify what this means is that if you want to use to use the
in-kernel OSS emulation you are pretty much on your own.

> I also get a load of these:

> Aug 10 16:09:27 cubox kernel: S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1

> from time to time as there's no way to tell ASoC in a DPCM confirmation
> that although the CPU DAI has capture capability, the capture side is
> not connected to any codec.

Yup, as I've said that's an issue.  There should be no need to tell the
framework anything extra, it should be able to figure it out for itself
based on information it already has - I've suggested just going through
and looking to see if there are any DAIs that could possibly be
connected before printing the warning, only checking if the user is
actually trying to do a capture should also do the trick.

> And here's the oops:

> Aug 10 22:06:17 cubox kernel: [<c030f724>] (snd_pcm_info+0xc8/0xd8) from [<c030f768>] (snd_pcm_info_user+0x34/0x9c)
> Aug 10 22:06:17 cubox kernel: [<c030f768>] (snd_pcm_info_user+0x34/0x9c) from [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280)

> This is caused because substream->ops is NULL.  Why that's the case,
> I don't know, but I believe the PCM which is trying to be operated on
> is the one registered against the backend (by snd_pcm_new_internal).

Liam did provide you with a workaround for this one along with a
suggested proper fix.  Have you had any success in using this
workaround, or with implementing the proper fix for that matter?  I
don't recall seeing any feedback on the results but perhaps I missed it.

--qjXtncIm5b3tWrFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJKTtAAoJELSic+t+oim9gMAP/0KwwPbLorYsXlu1agBOgEqP
q24lkduOqPCpQoyon26su584zpNtwFrZJZtPoeHAvkrzMwx2DglmY4GWgI+s0V0L
r6YlzzuR4M5LzHwbP6YfSDAqTe8+Z8AmstH3GCx5abpfhKgTZ5uf7Tl8t0y5xllT
pGqYqvSqyhMq/j74FpwRIIdKE2J/WNy6h9zpF4hU7Q4iZg7fUbQpA4xub4Ny3m8k
2aStzX+7s+gl9e/a+EpY0AUndHlKREqMfJeg5Y0BWza77eQln23IXPNvCw0BLP8b
YzTiOdCKq13sYxe4v9XAzH/OR37l14B1cEXADcF6wEmnLbneJ/6v+0ITvTtqJVAM
aiy7MnUvveTDIZor4c8wIasD8b2F7LOZoPq75LiWchaeXRTRwpOwzM6XSJSL1UzU
l9pI9h2f8kDGaJ1pvBVEg+tjxaiG9E33a1yWeMYh5B2E2X5akd9Lw5HSBU4CQbl8
ynbTJfDkCRxE5Nu8KN8rx5fW1sGqohoS8c9WX9/Jr2nFyJVE7BzC2SitCzC7rOn3
hs7w8/UqaIW8mXZUqGj4efti5tHHlAb3/4x462wwkKRnwTKZBx5aa7KvR7tQ2gtB
mcGHypfVjxxgji38Vcb2THUMn8Qyo8/i22ug0tsMZK0tS19LIFIclfdutAMr19mr
34x93mk61lvxc+MsvVGL
=0r8/
-----END PGP SIGNATURE-----

--qjXtncIm5b3tWrFJ--

--===============7814990146018720670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7814990146018720670==--
