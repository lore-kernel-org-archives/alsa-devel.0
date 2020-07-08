Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4857DC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 13:34:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6D420774
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 13:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AWoveREk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Scq6byou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6D420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50643168A;
	Wed,  8 Jul 2020 15:33:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50643168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594215248;
	bh=pWRPHGibjjPPWKpbJyMPd4KeiPF/cZsn0uBAep4dEts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AWoveREkDOVyriU/ihYGFNgl3B4nIK3pu+f/V2XsWv3JOimp0SgOWVRDWj2H/TfPc
	 IXWcP765I8qSjGslqO5nkknVQcMRuLpwZjvMaGyA2GfqxfrwPNI73n/3bnPXAvkhb2
	 PidMa7WvB8Q253aaZpf9WNGFOHpanzESwXfi/Gm0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E79EF8015C;
	Wed,  8 Jul 2020 15:33:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 131C7F8015D; Wed,  8 Jul 2020 15:33:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A04C7F80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 15:32:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A04C7F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Scq6byou"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5EFEE20720;
 Wed,  8 Jul 2020 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594215169;
 bh=pWRPHGibjjPPWKpbJyMPd4KeiPF/cZsn0uBAep4dEts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Scq6byouIRCANUCFAPOYPb22KSZxoBqJ+tf5/JkEVp1ex3HMbOmWCGCcTOAp4JEyM
 bS3aaHUNuKowQdQEaW6FT6Tc3+GHrLSYBzOsfq3tqy8hENXhvZpkHSH0WRA52EkmV8
 FQ1nqTlCxk6MqS3biSx0DMaLruXltRliCPAT1YDs=
Date: Wed, 8 Jul 2020 14:32:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 00/11] ASoC: qdsp6: add gapless compressed audio support
Message-ID: <20200708133244.GP4655@sirena.org.uk>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
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


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 05:36:30PM +0100, Srinivas Kandagatla wrote:

> Along with this there are few trivial changes which I thought are necessary!

It's better to split stuff like this out of the series, or put it near
the start after any fixes if other things depend on it.  That way it can
progress without getting caught up with the rest of the series and the
series gets smaller and more focused.

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FyvsACgkQJNaLcl1U
h9AWqQf+O9QgCNEJa54N14qIB5Rc4Mw/3fizJUF48b0PH+rmGoca3G1ZG5wMWi0Y
dACGNRHobAITHwclS6Sf2vJ9mYarNB+IWHBI7H9TR0bwXhg39gXqma6AmD6qCohW
P+4PpynoFmPkZ5vJ+ZXymzWbTQ3jbEfamhVV6HOoHZQWIo6DogQV8bRvxGs4u31O
/+RBvxigPKakC3IJWfGgri5pTo9IE2WIB4Lxg+oValuJ4zyAtdbhNP4D8/5AkozK
e98sDMLocMQ6WFRChSS6VnAB3ySmzOf250vL98fgn4bEJ/harJ5aCmmBXphStOKE
8thsg/8jOVCrWSnHTloxWQIfMHjAzg==
=apo/
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
