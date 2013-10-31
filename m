From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT
	support.
Date: Thu, 31 Oct 2013 10:45:49 -0700
Message-ID: <20131031174549.GG2493@sirena.org.uk>
References: <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
 <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0404568284998895325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B3289265698
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 18:46:13 +0100 (CET)
In-Reply-To: <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0404568284998895325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mOKeRhn3B7HglGBY"
Content-Disposition: inline


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2013 at 10:32:00AM -0500, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 8:28 PM, Mark Brown <broonie@kernel.org> wrote:

> > Please consider prioritising this over writing e-mails; talking about
> > device tree does often seem more popular than solving the harder
> > problems.

> If it doesn't get talked about, what happens is people copy paste crap

...

> like writing any because it mostly already exists. Device trees aren't
> something that appeared a year and a half ago and are new
> technology.).

These empty discussions aren't anything new either.  If we just keep on
endlessly going through the basics over and over again without any
associated code this just reinforces the perception that people are more
focused on talking than on actually accomplishing anything.  Lengthy
reiterations of design discussions won't move things forwards.

This is why I keep asking you to review and engage with the prior
discussion or to do concrete things to improve the situation.

> Why some of those internal names don't match the manuals despite the
> binding saying they do. It's because if you go through history of the

Do you see any specific issues here?  It sounds like you're perfectly
aware of what the bindings are supposed to be doing with routing signals
to and from CODECs and have found some errors but you haven't told us
what those are.

Like I keep saying, do concrete things to move things forwards.

> All of which exist here. There are levels of indirection for a good
> reason, I understand that, but in this implementation
> card->set_bias_level calls functions which do purely codec-level
> operations (set fll/mclk/sysclk), codec->set_bias_level does it's
> obviously purely codec-level operations, and then
> card->set_bias_level_post finishes up by doing some, again,
> codec-level operations.

To repeat myself yet again: what is done to the CODEC here is system
dependent.  This includes interaction with other components in the
system.

--mOKeRhn3B7HglGBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScpdKAAoJELSic+t+oim9x38P/1cbNaMOsx+iXI8iOhExlx/o
eD+sJDnNBfH/WxRpymPcI0CmyR7pcbHmVeHmMBYgvissuH0WPeYEv9MGI9AhiCsr
W2y81Rva0REsIgxyecI273OklB8u77K96tq0OoEEiug/Y7tK1N1Lp+o5F+gx4Apz
th8qUUh1YBrUrLL6Sy+ar3Z1RSIPxmFTwWD/Xb5+hrOF7KuOLj6yqHHTglUuNRMn
2ZLIU82gTG7HO7/4od0Osq1+2VllldwIkPPd5q0n7sdqNoRc3fiEmGtlho5Q4BIk
on8UXqAYTEvldPD0droXT+jaTrmfOMACRCPNTpZSpDTYqCYF2Tctsh7WAE+9Ranr
hrDbIkqCzEQc3uYygVMvAEBVYfYk9z6mx7pt18ulUc5y0sL6y9gsDqOi5pDa/32n
f2u67EJOt8Rs6pzXYf7RyfNmAxwhwwhof1Sqy45be3y5H7mqNyjGSTEi3G9Hw6Rw
lYAtpwLfY4PCfKzh60BSo5N62ILIMf1w7Bg1aa2YGN4Q+nSmnAC4y3W6zelZy0jM
uW7+5eMx3I5m6nXU5e5b+gU3UtX1vyi4D31z9id6iT2iNlJXNQBq580bwDqVnMf4
wvCSWcQlTahobEF59LURTRUF/35WwtSzhs2XkA67gOf6cCFQb2R1UQa8X+ZBtfuh
CVRiaQcfSUTFYuPbZlUd
=9WUI
-----END PGP SIGNATURE-----

--mOKeRhn3B7HglGBY--

--===============0404568284998895325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0404568284998895325==--
