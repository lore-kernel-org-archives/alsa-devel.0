Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6FC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:40:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5DA207F7
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fWmuRg6d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fax/Zbfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5DA207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEE481873;
	Thu,  1 Oct 2020 15:39:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEE481873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601559628;
	bh=c57DO2nasR8VEaegnNiprVRn0qXj6+EkwwBxu5gE+7o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWmuRg6dUOJMQwtyxMnukpYl8/Epi/R5lJhaAkTUG50U7aNt9AcAo1WOQTmJ/Vukf
	 reUtBHG2rkmIdojkRq6jqTpPo8fJNEMBKaCmaJlJEB9sRoddiVM8v510B8yiOm8Foj
	 g9p+kXqhjGJqRgaDtxV06dBvyNk3CuTgohSIhCGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E6D6F801DB;
	Thu,  1 Oct 2020 15:39:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59450F801F5; Thu,  1 Oct 2020 15:39:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BF4CF800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 15:39:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BF4CF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Fax/Zbfn"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 506B1207F7;
 Thu,  1 Oct 2020 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601559567;
 bh=c57DO2nasR8VEaegnNiprVRn0qXj6+EkwwBxu5gE+7o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fax/ZbfnNCPOBo4Fo/2+M+OB06oay7+vnBdXT55tSdonUPyZZTjT7fNjwG6QdPvHf
 KHItJN8MKsIKFVgYkaXFz3Fw9cBCs7y05p9lcTbzDmEAJFilTlLRVBaxQYX8+fc13d
 mKIxGp6fo06YUtGhhWHY6bYh0wH63wJgCojMZUVA=
Date: Thu, 1 Oct 2020 14:38:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH 2/6] ASoC: SOF: Introduce descriptors for SOF client
Message-ID: <20201001133828.GH6715@sirena.org.uk>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20200930225051.889607-3-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20200930225051.889607-3-david.m.ertman@intel.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@intel.com, pierre-louis.bossart@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, parav@nvidia.com, jgg@nvidia.com
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


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 03:50:47PM -0700, Dave Ertman wrote:

> +	ret = ancillary_device_initialize(ancildev);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "error: failed to initialize client dev %s\n", name);
> +		ida_simple_remove(client_ida, ancildev->id);
> +		goto err_free;
> +	}
> +
> +	return cdev;
> +
> +err_free:
> +	kfree(cdev);

It would be nice to have the ida_simple_remove() done in this unwind
section here too for consistency.

> +int sof_client_dev_register(struct snd_sof_dev *sdev, const char *name, struct ida *client_ida)
> +{

I know the hard limit on line length got raised but can we wrap this
please?

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9129MACgkQJNaLcl1U
h9BgCwf/TnlTqeqQLpBsKun+Y9adwWfxEAt+JQ+uRkByAucjyLvF4Z+z5befNRU4
PcbOqq9fXQDnetMVXli6qagzDbFuqEv2U+izZT5SOycU5s/SiW57Or+S88pm49zo
j2udkxT+y/1KGX2E8kwcZdpJDM047qHArdCPWQGmYDVDKNnlYUczWGPnG0Z4+hat
PtF8HpyBGaQV0QptGfUOWdNdoAqdMttBkOpMvVdqbsYZJi8IZIn7aM2PJjycc9dJ
HrneQKpTLD5PMS7DmJtT0DX47rRVSbjmZHf6xHhzI7K4gkrYEGV88UOBpkPXdlQY
yY5yguxR6f1AsP00FiropoQTTz801A==
=F2a3
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
