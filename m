Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789CBC10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:37:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F4C206B1
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KuD07fV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4C206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 586F416D7;
	Thu, 12 Mar 2020 13:36:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 586F416D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584016629;
	bh=FWHSTVwu+AWqzlT+tHcV/JGwu53sI53RTO4hF89umWI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KuD07fV2BAJClvI0BbXRv/GaQEhO+0l+N3faIWszlKQd/3xAAk/Pm1WpwQ/fsCJSF
	 xK0hbMbGqRewbHRuZaLhYcnnbXnoweC9AJ9WQGirNmJLzWHxal2CWDtRXOZp9KTt8i
	 ycdAJkC3MBESmd8pwFBynFIDTZ1dh+t7NeuVcqyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DABB7F801D9;
	Thu, 12 Mar 2020 13:36:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39E52F8020C; Thu, 12 Mar 2020 13:36:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D5A26F80086
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 13:36:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5A26F80086
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 641B231B;
 Thu, 12 Mar 2020 05:36:11 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC6823F67D;
 Thu, 12 Mar 2020 05:36:10 -0700 (PDT)
Date: Thu, 12 Mar 2020 12:36:09 +0000
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>
Subject: Re: [PATCH] MAINTAINERS: Update Cirrus Logic codec driver maintainers
Message-ID: <20200312123609.GD4038@sirena.org.uk>
References: <20200310192751.24487-1-james.schulman@cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20200310192751.24487-1-james.schulman@cirrus.com>
X-Cookie: Security check: INTRUDER ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 brian.austin@cirrus.com, paul.handrigan@cirrus.com, david.rhodes@cirrus.com
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


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2020 at 02:27:51PM -0500, James Schulman wrote:
> Brian & Paul are no longer active audio codec driver
> maintainers. Update list to reflect myself and David
> Rhodes as the active maintainers.

When someone else sends a tag like an ack or a reviewed-by and you've
not made any changes to the patch the normal practice is to carry that
forwards so the work of reviwers and testers doesn't get lost.

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qLLgACgkQJNaLcl1U
h9DrcAf/dgzHnLpULdlpiGHZ0V6zSZz3bWzlX+1Hl7bOBhWB9cTXr1Cbmi2x1ca5
RKRE8MR/UNdoa9eZHI2LaL7hk1mcPo7GQy2I96kxJLtLaN4lMYdsvN+E16ZlEDxj
e/UXiWuytFvHyUfXdWgntsv2/eFpN4LAhQueYUVtVbZU3dgJSguN86xVL9kf+D99
Cu7lcJMLdOtng3kmUzC06tJP8Pnqn/esdyro14j6FkqgxXW5pHn6axF0WiEmQrRF
tvrxGyeVjnI1ppt9c7RWaha+AQYSkfcMaYFBVXwKe/E6WdWg6W62RnSmSzE45zPD
Tm2wtElAFUzoLkEp/cVCS+TjwpcpwQ==
=XWo0
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
