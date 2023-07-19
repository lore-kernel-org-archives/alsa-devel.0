Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2FBC001B0
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 22:41:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 410223E;
	Thu, 20 Jul 2023 00:40:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 410223E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689806467;
	bh=7D7RzRHaJGxKAepbVKlDzJZQhozzOzlVH3Up8dTxW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mo/iPgmF1qv0GE74ZPZnZ/auMQKF5ZgCuc4AZtafpcN172M0sofmnqs7Br8lbdaD5
	 W2wetvZt/p0mBGtg4OI3eWchYVjNQnjmXs2PF90xJBxpBvsdQx4cMkCApiNYHJyBsa
	 eJKIgTd+25hAGv492PZAN43FKm8UrRocOTISxYhc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 073A6F80527; Thu, 20 Jul 2023 00:40:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB889F800D2;
	Thu, 20 Jul 2023 00:40:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 474A7F8047D; Thu, 20 Jul 2023 00:40:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F6C9F800D2
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 00:39:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F6C9F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pNJIjpan
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 832CF617C9;
	Wed, 19 Jul 2023 22:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346AC433C8;
	Wed, 19 Jul 2023 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689806390;
	bh=7D7RzRHaJGxKAepbVKlDzJZQhozzOzlVH3Up8dTxW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNJIjpang2qGoODuNSTGtHART5RZ5YCQpI6rZrVH95dMPqQDAlXivNJ9SP4mV5INb
	 yifBacyI/4VjOOBda5zOlJCy+lcS55oq1KhYdpbjLdtwrN8IciuD7G6HCqaEVVsOpf
	 YBM+dHOvRl5uQPEQWaMzQwclVYJdLZ9SvHNMNQXN+9dPiDuB2+hX+v7aXTXk8gcGHz
	 LXQxFvnAFlr+Sj506GtAvuSbozCblWCfNnIHB2+FstBJxADx8cO5iYc/fL50hdTgo8
	 Sf/YDljGqFM5DpfzZZgv4151cjjCrdrR51eHo5sp5nfk1jHeX0dLt/HoiCTUrI7Zfl
	 C0v7D3JTEbDaA==
Received: (nullmailer pid 899913 invoked by uid 1000);
	Wed, 19 Jul 2023 22:39:49 -0000
Date: Wed, 19 Jul 2023 16:39:49 -0600
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ASoC: dt-bindings: wm8904: Convert to dtschema
Message-ID: <168980638831.899860.9131467971421415167.robh@kernel.org>
References: <20230719121918.247397-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719121918.247397-1-francesco@dolcini.it>
Message-ID-Hash: OCOHPKUJ2MXTRKUQWDXA23GEW66GB47N
X-Message-ID-Hash: OCOHPKUJ2MXTRKUQWDXA23GEW66GB47N
X-MailFrom: SRS0=QU89=DF=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OCOHPKUJ2MXTRKUQWDXA23GEW66GB47N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 19 Jul 2023 14:19:18 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Convert the WM8904 audio CODEC bindings to DT schema.
> 
> Compared to the original binding #sound-dai-cells and the missing power
> supplies are added. The latter are all required as described in the
> datasheet.
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 74 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8904.txt      | 33 ---------
>  2 files changed, 74 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

