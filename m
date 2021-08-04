Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0E0C4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 17:55:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13B160F35
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 17:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A13B160F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34D19168D;
	Wed,  4 Aug 2021 19:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34D19168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628099696;
	bh=kz9gPDrkKbomiVRbRaKlh88RNYjtDnBdBJMpjzIUzH8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogUmSiP6HRKzpuaEfd29kJcUPrpzoDhKu0keSNnav1Y1EylsO8itp4BHVhj6mdboT
	 4dmru2lpvlgrR0pUKK9HXLHPkNcx3lpjXPZS0ZhV++zSHYs6Xb1wj4peZ60IT8jJPC
	 bIdMoOtAWerLROaD2puvUaoSmrbQmYKqYphcKlPM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5137DF801F7;
	Wed,  4 Aug 2021 19:54:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2838F8025F; Wed,  4 Aug 2021 19:54:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CB75F8016C
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 19:53:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CB75F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rg2+Cfyb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F1C760E78;
 Wed,  4 Aug 2021 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628099630;
 bh=kz9gPDrkKbomiVRbRaKlh88RNYjtDnBdBJMpjzIUzH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rg2+CfybkMDHJPagCgETvWYXPo25uad6oWaQJCMVwOgls+fIQYT4jGZPPgwAnVC/I
 fUhbdVuigIP/1BmFwIJ4XLsvKg0HDzaW7VaqfjvvmFe1XHMqnGPveflDBECbe1itX0
 +v1qkSvIJWEFd10rc/qwp9N4c7DT4DgEBNg/ANGDTtYtql4bEmrR9hDaPmTQ42DIR6
 h6p7Ty/dC6JP9HP+ppS5Cwm4uVZGuee3V/NPLZvYo/qubVGKak7moWz3VNdwVKZlp/
 /t7dIIuKQHBUoCQa3KxqUiOLxpvNCtdttMQU9kGVf5yvMLGFDxw3Wa1u0u6BcxA46r
 pdw3Nv379hO+w==
Date: Wed, 4 Aug 2021 18:53:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 05/20] ASoC: dt-bindings: replace q6afe bindings with
 q6dsp-audio-ports
Message-ID: <20210804175334.GE26252@sirena.org.uk>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <20210803125411.28066-6-srinivas.kandagatla@linaro.org>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, bjorn.andersson@linaro.org
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


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2021 at 01:53:56PM +0100, Srinivas Kandagatla wrote:
> DSP Audio Ports bindings have been documented with DSP services bindings
> which makes it difficult to reuse them, so pull them out in to a dedicated
> bindings.
> Also as part of this change convert them into yaml format.

> This patch also removes q6afe bindings as dsp services are now documented in
> apr bindings.

This feels like it's multiple changes stuffed into one commit which
makes it difficult to review, especially since I'm having a hard time
connecting the code changes with the description.  For example this says
it removes the "q6afe bindings" but we seem to be adding some in the
newly added YAML file.  At the very least the commit message needs to be
improved but I think this probably needs to be split out into separate
changes each doing one thing.

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEK1B4ACgkQJNaLcl1U
h9CCsAf7Bk2kUEyaY9bF2HEqMkC/8SPlqFE2bY0iOUTGlQT+Xa+iASTWMluPIq2W
+bWOL4ghG0zzfwlK/QBj3Mf3O8txUe+hTy1nPLvqPKDvci96ZDE31N4GM5e8Nd/B
1WmkfwnYK6BltcRgHX5jue/gQbFu4YaNKPpTYzWr14dz2IrnDye353rgQxeQYdM3
AIMRf/WI7hyBY7bOm5VEZOIsOshnik8PqljSHvVhFdVqgU3LNkE8fzNoIbrZJLwd
m2B4kaKHfDw0OoalbtV93Klhx5ZQL8tX82bUcbGzBd3mJWrc7rmAv/hMIHGen292
m6apnw83Vys3Z4V5I0G8/g12eg6GFQ==
=Y3vb
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
