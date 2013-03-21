From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: max98090: Remove executable bit
Date: Thu, 21 Mar 2013 17:25:03 +0100
Message-ID: <20130321162503.GC14768@opensource.wolfsonmicro.com>
References: <1363730323.16270.11.camel@joe-AO722>
 <20130320095758.GD28775@opensource.wolfsonmicro.com>
 <1363792936.16270.30.camel@joe-AO722>
 <20130320163627.GS28775@opensource.wolfsonmicro.com>
 <1363820072.16270.43.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8562652486683462570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75EF8265F87
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 17:25:05 +0100 (CET)
In-Reply-To: <1363820072.16270.43.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8562652486683462570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2013 at 03:54:32PM -0700, Joe Perches wrote:
> On Wed, 2013-03-20 at 17:36 +0100, Mark Brown wrote:

> > This is just like any other coding style thing - you should be creating
> > patches that look like other patches for the affected, if there's things
> > like obvious visual differences in what you're doing you're doing it
> > wrong.

> We've had this conversation before and I proposed
> to you a simple solution.
> https://lkml.org/lkml/2010/11/16/245

If you want a script feel free to write one, as repeatedly discussed
(including in that thread) it's not completely trivial.  Personally I
don't feel it's a useful use of time and it's certainly not something
I'd have any intention of using.

> and I still more or less agree with Florian
> https://lkml.org/lkml/2010/11/16/314

What he's saying there is that maintainers should just hand edit the
patches; that's just stupid especially for trivial patches where all
that should be needed is a git am run.  You're doing this a lot, you
should be getting it right.  First time and occasional submitters tend
to get a lot more leeway but when submitters send a lot of patches but
continually ignore feedback...

> I'm not doing it wrong.  You have another demand
> others don't.  I simply don't find it necessary to
> cater to you.

=2E..or even actively reject it then it shouldn't be a surprise when the
strength of the pushback ends up increasing. =20

> If you want it to be agreed that there is a specific
> form for subject headers that varies by maintainer tree,
> change SubmittingPatches Paragraph 11.

This is all pretty basic stuff (and if it were going to be spelled out
in more detail it'd be along with all the other stuff about writing good
subject lines).  Like I say it's also most important to frequent
submitters and not something it's essential to get right first time.

> > Automation doesn't work for things like this, there's a good solid
> > reason why there's generally a human involved in patch; the other people
> > who submit lots of cleanups generally manage to figure this out
> > usefully, you might want to discuss techniques with them.

> I suggest you use a git pre-commit hook to your
> tree and use sed/perl to add a specific prefix
> if it doesn't exist.
> http://codeinthehole.com/writing/tips-for-using-a-git-pre-commit-hook/

I don't think you're quite understanding the issues with automation
here.  Or indeed the desired end result.

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSzRXAAoJELSic+t+oim9vmIP/1Zh0oPDNwsmrRJrKMqQqYWz
Xegrr+vINO1K8F6OsaQ5tVa7mg297GL++fL2RXYVEl9s4OQEy8SG19j+TBSgpM/M
PUiymlB1fWIDSfH3cEW2ioglxTZtr8hvK5n2uAFoNHwaXxhaS031503GNp++DSP5
ueiJ7KrZI/ky5tX+F+8iYVD5akdjqmb+KNBBN5TU/ZGX/87CHoa08zWB/bUYDdeL
TRozgvfdJORkarOYW5uk2dEOMHuAo5xDdpi9bomfJBUkg/ZUqURivCPNkZ8BEMK3
yzximabuaa1RnH93vV/4Acl7y/nsPl1oYxrw9ZjhedkAEgRLP05RFedGFVraAZ0R
DOjDt0q/JCOV04cmNSErHKj2qWrUjENqeDIB0rOOge0rVN6oz7pQZS1aBkQdzNXW
SfkP19j00XeRDVAc7ueQBkkJl90AiblhPf1Diq+efQQBcxlEsIsZWfhfV8qQOBWt
ZHDxHBib3FetLJ10BCKLJ7ampGS5mHGIXg4JFUQVcDeZX5OZjpii1/c3hVZK0Zcw
No/JGqkwhmqP4uD7eTJNZv3FLTSEsFteM/IUDtk9NxvFocwBpSCUE15+IoBjuWaS
cir4nQUY0tCyE+PhG4x43jjIhBVPiUQbL65t3zjgbkrgJYqltGfx4mAKbqpUivaG
RtpeCNOHiGEX6vdxE03B
=EU4z
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============8562652486683462570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8562652486683462570==--
