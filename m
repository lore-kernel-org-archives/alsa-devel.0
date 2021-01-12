Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4918BC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:44:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB123120
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB123120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64E4B16B3;
	Tue, 12 Jan 2021 18:43:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64E4B16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610473439;
	bh=uRhf+TyHSUoTrYHgBqCcfnTsojVy5pcXeF1jpS9l8Bw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tsy0wDT4nJs0/s84hNsvrJ29haDRmSMeUfSWfxG7FAo70OTwmI3gh2U0nESTfPG0x
	 0U3Yzy34Sxvc1CVGQxEtjQENoZqHB3iKhHajdyMriuqt0Qidl25Wzm5e2o8S90yBmJ
	 oHaBTdips1insFxfS3uaW3PiiuncmYSfs0cXyAUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1ECDF80249;
	Tue, 12 Jan 2021 18:43:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD4B6F8025E; Tue, 12 Jan 2021 18:43:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7303F800EB;
 Tue, 12 Jan 2021 18:43:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7303F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hyj3L8NC"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3F522CBE;
 Tue, 12 Jan 2021 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610473379;
 bh=uRhf+TyHSUoTrYHgBqCcfnTsojVy5pcXeF1jpS9l8Bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hyj3L8NCapEXo78clX79jgQrOT7NcEmuR2dIJo76NmnLL/T9ULPBis0FzLyml51Bb
 IMne3UeANbCG20cmSTWB3QO1fmd6PRPLAXdZZnSSWkPzJt79YJGkDRZXt+8zPc2HHI
 oy0sVEE0w3MIRUQfIzdWBW5mUSaWZiVuItiAqSrYmr0BF3f8OnajFHLeaXsf7blr47
 kK0laLCcWELLE0ss1WVQenuhx1kf5gu7IWqKeXCk0GXxVZXbIlYsdzfu2pJVf9X9Q7
 vznTVH3x071DCtR6JwJV+s1CrcFm0va4QWV3J4P7ePos+MK31zeBz0k6qkWT7Hm4ac
 CtbOfUXpN9d5Q==
Date: Tue, 12 Jan 2021 17:42:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3 4/4] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
Message-ID: <20210112174226.GE4646@sirena.org.uk>
References: <20210112130704.1201406-1-kai.heng.feng@canonical.com>
 <20210112130704.1201406-4-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20210112130704.1201406-4-kai.heng.feng@canonical.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, pierre-louis.bossart@linux.intel.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marcin Rajwa <marcin.rajwa@linux.intel.com>, kai.vehmanen@linux.intel.com,
 open list <linux-kernel@vger.kernel.org>, tiwai@suse.com,
 Keyon Jie <yang.jie@linux.intel.com>, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>, daniel.baluta@nxp.com,
 "moderated list:SOUND - SOUND OPEN FIRMWARE \(SOF\) DRIVERS"
 <sound-open-firmware@alsa-project.org>
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


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 09:07:02PM +0800, Kai-Heng Feng wrote:
> Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> ---
> v3:

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/934EACgkQJNaLcl1U
h9DIiQf+PEUEqixskXVBjQpJev0kl6hdig9NTAKEFz/lDG4aMfUV/OsX7La50jX9
vxA05lQ0oWIDIT454uC5suBZVRSkF0JNl7ME9wXDx56sXOS1EGCcGOCBsmB3WHGV
43vW6kPn6IRBSdbrAwW7bhWJ3f4SMXd7gK9xpW/xfaVsGB5m1VymZsBX+86/o+P+
EKdDKm5EyH7pVbUjEeP0p9tePpiJ/qP1Zrjc9R7v4PwOLN+D5rCiUm+ABoHWwGBj
ZAB4o0c4FG/wbP2mQb0tS7D1Q3jUGAXwoB++Vp/4mjatkf0VkWPEMLyLH66dU8rq
ryR5H/wp6fBH7cwZrS1ZtaQfhEFGqQ==
=bkh0
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
