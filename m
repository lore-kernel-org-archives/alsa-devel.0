Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22D7CE7A8C
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Sep 2023 15:36:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3EBFDF1;
	Mon, 25 Sep 2023 17:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3EBFDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695656169;
	bh=Y7OQBC5AEP9R354Curchhk5OGpVdy/FisMGeX/iJKjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YdX4M9dHST+2deku2Kl1xI1Ir/J26ioPyIkfwpTr5y1AnwYJTMTZaAk5d52T6w2Qr
	 ooXnjAALYqiVIUx32uJcb0Ce/yLHPmNG4b5+7rk7Hh8gsMKK/WlLdYxi7ZLZYpxY1a
	 5jieQI4zEV9ANITsda6r8wFF9kn6oBNrQ0460UkA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72752F80553; Mon, 25 Sep 2023 17:34:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7029F8016A;
	Mon, 25 Sep 2023 17:34:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5CE6F8016A; Mon, 25 Sep 2023 17:34:44 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81B69F800AA
	for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2023 17:34:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81B69F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VVKIbioI
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A4554CE10E0;
	Mon, 25 Sep 2023 15:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AC0C433CA;
	Mon, 25 Sep 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695656078;
	bh=Y7OQBC5AEP9R354Curchhk5OGpVdy/FisMGeX/iJKjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVKIbioIyREl1zwTbB6F43J4ZOV5DT9Pn80/aejaOgNdQ6Zb+VS0AtCmNkcRcqHYf
	 nvp/AVewxpfGI+h5XlODkJUrEYsOEJBW9DLuBFM3W+KNtn7/HvA0ImYwwcMC/5U4hp
	 V4j6FbRLp3BybvJWNmlXvrexp+xuEGgNaCw9Z68+foaliwVubAED7hBuGctMwWZkDf
	 LE7A+UOHni0N2S+opZlZr/JN+Fczw1m7xEmSwc9mZIlvCukwuFjxI2taLhC8wgnCVJ
	 rbLePRTwyXFgDXJ6dSqlJURKzF7BifJka8AHzlc/8U9CRuUQJYVj0liY9v/S3eFgDw
	 tqMQkEUcya4mw==
Received: (nullmailer pid 1412130 invoked by uid 1000);
	Mon, 25 Sep 2023 15:34:34 -0000
Date: Mon, 25 Sep 2023 10:34:34 -0500
From: Rob Herring <robh@kernel.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: mathias.nyman@intel.com, bgoswami@quicinc.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, perex@perex.cz, konrad.dybcio@linaro.org,
 Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
 broonie@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org,
 tiwai@suse.com, srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, agross@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v7 23/33] ASoC: dt-bindings: Add Q6USB backend
Message-ID: <169565607344.1412068.10654540784578345179.robh@kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-24-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921214843.18450-24-quic_wcheng@quicinc.com>
Message-ID-Hash: CSX6L5PYDVQM3RWQDPVMKQAJFI4SZ6GM
X-Message-ID-Hash: CSX6L5PYDVQM3RWQDPVMKQAJFI4SZ6GM
X-MailFrom: SRS0=JOOG=FJ=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CSX6L5PYDVQM3RWQDPVMKQAJFI4SZ6GM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 21 Sep 2023 14:48:33 -0700, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,q6usb.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

