From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sun, 1 Sep 2013 12:51:16 +0100
Message-ID: <20130901115116.GB3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
 <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk>
 <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8099756091645036333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2522610C6
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 13:51:24 +0200 (CEST)
In-Reply-To: <20130901085121.GO6617@n2100.arm.linux.org.uk>
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


--===============8099756091645036333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 09:51:21AM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 09:42:29AM +0200, Lars-Peter Clausen wrote:

> > * With non-DPCM ASoC it is possible to have two DAIs if they are not used at
> > the same time (which is what I recommend you implement first, before trying
> > to get DPCM running).

> If you'd look at my other responses, you'll see that this is what I tried
> back in May, and I was unhappy about that solution because:

> 1. there is no guarantee that they couldn't be used at the same time.
> 2. this results in two entirely separate "CPU DAI"s, each with their
>    own independent sample rate/format settings, which if they happen
>    to be used together will result in fighting over the same register(s).

These aren't issues for either/or, the whole point here is that the
machine driver will be limited to only connecting one of the DAIs so
there will be no way for userspace to interact with the unused DAI.  As
Lars-Peter says you can add explicit checks for this in the code if you
are concerned about system integrators getting this wrong.

> Moreover, this results in a completely different set of changes to the
> driver which are in an opposing direction to the DPCM approach.

Like Lars-Peter says it really, really shouldn't be - what moving to
DPCM should be doing with this code is mostly moving the code around a
bit to pull the bits that are shared into a front end DAI.  The most
substantial change should be handling the enables but that shouldn't
take much code at all, your curent patch does it in 35 lines and I'd not
expect it to be much different in a DPCM world.

> > And I'm sure people are willing to help
> > you figure out the parts you don't understand yet if you ask _nicely_.

> Can you then please explain why when I ask for help understanding DAPM
> in a "nice" way, the response I get is just "it's just a graph walk"
> and no further technical details?

Ask more detailed questions and engage in a discussion; the reason you
keep on getting the same responses is that you tend to repeat the same
requests a lot.  Something like "I understand the big picture but I am
trying to do X and need to know Y because Z" (with all of X, Y and Z
being important) is usually a good approach.

The public interface for DAPM is that the widgets get created with
sensible types and hooked up together then powered up as needed, if
something needs to know specifics of that process like exactly when a
given register will be written that's a worrying implementation detail.

> | DAPM is a set of "widgets" representing various components of an
> | audio system.  The widgets are linked together by a graph.  Each
> | widget lives in a context - cpu, platform or codec.  Some bindings
> | only happen within a context, others cross contexts (so linking the
> | CPU audio stream to the codec for example)

This last statement is not the case; you can see the route connecting
code in snd_soc_dapm_add_route() - there is no case in which it will
only try to match within a single context.

As I have said to you without more information it is hard to tell what
problems you are seeing when you are trying this.  It could be a case of
trying to create routes before the widgets are added, or it could be a
case of trying to create inter device links with widgets with globally
duplicated names (though that would give wrong routes rather than no
routes so I suspect sequencing).

> > I mean I don't come to you either if I have a new ARM SoC that's not
> > supported yet and demand that you implement support for it and exclaim
> > that the ARM port sucks because it doesn't support that SoC yet.

> If you come to me and ask about something in ARM, then you will most
> likely get something more than a few words explaining a big chunk of
> code - a bit like the oops report I disected last night and provided
> full reasoning of the conclusion that I came to (SDRAM failure /
> hardware fault on bit 8 of the SDRAM data bus.)

The bit about the way in which support is requested is important here -
it really can make a really big difference how one asks.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIyoxAAoJELSic+t+oim93gMP/juuQfWsLnyUI0yVdA6ky1BY
utcSse4HxaE2PyLZG0ou0Jup1PVEUdBTtj5XlQ/nlv+L0nvC2R4xFgs5T79e/qvq
lKfeSwlvDKr+tKWdy+lCo1TGATSRSceUUYF0lfTwkfw7DdSc6C0T3Ttkv4Ns1SuH
Gcs3QDHyoNOLBhGTfpUbMYSQS+AMjQNZlZ2S8tqWdMtLP07Bd9blW5d4zupCVnkq
YvbchQOLwkX6isRELnxpWqcptf4SSKmasMEFdT2PCG7JqMgY5qj/7gJ+UMmbPZgP
DsIGep15ZYnP1IfHdxAfanCdeKKInS/fMKjwTqaAuHQFCCzZSLHhrA7SmyoEp9mM
hT8ApHNF29IkSi/rjZ89mcWlFVFEOI5f/eBvxvCmoYsS7Nf9Yw6+oFvyRV19x3DD
w+WEAe0IWCUDZEwXwHcS+8J3S/DnGtcUJWQVvlSda4QJQ+QDVd8OhnmvCT6TvMxc
liCsJ0DzHs/M7ExQ1Ts8YmPQzt6nRaeMJ2jWf8UwpPCOQAW4elDnjIY8u2yYb4gW
fZtgHuYKHkH3vSw4Z45R1kKUVUymbcOmn7U5RLtGqT8oTfl2S1TRxYXoLMAFXHsp
8h1RlXuIaAhYt2oAsUo9ipgkNR+VOG0gLf6TeTqyE0G7zVRkOwBXftDD5/lBhlfG
MIn/vmYQDRueT3PFI+Na
=WgaO
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--

--===============8099756091645036333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8099756091645036333==--
