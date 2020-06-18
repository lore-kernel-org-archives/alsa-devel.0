Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A385C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CB12075E
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tqUG6J9s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agh+JJqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CB12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98DC216E2;
	Thu, 18 Jun 2020 17:01:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98DC216E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592492562;
	bh=eUT8V2gyOM43tVhBO8xlNbvs06g4rMOSbbvIONUtD94=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tqUG6J9saAG+FsDpdbX+159R/E/Hhx8EHTnKyFrWWV/dzxQcl+pH933ZIUkjRQ0z1
	 uEFE4+HLGaLkG/Iv31YyjG3F6VwJOfVy8o+XKhfJi0LMvQX1tiPKvGVSzYbRu7HzlM
	 sZP6Rc5+SwWfX/ZRtD3xc/Lzf1XTjmDQRCBomdEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 249FBF8010E;
	Thu, 18 Jun 2020 17:01:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 375B7F80116; Thu, 18 Jun 2020 17:01:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3FACF80101
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 17:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3FACF80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Agh+JJqc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 200D92075E;
 Thu, 18 Jun 2020 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592492505;
 bh=eUT8V2gyOM43tVhBO8xlNbvs06g4rMOSbbvIONUtD94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Agh+JJqcsZnxeps31IPNo5x9l3ZuVITVcK1+s83QWGnCWIDLbtqaXncVJ1+p3s32W
 rW30QR3a4wZMulYdvnANkr68XkjV7plA8XqYjCkoR8P14s/wPJJF3k8fWo+EQkNpkr
 gCHco7dpl0FZ5vJBWZI26kjPk4RY7EMjogeFSrq8=
Date: Thu, 18 Jun 2020 16:01:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/4] ASoC: soc-pcm: dpcm: fix playback/capture checks
Message-ID: <20200618150143.GJ5789@sirena.org.uk>
References: <20200616090210.GA111206@gerhold.net>
 <254a667e-fa49-240a-6386-7e82df8e5c35@linux.intel.com>
 <20200616145251.GO4447@sirena.org.uk>
 <af973f45-59b9-ecff-7d78-97d8352ed072@linux.intel.com>
 <20200616155544.GA8891@gerhold.net>
 <7cbc9233-e5f2-03e0-5659-cf22dea75e53@linux.intel.com>
 <45d43cc9-be22-a7d2-1628-3fb30232bd7c@linux.intel.com>
 <20200617090112.GA38317@gerhold.net>
 <62ccb59f-9d08-c241-952b-bb7af8311618@linux.intel.com>
 <20200617174635.GA40060@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline
In-Reply-To: <20200617174635.GA40060@gerhold.net>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2020 at 07:46:35PM +0200, Stephan Gerhold wrote:

> At the end the question is if those machine drivers that have
> dpcm_playback/capture hardcoded just set it because it was required to
> make DPCM work, or if they actually use it to restrict the direction of
> a DAI link.

The other question would be if they are restricting it to limit the
direction of a DAI link beyond the limits that the hardware has why are
they doing that?  I'm not sure that'd be a sensible thing to do.

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rgdYACgkQJNaLcl1U
h9DoIwf/VbeCTcms9I+QZfQtPfP7YjQ7MKV7htjuAUqcTMHjVG/R7jnUL8sbDCzj
i5luQU27hsygTwqbkciQDKXfl0qLXIysRkLxQwPJcnzzmGwzLeuHEKlmDyjlaYTV
yLO6uR3JAVE9lKQfNB7De8PQZ4NHH00T1ykNlRL9MqExutvF/OmI6eoeo4wbK00d
kmAy1YDTpQdxmj1JMq8mwW04RvH+qW/R3qKnVEfZGd4C3LLqamJ99f4d0TOZBl0t
dmx3GB2YJPvwJV4B69hGjNpCMCcOjZq5AjHCaZtV2dZo2W1LuNy1pVYLO9Bpx7zR
4S0vo/9u3mS8NSZEa6b10hsc4aJkgQ==
=Jwu2
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
