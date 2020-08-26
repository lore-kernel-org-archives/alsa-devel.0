Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7699CC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:12:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193120738
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vL43vWBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63AD21764;
	Wed, 26 Aug 2020 17:11:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63AD21764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598454743;
	bh=7iMHTYe45blgfJcMVq89d8ewVsAO/mInqqEvO9Dccp8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vL43vWBxOxVnWfNb3svSWzzCzjOMXp/jA8fwmfDxr//jwJ0mdUg7VHCZClNBioKtE
	 b1M1p7cgDiiIz33kj3QEpz0a+GUC9tUfcyNwtIF79IlSAebJqA4zWI4j77NktqS+0A
	 51827f6YqJPtziL1ZhJxWgVbQWfY3Ovip5q8/Jtk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED4F0F801F2;
	Wed, 26 Aug 2020 17:11:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 990DFF802A0; Wed, 26 Aug 2020 17:11:31 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D40A8F8016F
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 17:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D40A8F8016F
IronPort-SDR: JAJ/Zp2VtWuw2390dxiBxQvdRGXQgdzT74SfY5iX6NjIs9FRhUugT/GO94K5tGliIEz62QZ1jb
 ztO/02dZIGDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="143970560"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="143970560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 08:11:18 -0700
IronPort-SDR: n8Fk4Q9CKxbnEO0LAV3Eh96gjzazs6sn7KtHO5iaKfDhiWwuHYSsPVumYhsKWlAwH/48vu/D9A
 lAiAuUByOwqw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="299505077"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51])
 ([10.255.231.51])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 08:11:16 -0700
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
To: Mark Brown <broonie@kernel.org>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826101637.GC4965@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e66a9e95-7846-f353-8ebd-e35458c79797@linux.intel.com>
Date: Wed, 26 Aug 2020 09:54:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826101637.GC4965@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



>> One possible objection is that this code could have been handled with
>> regmap-sdw.c. However this is a new spec addition not handled by every
>> SoundWire 1.1 and non-SDCA device, so there's no reason to load code
>> that will never be used.
> 
>> Also in practice it's extremely unlikely that CONFIG_REGMAP would not
>> be selected with CONFIG_REGMAP_MBQ selected. However there's no
>> functional dependency between the two modules so they can be selected
>> separately.
> 
> The other thing I'm wondering here is about compatibility - is this
> something we can enumerate at runtime and if so couldn't this be done
> more like how we handle the various I2C and SMBus variants so the driver
> just says it wants a SoundWire regmap and then based on the capabilities
> of the device and the controller the regmap decides if it can use MBQ or
> not on the current system?

An SDCA device will have two regmaps, one for 'regular' registers and 
one for MBQ-based ones. There is no known case where a codec can use 
ONLY an MBQ-based regmap.

It's different from I2C/SMB since the bus is really identical, the 
interface is the same, the difference is really the sequence by which 
you access registers allocated to SDCA and how the address is constructed.

Each SDCA control will be described with a firmware property, and based 
on their range and purpose you would know how if the control is a 
regular one or an MBQ-based one. Alternatively, the driver might 
hard-code things and define addresses for each.

Does this answer to your question?

