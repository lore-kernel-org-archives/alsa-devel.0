Return-Path: <SRS0=Trf1=CH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E90C433E2
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 00:12:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2095820838
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 00:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T0PTTM9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2095820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A99C318C2;
	Sat, 29 Aug 2020 02:12:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A99C318C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598659976;
	bh=iGeT3MSpUm0YvU4srxJW0ZPlUlckjmx6oZIiBQAaNbU=;
	h=From:Subject:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0PTTM9e2OmhphV0kl+pFYeWyluCC+MlUcJcXaPcDIbsurZnXZCirPXKSmUtFW0WK
	 HuVJtIvqcCrqfoyiXvqjCFgjN9ytdOmjlitDyeeVaMvpIzY7DRoN46z/RaKOAy7yoO
	 zb9NGaaZ4mWOXk+5aRctoBiW76HbysQHk1q8rCXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 162C2F80143;
	Sat, 29 Aug 2020 02:12:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FAA5F8016F; Sat, 29 Aug 2020 02:12:04 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0536AF80105
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2020 02:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0536AF80105
IronPort-SDR: ih+jyx23w7Ulh/QOdzVZa4U/vzk2leYkRNrXRWwExh45pMUX3NctfseOse62wvB+7FCgScsbq/
 SOtQWbnisXvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="144440468"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; d="scan'208";a="144440468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2020 17:11:54 -0700
IronPort-SDR: h4/orcg6Gn8nZ9ohrRYk+lZSm+43zkLVdgDI4N9Y2stHaHJZBEYbeRpB1m00xdjqKyRt5YQyWb
 VxfQI2pIm4Eg==
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; d="scan'208";a="340050304"
Received: from fvera1-mobl.amr.corp.intel.com (HELO [10.212.55.68])
 ([10.212.55.68])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2020 17:11:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To: Doug Anderson <dianders@chromium.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
References: <20200826110454.1811352-1-cychiang@chromium.org>
 <20200826110454.1811352-3-cychiang@chromium.org>
 <CAD=FV=XaCt6V+VXfk8T+2mS4d5sKQzMC12AcH9a=MNkgguvmjQ@mail.gmail.com>
Message-ID: <7b3bb666-c53e-e385-e153-1383f2831c2e@linux.intel.com>
Date: Fri, 28 Aug 2020 19:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XaCt6V+VXfk8T+2mS4d5sKQzMC12AcH9a=MNkgguvmjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Taniya Das <tdas@codeaurora.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 tzungbi@chromium.org, Ajit Pandey <ajitp@codeaurora.org>,
 Tzung-Bi Shih <tzungbi@google.com>, Andy Gross <agross@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>, Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Dylan Reid <dgreid@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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


>> +config SND_SOC_SC7180
>> +       tristate "SoC Machine driver for SC7180 boards"
>> +       depends on SND_SOC_QCOM

this depends is probably not necessary, the code is already in an if case.

>> +       select SND_SOC_QCOM_COMMON
>> +       select SND_SOC_LPASS_SC7180
>> +       select SND_SOC_MAX98357A
>> +       select SND_SOC_RT5682
> 
> I haven't done any significant testing / review of your patch (I'm
> mostly sound-clueless), but I believe that the above needs to be
> "select SND_SOC_RT5682_I2C" atop the current top of the sound tree.
> When I fix that I can confirm that I see the rt5682 probe on
> sc7180-trogdor with Rob Clark's dts patch.

Ack, no one should select SND_SOC_RT5682 directly in machine drivers. 
now that the code is split between I2C and SoundWire parts.

There should probably be a depends on I2C as well?
