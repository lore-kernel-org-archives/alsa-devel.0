Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81465C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 10:29:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF66360F42
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 10:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF66360F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 878A317E0;
	Fri,  3 Sep 2021 12:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 878A317E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630664966;
	bh=ALG3HBZ9tMQQ6qp3LSaDocNel4wVrD8EJq5572zXA88=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SnaJjLsD1MBWNV4McUGL4mGFs0RtaQ2KyudBSXhRarYyIEhQuuONZRyEjqLbimZxc
	 ZI3IR0TTRYaQLFQoXnkIv6nhqFQGvoty9p82YOtiOpW/8Buxl9prwnHXRJhkeqt/AF
	 MnVtqIVQTa3YmWUP4Q+P4WoSWIV5rVeelsw4ANXM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3212F80227;
	Fri,  3 Sep 2021 12:28:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25B94F80254; Fri,  3 Sep 2021 12:28:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04926F80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 12:28:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04926F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U5uCWSMT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A9F60F42;
 Fri,  3 Sep 2021 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630664891;
 bh=ALG3HBZ9tMQQ6qp3LSaDocNel4wVrD8EJq5572zXA88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U5uCWSMTuLZKnKr3JueXqz5npeRN/+ZOf3V533ybH4gOlXF1Y0jVY8wwL//GJ8PGZ
 ngu5lPk7yfnl7JPeIji789+vVpbLNweKtHrzJdvHpe5aFdxgwVy9Z392lUjiN3JTY+
 /zE8YTn08AkW0YgKvPHeCI5igSRlsoxv7Padu+5pTdQRdzaJ7+f3ZK8PFfNpla43TQ
 3K6yO3zPfxX8fNQ186yYGmBvFsW1YwlmfPurwH3hsp9KyjR8GMtp7DLAaT/aq7XrBK
 jVc+PL4ehUksCkuhNrI3icy0TGfATyMXcmGz62ZCtqnjM9NgBfajjWk0sdY3wPjli5
 Hy6zeHzLFWgeQ==
Date: Fri, 3 Sep 2021 11:27:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix
 CONFIG_SND_SOC_SDW_MOCKUP select
Message-ID: <20210903102738.GB4932@sirena.org.uk>
References: <20210802212409.3207648-1-nathan@kernel.org>
 <20210902181217.2958966-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20210902181217.2958966-1-nathan@kernel.org>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 11:12:18AM -0700, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:

To repeat what I already said in this thread: the reason this will have
got buried last time is that you sent the prior version in reply to an
old thread.  This new version has also been sent in reply to an old
thread which almost had the same effect.  Please stop doing that, and
also please pay attention to feedback.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEx+JkACgkQJNaLcl1U
h9Darwf/dMsP3sJkQI3zmuNnqYAH3Su2md52c3Q8zXiu6wWBT0JpJknJxExFVYFU
mpeCrDO3SsDPVkp+96ou9pIsEEtFY+cFb3bjI/jw3OLfM58bhuJHa9RmK6ysgGDy
3MM5VbZ0qKNMVEHJxSZvvPTFIWTg8ka07H77y7wzhAmByKEnRxMcRHoz/rGkp9dA
3Bv2o9gXcNTeIV+pi/f7rPvqPOhFmcgEtDfwVfG+xroYbVA6Qc9kmuOiq0tOgr1q
2a0g4/zmlo+iGdA/O0+vXZpvH3a+pPKBW34td9d/J5BDZjn7SFevEcJiDGfinlOb
4KJpG9My+1VJxwp/YXclvV8JER8sAQ==
=KVUM
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
