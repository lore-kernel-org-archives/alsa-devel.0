Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A789C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:47:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927A21973
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T2a7JQ7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xvFLlAbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927A21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B741E1675;
	Mon, 14 Sep 2020 13:46:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B741E1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600084051;
	bh=cSiupXUtizg1oV5A0Jw00sC2CIMDO5kVjup5+HKDv1E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2a7JQ7DWAyO10NZM0FSF9woDVCvsXfBiLAevAb/aa/42MFk+sK58DEGnydCWdw0l
	 7S7e5xgzugw/HdP8aPNae8wWYqY/Xh5zy7dbPhuwuT/1hoSID4X+Fxm3RGZt9OIqlB
	 VBNkOVMQTXapt+5YpvROfJ+Sk8nwKWp2YndH8sEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E114F80150;
	Mon, 14 Sep 2020 13:46:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC621F8015A; Mon, 14 Sep 2020 13:46:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21D5BF80105
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 13:46:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21D5BF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xvFLlAbC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F75521973;
 Mon, 14 Sep 2020 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600083984;
 bh=cSiupXUtizg1oV5A0Jw00sC2CIMDO5kVjup5+HKDv1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xvFLlAbC6XskGIL9TCSnGq/zQeQTuEeRyjvU/bELMJZbPldw5WcZyOTIDJU5MHYt3
 3W3FsJbK8Qu7eKxS1AFEdKtJcpbSNjpRrUDoOCWEFxEfCTpgRCozZWUD9jG45QZM8W
 nqu9DOeqa7Ws0flMm9MeK5M39bqf94IDXIPM+4dU=
Date: Mon, 14 Sep 2020 12:45:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v2] ASoC: ak4458: Add DSD support for ak4458 and ak4497
Message-ID: <20200914114535.GB4821@sirena.org.uk>
References: <20200911083048.29055-1-shengjiu.wang@nxp.com>
 <20200911104042.GC4895@sirena.org.uk>
 <CAA+D8APvRMXkrYPdGd7H1+hj8AFP7=nvZ0QbpnH8o52-sh50GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <CAA+D8APvRMXkrYPdGd7H1+hj8AFP7=nvZ0QbpnH8o52-sh50GQ@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <lgirdwood@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 06:47:10PM +0800, Shengjiu Wang wrote:
> On Fri, Sep 11, 2020 at 6:43 PM Mark Brown <broonie@kernel.org> wrote:

> > What exactly is this pin selection about - is it something that will
> > change at runtime or should it be configured by the board in the DT?

> It is to select which pin group is used for DSD. it won't be changed
> at runtime.  So do you think it is better configured by DT?

Yes, DT is a much better fit if it's fixed by the board design.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9fV98ACgkQJNaLcl1U
h9ADpQf+MaUWPyDgn+Z8C/aWXXNZ1YtpnQhTclVrouZrH+oZt6AtIe6Upc4dyLi0
JJ+wd/07YOes9zIjny4RI/bIXd2XogcYqUzjeDP9yiDbHfyezUSl0IOKJzEpyv/3
zXGXlFyXtEVRfwa/UORLG3gZ1HSW4Qok7L4w9TwraGUYPB7ZjohYFTQqKQHVmPY2
v3995vXRLdYDnxHCpaO5MR/wcxlftbV59xrWAcsZVvzEiQdLdhgl3kOzMeU0iP3v
j1JvLGhVtZTr9rhbiq30wKic2mi39rMoBDZ6zkWve3ejaK799Ev4qWr1K9URY4PB
SpAyT+3Se0+RK7JsLXA2r8icWVIGAw==
=j3Bf
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
