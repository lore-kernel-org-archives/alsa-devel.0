From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Thu, 26 Apr 2012 12:27:26 +0100
Message-ID: <20120426112726.GF3207@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1395991140368776021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37F5710BA62
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 13:27:29 +0200 (CEST)
In-Reply-To: <1335384469.14096.203.camel@mars>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1395991140368776021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 10:07:49PM +0200, Christoph Fritz wrote:

> # amixer sset "Mic Select Source" 'Mic 2'
> Simple mixer control 'Mic Select Source',0
>   Capabilities: enum
>   Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
>   Item0: 'Mic 1'

Nothing springing to mind here, can you see logging for the register
writes?

> When I tested arecord for line-in, the "Capture Slide" in alsamixer was
> wrongly inverted.
> in sound/soc/codecs/wm9712.c:
>        SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 1),
> should get:
>        SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 0),
> If you want I can send a patch in.

Yes, please.  In general this is always a good thing to do if you spot
an error in the code.

> Since patch "ASoC: Sync initial widget state with hardware"
> (commitid: b66a70d5e9929f3b0df5a7177bba75652d2f4c3e) the mic capture doesn't
> work. The MICBIAS bit from the "Power Management" Register are alway 1 (disabled).
> So that the captering works the active status must be set to 1, at the right time.
> That this works the stream name must be set.

This analysis seems a bit confused - how does changing the initial state
affect the dynamic changes at runtime?

>  #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
> -{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
> +{	.id = snd_soc_dapm_micbias, .name = wname, .sname = \
> +	"Mic Bias HiFi Capture", .reg = wreg, .shift = wshift, \

This isn't right, the mic bias clearly shouldn't be associated with a
stream as you can do capture without microphone (eg, from a line input)
and you can have a bypass path with no capture.

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmTDZAAoJEBus8iNuMP3dSLEP/3zMoEgp8/U3/w9kXNfA+93C
V3aF0Q1MgasfeZpJF1qm8k/N7ZB/mV0ISTsG7eyOH5IFJje9U6yHRe0h6UN1Y5Fp
4e4wEM2CB7HKvAUfBlpC8/f3Z2yfJr6yQTLGWk688MfqNE/TZ5og1oeYj0l/06In
KMR99edjzOvfxthsJr0pOOa4WcwpBvvHgKonrtcCI+VVaXH9PaUZFLEwiHrav7zo
4XPVp1f6wr2eO0T12MTD9PZL7Oc5CZh5sS3nEOl7FhoGemsGpqYghmcW/AP+egEK
RwzzuK3tcZqF2nJ6f0isC0L9FopyJwYGspkcS4Hp30bdzSABxUD3EFH339o0EA6R
/V+8lvDz+hxKBEzTIls9qDpKo+X/3zV6C2l/AGk/Z6CPkXOR8wjBmVja8pTWZ8li
Hyhhji7/wUte7zluGVKMKzbLhCax8HI8yf3cedMFz/ZSp2PgLEjkWruZrsMHad3B
ZTL+4Me1zhP/8+7l2HasjmtU1HrRLfV26vH7pbmZOrIOoOWjBrs4mkAoEjUHZOFL
0nmYbO0VuWdkj1hjbTLAaVwMuhHH28Le7SEcO3XzpB7viV7jIjwlqzKJIc4ajRti
Cu39sbOycfk5be/EBcME54d6624qiP3fwtYzDtzkMe04ntJWPjHlI5meWMwWfGCT
1e4FMxrVrlVz36tXub9j
=heux
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

--===============1395991140368776021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1395991140368776021==--
