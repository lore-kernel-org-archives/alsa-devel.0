Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB745C433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:44:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15872084C
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I9b85VH8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7kJtcFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15872084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 101CB17CE;
	Fri, 16 Oct 2020 18:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 101CB17CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602866636;
	bh=jr84u8hTDw7KLKrQ9vFJzO0wHhG/H9Q/V0cChZLCaO4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9b85VH8EuIlt+Nn0W83w96CKglF5xv37lso+vA7JMeu9ZrAvify67UGFudDKUbxm
	 qKqq/zMylcXIOI31rfIOg06RY9tf9FdBPlNE8sifqbgxdFpEqLr7RhGaHXYZ+sAV3s
	 OxUnzJbWbAUVCmYMv31qOpscedFObWHiDhzZFVS8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 956DFF80115;
	Fri, 16 Oct 2020 18:43:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2F17F80217; Fri, 16 Oct 2020 18:43:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7127F80115
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 18:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7127F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i7kJtcFX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D995820848;
 Fri, 16 Oct 2020 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602866578;
 bh=jr84u8hTDw7KLKrQ9vFJzO0wHhG/H9Q/V0cChZLCaO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i7kJtcFX1rlebxCP8OvS8KDC6rnqrJMllH/Ff9YX8pj76Dt61+nzSr2JzXKEgE5b3
 nbWsuJxtsl8TAivQIiG8DJzZSW0KXNH8qJToutOcvptVIJ9ujOxaWvaAvLyvqFLfNR
 CHpL4M5S6Vy8KfW5S/suGkcTyXLXZ5cSOwkemrSU=
Date: Fri, 16 Oct 2020 17:42:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 09/13] ASoC: dt-bindings: tegra: Add schema for audio
 graph card
Message-ID: <20201016164250.GK5274@sirena.org.uk>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-10-git-send-email-spujar@nvidia.com>
 <20201006203433.GA2786434@bogus>
 <a5bc07d8-fb2e-e86e-f0d3-be19166ad7bb@nvidia.com>
 <acbcd136-a933-e5e0-863b-f435dafe1697@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vbzKE9fGfpHIBC6T"
Content-Disposition: inline
In-Reply-To: <acbcd136-a933-e5e0-863b-f435dafe1697@nvidia.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, swarren@nvidia.com, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, rlokhande@nvidia.com,
 nwartikar@nvidia.com, tiwai@suse.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, devicetree@vger.kernel.org, thierry.reding@gmail.com,
 atalambedu@nvidia.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
 pierre-louis.bossart@linux.intel.com, mkumard@nvidia.com, dramesh@nvidia.com
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


--vbzKE9fGfpHIBC6T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 10:44:15AM +0530, Sameer Pujar wrote:

> > I am looking to reference the bindings used in below doc which is not
> > yet in YAML format. Only additional properties I listed here.
> > {LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt

> > Should I keep this doc to *.txt format as well and later move to YAML or
> > is there a way to reference *.txt doc here?

> The dependency here is like below,
> Tegra audio graph card -> generic audio graph card (audio-graph-card.txt) ->
> graph (graph.txt)

> I plan to convert dependencies to json-schema in next revision and then
> refer these for Tegra audio graph card.

Yeah, unfortunately you need to do it that way around - you can't
reference text bindings from YAML ones as the tooling can't parse the
text bindings for validation.

--vbzKE9fGfpHIBC6T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JzYkACgkQJNaLcl1U
h9DbqAf8DYA4YLlsLe3VZcZ+MHzvpMsnsHwATSDyKbIzcuVEyS5py0YVyaL9jfsN
wCv986CR6B7LLmAIo6TRfbbk7kDdHAgLDqFz6be5ypPoDkBrPk+PnQP/rPxZXMX3
K5Vq4oZDL3vjdJ5I0K4OLw2xXVnSny/Y/GcKNytTbrb7uKmbl8AWFXF7WUq2sivV
crmj6BSiKwt+pIrxeUDfWW5KdtatTanevhOx+d8lClG+mzCg0oGuUVjBzA8ZMGu8
EfPRMTAqnrEo9xaAMEIxdVvsntV+ibFSqT8o5dXozhL7+nw86FH8DFEOIRzDBLYM
hC5VtDA4CObZ/gwHIFkasu0/KOS1ew==
=/9Pr
-----END PGP SIGNATURE-----

--vbzKE9fGfpHIBC6T--
