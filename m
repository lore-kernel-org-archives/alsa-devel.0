Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91629C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 12:44:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF2764E57
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF2764E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE8BC1674;
	Tue, 23 Feb 2021 13:43:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE8BC1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614084268;
	bh=31LELFPToKWgefW3AsyR/S/RRSt0j4OXUWYElMSYQLA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUakiOBxcbj6Db7T0+ULDZmLFXLJQKZbPvI+OnO0lYtxWXaEPYUNdAgApqjx03sFh
	 HNXVSGuIuGbp2Io/0KtKFWkQsTM8uCEGVZCOXCrTKt5vXncDeGraDB8MR8RPUmM+OM
	 J5rW+N0gGyvB3JxeJ71eX9eQV8ol8+Ck//tL64R0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F466F80167;
	Tue, 23 Feb 2021 13:43:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF350F8016A; Tue, 23 Feb 2021 13:43:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69436F80167
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 13:43:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69436F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="p9YcRoM3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C93AD64E5C;
 Tue, 23 Feb 2021 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614084212;
 bh=31LELFPToKWgefW3AsyR/S/RRSt0j4OXUWYElMSYQLA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p9YcRoM3c4riBL2cyF817YCjfFPMMWHN9kDdGPyuALB69SHwsryI7X46abdO+GkrG
 EJWiyhOIXnarv0cPHtk7W3Ipx5do/RC0np0UleaWRMCkZrHw3jXfqflIt88PAYKzMV
 0goPIJf0zncK6OrAx2fBo/t+SF0EWJ2p+tK9rXZE2U4vADol2NKN5MQhZJethIDrGu
 apGMlg6r/dC4srVcz0UGu/QjUc7MH8hH9aDnLymW01KZJSTPHs4R4DiewlfIIzQMXd
 YgLiJblNhatgPscz6o11G6HjsmUrRwwec4+USu7lPbJ4+PiB/LZgluZOCGkwLxacLk
 5aivSUfLNQmVA==
Date: Tue, 23 Feb 2021 12:42:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: rt5682: remove jack detect delay
Message-ID: <20210223124230.GA5116@sirena.org.uk>
References: <20210217214914.700751-1-cujomalainey@chromium.org>
 <5b90530b77744937b87bbbd35901e320@realtek.com>
 <s5hr1ld22a9.wl-tiwai@suse.de>
 <CAOReqxibmAQNQe8PuHkUSW5Kb2L986X9DDqia-aN=ZrS8VJysA@mail.gmail.com>
 <20210222134551.GC6127@sirena.org.uk>
 <CAOReqxhRi9n-vxayVDNp-9R65s79OAqX8=YweCddFHTDJbbjGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <CAOReqxhRi9n-vxayVDNp-9R65s79OAqX8=YweCddFHTDJbbjGw@mail.gmail.com>
X-Cookie: Kilroe hic erat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 Curtis Malainey <cujomalainey@chromium.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2021 at 10:59:34AM -0800, Curtis Malainey wrote:

> if inserted && buttonAction
>   respond now
> else
>   run workqueue

Are you sure that *zero* debounce is needed for the button presses?
250ms does look like a lot of time but zero might be going from one
extreme to the other.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA0+DYACgkQJNaLcl1U
h9DUggf9GcwGwUyyj+fTARiq8sUBkYRUK0wyokI96F3gga2qOn3na6HJg5zMb0in
zMpi+IzzBL+UgmEdLSRYYxpv1AUf95QZFOtlBKSrsn7nT6XgtUQKXK2au3YaxEKe
Flc7SN9afrcYaNs7S13xENcc/hN9lKjrWkKOztFTRXMPlWeVEzoM+XASUaIFmSdd
Z/n/49w3QN75zL/hesg4RqispERSru00HKWIpXFrAXZZ7aPlmGvqSUHe6hOv8IjG
mT5vJz1U0OTchBlE5NCtCjxKAsdO6ElnaZiHgDsRWW63XHj+7MVM+cuf3lqJrPX+
lxyVPjctlUNPXU0UhawqN4bQ3+G/dQ==
=SRRI
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
