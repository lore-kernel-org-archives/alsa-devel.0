From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
	between DAIs and DAPM
Date: Thu, 16 Feb 2012 09:59:56 -0800
Message-ID: <20120216175955.GE3383@opensource.wolfsonmicro.com>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
	<20120215162412.GG2996@opensource.wolfsonmicro.com>
	<1329399358.28852.19.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3125535964826579679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA4F1103F89
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 19:00:01 +0100 (CET)
In-Reply-To: <1329399358.28852.19.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3125535964826579679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2012 at 01:35:58PM +0000, Liam Girdwood wrote:
> On Wed, 2012-02-15 at 08:24 -0800, Mark Brown wrote:

> > I was thinking about something close to this myself as part of the
> > CODEC<->CODEC automatic DAPM stuff I keep mentioning.  In order to make
> > that work what I was going to do was instead of mapping the widgets
> > directly onto the DAI was to add a DAPM widget that represented the
> > stream and link the DAI to that, probably created automatically from the
> > DAI definition.  We'd then have the DAIs sitting in the DAPM graph and

> I'm easy enough, but I'm not sure how we could map specific PCM channels
> via the DAPM graph. e.g. we could connect the L and R DAC widgets to the
> DAI widget but how would we associate the L DAC widget with PCM channel
> 0 etc.=20

We actually need to do that anyway for the CODEC<->CODEC links, I've got
use cases where there are multiple independant streams going over the
same DAI on different channels (eg, stereo pair on 0 and 1, another
stereo pair on 2 and 3).

I can see two ways of doing this.  One is simply to teach DAPM about
these shiny new things like channel numbers in the same way it knows
about mixers and muxes.  Obviously that's a bit invasive but clearly
it'll do the trick.  The other is to hang this in using the connected
callback on the route, have the callback look at the DAI to see what
channels are active and then report if the link is present or not.  The
infrastructure for that is there in DAPM itself already which is nice.

> To give us a unique channel ID for each PCM channel propagating through
> each widget (since I can map PCM channels atm).

> I did connect the DAIs together in the mach driver via DAPM, but I agree
> it would be nicer connect the DAI widgets together here rather than
> DACs, etc.

> The dynamic PCM patch is also blocking on having some sort of DAI ->
> widget mapping so we would need something upstream soonish.

> I'll take a quick look and see if I can modify this and try and include
> a DAI widget too whilst retaining the channel mapping before you have
> breakfast.

I *think* can get something working quickly that doesn't fill in the
blanks for CODEC-CODEC links, though the conference is looking quite
interesting today.  I'll try to send something later.

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPUQUAAoJEBus8iNuMP3dGTkP/A4wbYwc7VZmMBrRpTyMiXhO
l9VU4KytUrs8WZ2NwqtnF1kKsYML8+hlNvtIZaBcVXMHZjVxw6CpmFn5LlZd6XFo
kpRtV3BAO5nbuWz+ieCheXakX/tmSlyBka7sFDzozA0Sr0sypG9CBhI1ZBAR7zIh
CnWpeYG41NtSD16lvfcJ9Zc/55NnNKflJUyxIeeN1TLaOjgVqp0XQi9BbfZ8JvCb
BUDXrvJLKj4fpj1WrSpUjMn8MldR+BsuN4OLcPiPzmE4owgqzI9EWjlqLhps/weh
BUjE8mfpJgag3CrAJpmeIgVHeQyMkCgD7T2C7LFOWcLkrKnenwKKWL9ihrDQcz1K
76xeRioEyg5NCMY86F8QX4ToceHu2csVmZzD6LnaQnE/bXL/0PbKFYBbBrMkv247
qtLgPmuGSKNbkswoPg49d52fHwv9kc7F4Lb3s0NLgY09ZJqbNs/t63HiZhI8g/K4
ugBGpvSHC8VqPGSLkA7xEBuISlhA4IWuCyK9juDa9Iyl7GYA+OzbgmhFk+jV5fWf
MSR3StGNhheJLJYGq70r3ZUoVTVxDel/7ZfQR0H38tlJJIOiJdHgMuSXt9PozwGq
GAMxwrzIgYxwwkdDXDldYan1Hkpp4Vtq5wf6SZmnrvNUkj7+zxZpgzN71zVPDweF
ZO8y9EXs7V0YG0dlb7rC
=5fgM
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

--===============3125535964826579679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3125535964826579679==--
