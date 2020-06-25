Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E9CC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:23:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567502076E
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u3CBHvDm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zofvMJ0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567502076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D27EE18D3;
	Thu, 25 Jun 2020 15:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D27EE18D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593091420;
	bh=cIzv8OnHFNTKvxIVCOIG+Sw1VodfcxfOwam7r6nyET8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u3CBHvDmeJkGD9dcK/cRsQecM5O1W0fzsQ6XpbTw78Uqs+MJFZd/1C072UVgcQzRb
	 Yf1x04BRc2OVICjB1h5OEavGleTOeDqiOS23Wrbx9nPihcjxFfjgZ6hfTim3JGcKyU
	 3vu3WWHQxwRpjZedQitAtA+Gh4XzeqGyJafFvypo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 687D3F80218;
	Thu, 25 Jun 2020 15:22:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F325F80234; Thu, 25 Jun 2020 15:22:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63E45F80158
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 15:22:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63E45F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zofvMJ0/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7865B2076E;
 Thu, 25 Jun 2020 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593091363;
 bh=cIzv8OnHFNTKvxIVCOIG+Sw1VodfcxfOwam7r6nyET8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zofvMJ0/urdqt5QkTpvKigt6XBmAL/dcdpZc5gHhwJhNAvf75JlG5uLkLe8BiZHXC
 zMj7VbDad/YjctkKZnuAyF4k6BL59L8SLoEST5MTIDNRjnfPrG5DauvPA+va6Paxkh
 HTR21IZ970v8rMyHYFsAziYkJP4Cm+U2oqgrD1Mk=
Date: Thu, 25 Jun 2020 14:22:40 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V3] ASoC: amd: add logic to check dmic hardware runtime
Message-ID: <20200625132240.GC5686@sirena.org.uk>
References: <1593025336-21482-1-git-send-email-Vijendar.Mukunda@amd.com>
 <94c72bc7-6448-6d6f-d59d-4d6b30d20107@perex.cz>
 <20200625111142.GA5686@sirena.org.uk>
 <4c17afc2-cfaf-3d10-ffef-cc59747fe8c6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <4c17afc2-cfaf-3d10-ffef-cc59747fe8c6@amd.com>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexander.Deucher@amd.com, hui.wang@canonical.com,
 alsa-devel@alsa-project.org, Virendra-Pratap.Arya@amd.com
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


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 05:32:33PM +0530, Mukunda,Vijendar wrote:

> Next time onwards, i will make sure using maintainer list for posting new
> patch.

Please send me this patch as well if you want me to review it.

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl70pR8ACgkQJNaLcl1U
h9DWcAf/WfCHrmU/g5g+eXDBt+NBftuSMz2BIyWrCvn3C8Oh+Lr0+EXb1DTqzUuw
12LuTJeeiFM8tgKUX092N6tRgK8j/dnHpMwF7jGsvkSrWfyL389tV/OgNVCdi3Tu
3EWJy3EeaMx5FcN7BZMNYHueoALwvVlXLGGbYeZszyk4crjbURhyP2J85VgENtdP
wjTILG/LsnhvLhLZDKhSCvYQzAHISff+0att5XCBcM26f1YcidhhEtpAIBrWehHy
+irhDQBp8uLxcckkm0Li5OezqEotNG9OLZE3wMO86C38C2FcIgeAgTd4zSnSzBRI
LanBbGiN1IB+KhuQQ2SjbOcPRpftUA==
=yqoS
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
