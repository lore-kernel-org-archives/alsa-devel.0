Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E234B2467A
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u8ZC6u36";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D53JJ89F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E234B2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B6FE839;
	Tue, 17 Nov 2020 18:19:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B6FE839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605633601;
	bh=eR7SydTr/893wsEjK68DTHvGkl0x2Hy3c7YY0aSWAcU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u8ZC6u36o5125PhSNYCI3vNRlLmRq+erK0TrJe3VJvpFz2dyWDErb5CsNX9gkHE1b
	 GntH+tg4OwAYrFm4/ayfqt1a/BpSel0uHeZ6rwB8zw+JMBFKfnd94yXLXiBj14NJfm
	 vqbFtis1P7s5hrvOLKJaMzp5DhbBSb8Yvi7+fUes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05FB4F801ED;
	Tue, 17 Nov 2020 18:19:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCABCF801F5; Tue, 17 Nov 2020 18:19:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43814F800FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 18:19:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43814F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D53JJ89F"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A556B238E6;
 Tue, 17 Nov 2020 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605633542;
 bh=eR7SydTr/893wsEjK68DTHvGkl0x2Hy3c7YY0aSWAcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D53JJ89Fovxkz+KTB7kg2wHB6BfzUyD5kSGFLy4RL7pr+RQCEMQdA1qPa6ggZZALh
 5/wVQ2gN17a+V6BB6pspIGSoqf/D+G7qxP5xFVe21gZSWo9IHVMilGrAMdkAejKJIl
 2nOQBpcOadEfDZ+2LtDLGhgzBIgYEYokdWy4AcPQ=
Date: Tue, 17 Nov 2020 17:18:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 06/14] ASoC: Intel: byt/cht: set pm ops dynamically
Message-ID: <20201117171842.GF5142@sirena.org.uk>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <20201112223825.39765-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <20201112223825.39765-7-pierre-louis.bossart@linux.intel.com>
X-Cookie: Pause for storage relocation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Rander Wang <rander.wang@linux.intel.com>
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


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2020 at 04:38:17PM -0600, Pierre-Louis Bossart wrote:

> +	/* set pm ops */
> +	if (sof_parent)
> +		pdev->dev.driver->pm = &snd_soc_pm_ops;

This might need revisiting in future since we should be able to have the
driver PM ops be static const and hence unwritable but that's more of a
robustness thing for the time being given that only a limited set of
systems have this hardware and we know that there can't be multiple
devices.

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+0BfEACgkQJNaLcl1U
h9CrWwf/QkamX1Ht3Av0fuyl+N9t6ZmyS0Yz/iXQJDTnR9sTSzDEPuYXUZEGxml/
movQRwJeD3CvZ1k7wU4k3J3+RsWv1XVdgAy+APY07aTfe7UnF+Bg49NyEhOaG1OC
BBRPgDtuXyGK/3hnKqdysd/rBhbBKE0IU5+bxtNBaVXH6aNe6/u4B6iEAJUCwrHS
iWbRPS8atYjBdM0J9ex+qZTU2UET0IDsfCbbfr1Y11HauLqKPMsIBnyLmR2j6NpC
RaQv9Pp38WrjKXEFUSOWuuCHBDgtP0IRkaunVP+yejt1sERDb+cJOQN8/SRR2wJ5
sApHh3Eu/Qz2dWOV0M6ngDqX6Yr0UA==
=aySr
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
