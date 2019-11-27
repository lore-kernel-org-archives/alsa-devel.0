Return-Path: <SRS0=hmI4=ZT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F8DC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75A02075C
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fySdXx/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75A02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7488170F;
	Wed, 27 Nov 2019 13:33:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7488170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574858056;
	bh=dpJXRN9XpywbKpCfed3JCkc+zFpxzgGJveVzqPhW/iA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fySdXx/bpuNWvqPAvDth8Ue83tB8CM2b7KboCfwpyw5hGhdbTcM6OEau0I/3qlTCc
	 mzXTAMC5XTdCL4ngErBxpX8zZcN3pyAhsStTmXblXoS1JdX4OVV9FUV/ezlLnauBoS
	 36mK8YjIKWPYtvibB/BUZo6NbYka0ttdI/wNVMFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4889DF800CE;
	Wed, 27 Nov 2019 13:33:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A4B3F8014D; Wed, 27 Nov 2019 13:33:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D7D4EF800CE
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 13:33:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7D4EF800CE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B9C30E;
 Wed, 27 Nov 2019 04:33:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70AFC3F6C4;
 Wed, 27 Nov 2019 04:33:19 -0800 (PST)
Date: Wed, 27 Nov 2019 12:33:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Message-ID: <20191127123317.GA4879@sirena.org.uk>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-7-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: In the war of wits, he's unarmed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 Support Opensource <Support.Opensource@diasemi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [alsa-devel] [PATCHv2 6/6] ASoC: da7213: Add default clock
	handling
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
Content-Type: multipart/mixed; boundary="===============5152261682617373311=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5152261682617373311==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 11:32:54AM +0000, Adam Thomson wrote:

> As I said it's a small thing and requires a specific use-case to occur, but
> having the PLL configured twice for the very first stream in that scenario
> seems messy. Regarding the SYSCLK approach you mention, I'm not clear how that
> would work so I'm obviously missing something. If we had some init stage
> indication though that auto PLL was required then we're golden.

There's a bunch of other drivers using the SYSCLK thing, when you call
set_sysclk() they provide a different SYSCLK number if they want to use
manual mode.  If there's a concern about drivers doing stuff on init you
could always ask them to set the PLL during init, even if only briefly.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ebQoACgkQJNaLcl1U
h9BDaQf/ZAlgmS17icedamvRKebKOojZ+VtpiJMgMsOiLs1eMu10rJm/6XiCT5sh
dvPRA9mGno4nal5L/s8UHj3CFPkHSYqPGI/uwY4Gf4Ek2B9cyMHiW3ht1MozjcDH
I2QMxZxMhqHCf1p5a8fh+2jlyFfwC8lpluRg57rLT5PTdb27MBbrshYHlPuuxKtk
p7U1irpsbnO6iW3CAp9N8kIc996SItJ7230JQCHXdLJ0X773ekOLQTSb5Ypn0Y/f
kD+NRNoggRWJ70XZqm3DwMQRdGIW33IWR/nS+W0ncP93hfneMjYpp4byZ+BGWOwy
CozlfXK15fWw/kq+9Gw1LGWv9CKSxw==
=thrJ
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============5152261682617373311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5152261682617373311==--
