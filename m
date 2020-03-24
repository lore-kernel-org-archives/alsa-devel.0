Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F1C54FCE
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:55:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6862098B
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ElX7qric"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6862098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6617A839;
	Tue, 24 Mar 2020 12:54:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6617A839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585050944;
	bh=YmyV/Igqo63PYjhcIBSAOmR7woPpIBn5MWK6zaYtWYA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ElX7qric4vlWQV4G8OT4mfp93TN7sTBXIReNEdEio/pQhYlxCLi14pB9v4FDLfYD3
	 zec5UZN+YFWEKY6n3bJpNac/Zm3/w+8UbTx7NbX542zCIWHitFSFSW9f30Mn7cewII
	 JXAzX7TTv1x3Lz+Ic/0kA2Qm5V0qJ4MF7yL2Qcxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDF89F801F8;
	Tue, 24 Mar 2020 12:54:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB075F801F9; Tue, 24 Mar 2020 12:54:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 07DFCF800FE
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 12:54:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07DFCF800FE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E05611FB;
 Tue, 24 Mar 2020 04:54:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620713F792;
 Tue, 24 Mar 2020 04:54:44 -0700 (PDT)
Date: Tue, 24 Mar 2020 11:54:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: sysfs: show components string
Message-ID: <20200324115442.GA7039@sirena.org.uk>
References: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
 <20200324015331.GA3679@workstation>
 <d31659cc-d528-345f-1e56-b0cfae36be5c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <d31659cc-d528-345f-1e56-b0cfae36be5c@linux.intel.com>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2020 at 10:34:23PM -0500, Pierre-Louis Bossart wrote:

> In case you missed it, the components are used by machine drivers to report
> e.g. number of speakers, mics, etc, so that UCM can find the right
> configuration. For a given family of products, the syntax will be fixed,
> e.g. hs stands for headset codec, etc.

If that's what you're looking for it sounds like a richer sysfs ABI
which has these things in it more directly would be a more idiomatic fit
(or like Sakamoto-san says adding controls, though that is a barrier to
things like udev and so on like you say).

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl559P8ACgkQJNaLcl1U
h9COBgf/RDquC1gHDUh9L4XZMRRccpS7snxs/f+QEhXmM16Rw6K26rq3+lwBJtYU
ocVpTG+zpsgxegdk/W7OAX1xLN+VG1IgHf5uhs5D//32aqqD0N6sdaex7g+HWynR
BqoLXBQi3RZI3ot6fADkP8etyL/lpUmdVbHmLmavMmFLftvqrKBifrGpv5NYw/Kl
qNn5LG0E8pYuXo+4y98HoS34hRWGHwqPIpT5n1POxDxm6CaXyFmWL4ihK1iDJW8e
1+jd5K8Z33p2Y+TJr0H8+zCkOXTfCMPC5a8xkQmsNsTnecARpsFOlvXfmh1NdyEg
WDavvfZpM8AgK40uq5ZcsEi/BsNx/w==
=xoig
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
