Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23333C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Feb 2023 13:12:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D70111CF;
	Mon,  6 Feb 2023 14:11:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D70111CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675689147;
	bh=bj7z4VfBMW0oYbqujy/aQRtk9/bVRQMqEKQV5nfKues=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oSwiX9jMz65V7KZz+buE0/WDAkx4k//ll+FIz3+IrjldzIIMoWVWmWh4ElA7WcoD+
	 o7tziU+gFBeXXjyJC44uQSO7/8lXaRlU5fEWgKwtqglkSkR0BKDczgSYT45ES2GliG
	 xsPE5i/mXGLtdnnNO4TnvQFoclzP+42pUG5Jrzk0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6765AF804E7;
	Mon,  6 Feb 2023 14:11:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7881F804F1; Mon,  6 Feb 2023 14:11:25 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE6D7F800E3
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2023 14:11:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE6D7F800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ENQBymOO
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7CC7AB81097;
 Mon,  6 Feb 2023 13:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CAC4339B;
 Mon,  6 Feb 2023 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675689074;
 bh=bj7z4VfBMW0oYbqujy/aQRtk9/bVRQMqEKQV5nfKues=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ENQBymOO24Jnyr4VXvEPADyvpAYXELsy8/mAecH3s6YB24bNFEVL8BFmZMrOvWAcn
 ZlO0x03R3ukRxX57XbPUaCgM1mFij9Dp2DMSBkHwrZFVSK5LPo2mCIYsynkL/BDRA2
 Lny52Ca7Vc+5ltaljbmgUaWNgc5pAXyQq6AEZ3e28zeMs5CLytMYIfEtbZ0lRGXeBo
 rWt335esryV+W9Wb0BSl5QlTI8U4dPWd3IVkU+4eLfWUT4iB6CFQSAQYPRHEqgKQan
 4/lyKzwSM9JLPTdZ8ocIKeabdHCcHvCSVi36DPgZ2C0E+nRlYNVT0lQtaCJz1abJX1
 v9mZQyaG5dVaw==
Date: Mon, 6 Feb 2023 13:11:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v3 2/2] ASoC: tas5805m: add missing page switch.
Message-ID: <Y+D8bf/19aOL7Wzl@sirena.org.uk>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
 <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lwql8M/YpjFd8AGP"
Content-Disposition: inline
In-Reply-To: <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
X-Cookie: Hope is a waking dream.
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Andy Liu <andy-liu@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--lwql8M/YpjFd8AGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2022 at 09:38:38PM +1300, Daniel Beer wrote:
> In tas5805m_refresh, we switch pages to update the DSP volume control,
> but we need to switch back to page 0 before trying to alter the
> soft-mute control. This latter page-switch was missing.

You should just use the register windowing support in regmap, it will
take care of this for you, avoiding any further similar errors.

--lwql8M/YpjFd8AGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPg/G0ACgkQJNaLcl1U
h9AuSQf9EIW5Ag9rte8wlMbJdknCSfP5QH1E+2rlRNZ1vU7bbCbj80l55CjyNJoN
qk3UDHU5n/Vx/NF2rvqO+FS9WmVsaZOQF6QQLeNjId4674oNZbWPjGeGY0Xb/PPH
1MLwW0+33bChc4YGHuBu/aaVrTUxYdTSDoPKCSBz4eU3yHgmxhv5nYmIsa8CGNHT
aiHQebGLtf5GuZ7MOkSbQi1NsdCeVBzC4/VCpYtflEjFF136pYUp3PEXUjdah+lR
m6P62noZIflD/Hyu6CrkK+PajErpp7vKwcn46Z6LcGCx2FJ96N3rZUS20fG4c5Bs
16awfDAQeRN1MBCfGB33EUHNaCajFg==
=W1Zr
-----END PGP SIGNATURE-----

--lwql8M/YpjFd8AGP--
