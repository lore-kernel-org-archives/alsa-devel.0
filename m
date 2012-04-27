From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Fri, 27 Apr 2012 12:15:23 +0100
Message-ID: <20120427111523.GE18260@opensource.wolfsonmicro.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4042957467191840881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC180243A2
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 13:15:25 +0200 (CEST)
In-Reply-To: <4F9A7BFA.7000507@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4042957467191840881==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 12:59:06PM +0200, Ola Lilja wrote:

> We will add more codecs to be matched up the same machine-driver and I found it
> useful to have this split. It just separates the callbacks related to each codec
> added in the dai-link-struct. I would like to keep this division if that is OK.

No, I really don't see any value at all in it.  The machine drivers
aren't actually sharing anything visible and the effect of what you're
doing is to make the selection of machine a compile time one instead of
a runtime one.

> >> +	/* Setup codec depending on driver-mode */
> >> +	driver_mode = (channels == 8) ?
> >> +		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
> >> +	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
> >> +		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
> >> +
> >> +	ab8500_audio_set_bit_delay(codec_dai, 1);

> > What's this configuring?  I didn't notice it on the CODEC driver as the
> > function wasn't exported IIRC.

> The bit delay is the number of bit-clocks from the framesync to the first data-bit.
> For the AB8500-chip it is set by the bit AB8500_DIGIFCONF2_IF0DEL.
> I would have put this in the set_dai_fmt but I have not found a bit that is
> controlling this.

But what are you actually tying to do with this?  It sounds rather like
you're selecting between DSP A and B modes...

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmn+yAAoJEBus8iNuMP3de8YP/AiBg3+Ye/3kQ7UbaXK9bg1j
XjJblQ1xgim59R9R8rloHq8H5hptehyTHOwM19XQaQu+q4rzXUaBP9SMToqjspFI
cEfVnLHVRIxWMVamJV5ET4VJ7lx+H99CjhLm0WegYwybN5ODERMgg/f7sFvmv02/
k8k9wdWBVo3N+aOFhZJSpRld7RFu6YdWh2+kc7kYBRMBJhR/dknJvn5n4bYQoQde
1Qj2/L4mxDsLjPipIsEbRtqHMnE9n7rB+5Pq7f7tZQiqQhaWo4CDqKeu/tYgw2gE
IBQ2KES2cB65AAcgwyTAd1bhjsYddTE171y5T1WLJ4TkpYV4Xs+LHQbpaeoZ850L
FvgwX2KxlYpAaSL/sQh5NMQabrRmbmaK0OmMORbtZV0dSGB66H1/UKDlDZOGdY8+
hX6ztPAd91m7bLrrFJFCrtN4Z4ziEnfCgynUulXwsY4o0P3FbJQlNlQMbHJ3Lvj5
kv+HfWrktC5yZMda5fTHxmV7PI5fvH9Qsa4tCDMFkjzCGQe7X9wltdn5I/m/tPX6
QSDeb0XpHFWQOu9mdqkC9ox0+OR1dWGTtiArAqcKBw7qlTOX7FmwXVoOclAaofMc
iLg95zwTVWfzSuk4n7MdKtopta7khzczIVU6kBX8miavxLMGWIAAU9LkurO0G91h
BfZwLARC0xwlvORRZWp8
=e1Mz
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

--===============4042957467191840881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4042957467191840881==--
