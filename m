Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7DDC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 15:21:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B2D2389B
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 15:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B2D2389B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F06AF17E5;
	Fri, 15 Jan 2021 16:20:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F06AF17E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610724102;
	bh=7+nF2l9TtNjF6HXmyJWfi6x41zb59s8IRwjRZniglYs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RPSCUAyTmU4wsxzaomM+YwXcIxr/aPcv41nFbDJtpdtEApmveEPHo3NH+XgSeQKbs
	 p3BOTiZKM/Is8bZCxgqJjvjHcsTMgcAh1X448pHgihEf+DFcof4k9LOFzMuRxxwWao
	 xwHacyNQ4WR3nNatvLs5N3rOIk5emkg0mVua7xO8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D914F8016D;
	Fri, 15 Jan 2021 16:20:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C4A9F801ED; Fri, 15 Jan 2021 16:20:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21BCCF80113
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 16:20:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21BCCF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NT9bamE7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF902389B;
 Fri, 15 Jan 2021 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610724039;
 bh=7+nF2l9TtNjF6HXmyJWfi6x41zb59s8IRwjRZniglYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NT9bamE7cphEMa59UXgq5aSSmzjPkDxEc6wajUhyD3LeEwpPjmOVt/sWF4ok96KDQ
 T3Dk3yXadr5+L9Vd0GEO6pAifTTVFDCS3eRsSRXwYpVwSrjbO1SgNFxtATLJj1hxtH
 bpnqehb3VdtZiD0AUmhzD9RbzMogVTiqdvnZELwFLHGV4edteDE/mqXjFgbVkSeXM+
 RqV+pjw/G/YVXa2fsFhmTxBu/GGi0Vwzbif2d/CGPoOkUtMDB2ixyAMH2fIv6mLmNj
 zwr8AIuMdW2EPzHgbOoZkYlzBDhgwkDk4EnYTi0LwtG10eT1TAhIIDVECokl4999Mf
 Ti2rRgiuqeAsQ==
Date: Fri, 15 Jan 2021 15:20:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
Message-ID: <20210115152004.GD4384@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
 <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
 <20210115131142.GA4384@sirena.org.uk>
 <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 alsa-devel@alsa-project.org, f.fainelli@gmail.com,
 kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 nsaenzjulienne@suse.de
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 02:42:12PM +0000, Richard Fitzgerald wrote:
> On 15/01/2021 13:11, Mark Brown wrote:
> > On Fri, Jan 15, 2021 at 10:35:23AM +0000, Richard Fitzgerald wrote:
> > > On 13/01/2021 16:09, Mark Brown wrote:
> > > > On Wed, Jan 13, 2021 at 09:22:25AM -0600, Rob Herring wrote:

> > > some_codec {
> > > 	pll: pll {
> > > 		compatible =3D "fixed-clock";
> > > 		clocks =3D <&audio_mclk>;
> > > 		clock-frequency =3D <98304000>;
> > > 	}

> > A PLL is not a fixed clock, why would you define a fixed clock here?

> It's a fixed clock if you are only setting one configuration. Call it
> compatible=3D"any-other-dummy-clock-type" if you like, it doesn't matter
> what it is for the purposes of what I was describing.

> This isn't a clk driver for a pll, it's just a setting to be passed to
> snd_soc_component_set_pll() using a clock binding to specify it.

So you're trying to describe a crystal on the board?  Why would this be
a subnode of the CODEC then?  Surely it's just a standard fixed clock
which provides some input to the CODEC in the same way you'd describe
any other input to the CODEC.  The above doesn't look anything like the
hardware.  But if that's what you're doing how is that related to
configuring the FLL except possibly as the input clock you'd reference?

> > Are you confusing the selection of rates on existing clocks with the use
> > of the assigned-* properties that the clock binding provides?

> I'm not at all sure what you and Rob have in mind here. Perhaps you
> could give an example of what you are thinking the .dts would look like
> to define some pll/sysclk settings for audio-graph-card to apply. An
> example is worth a thousand emails.

As far as I can tell you are trying to configure the FLL in the CODEC,
telling it to take an input clock and produce a fixed output clock rate
=66rom that.  The FLL is a fairly basic clock, there are examples for both
that and choosing a configuration for a clock in the clock bindings. =20

> > That seems like a *very* surprising requirement - why would the clock
> > binding have that requirement?  It would seem to create issues for a
> > single device providing multiple clocks which should be a pretty common
> > coase.

> You misunderstand me. What I'm saying is that to do this:

> 	sound {
> 		clocks =3D <&pll>;
> 	}

> The node 'pll' must correspond to a clock provider driver. It can't be
> just a bare node with some properties pick-n-mixed from the clock
> binding, like this:

I'm pretty sure I understand you perfectly; again, what makes you say
that a description of a clock in the device tree has any requirement
for a separate compatible string?

> So the question I'm trying to ask is: when you and Rob said use
> the clock binding, did you mean pointing to that binding from
> clocks=3D<...>, or from a custom property like my audio-graph-card,plls
> example above.

When we say to use the clock binding what we are saying is to use the
actual clock bindings to describe the clocks, not make a custom binding
that looks kind of like them - making a custom binding doesn't address
the problem.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmABsqMACgkQJNaLcl1U
h9A0MQf9FqJR9Ff8vWBFntAW6Bpppj//aQxSRdj8Hf9cUqOn3izt8QDVsNc5+UwG
i0qQPlRQ4+so1rwDVyI11eNTbTNu0fepzlCPw9e1Q5mxwHqIHqZNTr+HctdgiIEa
41PDMPv5NXFoeED7b/q0D+u+0Wzjpt1ydDnvcv4sSZehkLjjQ+B7B7HFuwt0QY8g
1n7EiinZIaQkMnkx7krT7NzJqqR7F8PeGr40/HJkZtUwT54iwTJce9fT5HR4CUdZ
1Q2BOz4RuXrd3Frmef6SYLKNA3+z7IAvd/Qbvb/siCDaZU8FlNIEFQYR8sMtEpYS
FfOJHFjeekGzQr+MgiArBkNUW9NuCg==
=m3Ta
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
