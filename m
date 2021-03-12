Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645CC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 11:38:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902B664F6F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 11:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B664F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F77616F5;
	Fri, 12 Mar 2021 12:37:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F77616F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615549082;
	bh=Y3U0bmKJUb+3XHj6p4SPQWcNUnYsIrcL8PrFDSr94oo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZDGPEFXIpmS1ou78tZdUe1RfwHyGEYo1yeIfwNfTwLIQPAM13T2WKaV2vjai6Ejo
	 RY7aDACYhRocRlctN4RCKBu7oU2m6QRNBV4BrijycONabjmb5qoiin8DUj1E9Vx/Oq
	 +a4Ftxy+GCVgymLE+wF1QHzumJoK8uxoJm0fPN8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF231F8016C;
	Fri, 12 Mar 2021 12:37:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D678CF801D8; Fri, 12 Mar 2021 12:37:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D101EF8012A
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 12:37:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D101EF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d1fhTAli"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6223F64F6F;
 Fri, 12 Mar 2021 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615549018;
 bh=Y3U0bmKJUb+3XHj6p4SPQWcNUnYsIrcL8PrFDSr94oo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d1fhTAliRK4bwizKdTteFC6Hd7b76kVDBu6CuADnw71jrWGxEGBQxnzUqPp5JYiZx
 u2QQZ6YetXpIxxMinOxrnFsYy/ZCEHoMsjhUlpV9CA4UdzaOTquwk6zp98Tto0Dn0c
 NMJ1nRdp2wy/MiyVhNee2Yt812Wfow54HMAA+YtLYhUj71aVqiIbt71FzH/PiVNbMr
 fdXgstxUouTUJV1DIdJKlQDZcof6aH05FhtVjDWhg7xywIO+9qGvVYoCc5hHY/Y1cV
 rVQiw4tpiywZL0Nds+MW6CcX6c7xYjTfO4DAPY4S6mP0UM3mgE5vCwuJi4pPqMv4gk
 gdb22glb6W4rw==
Date: Fri, 12 Mar 2021 11:35:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
Message-ID: <20210312113544.GB5348@sirena.org.uk>
References: <1612939421-19900-2-git-send-email-spujar@nvidia.com>
 <20210309144156.18887-1-michael@walle.cc>
 <e8b80188-978c-29fa-b5d4-9788a9f2282f@nvidia.com>
 <611ed3362dee3b3b7c7a80edfe763fd0@walle.cc>
 <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
 <20210311161558.GG4962@sirena.org.uk>
 <f21b87f1afb3eda54b5f00f2d1c146d3@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <f21b87f1afb3eda54b5f00f2d1c146d3@walle.cc>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, robh@kernel.org,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com, sharadg@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 11:11:15PM +0100, Michael Walle wrote:
> Am 2021-03-11 17:15, schrieb Mark Brown:

> > The trick is figuring out if it's best to vary the input clock
> > or to use the FLL to adapt a fixed input clock,

> For simple-audio-card you can set the "clock" property if you want
> that clock to be changed/enabled/disabled. But that doesn't seem to
> be the way to go, at least it was NAKed by Rob for the audio-graph-card.
> I don't see a way to figure out if MCLK should be controlled by
> simple-*-card without adding further properties to the device tree.

If the card has a clock API clock as sysclk then set_sysclk(() should
be configuring that clock.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLUg8ACgkQJNaLcl1U
h9CSGwgAhrOIMEFqoBHhAxZirq3hXq7cqfPrHmJx8Y03rBpjXiY5Syx8tbIGHLHL
THMEzZwO2/QPnVG39A/KCu2fv4Pjd5EHzlV1ZurXSWFEFtXzzW06Kyx5TYq/wQch
UlYziTkkW97LkhsBGYTGLQT9lHbdkiQi2CZzv+DrfWA1ZEql2IThGI8/tHwvOiDQ
nl8Lm1QgjJ2jwiKZc2fWDoNnC6++ggNAQaCEwYyxpMSNgo55smZMTCJc7xHpU/Xp
1u1jYSrWDZwj3GwgbJKzZjFEQ1bWsWBwapjxOz1A30qo0SfCKk9N1OK3fi3DRB6m
FuL4a2mG40TQ+qsz3mx6MKAfagTMMQ==
=nIRs
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
