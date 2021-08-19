Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A5C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 15:41:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05C660EB5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E05C660EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50CC41680;
	Thu, 19 Aug 2021 17:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50CC41680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629387713;
	bh=uRbKPKMIQblTfmccfmfOhWBkZFNd05t+Bvhtw6A+1ww=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvEw0WzQSRJ0Ug9K3bCBJYFvrLsmXnpv7hbYr8AIRT/9UAuFSWrpQ+7gNEmBSMP7e
	 0leJEK5liY8rJufOfjglSn+AXcchwP4dcP2SPEQE01dIFHGk2YTCGcyaaoPDOL6GjE
	 tDfppA2kATF9t9aO6276cpp/7ZoVqDnO2PD0cfwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA745F801EC;
	Thu, 19 Aug 2021 17:41:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1269F8026D; Thu, 19 Aug 2021 17:41:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B0E0F800EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 17:40:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B0E0F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EWblrQ6r"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 805FD6101A;
 Thu, 19 Aug 2021 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629387655;
 bh=uRbKPKMIQblTfmccfmfOhWBkZFNd05t+Bvhtw6A+1ww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EWblrQ6rB0+K2AlM09acBZ3aZJldyfKzjZ4SbGbUasuH+b+WdKSJgKhc6dgivm1T9
 bV4Pb4WUPQQUIBoalqMiQ4CvJ5Ly+NGhL7oh0BR7nFjnW59S5SmH9ohVsBQPPMWJVT
 HuRgZjQDUm/8w3wvNn4VBJq35phva9N2bwKYr+vOzUZZDHZcuYJixxV41rg6v+cOcq
 5i5g2yaC/b5js/u6WvCs1DfUmp+GEAi25JD8RBmp/XHD9lD8Jbx6BJ6Pru25kXFXQh
 isU1NF9H5GxL+UeLUzPBfBS/kuckznWtR187r6n0EJSPDPkbxzl3SshRe6//V92y5L
 iN8aLHPiDJPNQ==
Date: Thu, 19 Aug 2021 16:40:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ASoC: intel: atom: Fix breakage for PCM buffer address
 setup
Message-ID: <20210819154030.GO4177@sirena.org.uk>
References: <20210819152945.8510-1-tiwai@suse.de>
 <s5hwnoh8n2h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <s5hwnoh8n2h.wl-tiwai@suse.de>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 05:35:18PM +0200, Takashi Iwai wrote:

> Mark, as it's close to the 5.14 final, exceptionally I'd like to merge
> this into my tree directly now, so that it can be certainly included
> in the next PR to Linus.
> (Also because the commit will be reverted on for-next again, too.)

> After the merge, feel free to pull my for-linus branch into yours.

Acked-by: Mark Brown <broonie@kernel.org>

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEee20ACgkQJNaLcl1U
h9CPaQf+K+xZbgapW5EjnWkBR2Pi0bw1HjoaHdxb4aDodkuI7c7+Dpyr/9/KD2a4
tsgCRvsuSWT7b4ybouVaHYVLODWvr33O1+LPRRVXyS9/zxW6zGUZiDi9IUWb8xrh
9ENja6QXVs1QPPJhecXUsHc9qgwxB8Jz63u82253N5vpugeX+H3LJNgl3JM+PJB6
vcqARBlsX6jtUtEv02DFX1e6R4a3BnPOsxA86LJU0cQ1SXSfamfN3rGguCvx1NG+
oqZgT2PhVg8K7HOzUnNMs2rmy1jFzA5ZHoUBj+jPchUPfm8/eRLnAaETwQv4KWyT
xc+e0yB0ZqbxK/I6sigHU3w1vOhfEg==
=z6rd
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
