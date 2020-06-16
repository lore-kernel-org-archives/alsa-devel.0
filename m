Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C8C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:34:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD76208D5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CpLQwuMu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="klCom9v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD76208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CBF9886;
	Tue, 16 Jun 2020 20:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CBF9886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592332459;
	bh=T5lT9kWL1+5XoYspMvqDXRAJi69PKCHG+eu2XIHeo8E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpLQwuMuzvr4C1TDHK38mfqCnkgs5BoGIUEIlcLyzNpCK4/RMoXfQ+aZVhr+nJJJW
	 ImF1Yq2jdg2KffsDgmYSjilw6jDNatQXn5ODvuLpy4bP9tlLYqZpyfXgoiB74/0DJm
	 2CT0RUcQIL3fkyyDEYkgrZ4irpXfD3/WI/r2Giuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E2EAF80217;
	Tue, 16 Jun 2020 20:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EC73F8022B; Tue, 16 Jun 2020 20:33:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC5EEF80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 20:33:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC5EEF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="klCom9v2"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD8F9208D5;
 Tue, 16 Jun 2020 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592332401;
 bh=T5lT9kWL1+5XoYspMvqDXRAJi69PKCHG+eu2XIHeo8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=klCom9v2icWhWrWU1Ztb6psrEGGQw4kopyXhtC5s/KeJzERv6F6cx//cxW4b8MTQM
 oRfr/ikNKd8Nso8qlmmU5PILvp5o8tEzVeTn/4rj8gMoIR3nZDwbkw39ttb/RgC/RM
 aZu3fvLVxyCLrAmF11j7GrYv2ayDSXR8wBgy64Vg=
Date: Tue, 16 Jun 2020 19:33:19 +0100
From: Mark Brown <broonie@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
Message-ID: <20200616183318.GW4447@sirena.org.uk>
References: <20200616063417.110263-1-john.stultz@linaro.org>
 <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
 <CALAqxLXnijNBB4HBqLG4k679FRcHT8hjSLMnpjE_+0UkqU7Y0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oDAD4Gb5rN9RYJiP"
Content-Disposition: inline
In-Reply-To: <CALAqxLXnijNBB4HBqLG4k679FRcHT8hjSLMnpjE_+0UkqU7Y0w@mail.gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, lkml <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rohit kumar <rohitkr@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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


--oDAD4Gb5rN9RYJiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 11:01:02AM -0700, John Stultz wrote:
> On Tue, Jun 16, 2020 at 1:25 AM Srinivas Kandagatla

> > > +     select SND_SOC_CROS_EC_CODEC if CROS_EC

> > Isn't "imply SND_SOC_CROS_EC_CODEC" better option here?

> I've honestly not gotten my head around "imply", so I'll have to take
> a closer look.
> What I have in this patch least is easier to compare and match with
> the existing code. :)

It's a conditional select which enables a Kconfig symbol if its
dependencies are enabled rather than forcing it on regardless of them,
avoiding most of the errors that select tends to introduce with missing
dependencies.

--oDAD4Gb5rN9RYJiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7pEG4ACgkQJNaLcl1U
h9A83gf/Wj+ilOQgoTPb2UGpwDK580vgreUDhkyI/tLuWCYjrCNHUE8QVY9gKbvz
WV1cDOsr+wHc5cv7kja0mYMyRfvuu+coZkSVv73R8SWXyFYu8sX5WGK74GobfsJB
1MxXEDMBz/WvXhdGITWeCzI0VgTWBUc7frTbx/EluN+nJOp1v+ogdpAjtO887vSP
JoiUfYiPXNUMMOxGEa1JTkRpirVFOr+FvH8JV8EvYF61RHJTZq/t3+7VIPYV7Zao
cdsNhNpvQm6tnfzaTrJA+nVEdr1vltAAT6tebOsGhrsXWQTfsQcif/jH7Me9h5EU
D+li1k5pHnpAfeHhp3rzPVpAhUjXVg==
=Xj+F
-----END PGP SIGNATURE-----

--oDAD4Gb5rN9RYJiP--
