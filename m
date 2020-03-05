Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA35C3F2CD
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6F42146E
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CUdczbqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6F42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 388C0836;
	Thu,  5 Mar 2020 14:36:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 388C0836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583415457;
	bh=sYZROB2lcYB6D8j4HepYDLXJp9KfK4Os5h8JyufHQzE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CUdczbqzRmWJH+cn6DmFMw7I6lN7OLCEnXwrsaAooFE6XTQwYQKDoZy1AZYmcLVYX
	 Ulsz4Dbvu8c9NXp3jtYHyaWcbVTlA4C0c0GJ4i3D58hGIyPNN7dpDrfe7NtI1N30Uy
	 gGscR9jWywnF1otro8nuYRLl89TMAUhnZh0p7V1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C72CAF80245;
	Thu,  5 Mar 2020 14:36:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A594F8025F; Thu,  5 Mar 2020 14:36:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D7E88F80126
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 14:36:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7E88F80126
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2AA81FB;
 Thu,  5 Mar 2020 05:36:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 357383F6CF;
 Thu,  5 Mar 2020 05:36:40 -0800 (PST)
Date: Thu, 5 Mar 2020 13:36:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] ASoC: Intel: bdw-rt5677: fix module load/unload
 issues
Message-ID: <20200305133638.GE4046@sirena.org.uk>
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <20200305130616.28658-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 07:06:15AM -0600, Pierre-Louis Bossart wrote:
> The use of devm_gpiod_get() in a dailink .init() callback generates issues
> when unloading modules. The dependencies between modules are not well
> handled and the snd_soc_rt5677 module cannot be removed:

In what way are the dependencies not well managed and why aren't we
requesting the GPIO on device model probe anyway?

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5hAGUACgkQJNaLcl1U
h9CsFgf/aQBj/iGDxFHULYVCoRhoPeb+ddNP2SnJ/J4ZCdj2O7BryH/+qRPlkfLL
hX7peu68F2EhsZsxF1+vEfsW1KgI5Ehtsx4RH38grh72RhTZG95Z8VmoehhwR1iq
peBmEiwozr669CswN25KwSuGULDgvxvzNYJNk9Jd3wsRwED5zvx9oSunKnylDoYx
EkV+nVF7iITP1OHPKI7A3hSorvvBrZPhHq9Vfs/KpEJiWnqnChImfNoda8fg7B3X
f+g2ijmrAqu2dipfX2xcPFLzobvr4nTdOv1YQlVK3VYgJsFnKwtdL74V0EhIDz00
MaQv2H0pOUa1++/NB0t3qTgCCO5XNw==
=dtB4
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
