Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C72C3E8C5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 18:09:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AA320872
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JOhE4tTg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+KKNmpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AA320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ED159F6;
	Wed, 18 Nov 2020 19:08:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ED159F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605722936;
	bh=G3eNmrElpyk/JxdBz4ZxECjisMtQTh/y/4ve+046iDc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOhE4tTg5uLETHvctCwYfVqBcYUQ4MUvIGvV3Fhp0Du0t2KPsnwsceaxQlvx76s5v
	 PEtdOrRfL1oLJnVN9tg49XeBZtWnYRXQnluw91oCOMMiafBAQTRyPRHxJkh8z6cxkP
	 w16zepUGwncSjPTCR1nyurKtdVD2XiJgde2tI6+c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18F1AF80168;
	Wed, 18 Nov 2020 19:08:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AEE8F8016C; Wed, 18 Nov 2020 19:08:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D780F80158
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 19:07:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D780F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J+KKNmpy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6420320872;
 Wed, 18 Nov 2020 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605722869;
 bh=G3eNmrElpyk/JxdBz4ZxECjisMtQTh/y/4ve+046iDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J+KKNmpy9vshVC7uON3rYNM2VC3nQSETkj1ls4ywL6YkZbRUIQGr2DtRsZkx8cgjS
 aHZRGqKRltau/tixcju0xTJw9aIYQ5MgpdWWDeNRi1+3nq2e7hA2Si7uIs+v4jl2md
 wl7Ar/XTUBMOenMKU0EuziYi+9AFzdOztNvbx97g=
Date: Wed, 18 Nov 2020 18:07:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe
 document"
Message-ID: <20201118180728.GF4827@sirena.org.uk>
References: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: A nuclear war can ruin your whole day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-kernel@vger.kernel.org, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, Trevor.Wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 04:05:20PM +0800, Jiaxin Yu wrote:
> This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.
>=20
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  https://mailman.alsa-project.org/pipermail/alsa-devel/2020-November/1768=
73.html
>  These dependency are continuing to upstream, I will revert this patch fi=
rst.
>  After the dependencies are merged, I will send 'mt8192-afe-pcm.yaml' aga=
in.

This description of what the commit does should be part of the
changelog, reverts are just normal patches and should have changelogs
describing what they do just like other changes do.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+1Yt8ACgkQJNaLcl1U
h9AhLAf/TGSE24nfALfss97iOQLpBN2TcEUOBzg/RRtpuWtwvSMYV4B6YSoNojIr
FMcDlZWyPnv+3y3iht5s5jNy278L2Dobyj10ncVofPIdIZ4duv5CRsxcuSb5bde+
4IKJ8om4SM+CEovLSNYLTclqEeu621cTX6dTklSi4cW5SOHxir9DqSKHlR973TRb
XihhxBmTMMIpUKIEYHqULed6nhHQ1nWPV2JvThXh4C51gO+PI9ixrLtGjSssfMtI
p2jSsO6qgJi4MyAPA7zZ1N/KLK/IUiL4jPE1qj5QfPtZOjOXp9uwAAJ2Y+jsRQDs
o7HKVJGxnso4TH365eWAQrexXZV6tw==
=g11E
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
