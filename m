Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4BFC56201
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:58:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5965D24654
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="le33s8Yo";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="CbWjch9q";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ln2fTzoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965D24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 541D417B8;
	Thu, 22 Oct 2020 14:57:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 541D417B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603371523;
	bh=SqzxoiikPEBmlhJn06ROlaXzpWOL5Lkl7lMHaqJvppE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=le33s8Yo0Nml+P+DIfr5mPhe1tAfCpJP+snFIZuOSLkAnVyRQbc8DDLhh4kSjKOAG
	 aHrrGJ9Qoe1U51UdROrUzXUrn5gKkfgW8gbxpha79bbfa2G1KsNVOKV3hSvwVfrWRG
	 zBVEE2MYNarm5lWon5Al48BXBy2pBHbSbHSU6QFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE488F80247;
	Thu, 22 Oct 2020 14:57:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB047F804A9; Thu, 22 Oct 2020 14:57:50 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3723AF80247
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 14:57:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3723AF80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="CbWjch9q"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ln2fTzoh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 107B35C00FB;
 Thu, 22 Oct 2020 08:57:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 22 Oct 2020 08:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=SqzxoiikPEBmlhJn06ROlaXzpWO
 L5Lkl7lMHaqJvppE=; b=CbWjch9q0xVMBCbOg/vBu3PnZRWmUXHzcCL5Cxi029s
 dQxIB63ezQK6YObcSgpikUp4UqTSX2QwKjna3YA7EPMnEDo7VCgKgO9Eb2qsfigH
 fCn8n5aexnV8JXUBmwUVJP7Auyl2GMFzT+szw1AoHsHGkV/Oh/Yils8SFLxmhroB
 FRvTK14CjtbSvj1qJT4D/Rwx4pxZkZLehXruAWc9tOw/Ty9xjyWhiJG0mPk4yBwk
 MJ+eu12hle/zwJdhSv8TIdf3zhbAtDYF3uIHWzuG7ff5cjEhGn7UaNFPocdpCm3E
 LLXY7sVoXzja8LecH+1s5yn7+wS40q15/4Jd27T92mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Sqzxoi
 ikPEBmlhJn06ROlaXzpWOL5Lkl7lMHaqJvppE=; b=ln2fTzohCK4peFmqfU2ffw
 GiYvCL2MzD7VGRLS6Tf1Q+RM/axS2/d4k7RZFE+H95zxX3QYNy0NcRbI2k89ClYH
 1x+OlJoYGcGdg8OOocX3ba8eItHudpcrTFvKiK17AsXBPMh6GIOh1iaWni1nO7cT
 VvFpGdQteKAM92jM7g8V1CYa6H6HzgcMMCWMvFJYd8Ff79gGwylJc6s4ODzI/VdH
 qgpdDm3HNfYBEM4xDIUxzzB/+tiwdo5LWGPJ6Dc4E6ZkagClyjYZrKK/DL8qJgjT
 LbfATHUfzXlFLgu+i7PxGzN/gS4fgkZPi+jPEtIb02K58AyXXnXSfGMCOGZrMNKw
 ==
X-ME-Sender: <xms:x4GRX7X12awgdHJAq9zUCnGn7DBgRiSy37GJ5yso81Mn2xdvmRKnow>
 <xme:x4GRXzlYYCxiICPBBGLK_jhkWM3fjyToocLGbDDshN95hFlv2maXUuqW4LxMAv9yl
 mjE5ro3zNuVpEtFBbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdehjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yIGRX3YeNS45xGORDNekM6BycridAu1Sdj7TCSuVLoWxu4VMIVqhNw>
 <xmx:yIGRX2VopxPa2EUADf9XezxtaPMv57T2WX6AFLAMIF1xozpw5VZtEQ>
 <xmx:yIGRX1n1cdXaB6aY0rIihs79T4OZMuEmvKI8faRI_7jApZtoKZNKhA>
 <xmx:yYGRXzYytHhEgelO4kJV7_fWGkhhaCUq5pV8nqllDthDhaLojGj2LQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id AEC50328005D;
 Thu, 22 Oct 2020 08:57:43 -0400 (EDT)
Date: Thu, 22 Oct 2020 14:57:41 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Context expectations in ALSA
Message-ID: <20201022125741.xxibhwgcr2mhxehe@gilmour.lan>
References: <20201022095041.44jytaelnlako54w@gilmour.lan>
 <30226f94-72e9-34d2-17d0-11d2501053f0@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d62deidd5dansznh"
Content-Disposition: inline
In-Reply-To: <30226f94-72e9-34d2-17d0-11d2501053f0@perex.cz>
Cc: alsa-devel@alsa-project.org, Dom Cobley <dom@raspberrypi.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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


--d62deidd5dansznh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 12:03:19PM +0200, Jaroslav Kysela wrote:
> Dne 22. 10. 20 v 11:50 Maxime Ripard napsal(a):
>=20
> > So, I'm not really sure what I'm supposed to do here. The drivers
> > involved don't appear to be doing anything extraordinary, but the issues
> > lockdep report are definitely valid too. What are the expectations in
> > terms of context from ALSA when running the callbacks, and how can we
> > fix it?
>=20
> I think that you should set the non-atomic flag and wake up the workqueue=
 or
> so from interrupt handler in this case. Call snd_pcm_period_elapsed() fro=
m the
> workqueue not the interrupt handler context.

Yeah, that was my first guess too. However, the DMA driver uses some
kind of generic helpers using a tasklet, so getting rid of it would take
some work and would very likely not be eligible for stable.

Maxime

--d62deidd5dansznh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5GBwQAKCRDj7w1vZxhR
xTCUAQDTmZkZWcff1PLx6AGpuQLAYMsZuMdLn9JoU1UyOhjCaAEAgN02qADXy1D7
SVTe4zN+/PYjg8cdc9fRz8yI1Udj8ws=
=n3lj
-----END PGP SIGNATURE-----

--d62deidd5dansznh--
