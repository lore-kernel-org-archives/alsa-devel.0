Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9806C2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:39:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D412082E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="feWHHcKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D412082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DE86166C;
	Thu, 30 Jan 2020 16:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DE86166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580398783;
	bh=FhsxNX/i+9RkWaC27Pnxg7bGFkqn5pCMHJJMA9yK4DU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=feWHHcKpYwACg/0LyDG8y4PksnHHWoNe0XMRq0NOI1eMHjN10oHGYRCw9IfUVZlCK
	 pRqnLYskEIYnYpEwIV5sr9AEoGP/IkDGiUnAhJy6iyDRlHJB5cUh3sUbDEHaEPPEmi
	 fPlIWT7XLDl7Gp+gjJI7bycs5EFaEzQgXU/LA6mg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08C39F80123;
	Thu, 30 Jan 2020 16:38:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76041F80150; Thu, 30 Jan 2020 16:38:51 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCFF4F80082
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 16:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCFF4F80082
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 07:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; d="scan'208";a="224152828"
Received: from jsmesenc-mobl.amr.corp.intel.com (HELO [10.252.140.145])
 ([10.252.140.145])
 by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2020 07:38:43 -0800
To: Mark Brown <broonie@kernel.org>
References: <20200129223603.2569-1-pierre-louis.bossart@linux.intel.com>
 <20200129223603.2569-2-pierre-louis.bossart@linux.intel.com>
 <20200130145548.GE6682@sirena.org.uk>
 <c6391973-fe6e-bd36-a2b5-c28cefc1ef75@linux.intel.com>
 <20200130151751.GF6682@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <882842ba-72c2-2e32-ec9f-0b1fb3ae45e4@linux.intel.com>
Date: Thu, 30 Jan 2020 09:38:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130151751.GF6682@sirena.org.uk>
Content-Language: en-US
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Intel: sof_pcm512x: add support
 for SOF platforms with pcm512x
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/30/20 9:17 AM, Mark Brown wrote:
> On Thu, Jan 30, 2020 at 09:14:29AM -0600, Pierre-Louis Bossart wrote:
> 
>>> These look like they might be a DAPM widget of some kind?
> 
>> it's the LED support only, turned on when you play and off when you stop.
>> At some point, I added a gpiochip support in the PCM152x codec driver to
>> avoid doing this, and have a nicer way of toggling the gpios. Due to lack of
>> time, I didn't maintain this solution, but we could add it in a follow-up
>> version if that was desired. It's really not the main functionality of this
>> patch.
> 
> Followup seems fine.

ok, will work on it, I haven't changed the code since December 2018
https://github.com/plbossart/sound/commits/hifiberry/gpios

Another thing I didn't complete is the support for the codec master 
mode, which would be needed for the Hifiberry DAC+ PRO versions (they 
have 2 oscillators for 44.1 and 48kHz support). It's a bit of a 
chicken-and-egg, during the probe the codec driver requests an mclk but 
in the case of the hifiberry the mclk is actually enabled at the codec 
level with a GPIO selection. I never found a clean way to do this, or an 
example where the clock consumer is also the clock provider. So far we 
only use these PRO boards in codec slave mode, which is a bit of a 
waste. For once we have good clocks, we should really use them...
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
