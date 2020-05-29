Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D91DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 23:03:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61CD208B8
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 23:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kp1X57pe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1BS4OVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61CD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2940A1762;
	Sat, 30 May 2020 01:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2940A1762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590793417;
	bh=n6ke17m7zdty2XbznaUf/ImP7/BQ3BkiDpHS+eIcMCI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kp1X57peL+KRqWiH48GHwqU83pAV4tbXBV5qS6YL1zXfZnS+j69nnl8KPay3ceroO
	 Uanfvg7KConYBxYqZywOIa0A14aB7W3Am//yEsJFA/tkv2kLaz130gMv9fAfvQy8K4
	 ylxd+TyH2HFyvh1FFEePJAUZxn7FZerD1U4R1WpM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D7A9F80149;
	Sat, 30 May 2020 01:02:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C8A2F8014E; Sat, 30 May 2020 01:02:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33914F80125;
 Sat, 30 May 2020 01:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33914F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="m1BS4OVe"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C987820897;
 Fri, 29 May 2020 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590793358;
 bh=n6ke17m7zdty2XbznaUf/ImP7/BQ3BkiDpHS+eIcMCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m1BS4OVeiGDlr/H54DvJ7vBi6oNU5RfNNAOxReGvn0xII0B8BNWF35D+LZ80Ov9ah
 HUamGoO9AKV20Z5Vb/D7CFZYdSG0we65B7EAyvlmPPydqCRHIHy5WhmRriFExGGiLM
 VmpmUU8UjQ6xcls3wIVKYxZ1jjBoVWVtBfD5ljzs=
Date: Sat, 30 May 2020 00:02:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: SOF: Intel: byt: fix unused-function warnings
Message-ID: <20200529230234.GZ4610@sirena.org.uk>
References: <20200529200433.19068-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NJ3GtppTlf/130kA"
Content-Disposition: inline
In-Reply-To: <20200529200433.19068-1-arnd@arndb.de>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Keyon Jie <yang.jie@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
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


--NJ3GtppTlf/130kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 10:04:17PM +0200, Arnd Bergmann wrote:

> Several functions in this driver are only referenced for baytrail-class
> configurations and building configurations with only merrifield enabled
> causes a warning:

Pierre fixed this earlier today.

--NJ3GtppTlf/130kA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RlIoACgkQJNaLcl1U
h9C0egf/S/FcGFYqxnk1QAy8ZfP+uCdN65yW0o7yJJ92rF4YUb7W8lUJvhS+8IHr
Kwjwa8+hIOUAUGSOol/q3HsK6rG7NtKXwa//CnX9oXdHAz0hwXEMwx+eVFBSb322
Nt2T3F6786OaYc10Yd30HrNzJHlOk7hJxJ5APKFrjvjX/21sgbt1f6aAEY2FEo9h
ngZcmmzAANLl6rhMkrgLax97gckP84jE1hr4Y4iKJTSa7mUQ+jDk3znz12IOu/Rr
6PTjhlapK/GjaODdubROW6i4QCxK3z2S/yaVP34NM/r8aZW+BZ5/NEfdviO/5NsI
ewCdBudt31j34yevaZDZNVWLZy2P2Q==
=dPCM
-----END PGP SIGNATURE-----

--NJ3GtppTlf/130kA--
