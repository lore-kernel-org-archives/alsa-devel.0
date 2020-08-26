Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF6C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2472078B
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Foo8Z4Dh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+EeWxWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2472078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E1DF177B;
	Wed, 26 Aug 2020 18:54:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E1DF177B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598460890;
	bh=yvbxB/dXm+wxQXgZYoFFZEVL9w4GvstjJ1BXu6Uy/Hc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Foo8Z4Dh7Mh3wA1EA2y4NswvRgcKzcfeEx+6bLh0K9FgVWO8LjLx2mRDXRQrIYdk7
	 x5LdPmZtvf6Yv8uCFTbUjfIrfp2MAH/dm26tDvzVDGDzOcXx2A6mk28cQv/xS57pJv
	 +3qVyMRtYnUY23MyyRvaVAuFA61+ctD4XWYEZWV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C71F801F2;
	Wed, 26 Aug 2020 18:53:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51439F801EC; Wed, 26 Aug 2020 18:53:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC71AF801EC
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 18:53:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC71AF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G+EeWxWl"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1DD32078B;
 Wed, 26 Aug 2020 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598460824;
 bh=yvbxB/dXm+wxQXgZYoFFZEVL9w4GvstjJ1BXu6Uy/Hc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G+EeWxWlvWkzBLDIG4YwXEVSUsPzaMdlqtMCM2GTdCgivysepguirOTd+5lMVVyNl
 i9dtROwHC76N4bjFqFddps3JLinWLMBAsEFpP1G3l7IiTW4xAaIG1kIJy28biGFpXk
 WCvP/u2YDSt5umUXhfoBNoy72IC0sT2M2Ob2p7Ns=
Date: Wed, 26 Aug 2020 17:53:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check in
 fsl_spdif_probe()
Message-ID: <20200826165308.GJ4965@sirena.org.uk>
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 11:09:18PM +0800, Tang Bin wrote:
> The function fsl_spdif_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.

Why is this an issue - the check will make things more robust if someone
manages to load the driver on a non-DT system and otherwise costs us a
couple of instructions?

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gk3MACgkQJNaLcl1U
h9AXowf+OVsKdeEZ3BjfcRZvF73cSt5ZNgBH2LZFoif+p5duvwFhYWYpiM838REI
CFWQz5uaMwq5pzA8Hx+iJA+HyEhiucpXw3yxW5Xs0j1nd/BgiSGKdyHlTXZ3RqD4
Gr2QdQXO17esiaT11+ZLFIwecynN29JLQ8GThARSMc7tGfmaXy5JQJkOy5c4nOFX
ycF3dds18vEua7ajqC3wFLTDygdqE6gv41YqIJgU3J9X/tAugKh1jtTa4k1eh/6M
ydH9ezNoA3havqWqAAhAGbW3kbLBCQFKsndWnZbYPU0VHZw5shBWTrx2+x6z8F68
YM/0TyIgmkvB07oBBF6wkjb5sD0hZA==
=6aKW
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
