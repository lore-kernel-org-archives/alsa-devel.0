Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC6EB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 11:04:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11517820;
	Wed, 21 Jun 2023 13:04:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11517820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687345494;
	bh=N49s8hoCPzg/d/5Yqx/JLNELPTMhdz+fJaCZkodGWio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OY4lCR2v2NcwwPxiC7Vm2oS+jZcpX5nYeVwdRFzt47R6ucvkVVSIWf53VS0B6N4Y3
	 lpAJeJXXHkbmUJkaCGUdLKSn9kt8VwdfCAVaJk1l6BQt+IUt6Bot2ALejMzppDOr3l
	 DsVm6BXCBjDsLwdxVQnA2/pYZrivJen9QClV307c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C29C8F8057E; Wed, 21 Jun 2023 13:02:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DF3EF8057B;
	Wed, 21 Jun 2023 13:02:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DA36F80564; Wed, 21 Jun 2023 13:02:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7D222F80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 13:02:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D222F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Gs93SjTK
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6A41B61500;
	Wed, 21 Jun 2023 11:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44444C433C0;
	Wed, 21 Jun 2023 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687345368;
	bh=N49s8hoCPzg/d/5Yqx/JLNELPTMhdz+fJaCZkodGWio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gs93SjTKfmM5tRP9D9zbsuHGo9f6Xh4kgyR0a6U1XttmyhFNhs7BavEpTXdRxLVaA
	 oD7wG0QOriYFbwHHdnAQC8YDhFlDhY5Q20yEP9aKQkxdhrOtiUAccszGIDq0TDZTlP
	 y1SZqSoIae7Tm+BlZMYX0sOdoTGYAVg1soxbYZjN1sa968M9SyIymcHeGOXLa9JoRK
	 ldl3lUHnyjgd9Wm+z+tKOZ0W1W4l9xXUgr0edpy3wQWWE2yU6nXJqtyP90yXI+rdck
	 Dstw6M3vrqSJirEhKXyx0q35sQ98fhhmJRPwXLz79SLJeneCJYThdsBuNDnfo+7y1q
	 H3Ti9T5en087g==
Date: Wed, 21 Jun 2023 16:32:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] soundwire: qcom: fix storing port config out-of-bounds
Message-ID: <ZJLY1A4es4CQpDxr@matsya>
References: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: 6SHQF7L2CTH6ISENYFBFQTIOE4JOTBFU
X-Message-ID-Hash: 6SHQF7L2CTH6ISENYFBFQTIOE4JOTBFU
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6SHQF7L2CTH6ISENYFBFQTIOE4JOTBFU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 01-06-23, 12:25, Krzysztof Kozlowski wrote:
> The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
> however we index it starting from 1, not 0, to match real port numbers.
> This can lead to writing port config past 'pconfig' bounds and
> overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
> smatch:
> 
>   drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

Applied, thanks

-- 
~Vinod
