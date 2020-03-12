Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D975C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:47:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29468206B1
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pkIlftWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29468206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D579172C;
	Thu, 12 Mar 2020 18:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D579172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584035248;
	bh=0xugY3eBjcWN0mHlOPkR37sG1nv9DlkZJ2yQg22bCZ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkIlftWbBmrSTYZo3jeHK9L4WB/qIstC5itKvsdqcXwcE8Tqx2s2d5yPuweZTxQn6
	 juH4E1pyf5hFs1xEt+NiutjghOeva0qLmdiXEvkuaETYMAXcTZZtREPE9NJQzuDpNG
	 Vq8fCl3J4F2K7NY+YDTbiBNgkoBEdwfP+pvYzyWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C818F801D9;
	Thu, 12 Mar 2020 18:46:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A23DCF8020C; Thu, 12 Mar 2020 18:46:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C9C77F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 18:46:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9C77F800BE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C597930E;
 Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4565A3F67D;
 Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Date: Thu, 12 Mar 2020 17:46:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5 4/7] ASoC: fsl_asrc: rename asrc_priv to asrc
Message-ID: <20200312174629.GI4038@sirena.org.uk>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <8282b290d39dd8dae5da02f5cbb3f647fa778aa0.1583725533.git.shengjiu.wang@nxp.com>
 <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
X-Cookie: Security check: INTRUDER ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
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


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 02:30:17PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2020 at 11:58:31AM +0800, Shengjiu Wang wrote:
> > In order to move common structure to fsl_asrc_common.h
> > we change the name of asrc_priv to asrc, the asrc_priv
> > will be used by new struct fsl_asrc_priv.

> This actually could be a cleanup patch which comes as the
> first one in this series, so that we could ack it and get
> merged without depending on others. Maybe next version?

Yes, please.  Or even just send it separately.

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qdXQACgkQJNaLcl1U
h9BEJgf+LDZKX86NoQW0sAyHfoI5bU8JDqMp0vov4A8JY6xc4HBhugGfdjg8WRoa
CaqNzRLw0m6VFU+a/AxSv5OADsO1vkjA08+yXeuWr7wKxasqSAmBwq7tjsa9Cu7S
QB0UowCO1N3Zn7zeWYFoJxiJ1iPlz9rUTDLw6U50yckkct9JlCnTKLmPpO7q5SRN
DSqUC5+8Hc/SZGOSKLoYc1SFqFaNLUxuF7O2harTjFRbWeuEaptWcgmf2CeXgtI0
pFBfaexsGndY8dFMvwkNeD74Yctt4xnefQRXwbMsbfhDpJFdruxSXYNkBHYMsIUk
YzSFifSaFrNhKESXNDY0arVypHltMg==
=rfH4
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
