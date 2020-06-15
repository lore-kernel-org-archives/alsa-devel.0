Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A6C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:15:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE0820679
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jtbMQYFc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc0Dcebb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE0820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67B611607;
	Mon, 15 Jun 2020 14:14:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67B611607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592223298;
	bh=SeO45nafpNrqNLAigKnrSNTvi4D8+s00hYG6wlDqxv8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jtbMQYFcOT6Qo/hj3rt7YVG38T7TZNrvcbhjNhSxYlWqoD2/lyiZrTHY36dQEPv+s
	 tlST9JR6BySaXtf38sjOFnWUwilNJ7QYfR/mYM4x6ZugypO8MMAAGpCkyHfO++Io7I
	 TbYcG0jOBbauz1I9Mm9HmByrVetRMFE21F90v6Mk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF4E1F80162;
	Mon, 15 Jun 2020 14:14:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 351A4F80171; Mon, 15 Jun 2020 14:14:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DA55F800EF
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 14:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DA55F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Cc0Dcebb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 108A920679;
 Mon, 15 Jun 2020 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592223237;
 bh=SeO45nafpNrqNLAigKnrSNTvi4D8+s00hYG6wlDqxv8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cc0DcebbMjDEL3CjM/ijLclP/AWSsll98fqcBtIAQbkJTW7cyNrsFm/msWwokMbMh
 ZogCJ5ltMb5HE+bHz0VH3OhwhgKtUVqYA5YwRkSWADMDqEfU/6DP44vyaiAi8vI4LN
 e3rO2+hYfe38xF36OMMrkERvkJ3eUIE6X/OPhE+U=
Date: Mon, 15 Jun 2020 13:13:55 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Subject: Re: [PATCH 1/2] ASoC: rt1015: Update rt1015 default register value
 according to spec modification.
Message-ID: <20200615121355.GM4447@sirena.org.uk>
References: <20200615032433.31061-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Content-Disposition: inline
In-Reply-To: <20200615032433.31061-1-jack.yu@realtek.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, lgirdwood@gmail.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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


--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 11:24:32AM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Update rt1015 default register value according to spec modification.

Do we also need a register patch to ensure that early silicon has the
correct values or was this just a software bug?

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nZgIACgkQJNaLcl1U
h9D+zAf+KcIsrJVCkuHDQxYRMkVagPbh0vY5H4um1h8xkb86Fhp1xo0l4wE0k938
pomcyFIEDuWYSe3FFROE7V+Uf2g+SWvLbg4TkVer+4kSXFPe5NM5OMVVOlOOA7tN
cmjXkyQB/+7NNQhNYgvcHEDwGYSRtpn11h+bJlcW7JTFaS2AqWyXQShdrl1ej+op
QaErSn+Oohi3rU8noPq9j2drIP1R4Ic64V9giwSTdJHpV5ha2XP2Ex8b50OuLCK3
a8K29UV+q5VDBOcDCw8xyW1iN+9YZ6irFrNudmF2pmEt0uI4vA7PsA1lT0lx57kf
YJsxd30PzUHno6QHdHFVgiouGFkYCQ==
=ifh7
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
