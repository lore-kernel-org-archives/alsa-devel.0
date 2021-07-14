Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84164C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:25:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACB8613AB
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACB8613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DF521678;
	Wed, 14 Jul 2021 18:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DF521678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626279916;
	bh=ydb3bROEvCOilFapPnKxoGtuhQaXeTXNdteDjVKfyIQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhKJsMI1AQ5VpWF/rnGC59MBh5NTjkW6cdTqZLhvchJLngMAZkr3YP+vvsRgH1HGE
	 SORFN2zHEfE5t1evAZIPpOEh65jdNwjbwVzSX0iFiUXU2kedzeWNPbgaSGT6cvna9r
	 7NVjl7LBuhQAFNQyoKI8oY2J9Jw+GXbnrlz17Yyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0BD1F80253;
	Wed, 14 Jul 2021 18:24:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2E8CF80254; Wed, 14 Jul 2021 18:24:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 830E8F8013C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 18:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 830E8F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UKnUVgN5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A573461106;
 Wed, 14 Jul 2021 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626279856;
 bh=ydb3bROEvCOilFapPnKxoGtuhQaXeTXNdteDjVKfyIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UKnUVgN5Vuj1Xmz2RRwq631aSQ4uiLZdgsPhSjSkXWpj/uHQ8Jmy3IvnQmSUEfPwT
 11m8uzFLs7Cw/BEjuHqNR8m9LlynlV32YhjUp1eGR+h5c18cIOlv0U3x+7Fe/uv/gb
 9SaMsAzCIQboNDfl6sQS4RTAtZsTggaa+wDI7z7JvPQv7SF6iJRpYtigVKmvr9yuYB
 N5lhzQileVGiG/ISOyLZm1k9ievTEcE3X2AQH4UcBq4OYvuSPX/thWnXcpmtd5XGUy
 3W3L+/PeJT2OwQpRBl/G5Nakb/ggDmUSs7gDiSR74LO9mHPrHogj9H5JtZPm1ULIT1
 w0KlfpiSsmGQQ==
Date: Wed, 14 Jul 2021 17:23:39 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 10/12] ASoC: amd: add vangogh pci driver pm ops
Message-ID: <20210714162339.GD4719@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-11-vijendar.mukunda@amd.com>
 <ce03f4b3-874f-a286-5523-7793722a6ee7@linux.intel.com>
 <b754ef05-065d-ee7b-754f-1498f7c6cff6@amd.com>
 <38def9e9-5161-9441-c88a-43b21edfec43@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <38def9e9-5161-9441-c88a-43b21edfec43@amd.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
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


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 12:06:38PM +0530, Mukunda,Vijendar wrote:
> On 7/8/21 5:11 PM, Mukunda,Vijendar wrote:
> > On 7/7/21 10:04 PM, Pierre-Louis Bossart wrote:

> >>> +static const struct dev_pm_ops acp5x_pm =3D {
> >>> +	.runtime_suspend =3D snd_acp5x_suspend,
> >>> +	.runtime_resume =3D  snd_acp5x_resume,
> >>> +	.resume =3D	snd_acp5x_resume,

> >> use SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS?

> suspend and resume callbacks implementation is same for runtime pm ops
> and system level pm ops in ACP PCI driver i.e in suspend callback acp
> de-init sequence will be invoked and in resume callback acp init
> sequence will be invoked.

> As per our understanding if we safeguard code with CONFIG_PM_SLEEP
> macro, then runtime pm ops won't work.

That's not what Pierre is suggesting though?

> Do we need to duplicate the same code as mentioned below?

> static const struct dev_pm_ops acp5x_pm =3D {
>         SET_RUNTIME_PM_OPS(snd_acp5x_runtime_suspend,
>                            snd_acp5x_runtime_resume, NULL)
>         SET_SYSTEM_SLEEP_PM_OPS(snd_acp5x_suspend, snd_acp5x_resume)
> };

Using the SET_ macros doesn't require that you duplicate the functions,
it literally just means changing the way the ops are assigned. =20

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvD4oACgkQJNaLcl1U
h9CFSAf9GXJDYHFf1ZYbjnC5Y/psNti5ZQIkL894y7bQ1oR/KwYUHFEUKag4zOJa
UxaEGAEFQe2pcFefvMz8jo6MtARR3jgsoetUVHCQTLdoaEcdsP98XxCQX+cr3yXq
41LkTiKUl1EEiThrDUkDxPlVxzn46R17ilHVQquyAcUgdnZqNb2Ggk2I/HWySA/x
ZkSjs8O7cIi0Z90c9qLVoFJRMY4SPvZ9hcf6aEbu/0eo24kWnt21bxD0V03y9u9D
fN6UlPF3anejGy3w+B78Ih651m4khWzqqEGYTtXcF6yAll7CYGOSHdMIQVKCd3AI
VI5Maa4nX676OciEdgu0YfOmZx3VUw==
=9L9r
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
