Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317DC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:39:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9462076E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gZMRGpRN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="toLXAql2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9462076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99A191756;
	Wed, 19 Aug 2020 12:38:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99A191756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597833548;
	bh=y+M69Til1EvJORNhPxvngspprJECf70sXE+hyFMk3+Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZMRGpRNviAVNQVpsNJBv2+6KeO1ulEzN86jOQjmu36YlJCbJIEy0MCKKoFpGNaJn
	 a6DQTk1RhLOnrkptMkvWpqdo29XxGC453YpkHxXj5xclPqi9rGsH5y0fnqvmMdsWlM
	 qwkJNEczZsrGmvVETAK+JJgKVKeEBev52LwuBrcc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 187D4F80216;
	Wed, 19 Aug 2020 12:38:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0BFAF80218; Wed, 19 Aug 2020 12:38:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56864F800D3
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 12:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56864F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="toLXAql2"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC7B52072D;
 Wed, 19 Aug 2020 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597833482;
 bh=y+M69Til1EvJORNhPxvngspprJECf70sXE+hyFMk3+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=toLXAql2wtllHm023rx293u6rgtg4oRalT1G7c7wfPh7zw6tadzcKc0nAX0mtQSv9
 cJCv8nopRHdF9FKLtrxwQZ8GdvEdfF2+RWPKX1UAnOfdE43dVszrqRdv7WbdIxH5JE
 UIM61liYddD+z/S7aiK9zvrhAesojjkLfn5YxTb0=
Date: Wed, 19 Aug 2020 11:37:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
Message-ID: <20200819103730.GB5441@sirena.org.uk>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
 <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>, howie.huang@mediatek.com,
 Takashi Iwai <tiwai@suse.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 shane.chien@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, eason.yen@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, bicycle.tsai@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2020 at 04:11:03PM +0800, Tzung-Bi Shih wrote:
> On Mon, Aug 17, 2020 at 3:29 PM Tzung-Bi Shih <tzungbi@google.com> wrote:

> > > +required:
> > > +  - compatible

> > And the same here.

> I misunderstood.  It still needs the compatible string to match the
> corresponding driver.

No, it doesn't.  The MFD should be registering the platform device.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89AOkACgkQJNaLcl1U
h9Dwbwf8COv9Rs7LMNn91TpJLXgOTRfXxwmnESd9+12yTNqmd+k9YAgp3PaB7PBq
GX1hQYeOeClZMGMGnjCt2RAkfT5A0/5SwKVsASefRpA6CTlKNCUk+5WQ6pK/LLqA
TH0RRiA3Z8ZS5WfUsZrovdCsHlCEQ+gCNctOyf3RqmX33RmycE1YWyWlQS3qLK7v
W7/F7t/mOMbrEAT4a4YHtbSYf/xT8aDr81GyndfpV6zwtQlWAmw4lI2IT0+XX4hr
BDwHxr6/Te3UgU6p+9xq5UgrIyXkR5htNv+49VqxNFNUhhPMgd00IO47kda9kvHP
rIO1YU5Mf+STMsbFuTk3zmEfud3FkQ==
=7xtJ
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
