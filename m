Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725C3C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:57:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC4F207DA
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SEmSd0+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJLsMQ2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC4F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D2081678;
	Fri, 21 Aug 2020 23:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D2081678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598047047;
	bh=omGYKu4UKaBy5l/8iUmdyJvFxlVfjWz4GLF05Wo2kJ8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEmSd0+z1o1xF78Bp0BDvbIDzpFt2eV6+AeBx4xR08ifGpZHGCPq8OzZT9+3IltNm
	 lQQC2yNj7PRTRT+xqjetFcGp5wF8z6hIfDeQsb/Z4Varo2LR6nGRh7G0wnAGBy6tK0
	 v6yvab01O1RrkArWjFyDjDnjKqYRHiWjGFznEeic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3FA1F80216;
	Fri, 21 Aug 2020 23:56:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02957F80218; Fri, 21 Aug 2020 23:56:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E42BDF800C0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 23:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42BDF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SJLsMQ2o"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7660207CD;
 Fri, 21 Aug 2020 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598046984;
 bh=omGYKu4UKaBy5l/8iUmdyJvFxlVfjWz4GLF05Wo2kJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SJLsMQ2oGuzSHfUbYmoNFlIbifymxPe6CaC6uh6rh5j4BfAY7VkT/bYe7fXUfm12v
 DQNLozLdt4plBt6fxGbQcSX4PH7EQTB1uG6pvScUWvx4nDNXyz8FfU2ctS8y1Va3yS
 n00gsLSs+Y4+15XCeGy2FEWJe3L77XhthcB/hWjc=
Date: Fri, 21 Aug 2020 22:55:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 06/14] ASoC: Intel: tgl_max98373: fix a runtime pm issue
 in multi-thread case
Message-ID: <20200821215550.GK4870@sirena.org.uk>
References: <20200821195603.215535-1-pierre-louis.bossart@linux.intel.com>
 <20200821195603.215535-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <20200821195603.215535-7-pierre-louis.bossart@linux.intel.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, vinod.koul@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 02:55:53PM -0500, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@intel.com>
>=20
> When the playback & capture streams are stopped simultaneously, the
> SOF PCI device will remain pm_runtime active. The root-cause is a race
> condition with two threads reaching the trigger function at the same
> time. They see another stream is active so the dapm pin is not
> disabled, so the codec remains active as well as the parent PCI
> device.
>=20
> For max98373, the capture stream provides feedback when playback is
> working and it is unused when playback is stopped. So the dapm pin
> should be set only when playback is active.

Should this be sent as a fix?

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9AQuYACgkQJNaLcl1U
h9A9swf/UufkcYfWi1pRxGTH1GbKmnWZa3hcITaHZdC786VMkj7weu7pZ3VIPjrB
RypxnA+Mn5Os/edf/lGaUKbxXwFRmi5GnXiouiSKiXQ4yPWk5x4LvwiFWpAtvdT/
dkG4yLg+4+WNHeY/pO/mpz0/oedQM/7RETO94yP1P+R6Urkv3NTWIWvZkD5q2Yzp
S04d1PVYCRNnl19O5z/0fzIVQ9PcOebjrtvxEZhj01X7lJ5ikIEijMH8wI/DJfFb
+RRQ6QjVkdMe3Eyjto9F69t/pHrsVxTABhf9MlcWMWVjnu/927clZbeks9x5KCKI
jJvSIhLdNrRT8Mk7NxOaRtK41QNtPg==
=YAIy
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
