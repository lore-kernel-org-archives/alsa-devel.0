Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A8CC3A5A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A135D2078C
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FjzBqCJz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/TnGDTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A135D2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C227C1676;
	Mon, 20 Apr 2020 14:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C227C1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587386958;
	bh=RzdHxTJacSWPvJtT5P775eirlREXlwIxyT8TPLJGksI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjzBqCJzehPRogWlCtZVeNG3Vpy81otyL/vcPbQeF6KbXqBpR4nE+q2bq+0PCX0yt
	 IQYlwZU8Fzn3q9mqAfzCVV38snBBJv9zfIj7CIhXbRL0tUuMEevBHgB/kGH7EEsMsW
	 Hm/E/7281YlxNGVqmbFAUza4vwDgrlFfvwXu7zT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4923AF8013E;
	Mon, 20 Apr 2020 14:48:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D6B7F801D9; Mon, 20 Apr 2020 14:48:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E0ACF800C8
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 14:48:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E0ACF800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="X/TnGDTv"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2552A20747;
 Mon, 20 Apr 2020 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587386897;
 bh=RzdHxTJacSWPvJtT5P775eirlREXlwIxyT8TPLJGksI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X/TnGDTvHH0vMuAwsnq/C1ypdllCB8+jrhyr3SYI3AJJcYfe9vQpsHoAiwfIN4cJ7
 1n3tfDUwuqIJRVZ6yW23Cz2PgZ8PYPYKzjdp/dnckdcSFhQax88JlVdYxGMgtQy3JZ
 0Ta1w0Pp+sMvSCy3sRg9EhDNou9w156H/eY1UrgM=
Date: Mon, 20 Apr 2020 13:48:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: Fix "no reply expected" error during
 firmware-boot
Message-ID: <20200420124815.GB10045@sirena.org.uk>
References: <20200402184948.3014-1-hdegoede@redhat.com>
 <1ecf6c31-4eb1-0288-2353-7a7a421fe5e7@linux.intel.com>
 <a0d5d95e-113b-3543-cfc5-43dfa3f9142c@redhat.com>
 <be66d657-f4c5-46d8-d0b5-4879d7aa7463@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <be66d657-f4c5-46d8-d0b5-4879d7aa7463@linux.intel.com>
X-Cookie: Hope is a waking dream.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2020 at 08:17:32AM -0500, Pierre-Louis Bossart wrote:
> On 4/3/20 3:01 AM, Hans de Goede wrote:

> > That commit is not in Torvald's tree yet, but it is in
> > broonie/sound.git, I've cherry picked it into my local tree
> > and reverted my own fix.

> > Unfortunately even with that patch cherry picked the errors my
> > patch silences still happen.

> Ok, we'll look into it. Give us a couple of days on this one, thanks!

It's been more than a few days now...

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dmg4ACgkQJNaLcl1U
h9CGbAf9FIvs13G5sWp3nwMbKELdV9p5d6cU39vJX6B0UV6WZibZTtEIIiGAfC/o
w02c7DK4/Iddmfn3dUTT2miQQ9WgQaYXFJsDxnE8K87YSod2ueFoKqhOsUd5dg/0
3pSxRhObS+IhRPOUQemQs07X8IE9r2hsDEre1HrE4bYDeZreMORbhpmrEw2Z2S9v
VmxvBkwl1qUAxon6xcuE59UuEGfg9RYKBm2dIILVKn8FMvIzDslaen/EdU5USEsA
u/Ej6tqSjFbTLCw2+yrX0acpiJspUkUPU/drzI46JQfh49hqylTWPPV5b00c2tRz
T6xkmKCYxTWCQozLQ2Q4YlSa3xTwoQ==
=W1gx
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
