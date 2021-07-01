Return-Path: <SRS0=xdAn=LZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8EC11F64
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 12:53:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E06613BE
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E06613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 206481691;
	Thu,  1 Jul 2021 14:52:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 206481691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625143981;
	bh=7/B1O5SRCZQDIH9JnUtLeO06PzUiR1aaEtM7Xh38A3U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cNZJ4lOkVKvoBYybLW3wm7nohesdpqnEbmyL4C9OnPv96ZVH2cHzQ/kH/AFbqzgz9
	 05rkTDJGOKrkOQ7IFXmXn64gapNWcSfvxRJt7bJh46zy0OUyMeXExwoIjjH7Tx2vcQ
	 ecG7RtrE1wvO6YytHGk2f/IUMrXeQ8YJ+RG53MV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83249F8025D;
	Thu,  1 Jul 2021 14:52:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E983F802D2; Thu,  1 Jul 2021 14:52:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B40DBF800BA
 for <alsa-devel@alsa-project.org>; Thu,  1 Jul 2021 14:52:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B40DBF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rymjU5e0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2475613FE;
 Thu,  1 Jul 2021 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625143923;
 bh=7/B1O5SRCZQDIH9JnUtLeO06PzUiR1aaEtM7Xh38A3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rymjU5e08NAPC41iGQ7oNJ01iDBURqmIomvMkTKIzMdhACduI1TLDPR90eQvkwt40
 mPD6U7gQh5JkbL5LEY0tq09tMilj1KaWmiRUPBfldfc/FKjcj1Cv+5MlglvHI+kCB1
 ywE6Xr8LQkI689pD649R1Wn2bvBYojvyostqE46cf6V20RgPxSk+E4hGxMm0e+uEqj
 Yba2npgPX9/JYOaPAirQqBo+wbIuCclxbhHCFvW1zIIME1colzKmkkKm/lCAsfCeWC
 yurn0fCtTH8kDP7iA/X3YtcVq8pGvUMmwu5L0Y5PtuwV1OTajWPhn6oZl9taO4jiOj
 jxkWUGPGJjgNA==
Date: Thu, 1 Jul 2021 13:51:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: (subset) [PATCH 0/2] arm64: tegra: Enable audio IOMMU support on
 Tegra194
Message-ID: <20210701125134.GB4641@sirena.org.uk>
References: <20210628181118.2295007-1-thierry.reding@gmail.com>
 <162506854659.43525.4480397285287043164.b4-ty@kernel.org>
 <YNylGG9RaM72CY2i@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <YNylGG9RaM72CY2i@orome.fritz.box>
X-Cookie: Turn off engine while fueling.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sameer Pujar <spujar@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org
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


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2021 at 07:08:40PM +0200, Thierry Reding wrote:

> Could you drop this patch from your queue at this time? I can send out
> the updated patch once I'm convinced it isn't going to regress further.

OK since it's the top commit, in general it's better to send reverts for
things like this though - like some other people I rarely rebase or
otherwise modify existing commits.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDdulUACgkQJNaLcl1U
h9BeeQf/T+umKNdbt87xaPCht7wCPEszcEG0SV5z2Y9UFkIs6HfeU/f4HRiuMtIv
DzTs/T0UmrqyzxLH49YkXfgCRTrkPr5qmdm0iZL6ng4YzWlJmOqT/vLKKyunFyKH
feshTEJ9AtH0pLzyjYkOyAr4HeLEt1+wsgyTTXS+MAGMSZrL/Y3titN0kvjYnWVq
2ju+YlZDQyOxIxvpltiXzgyKG94CUsG5NPBUh7xtHfkhcoHuW9vPBUvA0tyrC8EQ
p+PD96ZfICydEWEsSeA/WBtTVqfSbJRlPomAsaXcai9iZc7RAv7wBJkhEcL+qZde
iNBRANBx4F87MBzZill+pkwUsMHECw==
=mdqc
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
