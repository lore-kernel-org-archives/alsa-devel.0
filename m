Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0404C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:06:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1D92068F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NmBcxbxy";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCqEjgTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1D92068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7DA916CE;
	Thu,  2 Jul 2020 18:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7DA916CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593705994;
	bh=+ViH9gg1N4vHnbvW09Osmv3jgSWPSKTM98itdeGHjxc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NmBcxbxyfoLlaz0X2z3uo75F9JX22IpBBV2ixsNzysJmr3c9goeDZgiGaSenE9CTe
	 EW7C8i5xSS+l9PCw/+wnpo0wqG4C8JIN2Wp0JIE6qjElUZSOdGyaFTNzzjRfprJMGA
	 CJ99+0JwoPnTn3I2LzBRP8QEDD3EQA/K5+l3GzBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E822F8022B;
	Thu,  2 Jul 2020 18:05:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFA16F800C1; Thu,  2 Jul 2020 18:05:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92E4AF800C1;
 Thu,  2 Jul 2020 18:05:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92E4AF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lCqEjgTo"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C36520720;
 Thu,  2 Jul 2020 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593705931;
 bh=+ViH9gg1N4vHnbvW09Osmv3jgSWPSKTM98itdeGHjxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lCqEjgToa9YAhlJo1P8SbSYSZUeSeu/pHkTTDYA3v5owSvPxgpYFbtqNG5GGDIXC3
 dsm6bXEs1n031wwtKAjWbzf1IL2MTt1e3w9Hapd1UpsRoSYJV1JwbmdHFJ2SR4sHdP
 LF5TlWhXdyM5G8azXBd4kwt9NPAhYivwFXJZIxo0=
Date: Thu, 2 Jul 2020 17:05:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 5.7 15/53] ASoC: SOF: Intel: add PCI IDs for
 ICL-H and TGL-H
Message-ID: <20200702160528.GL4483@sirena.org.uk>
References: <20200702012202.2700645-1-sashal@kernel.org>
 <20200702012202.2700645-15-sashal@kernel.org>
 <20200702111835.GB4483@sirena.org.uk>
 <0baf17f3-1af8-a4a1-644c-ab27490f9b44@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
In-Reply-To: <0baf17f3-1af8-a4a1-644c-ab27490f9b44@linux.intel.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sound-open-firmware@alsa-project.org
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


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 10:42:21AM -0500, Pierre-Louis Bossart wrote:
> On 7/2/20 6:18 AM, Mark Brown wrote:
> > On Wed, Jul 01, 2020 at 09:21:24PM -0400, Sasha Levin wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> > > [ Upstream commit c8d2e2bfaeffa0f914330e8b4e45b986c8d30b58 ]

> > > Usually the DSP is not traditionally enabled on H skews but this might
> > > be used moving forward.

> > "This might be used moving forward"?

> There are two conditions for the SOF driver to be used in a distro:
> a) the DSP needs to be enabled (as reported by the pci class info)
> b) sound/hda/intel-dsp-config.c needs to contain a quirk to select SOF over
> the legacy HDaudio, such as presence of DMIC/SoundWire or a known vendor
> DMI.

> Traditionally for desktops neither a) nor b) are true, but this is changing:
> we will start adding quirks for specific product lines as requested by OEMs.

> Does this answer to your question?

The question was more of a why is this being backported one - without
those extra quirks this does nothing, and frankly with them it seems
like a *major* change someone might see in stable if they update their
kernel and it suddenly switches to an entirely different DSP software
stack.

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7+BcgACgkQJNaLcl1U
h9D9WQf/eYD0E9xMzfnYMjmvItrYNt7IX6kw7q7O/der/0OiCiMdvfKFLFr6bPBF
61VoeZFlJkpui/EcoPgTsf5qlJLPMoCy1Ht7i/TacZppBWp2I07uEw+rtioDkDRe
SAy+8LDiHk+Z6JQAXTXUmvdeUcI+tq9dfvQG8KY1wvAlh0+6dyLu4NOnlsTJHgFN
xYM6xR1n/y33C8oU7AnQNMZEN1U1O7QH78iHqUmktoWM/71PbE/e+54ZjshjXteV
nniGaCewi0NFozRzQaLS6e4SdPssH3Rh3npqa+cQOkLtTn+2U4zt1/mu9VGqmmLp
ojykL5QiFLb6CxUSm33uvn2zV8V6gw==
=iB43
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
