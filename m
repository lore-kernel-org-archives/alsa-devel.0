Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB9C88CB2
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:29:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C7A3852;
	Fri, 25 Aug 2023 00:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C7A3852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692916156;
	bh=bboWKN033MTanIppETH33HD3v1eMmP6kIFkTyVigog4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Pf8hEcR4YvWxIr/CSntvuK4McLsWBaozBoMBSkWe2MttqSpxcUeYs9Ba3zT3ncIkS
	 hLA7b/du9CdpDwMqgFjzFZq5/GV+ZVQcM7tH0HGMvYd6A85509RI8vUUFQ0fM780zi
	 nLgKixcfU8vdturIa8xpp8JeGqpl5JtPbhbN5ZYY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24E79F8055C; Fri, 25 Aug 2023 00:28:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C3CCF80551;
	Fri, 25 Aug 2023 00:28:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5095CF8055B; Fri, 25 Aug 2023 00:28:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EAA3FF80551
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 00:28:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAA3FF80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bmYXCtgl
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C6A12637B1;
	Thu, 24 Aug 2023 22:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D73C433C7;
	Thu, 24 Aug 2023 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692916094;
	bh=bboWKN033MTanIppETH33HD3v1eMmP6kIFkTyVigog4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmYXCtglOyIfCtPEWd0J8Hv7jRsm+blsf7Bhe57JFtJc04yQcUlXVs3RKkX+r/7kL
	 9vmOfwn68ZVnW49lpwHPafKNdLZxC3hlSMRS9jq2H9u0qubj+9YxuISIzTpa9P8czB
	 0bELQvBtrEPJFvEUsGvbbIyu1kstj/lYWaPjq8doI3qbD3UGldnboO5fw1xfO7u257
	 uE9yDII7tYJXBUbr6OYqRoRYLKZUEVScP+9fsartcCQnsXPO7Y7bJMlzZd/RWfvb8t
	 dvzvfV41AEyhQtoeHYVXENB47LR2g207z5HSBBt7oWJLNYG+02+iRI5RUlLaQlwoZo
	 vZ4RRSZTDsVXg==
Date: Thu, 24 Aug 2023 23:28:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com
Subject: Re: [PATCH 09/17] ASoC: codecs: hda: Switch to new stream-format
 interface
Message-ID: <ZOfZcsu13P8OHenp@finisterre.sirena.org.uk>
References: <20230823080546.2224713-1-cezary.rojewski@intel.com>
 <20230823080546.2224713-10-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHwJvQ8paUI0A1Ni"
Content-Disposition: inline
In-Reply-To: <20230823080546.2224713-10-cezary.rojewski@intel.com>
X-Cookie: Give him an evasive answer.
Message-ID-Hash: XFJNQZEAXTTQGAV4IXBPIW6SMT4WVJ57
X-Message-ID-Hash: XFJNQZEAXTTQGAV4IXBPIW6SMT4WVJ57
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XFJNQZEAXTTQGAV4IXBPIW6SMT4WVJ57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ZHwJvQ8paUI0A1Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 10:05:38AM +0200, Cezary Rojewski wrote:
> To provide option for selecting different bit-per-sample than just the
> maximum one, use the new format calculation mechanism.

Acked-by: Mark Brown <broonie@kernel.org>

--ZHwJvQ8paUI0A1Ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn2XEACgkQJNaLcl1U
h9DUzgf/ec3elJw2C8OeUCTeVKDvgz/xuOhTU6+vohxKSbQW9MlG0LAzhW0eGHI5
aQVl8Nj0i6TKBznOj3gDC3RWBrldgv15XhaYNPUCAiNZOz2qhXMhABZEO5viNj0D
/Nq8dpkg1LxbCDsXSHcma8yYQPpHdipAAuDJ3Lu0tjkf4GqXPx2SHTtv07RA08KN
swpuD9F8lNDEZiYbObk7ulJRMCFQM6v7+Le6ah4vqRR8AP/3ZkKPGC7ubGUsLo+O
r4P83FJGC2WTDvbkdw1xybh1Jp6lwa8Dq9eiDFyPYJ/3kg9eMQU4KodRS0URXkGP
6DGnHD/doZWNkK8s7pnM0++PMguSNw==
=772D
-----END PGP SIGNATURE-----

--ZHwJvQ8paUI0A1Ni--
