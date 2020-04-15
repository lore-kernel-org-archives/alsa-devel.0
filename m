Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11807C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:29:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C2120784
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sb4xqgst";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgXdq6RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C2120784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2F18886;
	Wed, 15 Apr 2020 19:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2F18886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586971757;
	bh=Up2EZrSuJmR+/Ct9e0Zig4VEgFWU7CsIcOYsNq9adSA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sb4xqgstavPA4AXPbeCHx0DjhCZ1pCHyyGQThKFJ5wXgaedapSHzxbokZtBl7YmSC
	 TY6K3mPFCCYF2I3q02CABqLPfpAJhqL19Muxzoi/1a7oBZC4gSEWsaFw+qePy8PdvS
	 rwmJimbDoX3AJlpBgBMZ1WeCOP3A0xA76mbhK1SA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A183F80229;
	Wed, 15 Apr 2020 19:28:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86AFDF80264; Wed, 15 Apr 2020 19:28:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DB93F80229
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 19:28:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DB93F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lgXdq6RZ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8979A20787;
 Wed, 15 Apr 2020 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586971698;
 bh=Up2EZrSuJmR+/Ct9e0Zig4VEgFWU7CsIcOYsNq9adSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lgXdq6RZoxW+yz0bP0F/wDIm7vdvNvmED9v2AKxDpnPgNw82mcA+WLUP6GUUlhK5t
 /3dHGJI8ZOLa0s6bBp6RbwI0Ymm1bBg1lUWAvTZQn5e+hzkdMkir1Z3jzqBg422lq/
 VOj7XPKkTjmXCGWAACDbNe4wkbeCpVWLFEB11ncE=
Date: Wed, 15 Apr 2020 18:28:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC TEST] ASoC: soc-dai: revert all changes to DAI
 startup/shutdown sequence
Message-ID: <20200415172815.GJ5265@sirena.org.uk>
References: <20200415030437.23803-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <20200415030437.23803-1-pierre-louis.bossart@linux.intel.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2020 at 10:04:37PM -0500, Pierre-Louis Bossart wrote:

> Sending as RFC since I don't have a good understanding of the
> root-cause and for others to confirm my findings. Tested on top of
> v5.7-rc1.

Hans?  Morimoto-san?  I'm fine with this as a fix, it's not ideal but
I'm guessing anything more substantial is going to be unsuitable for a
-rc series.

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6XRC4ACgkQJNaLcl1U
h9Ajfwf8DP38+XB2QLA/Iv7hScLp6vKUgfU5N+o0dioKetvISNoURXLOH545LnOc
IqGzmLBcTaVbVb9f7Y9NnuSVc0qCsw3N+kUIJojNIlB+m8li9sUMVekHj8kUgbjp
y6mFyK9my8mqn3WZDcMC4eIFZq/6PSDOHXfomkC35QZUpGbvp/VjKLhujkS1uGkg
VohMLJG3RnA52Pw7cbWlZR/1BhK4RFW/lIapwYmQJlUpBAVuhZRWwnUh6o28nQL7
ctGu4UGlw77tmdYbZ7NzXLTpTn6N2wy5Ug6/UnYO9LGNEYS7RF13vCmvZ5BWS+T0
fJcR0ZSvA4vU8vDanqcpIOx65831Jg==
=7Nan
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
