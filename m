Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051F4C43334
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jun 2022 13:54:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C2111A74;
	Thu, 23 Jun 2022 15:53:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C2111A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655992454;
	bh=3hZJqQgd858AdvZKankIYTrsnm6oS+7J5kIS2PHpFLw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G7SifqRoAlaT5JH3WFZH5DUacaMeRlsiZWtG+IcNKp+EYACsUmh+DvG8n5MFH+KeF
	 Eb97OjU7p+ovZqnHQPh+mRj85r4CwvwOMi1PDAy7CX1pCjAqgdy24jzmK6IKnkn2Vz
	 BcJ/lHDxp7QeVi0AF2+d1+UfMsQkvppaGXarcIi8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95DE8F804BB;
	Thu, 23 Jun 2022 15:53:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AADDF804C1; Thu, 23 Jun 2022 15:53:21 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7560FF800CB
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2022 15:53:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7560FF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="JXM2Mmp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655992399; x=1687528399;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3hZJqQgd858AdvZKankIYTrsnm6oS+7J5kIS2PHpFLw=;
 b=JXM2Mmp+7gLkjCjOO3SDEKV8sXEUI/sK7EZxamdzGINNR4qmdDg2GkUe
 uxlUEU11d/8V+QNqryjOnFJjLFVa0uvx8JxFxfKTd6lmRYbDCFFSqE3/t
 5C+Ois6Md+Etb2MGYnIgUYxA0NdIsS8T2TfzGQhX041b96Zk5ew6TmD5W
 A/Wflad/ND7lRPoIADLKjkjExw8SMVz1WWtskmoVPwfX0cyd5awyfrb22
 nX9w/8NiV5I3WvqcMRZhVJ2+smX+X1oXUnwiwFo9B+c27fQuxR5JA9o3g
 BV6Tflb6Gf3j4xsc+HMNXpkAHHWKo7EYBaWwh7ARWI0YFMsC7g8vwaatd g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261155146"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; d="scan'208";a="261155146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 06:53:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; d="scan'208";a="644751190"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.161])
 ([10.99.249.161])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 06:53:11 -0700
Message-ID: <5d453e11-4a46-bfdc-973e-8d65d891421f@linux.intel.com>
Date: Thu, 23 Jun 2022 15:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/11] ASoC: codecs: rt274: Enable irq only when needed
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220609133541.3984886-1-amadeuszx.slawinski@linux.intel.com>
 <20220609133541.3984886-8-amadeuszx.slawinski@linux.intel.com>
 <YqIBRGNAOfxPJjc+@sirena.org.uk>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <YqIBRGNAOfxPJjc+@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
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

On 6/9/2022 4:18 PM, Mark Brown wrote:
> On Thu, Jun 09, 2022 at 03:35:37PM +0200, Amadeusz Sławiński wrote:
>> Interrupt is only needed when jack detection is enabled, so enable it
>> then, similarly disable it when jack detection is being disabled.
> 
>>   	if (jack == NULL) {
>>   		/* Disable jack detection */
>> +		disable_irq(rt274->i2c->irq);
> 
> There is absolutely no need to do this, it'll interfere with any sharing
> of the interrupt and if the interrupt isn't firing then there is no cost
> to having the interrupt registered.
> 
> The driver could use some cleanup of the interrupt handler, it currently
> unconditionally clears anything that fires and reports IRQ_HANDLED but
> should only report IRQ_HANDLED if there was anything from the device.
> Practically speaking it shouldn't make much difference unless there's
> spurious interrupts or the interrupt gets shared.

While this sounds fine, in tests I see that irq handler gets called 
around ~800 times per second even when we unload platform driver and 
there is no one caring about jack detection... in this case I would 
consider this to be a waste of CPU time and would prefer to just 
outright to disable it. Is there some better way to avoid unnecessary 
calls to irq handler?

Main reason why I even looked at this is pr_debug() present in 
rt298_jack_detect() which kept spamming our debug logs (~800 lines per 
second fills up logs rather fast...). It should probably be removed, as 
rt286 and rt274 do fine without having this logged, but they also call 
irq handler quite a lot if you add message log for debug.
