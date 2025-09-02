Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5097DCA1005
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Sep 2025 20:54:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05E2560205;
	Tue,  2 Sep 2025 22:53:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05E2560205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756846445;
	bh=jECdS4CzQRUdpw1q8UvY0XbAJXPo1RSL3BkjoizI0Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mjxJVD+Kjqg6B5rzqBfYQS6BSWNdOIlOxNEuBtOcVgyvnVhLf9tYPKQwLwrepnHH3
	 IgjSAPM1jHLDYiUNTnbncuwb8+L1LZoeOBxvDg3lIn2MIHNK6LZ0xYjpZAvkZ94sM3
	 +iuCn2oOdnp8WBI/wsNPatB4J29KTQiz+kRSCXtI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE942F805CB; Tue,  2 Sep 2025 22:53:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06A38F805C3;
	Tue,  2 Sep 2025 22:53:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC0EDF80254; Tue,  2 Sep 2025 22:53:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7B9FF8016D
	for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2025 22:53:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7B9FF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O8X7ewLS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E96D40201;
	Tue,  2 Sep 2025 20:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD889C4CEED;
	Tue,  2 Sep 2025 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756846379;
	bh=jECdS4CzQRUdpw1q8UvY0XbAJXPo1RSL3BkjoizI0Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8X7ewLSTUxPVmrMSli6DcTVJqsbuOAtwGSFGZd1/mMohM2fuq99V5CqsrCG9oAJK
	 ZCQZ94fVa4tZPWGiEEW9VY/JiCZnnbc+cevBe32S59461UCGzTZYXkuj8/IzQ3bEVZ
	 ZDkLDoe0636QrDMy4RqA7DwvK3ON0gW9q9GFciYm2XsX/rff5YqS8nyts78B2hGO+f
	 R8W90Z+nF6iV8gm1aoKS5mtxJ6RdvMkHU6EobolgQG6X2nlhoFbqNdl2Mo9WMWyUwv
	 EqIXVqTbNfzSS3cKyH1wakZ/B/6Yj5Rdv6JpJWZb6It9NI4KPFZZTzGMim+RgUbDur
	 tID0QvxDZsK+g==
Date: Tue, 2 Sep 2025 15:52:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: chinkaiting@google.com, conor+dt@kernel.org, jim.shil@goertek.com,
	jesse-ji@ti.com, lgirdwood@gmail.com, shenghao-ding@ti.com,
	tiwai@suse.de, broonie@kernel.org, will-wang@ti.com, k-yi@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	robinchen@ti.com, linux-sound@vger.kernel.org, krzk+dt@kernel.org,
	toastcheng@google.com, alsa-devel@alsa-project.org,
	andriy.shevchenko@linux.intel.com, henry.lo@ti.com,
	13916275206@139.com
Subject: Re: [PATCH v4 2/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825
 support
Message-ID: <175684637733.1163682.7826171092384451555.robh@kernel.org>
References: <20250830061459.24371-1-baojun.xu@ti.com>
 <20250830061459.24371-2-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830061459.24371-2-baojun.xu@ti.com>
Message-ID-Hash: YZOMTGIWGMLLD5KKYN5J5Q4L6PZEDMTT
X-Message-ID-Hash: YZOMTGIWGMLLD5KKYN5J5Q4L6PZEDMTT
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YZOMTGIWGMLLD5KKYN5J5Q4L6PZEDMTT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Sat, 30 Aug 2025 14:14:59 +0800, Baojun Xu wrote:
> Update ti,tas2781.yaml for adding tas2118, tas2x20, tas257x and tas582x.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v4:
>  - Change description for adding tas257x and tas5827
>  - Added descriptions for tas2570, tas2572 and tas5827
>  - Remove unnecessary description for I2C register
> v3:
>  - Remove unnecessary minItems.
>  - Remove unnecessary description for tas5825.
> v2:
>  - Update the mail list for maintainers of yaml file
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 96 ++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

