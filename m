Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8AC2D0E2
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:35:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E5D206B2
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dg5Dms7t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMLUNwVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E5D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BECD17BC;
	Thu, 24 Sep 2020 14:34:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BECD17BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600950944;
	bh=vUr9YRwd8hF9XVYF5mU6UJwtg0FyUtpF0E+w/IWZWq0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dg5Dms7ttLUCeghwqyhKk7MPcNfQar6BI2uCHB9r2Dlu7Ky3oT7rQGc4F6tzSBoMW
	 +RkmkfauDCB4fPv/OjI0rzLDjs9SaGitqT8RujlXRi6qEEvC1Kb9wFFMboM9FcKld2
	 HgSpmh8yaMAEe3T5ARhhDsPfYA8aOR0Wq+BPpL6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18F05F80229;
	Thu, 24 Sep 2020 14:34:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB126F80232; Thu, 24 Sep 2020 14:34:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D64CDF800B4
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 14:34:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D64CDF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IMLUNwVG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01703221EB;
 Thu, 24 Sep 2020 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600950881;
 bh=vUr9YRwd8hF9XVYF5mU6UJwtg0FyUtpF0E+w/IWZWq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IMLUNwVGVpBWEcEDHnBGCIEwvLQ53r6P2qMp1LdjUS1aZkB1DQXc7wZm3dwpv22Kl
 zx6HW380Wd0V9v0bEAic87a0Mtn7nU4oJj20yGVPnI1rqP7r3NcKmGxOZ8CYFBg85Z
 AL7ZqhHa2LovElH/FMpx1MfgjR2wxMaNqVouAbrQ=
Date: Thu, 24 Sep 2020 13:33:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
Message-ID: <20200924123346.GE4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
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


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 02:43:59PM +0800, Wang Qing wrote:
> Modify the comment typo: "compliment" -> "complement".

These are both English words, and compliment appears to be the one that
is used in the datasheet for this part...=20

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9skikACgkQJNaLcl1U
h9AxRQf/S8gmS+UH+JNtXpZHuFOgB5egaqnkf4SwuZYxea8zSzPdU+E/Mt7JlpCP
avHwW2gQ62VSV3dv3eZLhc7JXwBU0+26cOSaUouzsyR6Xn0Qjh29+Zp1PsQyu8if
YvD/mdzEfb+j1WX75BQiA7y34PTRhLLKMdjET4jLUsf6T+R2btEde/jKGB1os+Gx
OMSPXu/IFPqIjZGnKCG1nCZKOQUhV7PGTr1x29ZMfnonsvTX33dbsALLO5xiJcPw
gefvylbfnma4XnXYQlzt6pJ4VwwsPcsUFb2AAeaEv2zVQuU1qNa5vRd2WAm6aC9c
j6dSFfl87W97J4JDH8AM8FzO1AFqTQ==
=VsqG
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
