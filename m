Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3AC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 19:55:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468D560FED
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 19:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 468D560FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEBB716C9;
	Mon, 27 Sep 2021 21:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEBB716C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632772539;
	bh=f2eIk/XKNkAUcsKAULARwYcninFyYHb7o+Ja79TDf6w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jq/73FRKJRphfzHa4JcSaaLFOB5zbM7yrkDVlwMsEx43TLvAjA4V5F/4sYn4E7pGJ
	 aYlPAg8ru7dW3MM4omYD3+YAqWaDwaj5ikceVElGgB6gOei0gFxNVQtkLXnvA9EMLh
	 CeXPyx+8CYpj7bXJnNNvGQ0Up3cURJub4MpXW7NA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0998F8026D;
	Mon, 27 Sep 2021 21:53:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E5DBF804FC; Mon, 27 Sep 2021 21:53:16 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FE49F8026D
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 21:53:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FE49F8026D
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211802395"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="211802395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 12:53:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="486268040"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2])
 ([10.212.27.2])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 12:53:00 -0700
Subject: Re: [PATCH v8 00/22] ASoC: qcom: Add AudioReach support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <603b8650-d6cb-74e0-b6bd-3b650c6bd194@linux.intel.com>
Date: Mon, 27 Sep 2021 11:32:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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




> Srinivas Kandagatla (22):
>   soc: dt-bindings: qcom: apr: convert to yaml
>   soc: dt-bindings: qcom: apr: deprecate qcom,apr-domain property
>   soc: qcom: apr: make code more reuseable
>   soc: dt-bindings: qcom: add gpr bindings
>   soc: qcom: apr: Add GPR support
>   ASoC: dt-bindings: move LPASS dai related bindings out of q6afe
>   ASoC: dt-bindings: move LPASS clocks related bindings out of q6afe
>   ASoC: dt-bindings: rename q6afe.h to q6dsp-lpass-ports.h
>   ASoC: qdsp6: q6afe-dai: move lpass audio ports to common file
>   ASoC: qdsp6: q6afe-clocks: move audio-clocks to common file
>   ASoC: dt-bindings: q6dsp: add q6apm-lpass-dai compatible
>   ASoC: dt-bindings: lpass-clocks: add q6prm clocks compatible
>   ASoC: dt-bindings: add q6apm digital audio stream bindings
>   ASoC: qdsp6: audioreach: add basic pkt alloc support
>   ASoC: qdsp6: audioreach: add q6apm support
>   ASoC: qdsp6: audioreach: add module configuration command helpers
>   ASoC: qdsp6: audioreach: add Kconfig and Makefile
>   ASoC: qdsp6: audioreach: add topology support
>   ASoC: qdsp6: audioreach: add q6apm-dai support
>   ASoC: qdsp6: audioreach: add q6apm lpass dai support
>   ASoC: qdsp6: audioreach: add q6prm support
>   ASoC: qdsp6: audioreach: add support for q6prm-clocks

I added a couple of minor comments, at this point other reviewers should
start looking at this patchset.

For patches 5, 9, 10, 14..22 (everything except dt-bindings which I
didn't even look at):

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


