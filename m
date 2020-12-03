Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B6C3526A
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:51:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D232166E
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D232166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AA361810;
	Thu,  3 Dec 2020 15:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AA361810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607005940;
	bh=eoja12WkKudA1gdkqq0jyu0ZXHPB9UvbmoYXrl4E5Zw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dEd/TbxVrWfOjabnpczsPo/nG8O4YY0UppQOROqsXbNvDSDgumvo8FXcmVSm2Aa7y
	 LqBnhBKE1tu0eK78GvrQ0Zl5J65z3tzJ7BXQNFhuXdg51AY8euOq7fzQDz3wtWPrI7
	 q9BN3As23h0mtAcwgFdVvhEz5AjC28hdP/se6kLE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2EEEF80158;
	Thu,  3 Dec 2020 15:31:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE64CF8016D; Thu,  3 Dec 2020 15:31:27 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24C73F8012A
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:31:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24C73F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jG2nGATA"
Date: Thu, 3 Dec 2020 14:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607005880;
 bh=eoja12WkKudA1gdkqq0jyu0ZXHPB9UvbmoYXrl4E5Zw=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=jG2nGATAg+FhXgV2mJapE15c56CqCf/mIUHF6i0iZuYw2FEAEh1cL14Mj6MO9WCq8
 mu3vYdjq3GhrMsvQqcPmni+nnHJLUbPwOT/2qEtdi5KzFpTGRiwVlpSRh6Y6RVtP6V
 v9YX8l1wDdYNUqsdGeXajoL1cxheGt1GVvXmyo268Pm/UFI3yF4lz8ro2OuSWAF7r0
 tYAkQuNBwbfMY01vj00NfcHcSw6xFBsURXCLMdx3miOfbnKqV2n9/VUtLkS6u+nEhP
 CAbuflZNcc5Gue73ciWfpeDQ+eDHBoDHqdya/CEHDz/C8DCYySjpduA2/wfsK4w07P
 Pna6DMhifaGUg==
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: pcm: send DAPM_STREAM_STOP event in
 dpcm_fe_dai_shutdown
Message-ID: <20201203143117.GF4700@sirena.org.uk>
References: <20201202193343.912942-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20201202193343.912942-1-ranjani.sridharan@linux.intel.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, hdegoede@redhat.com, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 11:33:43AM -0800, Ranjani Sridharan wrote:
> A recent change removed the call to send the DAPM_STREAM_STOP
> event in dpcm_fe_dai_shutdown. But this causes a regression
> when a PCM prepare is not paired with a hw_free. So, add
> the DAPM_STREAM_STOP event back to dpcm_fe_dai_shutdown()
> to fix this.

Hans, does this fix the issue you were seeing?

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/I9rUACgkQJNaLcl1U
h9AYoAf+OQ6gWJuaxmgLxHR9n8rbtVfOzOHhII77c/5XEZCDsm5vgsjQ1nxuE2+S
Rfd1dOuGQ4/5XOnQ4ZVvFG53DHFE3+2zD2uBZB9StQsNueWPK8LW/wFCh5oxv+y1
8yA8Hl2AtREsxvBRo6dr8q00aE3jwoEuD+nNuUawGbap+wlJ8MhRJRXPG3bGXZKM
4E71CBj9hmGmeTRz8wJUYir5RSrK7Mu2G5XoRLrew4h36y/RUHnrR7CX6KaUBFp9
wCXIIP71pg3Ul+OhDKGeoFiuHE2Pu2yeK+fraLcMURImj6HHTyjMj06KD3jGJoRY
wzfJOGdsbaEgqcc8umHV6b7I+t+/pw==
=jT9+
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
