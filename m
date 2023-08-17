Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DDAC677C4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 21:48:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2445282A;
	Thu, 17 Aug 2023 23:47:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2445282A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692308925;
	bh=gsNe6gnzQS0toMdZ48Bf0J5sR22EC9oQMgXox/HSGLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mgqMlr/Cp/pMEIoXc2/fSnIei/dEJZKajC3HIRBS45RHGjulaYjwTsVd7TSQShncd
	 eNATh0vaftFKHAxRD2wte1MQqJk8K0vBmeIVzk+HQjIwET4Fnq1B8T+xUqg5iv0D8u
	 JrCJvTT0/2xtxMuPP56QfzijVsCspsgm366MHHiI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26F57F80536; Thu, 17 Aug 2023 23:47:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AD6ABF801EB;
	Thu, 17 Aug 2023 23:47:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D706F801EB; Thu, 17 Aug 2023 23:47:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C8F1F80027
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 23:47:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C8F1F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EysGIT/C
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A5D6461AC3;
	Thu, 17 Aug 2023 21:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15764C433C7;
	Thu, 17 Aug 2023 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692308830;
	bh=gsNe6gnzQS0toMdZ48Bf0J5sR22EC9oQMgXox/HSGLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EysGIT/C9dpJYFqDFBnWgNGW+ErovFcFEDdakdCPhGGNGXZWPUC7DNU61dypmoXmq
	 1wBASdTGyxhk6qX6yC66W/TJPjRs8DIq0TZLJ+T+WWL9Mwrkq+Uu+ql+hzb03gF3Ut
	 IBGsAxVJCyiOFQ7gH69i9VSUdkxUUPPTfXS8zfIyJOErU3q2bcB/60Wxl+G/H5j8wD
	 4q0N2ZI2H/ZbqUbrO3YASq/PheXQGsQxVTWwZqtRjXrM5YHmg5zivEiAcERMr4RNdZ
	 quij9NT4/Kr/KsqFK5W7ucofA74UJnuONqlol0TYCLhVhUQsi8EXguEpV9zFCQbtfh
	 EyuF4f95tvzMA==
Date: Thu, 17 Aug 2023 22:47:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Marian Postevca <posteuca@mutex.one>
Cc: =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
	yangxiaohua <yangxiaohua@everest-semi.com>,
	Zhu Ning <zhuning@everest-semi.com>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <d2be9183-87fd-4cc4-a239-9401b5b88364@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
 <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one>
 <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one>
 <ZCRCqJ7oG6oefo9g@sirena.org.uk>
 <87zg2pxtog.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3AvIH1ovbTbGKWEG"
Content-Disposition: inline
In-Reply-To: <87zg2pxtog.fsf@mutex.one>
X-Cookie: Walk softly and carry a BFG-9000.
Message-ID-Hash: 5LRJCKZMPLKF3UAWMCPR5W6R7VWWK5YN
X-Message-ID-Hash: 5LRJCKZMPLKF3UAWMCPR5W6R7VWWK5YN
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5LRJCKZMPLKF3UAWMCPR5W6R7VWWK5YN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--3AvIH1ovbTbGKWEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 12:09:19AM +0300, Marian Postevca wrote:

> Sorry for taking so long to look into this.

You didn't quote any context here so it's not 100% clear what "this"
is...

> I think I understand why sound doesn't work if suspending with
> headphones inserted.
> When the jack is inserted, function
> es8316_enable_micbias_for_mic_gnd_short_detect() is called and 3 pins
> are enabled: Bias, Analog power, Mic Bias.

> Since these 3 are supplies, the loop for_each_card_widgets() in
> dapm_power_widgets() will always force the target_bias_level to be
> SND_SOC_BIAS_STANDBY. So the codec component will never enter
> SND_SOC_BIAS_OFF bias level.

> When a suspend happens (with the headphones inserted) in
> snd_soc_suspend(), in the for_each_rtd_components() loop, since the
> bias level is SND_SOC_BIAS_STANDBY and dapm->idle_bias_off is true the
> codec's suspend/resume functions are not called. Because of this the
> codec stops running correctly.

This is saying that the machine driver should disable jack detection
over suspend and restart it during resume.  The machine driver should
suspend before the rest of the card which should mean that the CODEC
gets powered off then.  The core can't tell if jack detection is
supposed to work over suspend, it is a standard wake event on systems
like phones, but it sounds like on this system the power gets removed
=66rom the device so that can't work.

> Now I'm not sure what a proper fix would be. Enabling idle_bias_on in
> struct snd_soc_component_driver fixes this issue. Would enabling
> this option have any unwanted side effects?

I don't understand why that would be expected to help?  The main effect
of keeping the bias on all the time would be to consume more power.

--3AvIH1ovbTbGKWEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTelVgACgkQJNaLcl1U
h9Bw8wf+MauxV26aafzBvhuDABYFfSop1uDoa5yA/ivzvxo8gBnRiffi2/VumZwp
9JziZ47jAF/RAwTAE7ZiO609XsH4a5zn/9yKDhWDIi+ngPV1otc6Yslcw8+dmUgb
Lv1JYoQv5wLSEQOlEqW52aVOU/R005bgxeO0McZlkR6QqftLrqcZyoz3mj5HT27b
IoZbofK/UP7t0sWW1St5Ho461AXsqpB/wPz13PNdHX0rlEfJiStXRPr8YqRy8UfH
1UxQKDUMRHiEKyUmYT1kK2xjdfrRxwDHz6dMp/5AH3glXPfz7i3sSZ/LKlEYFh45
BnzoHaIxTDIhp2BQatUDU8JYd5gU2Q==
=Gk3p
-----END PGP SIGNATURE-----

--3AvIH1ovbTbGKWEG--
