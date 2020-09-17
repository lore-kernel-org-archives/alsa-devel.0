Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C25C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:58:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B2E22210
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r05cEjkx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="prSjxzW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B2E22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B80216B6;
	Thu, 17 Sep 2020 17:57:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B80216B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600358288;
	bh=0R8wQ8wtOhNvgIX+2H28XDlxNwOFHmlyptZe/q+b84M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r05cEjkxycs8vpAOA6LS9nJCmkeIYuYoyTD/G8DFRGXyXfTmQ99QJ6Fny1T1cD11s
	 5+YOh1j0gs8u0LTwwMO+iqPAhRdyxzrc9wd8CZYy5GFe8uSyjWeic1t7lfxVbnTR8t
	 /CeXGOog/injHUpoimSHl+ikymyCeb5bKKRKukmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E999CF801EC;
	Thu, 17 Sep 2020 17:57:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44364F80212; Thu, 17 Sep 2020 17:57:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FFBAF800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 17:57:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FFBAF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="prSjxzW1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEB372220F;
 Thu, 17 Sep 2020 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600358228;
 bh=0R8wQ8wtOhNvgIX+2H28XDlxNwOFHmlyptZe/q+b84M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=prSjxzW19p/f7/IiwXidlQxWIH4yvQe3YiglaEZOzU+xmrU8Rdom+UWXBbTRDidKX
 47oehxQHgFGKaSQk54UP3d5JFCxVhVjp7Z2ltXy9Ke6DVUeKqG61MIDETd/c0i8zSC
 hjUAYjlLMOFUMr0yoF6qhtl/U0F7s3ucTW+AdapM=
Date: Thu, 17 Sep 2020 16:56:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming
 property
Message-ID: <20200917155618.GG4755@sirena.org.uk>
References: <20200915190606.1744-1-dmurphy@ti.com>
 <20200915190606.1744-5-dmurphy@ti.com>
 <20200917130236.GA2954@sirena.org.uk>
 <f4a83c01-58e2-1b7a-677e-44d5bde7b175@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <f4a83c01-58e2-1b7a-677e-44d5bde7b175@ti.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 camel.guo@axis.com
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


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 10:15:27AM -0500, Dan Murphy wrote:
> On 9/17/20 8:02 AM, Mark Brown wrote:

> > This is something I'd expect to be done by the machine driver rather
> > than in the CODEC specific DT bindings, and apart from anything else

> Customers need the ability to not transmit on a TDM slot, since another
> device could be using the slot.

TDM is not an issue, we already have the set_tdm_slot() API.  The issue
is how you're configuring it.

> The dai-tdm-slot-num would be a good candidate to add to the sound card to
> define the slot number but it's definition is "Number of slots in use." So
> it is not really setting the needed slot.
> I am not finding any good way to assign specific slots to specific channels.

If the generic features are not sufficent then please extend the generic
features rather than bodging around them in individual drivers.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jhyEACgkQJNaLcl1U
h9B6/Qf+M5hvEXVKhLg+PkuggYW/zHPqIs79pJjddV/tkBhy612mpeKAAj8Crp4G
WTsAdCZ8gh0xhUu5quFCArp73bD+tVGMcp2OidYjpG9sZ/4sBW36oYeBRei3zPw0
531VEYn5lS95/BbYlXyTJGT09zHbPRIv2PReev6s+3pUmK1DFsgaLitDRwLz+Ndt
DiJLHewySrOXdvwg3VBE04nQjYW5qAgkF9EVKAyKU68NKpAw3NAYcaIlOe7KFubg
Gy1yyCiYFNmdfDGcGJ+H8JdhpvUKc8fh4dUbNJGl5n1X3S4R78IunjNw9fnR/l3U
yiO+EE3d5A1qgWqlUDXSOLr+om19xA==
=OC0y
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
