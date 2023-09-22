Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C1DCE7A86
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Sep 2023 20:52:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4450FA4D;
	Fri, 22 Sep 2023 22:51:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4450FA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695415964;
	bh=GYskKyjo0FmpusJcMMZmSC6zPPr6TtDi/xqUdv7Hd9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mCz95KaNh9wfC5nfJqdthaKZH0c/SDs4Ft1+QPW1cB3VDj3dcVRZO//Von3tKdGeD
	 dENfTHAzBriS1mH0NjQexeEGbO85VgaEa67PjeWVcWUy1AJ0fP/bRV+fJGPYl4+CdG
	 VJaUC/3PeOIYpJ75b7fZZ75FaGvdfA8gLddUIuOg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4EE0F801F5; Fri, 22 Sep 2023 22:51:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 78F9DF80125;
	Fri, 22 Sep 2023 22:51:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44B96F80125; Fri, 22 Sep 2023 22:51:48 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6661CF80005
	for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2023 22:51:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6661CF80005
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P/RjwNzW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id B8D34B82461;
	Fri, 22 Sep 2023 20:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C33C433C8;
	Fri, 22 Sep 2023 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695415898;
	bh=GYskKyjo0FmpusJcMMZmSC6zPPr6TtDi/xqUdv7Hd9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/RjwNzWltM4aAsJn610JUMps6FyrMDPCJyZ72S/JOAKqgXdB9fgpRSarV3VFJFhQ
	 S3qqIpr5wfIRAvx5Bu1cPr5faImWsAHeznwtfUP8UgTDuvsVeulHTQxcp+nKTwrhSY
	 q5oXhZ1Th3+SOV5pWpYbTfjpGkQn9ibo7slndunaHwHH/twXYGXyZsu+odl9B1ti5+
	 8NWa1OCoZwcS+5zdTf7r+aMqF5M8uyxG+MLyymx1/qOg2l7IdWevK+CiPra6fw0d1c
	 R6HCqiy4qZA8RrmRWdO9QbqvEZVyHRqpd4EcYIdPgEbjQKSVSKSGU79iSS8MgytYP1
	 snB1Ls5C3HFlw==
Received: (nullmailer pid 3557889 invoked by uid 1000);
	Fri, 22 Sep 2023 20:51:34 -0000
Date: Fri, 22 Sep 2023 15:51:34 -0500
From: Rob Herring <robh@kernel.org>
To: wangweidong.a@awinic.com
Cc: 13916275206@139.com, rf@opensource.cirrus.com, liweilei@awinic.com,
 lgirdwood@gmail.com, povik+lin@cutebit.org, ryans.lee@analog.com,
 perex@perex.cz, tiwai@suse.com, linus.walleij@linaro.org,
 yijiangtao@awinic.com, colin.i.king@gmail.com,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
 arnd@arndb.de, harshit.m.mogalapalli@oracle.com, yang.lee@linux.alibaba.com,
 ckeepax@opensource.cirrus.com, broonie@kernel.org, herve.codina@bootlin.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, trix@redhat.com,
 shumingf@realtek.com
Subject: Re: [PATCH V4 1/7] ASoC: dt-bindings: awinic,aw88395: Add properties
 for multiple PA support
Message-ID: <169541589406.3557849.14317344918884630444.robh@kernel.org>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
 <20230919105724.105624-2-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919105724.105624-2-wangweidong.a@awinic.com>
Message-ID-Hash: GEAN2DRTOEBZJO5RUOIX2VFL4NRT4LGM
X-Message-ID-Hash: GEAN2DRTOEBZJO5RUOIX2VFL4NRT4LGM
X-MailFrom: SRS0=kpay=FG=robh_at_kernel.org=rob@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GEAN2DRTOEBZJO5RUOIX2VFL4NRT4LGM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 19 Sep 2023 18:57:18 +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add two properties, the "awinic,audio-channel" property and the
> "awinic,sync-flag". The "awinic,audio-channel" is used to make
> different PA load different configurations, the "awinic,sync-flag"
> is used to synchronize the phases of multiple PA. These two properties
> will be read by the corresponding driver, allowing multi-PA to
> achieve better playback effect.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw88395.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

