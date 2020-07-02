Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FE4C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50141207D4
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bBTNtSDo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1T1sJiBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50141207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBE9F16D0;
	Thu,  2 Jul 2020 14:26:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBE9F16D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593692826;
	bh=CTOwxLg+n8bAvIzD1IVs4kKNUWk2tiRGSHFgkCW870g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bBTNtSDoHV4NRWhyj9YUgnIG16kfvpSrMAm/2trW+YxSxEc+pcyiKnqD9dTTIIBr9
	 0dHJGOijCml0j73t3HDZ216y4gPAHMVH+TOBG75OJ1195fC1YTV+rDdiRldTW5UE8D
	 Bka7OL4y+5V8V45yT36LRGXVFyFs2MDuZK3qeP7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FDE1F80134;
	Thu,  2 Jul 2020 14:26:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E17DF8022D; Thu,  2 Jul 2020 14:26:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D975CF80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 14:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D975CF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1T1sJiBr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 726CA207CD;
 Thu,  2 Jul 2020 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593692768;
 bh=CTOwxLg+n8bAvIzD1IVs4kKNUWk2tiRGSHFgkCW870g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1T1sJiBrL93OzyoE3j8Pp+hjxq11/0nZA94VY4Vad9HkKNAyoEOK7UpSMMwootbsB
 gZ6UOeWnQipL/sYc92CJBnUVnaoUlUkZ+3b6dNAh/HHnRSLCfvkHLG8p/b5sm3vAgn
 c+Z3ZIeRIY2VLdmtGpHq+Hq/Aum9RTvwSju2PH7g=
Date: Thu, 2 Jul 2020 13:26:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: Re: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI
 link with multiple Codecs
Message-ID: <20200702122605.GE4483@sirena.org.uk>
References: <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
 <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
 <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
 <1d7888c7-a8cc-e891-01aa-016e31cc9113@nvidia.com>
 <87ftadyrec.wl-kuninori.morimoto.gx@renesas.com>
 <492079e9-4518-78ba-a227-859d31594369@nvidia.com>
 <20200630110100.GH5272@sirena.org.uk>
 <81d106c0-e1c8-a79a-8caf-1f3be0d61f0c@nvidia.com>
 <20200630153220.GL5272@sirena.org.uk>
 <fb286ab7-21f2-43ad-2751-c76b7b6e4cf2@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <fb286ab7-21f2-43ad-2751-c76b7b6e4cf2@nvidia.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jonathanh@nvidia.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, nwartikar@nvidia.com, lgirdwood@gmail.com,
 tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 04:06:14PM +0530, Sameer Pujar wrote:

> For the HW I am using, there are no fixed endpoints and I am not sure if it
> is allowed to have empty endpoints in audio-graph-card. Crossbar/router
> provides the flexibility to connect the components in any required order.
> Patch [05/23] exposes required graph and MUX controls for the flexible
> configurations. Mostly, in DT, I am trying to model the component itself and
> finally router can help me specify the audio path to interconnect various
> components. Hence I was trying to understand if it is really necessary to
> represent the links using audio-graph-card. Kindly help me understand what
> more it offers. If simple-card works fine, are we allowed to use it?

The links in the graph card should be the physical links at the edge of
the devices, those must be fixed no matter what.

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl790lwACgkQJNaLcl1U
h9BPigf+JRDzmC/OXZU6GO+RPto06SdJhbNhvLjXQA6BqKzqFg9qNRwNxEK38qz/
nBq43rOuPFzPkX8j9qxChkJ7pIyhNHx+Vkqo3fRnulH3afFxAiCLKq0IkFph+A0q
vOOpNX/7HPZHTXzCWDrSF/pkQvgf+ou9X+K6johBzn/Wtd36X1okIf4LCkmrrhzs
/HXd6bGFbGzUC86c2F2Vqbq9aFWhxRMBWGnV5LTGz1I+Y1RiAqUE7yE2whTTGRhv
WdrHBrGkXU2R1mtjoecmZ5k86iY8Ho2PQ6ropR7AHRZXmlEYor7T0ViwjXETvQie
m0fVcHg7vi04mLyDdmy2dUZwC7oo/Q==
=lgFt
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
