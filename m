Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71732C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:53:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DC720872
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TPWW5WTe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1KmY9ZEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DC720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9877B191F;
	Thu,  1 Oct 2020 18:52:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9877B191F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601571220;
	bh=kttJBOY2LteylDygQbQe7NZmzrWDZM1KZAFIr+MVDdA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TPWW5WTexUmdSvD9XoVH86DD3LAZ7ayJ0XgXZC8ZnkVSvUxrmSB64GuraFoAiv6Gb
	 RgSwJBmxXLcoiioVnaUTI7zGxuy1j7o7LRVeSRMMa0vIUvSpdgjxnRQzuMI797OYt2
	 9Y4lu6qOcuaO2MURzSb6jxcPOm7ig915rDYF5OD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3008BF801DB;
	Thu,  1 Oct 2020 18:52:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A901EF801DB; Thu,  1 Oct 2020 18:52:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CE05F801DB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 18:52:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CE05F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1KmY9ZEV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 204C92075F;
 Thu,  1 Oct 2020 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601571156;
 bh=kttJBOY2LteylDygQbQe7NZmzrWDZM1KZAFIr+MVDdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1KmY9ZEVfSnCvuASsN3GXwoWJ0nJlLzP2oWOSC3KUDFr0PVKA0m+SEJYsFKpZT/JL
 lSvdO94BsFFaYptH59RgJAvo8G7Va2ctt2QkVttbWHOyV/9TNFzy0tuZNyLb4Ln4sf
 ToYpOA+jJixy9wGyDMr+R+37lVBmBqHBS9uWlegk=
Date: Thu, 1 Oct 2020 17:51:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001165137.GQ6715@sirena.org.uk>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001125038.GC6715@sirena.org.uk>
 <ddb019b8-4370-eca8-911f-38adf0531076@linux.intel.com>
 <20201001152450.GK6715@sirena.org.uk>
 <2ba29c19-205b-6d0a-3a28-f9d5cc32adfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline
In-Reply-To: <2ba29c19-205b-6d0a-3a28-f9d5cc32adfe@linux.intel.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@intel.com, parav@nvidia.com, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>
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


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 11:20:39AM -0500, Pierre-Louis Bossart wrote:

> I have nothing against MFD, but if this boils down to platform devices we
> are back to the initial open "are platform devices suitable as children of
> PCI devices"? I've heard Greg say no for the last year and a half - and he
> just re-stated this earlier in this thread.

As you'll have seen from this thread and the prior version (which was
the first time I became aware of this stuff) I'm not clear how that
desire maps on to hardware, as soon as subdevices start needing to get
regions and interrupts mapped then we're going to end up reinventing
resources and regmaps AFAICT.

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92CRgACgkQJNaLcl1U
h9C57wf9HGnvJIDIcpu3TiztvrPLnNTkESx92U3wl4H23Q+d4y0xNU3n0QLRdPNC
Y+Cg1rTQnZwdCl68UhOz8xTHmPoEIF+6SzJ7xugtKcOfQTVze3mxr1xphtr5YKDL
CdG0Zm/HXHUkbH4MSv+2yqGZBK5q7Okrhpcp0FqbTBiuBXk6xZibydxLdreFwzr+
riSLuzKdNRjFcandg2cru5zsFcvDRB52P3YJVCfNoQ0F1oHf+lcMPuCOwEA05PJf
UShLKcvER6jJ667HM8szGjvpwfWyImKzXPTtUdL68q/u+4tG9wReizYJEjKZXO8o
EPqLg7HLYsJI2WQeROCLidCE4I471g==
=OUd+
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--
