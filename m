Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89ADC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 12:15:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C07420758
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="myRkugfl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNpO8kBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B8B317DD;
	Wed, 20 May 2020 14:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B8B317DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589976946;
	bh=d7yiottnab+AbH3mdZUj6S9pFf3wFskiRmX55wG/s6w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myRkugfl+hXlZgAn0hSJd5uWjHVg2nUmc9QUvhPg0RmkbkQbgYYu6ZsS5qRvCcRDG
	 Ahaw13Q8GOrwv/2kQPOal9jLPXb3xAKUranN2I8kJCdhw4oS4LAXtJbSxWDtB9JyuN
	 nSoQ+QGloGUgHSbOLdr/PQpuJpgNp1mZH5Sk58nQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB72F801DA;
	Wed, 20 May 2020 14:14:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 696E1F80111; Wed, 20 May 2020 14:14:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 558DAF80111
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 14:14:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 558DAF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bNpO8kBC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 514AC20758;
 Wed, 20 May 2020 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589976885;
 bh=d7yiottnab+AbH3mdZUj6S9pFf3wFskiRmX55wG/s6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bNpO8kBCRKCkKW9cwpSE50gVbISYACtLB1k1VxmhTZ/jUZg9LkLzJcNPQDmN1xbJJ
 xwd/oc6eU5J9c7wuNzM9JnoIaXqifKCrAI8jmHTjyCJayIFwJZ3ix1nynDmPUM6qiH
 TrpclPshd24ty6OSWwOHYBsGJLFYJvB/WKryT//E=
Date: Wed, 20 May 2020 13:14:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC dailink capture/playback flags
Message-ID: <20200520121443.GC4823@sirena.org.uk>
References: <b8b658b5-9c9b-5174-c2df-31ce34a66d75@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <b8b658b5-9c9b-5174-c2df-31ce34a66d75@linux.intel.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Stephan Gerhold <stephan@gerhold.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "Wang,
 Rander" <rander.wang@intel.com>, Bard liao <yung-chuan.liao@linux.intel.com>
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


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 09:25:31PM -0500, Pierre-Louis Bossart wrote:

> So here are the questions:

> - when using DPCM, is there an expectation to use dpcm_ flags only?

> - should we instead use playback/capture_only when only one of the two dpcm_
> flags is set?

> - should we flags errors if we ever encounter cases with e.g. dpcm_playback
> = true and capture_only = true?

TBH I'm not convinced DPCM is well enough tied together to have clear
answers on this.  I don't really know what those DPCM level flags are
doing.

> - do we actually need two sets of definitions? There are very few users of
> the .playback_only and .capture_only flags and only a single place where
> it's checked in soc-pcm.c

We could probably do a driver only thing for the i.MX stuff if we had
to.

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FHzIACgkQJNaLcl1U
h9AQkAf+M7YQeVwk3WjXZE9o392Qhi9+fyGA15DjHJzx2XLCiLSOqg4PwlDul6U2
s0Pj71ZIrrDczpmE43HSsYBnJRd3bO0Ohlfk3vb95RiGR5GPaSUWePrmnxpeHCHp
mDND29TAG3OnNWg0ij5FL8ZRnuQZLosxWXIrc7tGJLp5ANP1YM/g0yIVdi5a6LTq
FU/LFnMUKX8MkNCuMRdJ737yFzorKhQx2Q/n2pAGsq10n6hyWbi+eq3KkQDjh2d9
9JIXWAVUBBJ6JmaVoU6bHvOoEMSnR/pNU5DNU4AEroy9FF5j/auEgzeAmDTShjD0
F+hsx/I2BnM4hDGJ4yR9oFV981VxWw==
=E3F2
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
