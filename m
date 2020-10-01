Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC53C4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:26:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C5520872
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FerX9l41";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbtSHDMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C5520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A1218FB;
	Thu,  1 Oct 2020 17:25:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A1218FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601566007;
	bh=pLs0hMhl/WuVcGJqTFR8WN59rKno5gUpavgkjHXmd2Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FerX9l41IPM6B2T3/l9j+UuqrqevhkGzScjmnDeXOW+5N7KkGwZjqBPBbsatw3Cjy
	 QysY70oGgERhdzK9GqwwC1vxLVgLwfUcq4RTgKe1lTx0XtmgMvOCiaR0aadPU6i9bJ
	 xgTjHjrW48aj9AbrqoYcUi/m1w8/fF/eXJJeanWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA7A7F8020C;
	Thu,  1 Oct 2020 17:25:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 602FBF8022B; Thu,  1 Oct 2020 17:25:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCB8F801DB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 17:25:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCB8F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jbtSHDMM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5809D20708;
 Thu,  1 Oct 2020 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601565949;
 bh=pLs0hMhl/WuVcGJqTFR8WN59rKno5gUpavgkjHXmd2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jbtSHDMMtCoOmUubr67+xLsfZ89MffkNG5RbovPl1Q484QdZLmBEp0lfbDVvMN4hI
 DkKSMiBPf9rhBkUD/uklahS/ER8xNamSszncz/7cIVDSFu2Kq0lMkPBAE1uKqhb2gY
 mzJ7rC49q3UcWmmTA0dB2PrpQznwn5TnyHhI0xq4=
Date: Thu, 1 Oct 2020 16:24:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001152450.GK6715@sirena.org.uk>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001125038.GC6715@sirena.org.uk>
 <ddb019b8-4370-eca8-911f-38adf0531076@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
In-Reply-To: <ddb019b8-4370-eca8-911f-38adf0531076@linux.intel.com>
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


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 09:07:19AM -0500, Pierre-Louis Bossart wrote:

> > > are controlled by DT/ACPI. The same argument applies for not using MFD
> > > in this scenario as it relies on individual function devices being
> > > physical devices that are DT enumerated.

> > MFD has no reliance on devices being DT enumerated, it works on systems
> > that don't have DT and in many cases it's not clear that the split you'd

...

> To the best of my knowledge, the part of 'individual function devices being
> physical devices' is correct though. MFDs typically expose different
> functions on a single physical bus, and the functions are separated out by
> register maps. In the case where there's no physical bus/device and no
> register map it's unclear how MFDs would help?

MFD doesn't care.  All MFD is doing is instantiating platform devices
and providing mechanisms to pass resources through from the parent
device to the child devices.  It doesn't really matter to it which if
any combination of resources are being provided to the children or what
the devices represent.

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl919MEACgkQJNaLcl1U
h9Cqjgf/XAeFaN9Q2PEU20wt0+lf8oOEFmxdz3oUY93lINaCpc98Eo9ju5XGcidP
+tOMkft/el3/8SjOC9xUUeLy7Zz+qdcitJEzDkInvFTiB6Zy07dlmAF3cUyhy4hP
tlDq8TTcwoQhk/1crQyGK54m3URNTwMIa0VnWmAwJGHmaaGmWWDsjxYTU+XSD0ED
uUD2GU25PixuXoJUD4p5Nq8ITT9KBUeekzOsC2bAk7LKEteqNKsfEX18/7lZco4G
l6XF31Xwjy4AJ8q6KH3lJYpKXj2BwhKdLPNhB6gJvWtkols65XfZAX8GO1260c5/
ewnA0yJrwBH2MxD1ISMtPq193WbZ3Q==
=5qXn
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
