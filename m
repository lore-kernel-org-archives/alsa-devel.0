Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F183C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 15:41:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F336E204;
	Fri, 29 Apr 2022 17:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F336E204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651246867;
	bh=ZpcakiJxEQVk/dBVZU62a6TPC1XmaL12jKvXBfGE8Ac=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/OKLCpmqn7fHKn+sF2ZsWAYYpoN8/fWjGjjb7TMR3ta0bWsGx5QUJOCm1uH04ute
	 44+rONk2dcI0xWumFdUV9GSNe7VeVLmjFpfEWmMHpDgeu3eK2qZjPIbWYXrC/doLR1
	 6+g1qxNXkvudlRcD2TjBbu80amL6sFxZ0fdV3Rd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F600F80237;
	Fri, 29 Apr 2022 17:40:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06C2BF8025D; Fri, 29 Apr 2022 17:40:15 +0200 (CEST)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com
 [115.236.121.145])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07320F8012B
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 17:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07320F8012B
Received: from [192.168.3.48] (unknown [58.22.1.245])
 by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 02F4C800387;
 Fri, 29 Apr 2022 23:39:52 +0800 (CST)
Message-ID: <24c08c1e-e4b5-3731-de33-e75a9b4bdf1f@rock-chips.com>
Date: Fri, 29 Apr 2022 23:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ASoC: hdmi-codec: Add option for ELD bypass
To: Mark Brown <broonie@kernel.org>
References: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
 <YmwDv7poot/5pcgb@sirena.org.uk>
From: sugar zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <YmwDv7poot/5pcgb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJJSE1WSUJITkkeGBlJSU
 NOVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITk9VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006ISo4ED0xIhcLMhkYIh4y
 Mk1PCy1VSlVKTU5KSU9NTEJITUlIVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVSlVJT05ZV1kIAVlBSU5NQjcG
X-HM-Tid: 0a8075fa8274b03akuuu02f4c800387
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <maxime@cerno.tech>,
 Dmitry Osipenko <digetx@gmail.com>
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

Hi Mark,

在 2022/4/29 23:26, Mark Brown 写道:
> On Fri, Apr 29, 2022 at 11:13:38PM +0800, Sugar Zhang wrote:
>
>> So, add this option to allow user to select the manual way
>> to output audio as expected. such as multi-channels LPCM(7.1),
>> or HBR bitstream for these sink devices.
> Please check this with mixer-test, it'll help validate that you've got
> the control interface correct.
Okay, I have found it in the tools/testing/selftests/alsa/mixer-test.c
>
>>   		.info	= hdmi_eld_ctl_info,
>>   		.get	= hdmi_eld_ctl_get,
>>   	},
>> +	HDMI_CODEC_ELD_BYPASS_DECL("ELD Bypass"),
> This is a true/false value so the name should end with Switch.
will do in v2.

-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.

