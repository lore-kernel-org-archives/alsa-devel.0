Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622AC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:32:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F94A20578
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cXNY7RJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F94A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EE0615F9;
	Mon, 30 Mar 2020 18:32:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EE0615F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585585976;
	bh=7YLPfHYzvcjsitPmeEChTl9Q/c63c9iJrj1hH472ybo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXNY7RJUzezS37eqad4hEEzILe4n2VDSOwAnbRw+QX//rz3ACSeikRfcKZRP7lEEU
	 jQpjfvAol37gwSh6D187Am1eZ2S4YNtoehQit/OIqrXYW2q8//rnltMo+sCNmFgJpR
	 kQbKfE7CRTMsoMONbmWd2yCnuY2LCaQxMQQ94OjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7E48F80145;
	Mon, 30 Mar 2020 18:32:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30B43F80148; Mon, 30 Mar 2020 18:32:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4705DF800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 18:31:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4705DF800EB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CED1042;
 Mon, 30 Mar 2020 09:31:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D5B3F71E;
 Mon, 30 Mar 2020 09:31:43 -0700 (PDT)
Date: Mon, 30 Mar 2020 17:31:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: snd_soc_dai_set_fmt add substream independence.
Message-ID: <20200330163142.GI4792@sirena.org.uk>
References: <20200328015831.6230-1-flatmax@flatmax.org>
 <20200330103213.GA4792@sirena.org.uk>
 <3c00bf93-04a8-04af-e0b5-d0f76f5dbb06@flatmax.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <3c00bf93-04a8-04af-e0b5-d0f76f5dbb06@flatmax.org>
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com
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


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2020 at 11:28:26PM +1100, Matt Flax wrote:
> On 30/3/20 9:32 pm, Mark Brown wrote:
> > On Sat, Mar 28, 2020 at 12:58:31PM +1100, Matt Flax wrote:

> > > This patch is aims to start a stronger discussion on allowing both CPU
> > > and Codec dais to set formats independently based on direction.

> > If the DAIs support completely separate formats they're not a single DAI
> > and should be represented as two DAIs.

> I understand, however having two DAIs produces subdevices and pushes the
> overhead of managing registers to the end user in the form of two sub
> devices.

I think that's a swings and roundabouts thing where it really depends on
your use case - for example if the DAIs can be organized however people
like then people can come up with creative ways to wire things that
don't pair things in the way that makes sense for userspace.  Ideally
we'd be able to match up any playback only stream with any capture only
stream which would help a much wider range of systems.

> Is everyone firm on the concept that a DAI's playback and capture stream has
> to have the same format in the same DAI ?

> I can see a much better solution (then the one I posted here) which is also
> very simple to solve this problem in the same DAI.

It does push a requirement for dealing with asymmetric setups including
validation that nobody did anything that can't be supported onto all
users to at least some extent, even if standard stuff were factored out
into the core (which didn't happen yet).  This is for a *very* unusual
requiremenet.

> > having an asymmetric configuration.  You probably need to represent
> > these isolators as a CODEC and do a CODEC to CODEC link and even then it
> > seems worrying.

> I like to think of isolation as innovative, not worrying :)

> However w.r.t. the codec to codec link approach, I will take your advice and
> not go down that route.

No, my advice is to go down that route if you are doing this.  I'm just
not convinced that it's going to work reliably since this all sounds
rather shaky.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6CHu0ACgkQJNaLcl1U
h9B25Qf/T5vJZAS/Fv5gDforAG223ex9jg1vhJu/1mHrKrtt9x7R0+tWYV1Jic/I
dc+eI4LLoLeHiEGXEGuWxgcPpygK8+Elos5pEtcCxA6IzG7YODMdL/HPTmqHDrOd
A3a2j1kHS/Ga7uxUf/SkCumBfIx3f3yOMt/JQ8MVkcwjg4g1Dg6XXEfm31MAnWbW
FGzrmHOj/U3s4SWE6I0mKVvjqYpQusXE5LHyB6mhdc4yuPzJdva4xXL8yLL/0tVH
++vWjBottWcSoVbldGKymgLMj+rG4nkVVuOk4wix0h5DEdgV7EZXfIMkYh84036e
I2UX2bmsxFWasW9qHQhgFsxh+hNbvg==
=Gbt9
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
