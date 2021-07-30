Return-Path: <SRS0=QuHl=MW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13004C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 16:21:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FC660F4A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 16:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7FC660F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1D50206B;
	Fri, 30 Jul 2021 18:20:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1D50206B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627662100;
	bh=VGa6prA1nzRPbhwNcJKeBBIqmDX/7MYK01Bhpb3t+70=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uzb8Fq8GlWCcvCp0snkj+t1PmFM2bBPgk0DKm6lMh/NM0f4RNeZTGlPBSKCZgY/hn
	 ITOWRNvvXb2T9DLctoUi77DrYlbK/yZ8Vx4gH4d+woAJwpGVOTON7xYeR/fEFhFdEH
	 hI40MQDj+7LOydAeQZkrCgxhZIxep/p+1mtLILFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C4E7F80212;
	Fri, 30 Jul 2021 18:20:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3803FF80253; Fri, 30 Jul 2021 18:20:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 734BCF8019B
 for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2021 18:20:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 734BCF8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="H7oBXUB/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DE5560F3A;
 Fri, 30 Jul 2021 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627662036;
 bh=VGa6prA1nzRPbhwNcJKeBBIqmDX/7MYK01Bhpb3t+70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H7oBXUB/+TuEyOeWERLFTiUFVCvas9noVX7Fh4i1NVGQztMDTKCGkqGLR4a7QsmFg
 VdkmtGw7VIoT8HllAfhaae+FnDczEoU1rCQ+7vRUm26Nc/rHp5Wb5yvnuo424ieoTd
 0mehdVexG0pxgmhSDVIPmkErFogPd4HGK8vrfBu5yPTytZ1M48fuLIPp8AgJEuofOf
 E8LUuBxzHqFkQn5zJcGeRROepbhrCftdNI32wNBRYrkBb6VXTaTQ+d1I8G36QwlGuP
 NEXo7C2Onm6Jg3BtUfmp1C1NQHf53OHfPO8Zrdf7/dYZQsmtwJrUXPORfZE2I9vPqz
 8tgkuIygdeDrg==
Date: Fri, 30 Jul 2021 17:20:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/5] ASoC: amd: Fix reference to PCM buffer address
Message-ID: <20210730162025.GB4670@sirena.org.uk>
References: <20210728112353.6675-1-tiwai@suse.de>
 <20210728112353.6675-2-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4hVWSOEjyjyaPny9"
Content-Disposition: inline
In-Reply-To: <20210728112353.6675-2-tiwai@suse.de>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
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


--4hVWSOEjyjyaPny9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 28, 2021 at 01:23:49PM +0200, Takashi Iwai wrote:
> PCM buffers might be allocated dynamically when the buffer
> preallocation failed or a larger buffer is requested, and it's not
> guaranteed that substream->dma_buffer points to the actually used
> buffer.  The driver needs to refer to substream->runtime->dma_addr
> instead for the buffer address.

This breaks the build for me on an x86-64 allmodconfig:

/mnt/kernel/sound/soc/amd/renoir/acp3x-pdm-dma.c: In function 'acp_pdm_dma_hw_params':
/mnt/kernel/sound/soc/amd/renoir/acp3x-pdm-dma.c:245:18: error: 'runtime' undeclared (first use in this function); did you mean 'vtime'?
  rtd->dma_addr = runtime->dma_addr;
                  ^~~~~~~
                  vtime

--4hVWSOEjyjyaPny9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEEJsgACgkQJNaLcl1U
h9D/ggf+NKw2azq43RPY9BmrkJs2AXXIxLk8D2crutNB4pWDwp3vU3+FdtgawWg/
wiO6repRQLXVvOy8RhggU97anU0EjrZQ1gMwiMcqTKjulwisnRVp1MSEJQlHFgbN
WtAcJZr6op6O2HZZa9lOSmtnQjI4dQYDN4IMk9dwz9aIubA2FYBIPY61xC7MkQ7g
EHHZC2emn3LJ2bvk4WdZMFj8SD0dUzpcAOSdrwcT6jvb8kwqFqBapZz9TgpQWaZg
o+7gSWoQB9+AaeO/KXjFMoE/UPDhH07k7rV2rYpNTuohkx3ZjnAZUw3wzikHBQY0
1eD4ZEeHP9Is9IGAx1DC/7Crzrq4jw==
=eZ+w
-----END PGP SIGNATURE-----

--4hVWSOEjyjyaPny9--
