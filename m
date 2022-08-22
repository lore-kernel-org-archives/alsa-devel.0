Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C42C28D13
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 16:15:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24F00950;
	Mon, 22 Aug 2022 18:14:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24F00950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661184924;
	bh=VfxwmQyY1k2NzPt+1UZYvEgGjJI2gAhCSwC0aBuS5l0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvQoSuQkxTKb6cosH2WhHHVg2HMY14uA0Aq9UQ4c7JNzx9NveaabB9lrk/EueFAN/
	 9NSYuhr6Js9sD2LctXWKk5mjLpqwpKF36fEMGZrPIKrQxhzYoBLNlY5IUQDU9k7KWD
	 74aF3L0LJk/pKMqX8vVZOss8YXhSFnEs0MuTBIHw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAD65F80154;
	Mon, 22 Aug 2022 18:14:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C625DF8026A; Mon, 22 Aug 2022 18:14:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74EF4F800ED
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 18:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74EF4F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e1NwVfeJ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E3958611D5;
 Mon, 22 Aug 2022 16:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D95C433C1;
 Mon, 22 Aug 2022 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661184862;
 bh=VfxwmQyY1k2NzPt+1UZYvEgGjJI2gAhCSwC0aBuS5l0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e1NwVfeJ9Ad/qSBNDH68vNs1WvlmFEYBCjEdHHePKRbkFqng4aiLqjPoiRXO0Wx1e
 IA5FZYoULIcx3QO5frlh9X197PP8TtK++mizaMp+FfrnqNoNzITLLz1oS0TDp9+JA6
 0yRVMQSS7zG9T6Teuc8ubsI/mGd/GKIXFPcLULQKsKhpDn1QGJSUaGcBOJL3v9EQbM
 FMlCJI7iqDMCi0X9vLxRSeA8R14dwZ4+DDiWIIYEvH2t0cLSLw90ESOTdgu58oExJL
 5WMcHbb2KLtCP/Z8sdP1n0FBT9z01iJmqeoMKSSr8JZlGwsI7z1UrZRRtuTFaQLuD3
 yBdeuNX22JvGQ==
Date: Mon, 22 Aug 2022 17:14:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwOrWf3+9c3o5FPO@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
 <19b60ea9-6bee-1cc9-5384-89231fce3a99@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/lY9LArAiCvVh4P1"
Content-Disposition: inline
In-Reply-To: <19b60ea9-6bee-1cc9-5384-89231fce3a99@linux.intel.com>
X-Cookie: Do not write in this space.
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-kernel@vger.kernel.org
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


--/lY9LArAiCvVh4P1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 03:06:03PM +0200, Pierre-Louis Bossart wrote:

> The Chrome folks used an 'asoc_dapm_graph' python script since 2014
> according to the copyright information. IIRC it was python2 so might
> need a bit of work.

> https://chromium.googlesource.com/chromiumos/third_party/adhd/+/refs/heads/master/scripts/asoc_dapm_graph

That's a different tool but also interesting - doesn't look like it's
too advanced Python wise so should be fairly easy to update for any
Python 3 incompatibilities.

--/lY9LArAiCvVh4P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDq1kACgkQJNaLcl1U
h9CgJQf/T/noyjLy9gGJUSy87tOqoWe7zUNpA0QTr56GbMNO9ICucL8cwYYuoqkL
JH7Fi++XqbeFFCSsfC13R4cwaJgYCRAshf2Za/IsSn9TTT8InHl6n4OHXo2hV/4E
4VB7dDPi5pfG2qZXLcJmDMKXekSmUAwPhso0+F/1Yvo6sruKwtYb6DPthKKpadJF
tXWrYhxxt7/LmDL62PBqUEUV9y7rWj7Hc6tI2Rtba4HGlra+jdQNbMOZDo+3ipkL
FY8A6RqLDI7J02C8OUEkO77u8jYs3mBlmfiPzZE9EcXhqXlYiWpS7EvPXhL4i0DT
/L/N6X2H/jfMtn3ywl7/oGFBAjRNfQ==
=0/Pw
-----END PGP SIGNATURE-----

--/lY9LArAiCvVh4P1--
