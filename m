Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3524C2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 09:35:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6626141B
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 09:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6626141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC320172C;
	Tue, 25 May 2021 11:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC320172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621935306;
	bh=jROtr0lHgeFAU/OduOZJ0abHrauDG88KGsvMrltysdI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPa57UI9Jcqq1S3ZLXOyct9r5T+U+wGGDuFODk0BSk66Q/j832aNDUrERuIUpsnz/
	 SfGCMjhrunuXQ/jzShAATUkQv5+iiKjdaA5QZHaZQ4MoYKGVCq+LSbE9c41dYwO7mG
	 DYcZNL9zRBF0RmV82CV1j/WDPzh0TtLzp9XDKh+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 492D1F80137;
	Tue, 25 May 2021 11:33:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A26DBF8026B; Tue, 25 May 2021 11:33:45 +0200 (CEST)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7C33F8019D
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 11:33:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7C33F8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="TLPZBtCa"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="EPrdFpjy"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id B65C213C9;
 Tue, 25 May 2021 05:33:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 25 May 2021 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=jROtr0lHgeFAU/OduOZJ0abHrau
 DG88KGsvMrltysdI=; b=TLPZBtCagzgKGJPCmH4mUGQRE54Ss6YUFxm47RiK/7w
 D3DdIzzPJlix+xCCczeO3AbQm78U/XAROdw3rosxCxoLOtAIbqY1PEw7IaKDdiD1
 ge1iDpNAEHdinDomQpkVzLC2ePI//nrpzhDFq7hSfzLgdBAgIVwx+BUxaXTiZ++m
 s0IzBnjnWwHtmkBw4sJt24n0BOT2lMZAN36/zlDHxDMIsepuZlWinJey2mUegmJV
 wLfQQYil5kKWFTf5lKLU/4jw2RkVUCSE0Rn9d+l7bPvn/FZLcmvkQRmEvr8ez1du
 S5/eTUCYo3rffAqJj9DVVeln+3dRB8eyrWWCkxEbiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jROtr0
 lHgeFAU/OduOZJ0abHrauDG88KGsvMrltysdI=; b=EPrdFpjy5DbjELj8+jWq4I
 H7kslYwLoyWuKudCa/+iYse2L8azuHIi/CJUfv6Sx5878orW6UPRxO6xC5hn+NIS
 KS5R4q3/AwEaH/ZAcMwLgmXoprrIWdAsz9qCBEwD3ECZqrJ1D2Lzla0759/nuIPF
 HrLMD8nG2hCqpj9695bUlF5qKB3xOuBmyz+Siwe3HAJAOAvBBoMB9psU6gpLZeED
 sKcoAxgdRHv3BVo92RS2ObkeCqODErHNKzlwjSdvK/PV8fGElw1ae/2Uos4EA+Hi
 u5+FfK+0Rh5YKWDWaWjSNUd62Y8+UZm72URoYE26ATxf3OdEpl3DbZZfd9qJueXg
 ==
X-ME-Sender: <xms:bMSsYNWWx4K7zZOUZnyIzS5z0uNCe4gX4e_Y6j_9hFPZJvmjQkAbyA>
 <xme:bMSsYNmy0AodNTZsM50cPsJ2ysIo86rC9SIJxu2uF2JD5RwSq5deQ5OIcxYdPzDYo
 -mGBeDBZtfJkMEJNq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bMSsYJZ09yBox5hokHxS0K0cxQZCLOKJUfo_j29kM51BdRWzrYge0g>
 <xmx:bMSsYAXURi_GssbkSTkTX_pne958RhRhOquoeW-KLY65ONYDMDA2FQ>
 <xmx:bMSsYHmIhMqVwQGl6FBrDJttHkSzgOJh3W-Fwi6yziF8813X8OHKeA>
 <xmx:bsSsYJuJydhsJUXfxb7fKgfdgGY2uVOCcOoB9hcOxw_4IlJoiVLtJrPm08g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 25 May 2021 05:33:31 -0400 (EDT)
Date: Tue, 25 May 2021 11:33:29 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 01/11] snd: iec958: split status creation and fill
Message-ID: <20210525093329.trltam5mqtvbqkr5@gilmour>
References: <20210507140334.204865-1-maxime@cerno.tech>
 <20210507140334.204865-2-maxime@cerno.tech>
 <s5hbl8ze082.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qxe2w3b6f53vgutz"
Content-Disposition: inline
In-Reply-To: <s5hbl8ze082.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Tim Gover <tim.gover@raspberrypi.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Daniel Vetter <daniel.vetter@intel.com>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Takashi Iwai <tiwai@suse.com>,
 bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 nsaenz@kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Dom Cobley <dom@raspberrypi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
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


--qxe2w3b6f53vgutz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 25, 2021 at 09:33:49AM +0200, Takashi Iwai wrote:
> On Fri, 07 May 2021 16:03:24 +0200,
> Maxime Ripard wrote:
> >=20
> > In some situations, like a codec probe, we need to provide an IEC status
> > default but don't have access to the sampling rate and width yet since
> > no stream has been configured yet.
> >=20
> > Each and every driver has its own default, whereas the core iec958 code
> > also has some buried in the snd_pcm_create_iec958_consumer functions.
> >=20
> > Let's split these functions in two to provide a default that doesn't
> > rely on the sampling rate and width, and another function to fill them
> > when available.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> The changes look almost good, but please use EXPORT_SYMBOL_GPL() for
> newly introduced symbols.

Ack, I'll change it.

> Also, it'd be worth to mention that some bits update are done only for
> the default values; if a rate value has been already set, it won't be
> overridden by this *_fill_*() call, that's the intentional behavior,
> right?

Sorry, I forgot to put a commit log on the patch 2 that implements this.

My intent was to provide a default in the probe, but if it was ever
overridden, we would return it in the control afterwards and pass it
along to the hw_params (and later prepare) hooks

I'll add a commit message

> Last but not least, the subject prefix should be "ALSA:" in general :)

Ok, I'll change it then

Thanks!
Maxime

--qxe2w3b6f53vgutz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKzEaQAKCRDj7w1vZxhR
xX/iAQDyKGU5zZGT0hhjwnnBey03GOnI+zvb2A8SFJmO7NaZvQD9Fo3ynLNkuX+w
ANzO43UIWP4npIS3a391pApWC4R1tAg=
=d5nb
-----END PGP SIGNATURE-----

--qxe2w3b6f53vgutz--
