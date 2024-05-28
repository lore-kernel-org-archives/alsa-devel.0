Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E2CC25B7C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 May 2024 15:42:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 163A0846;
	Tue, 28 May 2024 17:42:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 163A0846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716910971;
	bh=+ka7lAt0AaEKQOhVhdJkYL8d3RJmgi15bjbIH1lkuVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Zh6W9USpVv07fnEHed9AHb7dC5j5dPY/u73MhFemMNod5eDhFOQm1fXSrPfUK1Y6X
	 Ajox70qGi6xopG+FAcYg3NDZ+C480TTRObS88R9woMJLCiEKkYy81qnxsB2VNer/4N
	 UhYpkvnmOyB8Bs8I2ZpT1+CF2+4P0hfGsO5EpoXg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31A59F804FF; Tue, 28 May 2024 17:42:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF1BDF80525;
	Tue, 28 May 2024 17:42:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3B4FF804E5; Tue, 28 May 2024 17:40:50 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22147F80580
	for <alsa-devel@alsa-project.org>; Tue, 28 May 2024 17:40:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22147F80580
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mQ7ugF7o
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3775CCE1140;
	Tue, 28 May 2024 15:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4197BC3277B;
	Tue, 28 May 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910835;
	bh=+ka7lAt0AaEKQOhVhdJkYL8d3RJmgi15bjbIH1lkuVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ7ugF7oci9zQMotueSFnxOlJdgSRiTo1pl+/I7Io2p/oLGt1ADaaVRU77uZxsPuH
	 rtTv+4iuxxOMr2QFWMz+5rPxQein+0RRcvFeJ6GQHxOdY8q69i0M51lcTVSE4BLsCQ
	 pXnxFVWjEU25VKXaxQSE4toPW/4jrKA/047xXTq9WfVvCi/aey5IGZiQCss5yDqNBt
	 jFH0Tt5U6Vmv/8bVtmcnFHzJApiGDaxCtxLX69rkaD775rLU458uIMahHRCr4meZ9S
	 zgLhUSYIy19b6eoSnA2k82xb2gcQd6LfbrY8S9iyDkpeIFSKLGvw+KRr1QSkTpUu5U
	 P7TIJXaOYZuBw==
Date: Tue, 28 May 2024 10:40:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
	krzysztof.kozlowski+dt@linaro.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
	shengjiu.wang@gmail.com, lgirdwood@gmail.com, tiwai@suse.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linuxppc-dev@lists.ozlabs.org, perex@perex.cz
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform
 support
Message-ID: <171691083154.676898.17539558632778396948.robh@kernel.org>
References: <1716347305-18457-1-git-send-email-shengjiu.wang@nxp.com>
 <1716347305-18457-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716347305-18457-2-git-send-email-shengjiu.wang@nxp.com>
Message-ID-Hash: 6XGPILDGFOAZXFBRDVGHJHSLNLHLGHKU
X-Message-ID-Hash: 6XGPILDGFOAZXFBRDVGHJHSLNLHLGHKU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6XGPILDGFOAZXFBRDVGHJHSLNLHLGHKU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 22 May 2024 11:08:24 +0800, Shengjiu Wang wrote:
> There are two MQS instances on the i.MX95 platform.
> The definition of bit positions in the control register are
> different. In order to support these MQS modules, define
> two compatible strings to distinguish them.
> 
> As one instance is in the always-on domain, another is in the
> net controller domain, so the compatible strings are
> "fsl,imx95-aonmix-mqs", "fsl,imx95-netcmix-mqs".
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,mqs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

