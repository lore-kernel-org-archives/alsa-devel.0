From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Tue, 4 Sep 2018 15:55:03 +0100
Message-ID: <20180904145503.GD12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6607888993654202915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E3D2678EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 16:55:04 +0200 (CEST)
In-Reply-To: <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6607888993654202915==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 09:43:03AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:41 AM, Mark Brown wrote:

> >>> If we really want to pay attention to something setting this up we'd
> >>> need to completely remove the widget - what the code is doing at the
> >>> minute is setting the voltage that the bias will go to when enabled,
> >>> there's still a widget for turning it on and off.  There's some chance
> >>> that this will break existing boards.

> >> Turning on bias is controlled separately, automatically in user-space in
> >> many cases, not based on the board. The DT needs to have a way to state
> >> that 0v is the needed bias on this board, without this you can not set
> >> 0v bias and 2v is chosen by default (which is IMHO should be 0v but that
> >> would change existing behavior so I won't touch that).

> > Surely turning on MICBIAS at 0V is equivalent to leaving the bias off?

> It is, but DT doesn't control when or why MICBIAS is turned on or off,
> only what voltage on should be.

The DT controls this in so far as it will arrange for the bias to be
connected to something, if it's not connected to anything then it will
only be turned on if the machine driver explicitly forces it on which is
a potential source of problems but seems comfortably in "you broke it,
you get to keep the pieces" territory.  If we really want to have a way
of explicitly specifying that some widgets should never be turned on
then it feels like rather than have something device and widget specific
like this we should instead have a higher level way of doing that which
can be applied to any widget, that is something that could be useful
especially with things like speaker drivers where there's real potential
for physical damage to the system.

Like I said in my original reply I'm also worried that this will break
existing boards by causing them to change to a voltage of 0 when they
had managed to end up with the default of 2V which happened to work for
them.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOnMYACgkQJNaLcl1U
h9C5rQf9EitPZEIwdrnRzlotHH90WYdwdgA/c4XcKqOlnJ5fFPBoOhfrODmw2fOS
zt7IgdjXBPyNeUtWGvAxNJW2IQ1bdwA6pTr5LtB/LPa22N54tCa7i58T3kc4knGM
TbivsKuBndK2nAgPlA0779KK0LLM6EjSs+lQ5mFWvFCwLUbSQ7fEA9nZ0zVTtq+3
JP5F6OEvvht98QxHKVm9TwcaED2tMW428RThXmh09soARjGQFhAFD28OLthTQG71
/yLKFGFgSLgvJT4/rXeGvdAHLBQnbkDc/9VPyrqpdjh7Yc+YrFK9sChK5Y/vBkgI
YGli/tDAJq71FIS1OPPxfj6qYMFN8g==
=+cLv
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--

--===============6607888993654202915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6607888993654202915==--
