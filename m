Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789CDC4332E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D9564E76
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D9564E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BDC0950;
	Mon, 22 Feb 2021 14:47:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BDC0950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614001728;
	bh=XCrkV1b4eW72wlwlFGJM+fGMWXYsc1qnWdLhx0MpYXA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NubR9X7GGTvFcXUXeE94nqoJDgbS+h2bCbwctP4jdyj3r+/FC0BXyJUJwH/23VqyN
	 v1BLeH8rEBC3CC4dQvPBgenkJsha17pE2Tt0+XFUyWous40pIIOuRYl1sKr/vOW2GM
	 wJkiXeQi9IoXqKPM2Lc8sdIrxxF+ANOV4jJ+tEec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14901F80279;
	Mon, 22 Feb 2021 14:47:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E305F8027C; Mon, 22 Feb 2021 14:47:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F483F80129
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 14:47:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F483F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MRbFZS3O"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CC5E64E5C;
 Mon, 22 Feb 2021 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614001671;
 bh=XCrkV1b4eW72wlwlFGJM+fGMWXYsc1qnWdLhx0MpYXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MRbFZS3OzDUIDA+H5IZtI3RLtcop6I2kCgE8NHwvesNuNTcxgFWAlnvExVji+Girz
 qTrlBNa2NslOXgqEQNL9JiyAaiyfZpZNel8U8+7MtljhsXM4DHZPZr6H32QRnLTbs6
 L+R9SGvOpmZlHPtVbS07qYjuThmsLXhc0duuZ/lFL9bxKR5aX7lYo1cwu3H+eaY9ZL
 iQY+/oulgHQRZa6O5vElhThVZSwgXjOuoB091GAcDvu50eJba1/JIYHRBtWmBaO8v9
 GyBJu2jqHDGtSvxzmEwiqYLMZ1fzeJgQAlck0TpXkHcx6R38yamNKmiXqbDHRjw1Q/
 mi9ZPSUOXRCFQ==
Date: Mon, 22 Feb 2021 13:46:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210222134650.GD6127@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
 <20210209222953.GF4916@sirena.org.uk>
 <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
 <20210210153808.GB4748@sirena.org.uk>
 <CAA+D8ANdqd2W6xvwFuuk=YqUGCfuXCFzwO7tkhuGwzPRgA_A4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANdqd2W6xvwFuuk=YqUGCfuXCFzwO7tkhuGwzPRgA_A4g@mail.gmail.com>
X-Cookie: A motion to adjourn is always in order.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 18, 2021 at 03:57:11PM +0800, Shengjiu Wang wrote:

> Can I add a flag:
> "rpmsg->mclk_streams & BIT(substream->stream)"
> for avoiding multiple calls of hw_params function before enabling
> clock?

Yes, if you do local refcounting that'd avoid the issue.

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAztckACgkQJNaLcl1U
h9B2Ygf+N5kwNgpqApDIfReFqtqLtqQXDeHRtyJUp2Mw/FBKGxRIZtSpFboDMi5J
VXujKz7xY9csIA8KyCOStwamXxGesJy0uWUdrjX1Et/X4YYUXtDc+F6hUB1zaB7v
6xEPPINxm87gd/m1j2qeCKA8yVqdLLuZRBLIYvhzr5xzZhN5q5brqie2sHaxjysF
GeuG0uiWiLDUn/+KJAN1MNnnk3zrGR6oD8C8ZL1IZhT10oxYuK8M/wxlWMXC0JbE
fxxUD9Aau8k0ezS5VQquzWRTjZAC4utv/F4N6DBK1FCv3My0aM69mL4BL5a0mUji
tAkM5F9xNM+F83iGENlGypDkiCgd8g==
=kbni
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
