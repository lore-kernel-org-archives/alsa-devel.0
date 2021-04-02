Return-Path: <SRS0=kQrV=I7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A11C43460
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 15:24:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005B261155
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 15:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005B261155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E45CE16BB;
	Fri,  2 Apr 2021 17:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E45CE16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617377081;
	bh=DBl2fwgcPxtK+wafl3e+AoDL7rHOuEM2EySnkBrXa18=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Po5VlsOcJSvZ0o+92P9uh6oV2UWh40rpBuS5A0LzhYDhpB+8f1MSWaVCnyFDUEnzp
	 qbBeex7dwiNRdDSEKdLyMsgCVVcQO1UY7tIM1p3BPFfsu3acuv5xKc2wDo5ySHWxGy
	 GJ22nuLxpA0dhWg+lBHaBXXuFWGi2KitiZ1g7NSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10F16F8016E;
	Fri,  2 Apr 2021 17:23:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C347AF801DB; Fri,  2 Apr 2021 17:23:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DF09F800F5
 for <alsa-devel@alsa-project.org>; Fri,  2 Apr 2021 17:23:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DF09F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VPHheqi7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B25EA61155;
 Fri,  2 Apr 2021 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617377020;
 bh=DBl2fwgcPxtK+wafl3e+AoDL7rHOuEM2EySnkBrXa18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VPHheqi7hj3Ky8QYaqiooCBeHfhVgOjQY8lrW17v6d/dx8LvnHkXrGNy79Wk23aXo
 ZbF9qnFOiimlWJiraE/MBhv/zSETlFdwGFkTYo//bBlpqRyK0IkhCtw9GlsXvlUh9k
 G9tBnGR1v4ZYMboX8Vg2HtA3O7rJ6Sr9/sd3YnWMynN9Chu+WjkVZJFubFydCk19tm
 0M0MUxD1sZmWYJHqzgOgCNrlxMcrCgkEqe4eQf+yW2hBk1G28ukNKp399u3uw9OpB6
 8xWVRnT+ezrfSVWRl8L+FQBdQd1liiWA0Z8s5iqtC6AA4qF63K60Saz6JukrcpFfhb
 MaWv53xYkTkIg==
Date: Fri, 2 Apr 2021 16:23:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [PATCH] ASoC: max98390: Add controls for tx path
Message-ID: <20210402152326.GA5402@sirena.org.uk>
References: <20210402033643.12259-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20210402033643.12259-1-steves.lee@maximintegrated.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
 ckeepax@opensource.cirrus.com, steves.lee.maxim@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, krzk@kernel.org,
 lgirdwood@gmail.com, nuno.sa@analog.com, geert@linux-m68k.org, dmurphy@ti.com,
 shumingf@realtek.com, rf@opensource.wolfsonmicro.com
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


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 02, 2021 at 12:36:43PM +0900, Steve Lee wrote:

> +	SOC_SINGLE("Tx Enable Selection", MAX98390_PCM_TX_EN_A,
> +		0, 255, 0),

I'm not clear what this is (especially given the source selection below)
but it looks like it should be a mute control?

> +	SOC_SINGLE("Tx Hiz Selection", MAX98390_PCM_TX_HIZ_CTRL_A,
> +		0, 255, 0),

This I'd expect to be tied into machine driver configuration, either DT
properties or TDM slot configuration - it's not something that looks
like it's something you'd want to control at runtime.

> +	SOC_SINGLE("Tx Source Selection", MAX98390_PCM_CH_SRC_2,
> +		0, 255, 0),

This looks like it should be a DAPM control or possibly a TDM slot
configuration - look at how the Arizona devices handle routing from
multiple TDM slots for the DAPM version.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnNu4ACgkQJNaLcl1U
h9AcQAf9HFJYiEd0KVxqnDJ5nyLgUXBD7W2RjBQ7MMluKeti3cwsaSiFHs90efQt
7wTHZWUbEl1V3FdBv1u/xe8yyCkrEBFUt5IRKh2HUcvvM7izZrfzl+Pfe3uz3G5j
+V7545xbUvIUsgMTDAGTdCjTZrjVvATyXYLNiZZKzFqrEUrT5fEWrKfoSnfO3EQG
EHC5FDmzGz8jUWOjdUo6FkFXegsLJC2pm66jmSrT4pyVGQe71cePh2O03/Ok9uU5
U5TTpQgqekU80WyOVAuJPoPiJAi1Xr/vV9H9LSlwxazeINQZDHYJhyqOhLzBtjYg
K1XFzhEKIAHt6p61no1KcnWVk9ECEw==
=k78j
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
