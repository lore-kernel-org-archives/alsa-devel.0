Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9119FC5479D
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Jan 2023 23:59:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4B3C14C7B;
	Sat,  7 Jan 2023 00:58:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4B3C14C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673049566;
	bh=3d1DO0cDsSSFGxEy7xYujqdO/RXqj/Yc3KB9N5fpqDU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Sj6iPhoqp3xuP7T+z3QvmLZAe4DEN41rz3wnZtK2y4bg93FxfJGKA3dG2jsyih6Cy
	 ulpC8wPFEO2BB/f9e0m3qaFJzxFuCETSBmgVm/wQMtesugG/FnIi3SJtquOFWBK5My
	 T+cd3QnAFhGDbGdHFb+H65270wZZybUJgeEK9vJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90036F8032D;
	Sat,  7 Jan 2023 00:57:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B61F6F8032D; Sat,  7 Jan 2023 00:57:46 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEE2AF800C0
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2023 00:57:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEE2AF800C0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3Uboh1+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673049458; x=1704585458;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3d1DO0cDsSSFGxEy7xYujqdO/RXqj/Yc3KB9N5fpqDU=;
 b=R3Uboh1+PG9iScn29b3X31wL8Duvu6lxL2XqGXOwo25fdmnkyW6wYdRA
 70Wuk/jsaIznuPdqR+RmWnZIABI0FfxaQ96J2b6q+EVIqJweBVcn54zyt
 044SxI7hHh+J8phV+iT10evrgaYK0Z3L5+0GxtEpvnZapF4oBNqWnKtXf
 6P0EOILYY/Nsd8z9s6eXL7uK57B+3a1kpqBX/fAflld+pqixwfDK3KEqP
 TPkXx1UTpC79htz+Cn7XwMCPah+1msIlyBDsFDSQZ3Q4xc6Uo17c0ejbd
 Z2O+xRGJXCaZRlJMtUlD6sTPB2xAH99AA9G3RQT/7n9mMRVdAM+Aoymyb g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387047046"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; d="scan'208";a="387047046"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2023 15:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984817951"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; d="scan'208";a="984817951"
Received: from apbaezbo-mobl2.amr.corp.intel.com (HELO [10.212.60.153])
 ([10.212.60.153])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2023 15:57:32 -0800
Message-ID: <654077f4-2ae2-3457-b777-9eb3b816c6ba@linux.intel.com>
Date: Fri, 6 Jan 2023 10:16:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, broonie@kernel.org,
 lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
 robh+dt@kernel.org, agross@kernel.org
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <e29060b1-df65-c0d1-5777-023879a5863e@linux.intel.com>
 <0f903c49-a989-14a6-bac1-c4cae21839eb@quicinc.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <0f903c49-a989-14a6-bac1-c4cae21839eb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_jackp@quicinc.com, quic_plai@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/5/23 19:05, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 1/4/2023 3:41 PM, Pierre-Louis Bossart wrote:
>>
>>> +int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>>> +            int connected)
>>> +{
>>> +    struct snd_soc_dapm_context *dapm;
>>> +    struct q6usb_port_data *data;
>>> +
>>> +    if (!usb->component)
>>> +        return 0;
>>> +
>>> +    dapm = snd_soc_component_get_dapm(usb->component);
>>> +    data = dev_get_drvdata(usb->component->dev);
>>> +
>>> +    if (connected) {
>>> +        snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>>> +        /* We only track the latest USB headset plugged in */
>>
>> that answers to my earlier question on how to deal with multiple
>> devices, but is this a desirable policy? This could lead to a lot of
>> confusion. If there are restrictions to a single device, then it might
>> be more interesting for userspace or the user to indicate which USB
>> device gets to use USB offload and all others use legacy.
>>
> 
> Yeah, as mentioned its still pretty open ended.  I think from the
> feedback received from Mark/Takashi, this was a viable option for now.
> Would you happen to have any insight/input on how the userspace can pass
> down that selection to the ASoC framework?  Maybe some kind of PCM IOCTL
> call?

I don't have a turn-key solution either :-)
We'd need userspace to make one device as 'preferred' or 'optimized' and
give it a priority somehow. It can't be a PCM IOCTL, it has to be at the
device level.

It's really a second-level optimization that can be parked for now, the
bulk of the work is really the interaction between USB audio and ASoC
stacks, we should probably focus on that BIG topic with a design that
can be shared across implementations.
