From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/16] ASoC: core: Add multi reg control
	struct & macros
Date: Wed, 21 Mar 2012 12:40:30 +0000
Message-ID: <20120321124029.GD3226@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213859.GG3177@opensource.wolfsonmicro.com>
	<4F69C493.7070109@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7864804926020867516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BB8A104467
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 13:40:32 +0100 (CET)
In-Reply-To: <4F69C493.7070109@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7864804926020867516==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 01:07:47PM +0100, Kristoffer KARLSSON wrote:

*NEVER* top post...

> I believe that the assumption that all the registers are contiguous would pose a
> troublesome limitation in this case.

...it leads to people reading contextless things like this and having no
idea what you're talking about.

You should also fix your mailer to word wrap within 80 columns - note
how the quote above wraps.

> suggested would work just fine, we also have other controls with signed 32-bit
> values that span four 8-bit registers that mapped in the following manner:

> bits	31-24	23-16	15-8	7-0
> reg	0x59	0x5A	0x59	0x5A

> This means that to write one complete 32-bit value we would actually need to
> write to the same 8-bit registers twice.

This makes no sense - how do the vales "span four 8-bit registers" while
using only two register addresses?

> Also I believe that the definition S1R,S2R,S4R together with S8R might in fact
> already be a fairly complete set with no need to add some new crop of macros for
> this in future. Why? Well since the value handled by ASoC-framework when
> setting/reading a integer control is of type long (snd_ctl_elem_value) in
> combination with the fact that 1 byte being the smallest register size in
> framework means that in a 64-bit world this would translate to a maximum of
> eight registers mapping the composite value of that long value.

What happens when someone wants unsigned controls, or stereo controls,
or 24 bit registers or anything else?  There's way more things can vary
than just the word size.

> Anyhow in light of the situation above do you think we could stick to the
> submitted approach or do you have some other suggestion on how to define the
> signed 32-bit value control with registers mapped in the above described fashion?

No, sorry.  This stuff just all seems really painful to use, I'd at
least hope for more parameterisation.

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPacw3AAoJEBus8iNuMP3ddqYP/2ElhJb3JxKKM8CHpohoi1sT
o5wg0bpzALhqyAGCP5auHV23wKrMSn5uqwKR2nLxYW2O4jz3UAwoz0fyfDtkrlKG
wLyq14ITBQBCRBf/dvpfRsijwwiOlHNrw1LTWIC0vMy926nLE5OJ8tFTPtIZXhXd
xKAHRaRGp2WDm6eUKwkRza7Lt/r+mk22p2ho3IEOxktebMOS7ptVA8rQaNrhdjVy
GxLYh/rPNsCQenCBz3Ox9od0v1kCAgzLSOD9mHRWjM5sQYAts0dpZ11T0wqKHbP5
NeaJvA4aw5RxgAE/MNa31o9fXUkx8WJyIj8mcnZvCv6qyk7+5gB9l3nagkwOVKOO
06L6m/oOhyL4gUWvoHUDjjDhQuJTUaWXeTsucbyIL8chgEz+CR4B8ttXSk7Z2W3G
aow6xW+swi4iChSLJqbloecXkOkB32Bu/c4mmdPs92xc1MxYz43E4cnCND6W/hjf
cDjCjIhyANZOmDXxm/Opo08MZSfgOjsxnzU7SPzUimh4hUj7v5IUc7vyJjAgijBM
Q081X6CCsRQixj7tsOhw1duVF2M/B++uz2N8UgoDDsNkleCwpODtfvpDDmuAYaCQ
9eSi/mPETcLTWOqog9JaEhWlmrqsAURWOAVZhMbe57nMRinZQ8ByElYQ8mPQ/mEg
z5tQHycO9ngGc86hd7ce
=urk0
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

--===============7864804926020867516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7864804926020867516==--
