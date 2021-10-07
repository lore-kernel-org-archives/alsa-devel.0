Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCDC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 18:39:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870B5610EA
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 18:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 870B5610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F77C1661;
	Thu,  7 Oct 2021 20:38:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F77C1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633631946;
	bh=15F2rqynkTNmXCViqkvtCk8OEwqwlTAEmW//wtmZhBk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxUwTQdEvs2hnyCAiV2FCOgP0Q0wJ3OJ2xbDBQWkusBpghx9dyeJn00FqhB0GSn70
	 Olme7tMKIydoVwI78mxMWKy2D16Q+y5Xgs7VSmV3hKBYV7B1dyoAw0/F0KI4an2370
	 9ac6fE1fdzzuv0CyQTYiX2DV2czuRUsDb35hbJ+M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2044F802A0;
	Thu,  7 Oct 2021 20:38:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5332DF804BD; Thu,  7 Oct 2021 20:38:13 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7DBAF800FE
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 20:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7DBAF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DH6fzr+I"
Received: by mail-wr1-x42a.google.com with SMTP id m22so22053625wrb.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2021 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0T4sFmsFD4jLWnAWeMtgvLVvevwwzto8DJfNckqAtjk=;
 b=DH6fzr+IIzvip9zeeAFecwpDyaHALa4B1Oe0c/V/M91O7gttobD0SPdeyjx95lbLJL
 W+XMI7LFo1/Yb718Lz5oI6G+nenZ1v4SAKbLSpheS/IMWMAJMQTrgMSP5oUOm5sLNJVD
 66SXUtnopJLlySa9fWdXU9f06q1GfGykRH4QZezgx1aHDXlRJZORvhUT0p0s0xYOZy0+
 U0NPIQtE818CunbhYVeyd5/Tx9ElijJBBRhACr9dVw0KCU4BGhOLwezRm0pSZtKTm7Sw
 lY/R5JldsmD29j9U8/y1Lf96e9XpYnVNnksLNAE4PKvFr8SVR0AmxV0P6a753XU58SUn
 F8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0T4sFmsFD4jLWnAWeMtgvLVvevwwzto8DJfNckqAtjk=;
 b=2WbeX3kCJsA8Ut39XQLW/OK+V/4sy7Zm68jVBPhslwXV37s1AF7WjHeT36mnbqjUlK
 BgNPY39oB5N0/DtspSRdWW1WniR2le31KXYLBLwrSrRIikvSJRbTlqTfAQKoR2iRl/gD
 y3ttwu4vc/4S3zWGjUCknx5E4Zk6SURQ9Hc3eEAp0XbRqFAnBWZIxGe6ryFYXLYg5/Ho
 QDFO3xtsTcNivk4qwvFK9ENH7ky4aLfNFgEarzS8dVDcLCAYZRKwZspAS0LQP/3QMt+/
 1BxpV5ylzP1Ag7xX/f7bmPd4j6QhLkX4FTwkmVwE2gnXuz/r0kebCOjNb0ckqCBR1R0n
 90mw==
X-Gm-Message-State: AOAM530jopvFurl7LVHzvN89yLLayKZn7iV5InKSzTuVyJA4kXJfhZBe
 1Tr9hxbY7d/A3eJKoSpA7qw=
X-Google-Smtp-Source: ABdhPJzJfuDW9EQbVCHx1gflY1tLjMExzGosRt6WHhIO2MXUwwvJLhDGBqt/htKqf6iSgvJNqqHdww==
X-Received: by 2002:adf:b19b:: with SMTP id q27mr7627454wra.125.1633631882331; 
 Thu, 07 Oct 2021 11:38:02 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id w5sm102868wrq.86.2021.10.07.11.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 11:38:01 -0700 (PDT)
Date: Thu, 7 Oct 2021 20:38:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v2 13/13] arm64: tegra: Extend APE audio support on
 Jetson platforms
Message-ID: <YV8+iNu+BFWtUi0k@orome.fritz.box>
References: <1631551342-25469-1-git-send-email-spujar@nvidia.com>
 <1631551342-25469-14-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WYOR3Bx3yFK/LlLF"
Content-Disposition: inline
In-Reply-To: <1631551342-25469-14-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, catalin.marinas@arm.com, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, sharadg@nvidia.com, will@kernel.org,
 linux-kernel@vger.kernel.org
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


--WYOR3Bx3yFK/LlLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 10:12:21PM +0530, Sameer Pujar wrote:
> Extend APE audio support by adding more audio components such as SFC,
> MVC, AMX, ADX and Mixer. These components can be plugged into an audio
> path and required processing can be done. ASoC audio-graph based sound
> driver is used to facilitate this and thus extend sound bindings as
> well.
>=20
> The components in the path may require different PCM parameters (such
> as sample rate, channels or sample size). Depending on the pre-defined
> audio paths, these can be statically configured with "convert-xxx" DT
> properties in endpoint subnode. The support for the rate and channel
> conversion is already available in generic audio-graph driver. Sample
> size conversion support can be added based on the need in future.
>=20
> The support is extended for following platforms:
>  * Jertson TX1
>  * Jetson Nano
>  * Jetson TX2
>  * Jetson AGX Xavier
>  * Jetson Xavier NX
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 1554 ++++++++++++++=
++++--
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 1493 ++++++++++++++=
+++--
>  .../arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi | 1520 ++++++++++++++=
+++--
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  876 +++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |  876 +++++++++++
>  5 files changed, 5900 insertions(+), 419 deletions(-)

Applied, thanks.

Thierry

--WYOR3Bx3yFK/LlLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfPogACgkQ3SOs138+
s6E0BA//V/eXDLK/uGRMAQbd9X+wxshlGqYWKNNJgBMMyoAm0pmjd9zMOsHzZEZi
0lgEL7Bdy2BvzUF2KG79yQfyggFZPNLG8eGtSmSrbTtJresRXXHO0R75vN071bF7
KFYG4rVvYiucFakXV56UaqesjPUJLWW6Gp9XmTkkyBIA+UA4IpOJHoIxF8NZ4Kb5
37yQfqqweQf9B/eblz699rnZMYlZHKRQh4TXlyav3HiMUOb2JcowF3wLF+nac7mj
6QsV48xa0gFSgMy9k9KeiAmhS4EYEAsGKbxyrf594U6cfLpXgKFhZv4QJ3w3UZHJ
mrY9ktzkjDj2fbOqtQ/U5/pMGBa71IJWgdc1/HZbXcvzxQ9y4A6p3143XFLHdw0z
s7VDJ4teuu4lPaE+LocpWVqXepIUNlvKZzQZOdFMMJSlXOwI+Git+wBT4vS9+tDX
VDMLvjf+0LOhGtw0gPuFxr3GBnWy+3gwakqVnSnCHZoEvdCo49TPbWOA8GUjfOve
YWrFw7Om6iQspODn/uNTrtg47sTonx9+6iITIC/o4Ie3+kZHWqm6OxOz5Bx2hQ7T
dqC2WqbjRCGvYzdAY7fGo+wycz4gGihabgEQ/sjs8J9J/+Pv5Zezwrkda7kc1Al/
jNG5ZgbLb74oHlXwPtQFtF5DuQ1NCYo25GSOevRXj4fDx24vLro=
=B2Sx
-----END PGP SIGNATURE-----

--WYOR3Bx3yFK/LlLF--
