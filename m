Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B53C4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:34:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6151F223AB
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g2guWcv1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSTvQ9Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6151F223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1F3816CB;
	Mon, 26 Oct 2020 13:33:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1F3816CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603715668;
	bh=4SFrOofkbOuHq20J4eNmo7bqNQONigwBpTqFe+QuLaU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g2guWcv1/oP7ewX6N7Z4tkSMbJ5o/M6ksZRcY0TBiGnanarsRioc2V0q4U2yJBERr
	 QF/HBVEAU6bTOnrzfqNT+2nOWo+cnWZbbF5KJUj3Yk5xeKQOJEz/uA7qLMjiVc0v4s
	 C05j4vzbG0L3U0DLQ5R2rs3fpiXR+QKGIlETNzbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27DCDF801D8;
	Mon, 26 Oct 2020 13:33:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F3B4F80212; Mon, 26 Oct 2020 13:33:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AEBEF80086
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 13:33:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AEBEF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MSTvQ9Jg"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3801E223AB;
 Mon, 26 Oct 2020 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603715609;
 bh=4SFrOofkbOuHq20J4eNmo7bqNQONigwBpTqFe+QuLaU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MSTvQ9JgDU4E266eDtnpE8fF00rqLD5a/zR06pFR74pkcYrVT49BHkMKe6c3hBZ/Y
 pl1wiSQKrZux5zzJ8W8cjqWoWJQ4RPXGOqeM+tlMindjzcY/6jLJm+zfLlf9D+RdsU
 z+hJjyvLO00Pf9ZfTwtTiuUnnzWjC1QQgY/+0THY=
Date: Mon, 26 Oct 2020 12:33:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: mt6359: skip first time data at the beginning
 of DMIC recording
Message-ID: <20201026123325.GC7402@sirena.org.uk>
References: <1603521686-13036-1-git-send-email-jiaxin.yu@mediatek.com>
 <1603521686-13036-2-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <1603521686-13036-2-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, tiwai@suse.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2020 at 02:41:25PM +0800, Jiaxin Yu wrote:
> We can choose to drop away any length of data from the beginning according
> to project needs. Some projects don't want to throw away any data, because
> they want to use recorded data to do echo cancellation, so they have to
> make sure that they are aligned with the reference data as much as
> possible. Or there are other algorithms in the upper layer to eliminate
> this noise. Or some projects want to eliminate this noise form the kernel
> layer. However, the minimum recommended value is 50ms to skip pop noise.

This seems like something that would apply equally to all DMICs so
should be done at a more general level rather than in this specific
driver, for example it could be done in the DMIC driver.

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+WwhQACgkQJNaLcl1U
h9AEVQf+KDjMkz85oAAg0VSQQiu0FRenOToPtwGoQnRHHFP4/5pWNlo/BFTRsPwW
Ws/YQ+VVaEd4tRYjkiwwyl6wTG4YHhuYotHDt8ytKVlsmOAiiL7t4FD0OXbW4LFc
zhJT6TTQ8hLXystWPFnD0ls22uWoH8PvKIMZhLO61kb39D6zMYUiHZBCBeeUzpdE
KlcnnCYNa5KQ/NLKDQJyRDLbQdTkkA+B+Tg2K6NF/iuV3AX8wd6FJjEdsjRhJHHW
gUAnKtK9vcPNNfY388XcSXJwhllb6DvWRQf0RvF4+IYVO9Hb/2Tjpuk4DcKCN/xV
+ODyoEfWbZqBWEjcTOePJ969+sAiyA==
=a14I
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
