Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D6CF3197
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:23:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E232B847;
	Wed,  2 Oct 2024 08:23:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E232B847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727850198;
	bh=qhtMKLfMrHWg7xcq22fCBHpt4Xx3c2YhTdS/dFAoA3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C5YvZtOMHJ4nPvaD/5bf8BSrbNymiuztNhl0HP8BwrydVN9/rl96eOXzRgdrG1yWw
	 2iy0lxXCElkewSqrGlltKZZsJeEtph3mqIqTeX2gcJndGYyz2YauxOoq5AKbuP8uNE
	 Kt8B7mA/nHoP4jU/2Tz4+VgxulcHFrwrrqUvr9jk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 225A7F8058C; Wed,  2 Oct 2024 08:22:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67360F805B4;
	Wed,  2 Oct 2024 08:22:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0A55F80517; Wed,  2 Oct 2024 08:22:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10C21F800C9
	for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2024 08:22:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10C21F800C9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 673BF5C4A8F;
	Wed,  2 Oct 2024 06:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616CEC4CEC5;
	Wed,  2 Oct 2024 06:22:36 +0000 (UTC)
Date: Wed, 2 Oct 2024 08:22:34 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, perex@perex.cz, tiwai@suse.com,
 linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, elder@linaro.org,
	dmitry.baryshkov@linaro.org, caleb.connolly@linaro.org,
 linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: qcom,sm8250: add
 qrb4210-rb2-sndcard
Message-ID: <wcrkdgri4o3v252dzdimp2qng3zqlthynkozodukuxecm6k4tf@bglumhiwiwri>
References: <20241002022015.867031-1-alexey.klimov@linaro.org>
 <20241002022015.867031-2-alexey.klimov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002022015.867031-2-alexey.klimov@linaro.org>
Message-ID-Hash: OSNB7YHJQAPVYKHHCFPGH4OSYTQPEJ4A
X-Message-ID-Hash: OSNB7YHJQAPVYKHHCFPGH4OSYTQPEJ4A
X-MailFrom: krzk@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OSNB7YHJQAPVYKHHCFPGH4OSYTQPEJ4A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Oct 02, 2024 at 03:20:09AM +0100, Alexey Klimov wrote:
> Add adsp-backed soundcard compatible for QRB4210 RB2 platform,
> which as of now looks fully compatible with SM8250.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

