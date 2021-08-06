Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B388AC4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 11:04:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB0661181
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 11:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CB0661181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDD5E16DA;
	Fri,  6 Aug 2021 13:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDD5E16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628247859;
	bh=20NfF3J9cl225zcEu0KJHGyDeyhbZp7+OrKXj20E938=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oXaO7o4Br4240p6qsOFAQbY7QO9Ggfct53qnNhO/9xcYQCcBjw1FWBYrvt5BLshIi
	 FXf3dL8BZUwnwCOxR8+iupA695rKawTr0Wi9ROQwbC/jlaiZSfw24rJbob3r4J96o1
	 GdbEYXXidGjFNXRaqqqCbzjtbryTHHUXpm/1p1ZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71B9BF80169;
	Fri,  6 Aug 2021 13:03:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6527F8025F; Fri,  6 Aug 2021 13:03:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E8F8F80169
 for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2021 13:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E8F8F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hzmXTg6b"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E59761184;
 Fri,  6 Aug 2021 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628247797;
 bh=20NfF3J9cl225zcEu0KJHGyDeyhbZp7+OrKXj20E938=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hzmXTg6bqsJf90YQnaimWLVaXTfXj8zag1L7nAopdECFMW8Uv/qcv3hhm2wQxPcUs
 nrWNCvcP4u3VgEsLiu1Z6niaWPPutPz8fLrJI5ta0L3UdIIkGlaB+QygWSQG44ZS2r
 nwtZbSsqPz8D5CDP5MhwEmd1AFivWjAN0NtfaSHoAFQal7viQqtFkO9/E7Ecieffkr
 PdsuA+H9837AtRN7Xhqc7uScVjXxDuLKpsSm43aJsDaYMnta+WJQR7bjMOs9tx71WW
 h4lXxsGvWILQfN4MPQHxNCjKc0UbKCtjNGke2LYP12IRcLZFVWxK5azak7BmeCi7bl
 huG9TpaUaJaaQ==
Date: Fri, 6 Aug 2021 12:03:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [PATCH] ASoC: max98390: Add support change dsm param name
Message-ID: <20210806110301.GW26252@sirena.org.uk>
References: <20210806080834.16705-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="js+/jT5SQQin5+Fm"
Content-Disposition: inline
In-Reply-To: <20210806080834.16705-1-steves.lee@maximintegrated.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
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


--js+/jT5SQQin5+Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 06, 2021 at 05:08:34PM +0900, Steve Lee wrote:

>  	ret = request_firmware(&fw, filename, component->dev);
>  	if (ret) {
> -		ret = request_firmware(&fw, "dsm_param.bin", component->dev);
> +		ret = request_firmware(&fw, "dsmparam.bin", component->dev);

This will break anything using dsm_param.bin as the default - why make
the change?

--js+/jT5SQQin5+Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmENFuQACgkQJNaLcl1U
h9BXGwf/YRMSJCh7uD1Bjn/x2m3TeF4LisjMz7+rn7cYD3tdHoKsH8QpSkO69E/P
WSRXZMZqySN9e4FacYFYVlqEjOGoprB+gGpay3eL10Vj3Y8YUNfKA+x6a3WMnCDD
6KTLXtUABhKgYaeZvttmNjskXCfrDr0G6D+fS/qGXkjjfqiGnATUmetKf9hVMrdC
9Rb4JAdy8yvqWdo4c2zrx6To5Hy1CWtbISGDRDxy09Ik3YQuqN+tJ5C4j7lzQDP/
m8e2twJbchuvk39gcSYTGG7pBV+bOluinVhp1H20hzHC7cL0lSWqgNMpt8BItk+o
VmPRHBf/aJE4SvghbRHd/RoBbbqF7w==
=mdVv
-----END PGP SIGNATURE-----

--js+/jT5SQQin5+Fm--
