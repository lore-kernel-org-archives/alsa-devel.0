Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1586AC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 16:32:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A95E1868;
	Mon, 28 Mar 2022 18:32:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A95E1868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648485174;
	bh=hK7ZDdgQaPjqOYen8B81+Sjmp3Ahshxy0heHpeX2Ado=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p185/1GWe1t3xvX4HrwiHvEQHfHNgqx5Lmj2yR5tGhtJXR33qqptEvmSu9oqPArkx
	 HbyrDhE+UUKfF5NRy6NcrHIlLfXqD0kQVVPdkvHkyX3yuJFVw8gFvXk7sTA6yfRr+E
	 5Uf5UctaqY/G1RHSHMdxTwCaasEjiDdgzhppmWM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7090F80128;
	Mon, 28 Mar 2022 18:32:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63ABFF800FA; Mon, 28 Mar 2022 18:32:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 025BBF800FA
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 18:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 025BBF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V64A7qzb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DA0AF6147A;
 Mon, 28 Mar 2022 16:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D239C004DD;
 Mon, 28 Mar 2022 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648485117;
 bh=hK7ZDdgQaPjqOYen8B81+Sjmp3Ahshxy0heHpeX2Ado=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V64A7qzbboy0p+y9aBTjLc241GMoRliUriJxyNrw6yB/jmVHADwXP4GoWMZOiZVey
 fSVW6+r6DFMiNbPdvBTPox/Ah4BTa8+qYvJi1ghnduc9HW1EnDo37W4hDT+X9HbAKp
 nhvU1oQhmiwdiOGgkZXxGOMyoelYavWmr8AI57qTYbwi1lEdXsUAc3kQ/yoWrV+RO8
 4YmZ/i4hfuEZcxWmuZ4ZW/bYCinDrRi/oLomJ56HpbbGFyCAJmvSLy0Pr+jSmQR3Yw
 NazZK5zP/Ga/fRV6B7z7EwI5hc6ahI+UjFP4be+aQapGo+bbSzrRPEt9ckM+CeQrHr
 7/1QGw/bgTLhA==
Date: Mon, 28 Mar 2022 17:31:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: Re: [PATCH] soc: soc-dapm: fix two incorrect uses of list iterator
Message-ID: <YkHi98GDDWNie7GP@sirena.org.uk>
References: <20220327082138.13696-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U/jhfLnga9E37WzA"
Content-Disposition: inline
In-Reply-To: <20220327082138.13696-1-xiam0nd.tong@gmail.com>
X-Cookie: What hath Bob wrought?
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, tiwai@suse.com
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


--U/jhfLnga9E37WzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 27, 2022 at 04:21:38PM +0800, Xiaomeng Tong wrote:

>  		case snd_soc_dapm_pre:
> -			if (!w->event)
> +			if (!w->event) {
>  				list_for_each_entry_safe_continue(w, n, list,
>  								  power_list);
> +				break;
> +			}

This doesn't make much sense.  The intent here seems to clearly be to
continue; the loop but this doesn't do that - instead it appears that
continue doesn't actually do the equivalent of a continue but rather
skips over an entry.  This should instead be replaced with a plain
continue statement.

THe naming of _continue() needs fixing I think - it's just asking to be
a bug.  Fortunately there's very few users.

--U/jhfLnga9E37WzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJB4vYACgkQJNaLcl1U
h9CKuAf+J7JMfNycivcp5VxSUAzxAbiMWBbMwaM201sPHiXMYm9MwDk+lxEQ6yzi
jhSvB1tSNDLp4rHftobH7ShFTed4UOx/RhLShGKJPPJo3l1sfpvZYRdYdS1KGbTm
kjGx8Q4RaC6LyJjsZw8VGEvsf6lC/cJRP8MGMuTo7fN5OW8U5l8YpK9w53xaaIgo
D9f4ah5tKdO4zwpXNrYvk5U6wKjkPT9qXM6MBarcJrWuoEn16JY36o8kcCvLr2PH
xZnlW44J91Kgd/AQuUxl0wM2g5Wde5Pbk0QrlVJCrBwfIhnA0ql5RFezuS+sSZ/w
7JuLdDfkWs7g9P1i+AH1hcRZ/1BNVQ==
=Y449
-----END PGP SIGNATURE-----

--U/jhfLnga9E37WzA--
