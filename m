Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E9C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CC364EED
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CC364EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6D7518B7;
	Mon, 15 Mar 2021 18:46:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6D7518B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615830433;
	bh=J26lkwysKMOUxZoHy7/kDFMsd2heLJablpRJYGBxM14=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9aJOFY9r4zOxcAHdUwl9+uiS+9lQPHq2cd06SZYkY3WDMfgk04TPTph4cjSaXa8Z
	 gy9M1sT4+q24wsCVCzvAAYOTQy6g3TW3ziqMTZqImuyGeHolGG3TzaDtDVwqkdvZYn
	 CvUFClNfELjxTf5um/Bkc5WEOZ3BOifPWYmKGfxg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E011F80163;
	Mon, 15 Mar 2021 18:46:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3603F80171; Mon, 15 Mar 2021 18:46:21 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CEDAF8010E
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 18:46:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CEDAF8010E
IronPort-SDR: tZI8Z7DEV+HCuOtL4ceI/2WO+HG8SrVwpZ3V/gAB3RpJ7yPKe/s58OK1VGO6OYmHQoCcTtruW8
 dBpmPFhY9fZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168404154"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="168404154"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 10:46:00 -0700
IronPort-SDR: v8t5y50ubkXves4zafwbQVR32hXp6Mt5VX4zMLdh7feUVv5AskleWaXsAgrqYunr/+jqDs14wF
 zEIeZvVMn3Bg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="438962876"
Received: from pwells-mobl2.amr.corp.intel.com (HELO [10.212.5.38])
 ([10.212.5.38])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 10:45:59 -0700
Subject: Re: [PATCH v4 0/5] soundwire: add static port map support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, 
 vkoul@kernel.org
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c7bbbcb3-cc82-9422-9736-7d5393970fb3@linux.intel.com>
Date: Mon, 15 Mar 2021 12:10:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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



On 3/15/21 11:56 AM, Srinivas Kandagatla wrote:
> In some cases, SoundWire device ports are statically mapped to Controller
> ports during design, however there is no way to expose this information
> to the controller. Controllers like Qualcomm ones use this info to setup
> static bandwidth parameters for those ports.
> 
> A generic port allocation is not possible in this cases!
> This patch adds a new member m_port_map to SoundWire device so that
> it can populate the static master port map and share it with controller
> to be able to setup correct bandwidth parameters.
> 
> As a user of this feature this patchset also adds new bindings for
> wsa881x smart speaker which has 4 ports which are statically mapped
> to the 3 output and 1 input port of the controller.
> 
> Tested it on DB845c and SM8250 MTP.
> 
> thanks,
> srini

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Changes since v3:
> 	- updated kernel doc for more clarity on m_port_map
> 
> Srinivas Kandagatla (5):
>    soundwire: add static port mapping support
>    soundwire: qcom: update port map allocation bit mask
>    soundwire: qcom: add static port map support
>    ASoC: dt-bindings: wsa881x: add bindings for port mapping
>    ASoC: codecs: wsa881x: add static port map support
> 
>   .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
>   drivers/soundwire/qcom.c                      | 31 +++++++++++++++----
>   include/linux/soundwire/sdw.h                 |  2 ++
>   sound/soc/codecs/wsa881x.c                    |  7 +++++
>   4 files changed, 43 insertions(+), 6 deletions(-)
> 
