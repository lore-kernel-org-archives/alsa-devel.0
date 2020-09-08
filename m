Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40BC433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:06:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E28F20732
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qYyr3L0a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="nCSLpNb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 986EF174F;
	Tue,  8 Sep 2020 14:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 986EF174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599566787;
	bh=woA2OUV1esAcXCp8pY5naCYSJESW7kmN7zj2pknPraM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYyr3L0aGUPILnjinT8pbKLL3j5eCY1EfE2ZFII/eNwlS/0xRKCf9kss8FzUrVOKm
	 RMfcaruM95JEVQ1oAccH0NrgNh0qiM86ALyZ4wKGn6kOqsCvQbcbWnXM7YHhWTukO4
	 IAVDE42Cvg+5ISi8WQAxhpSeGIA0VcyQ/s50sD5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39771F8010B;
	Tue,  8 Sep 2020 14:05:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4A38F801F2; Tue,  8 Sep 2020 14:05:35 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0E2AF8010B
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 14:05:27 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 74EBDA003F;
 Tue,  8 Sep 2020 14:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 74EBDA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1599566727; bh=9b5Fqq5fU5wOYJ08GzQClBq0X5a2Ysj/PnRr3hJV/Bc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nCSLpNb+FHy8GvG62T86k1W+ona5zG0+IxqnC3fhMaBBcNgEzZcEH/DgVCNc7N0Y9
 a7Wq5U1Gbje/+2hPO1vHYBMustZQq8fhy00UaKVidmRWis5Q/4QiEkkwZsuVVxMB+f
 ZlkzkKw6BnpkO79CL00Q0fyMshTh0oz9kaHov2Io=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  8 Sep 2020 14:05:11 +0200 (CEST)
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To: Vinod Koul <vkoul@kernel.org>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, broonie@kernel.org
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
Date: Tue, 8 Sep 2020 14:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828065125.GI2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, bard.liao@intel.com,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, linux-kernel@vger.kernel.org
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

Dne 28. 08. 20 v 8:51 Vinod Koul napsal(a):
> Hi Mark,
> 
> On 18-08-20, 22:06, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Add a slave-level property and program the SCP_INT1_MASK as desired by
>> the codec driver. Since there is no DisCo property this has to be an
>> implementation-specific firmware property or hard-coded in the driver.
>>
>> The only functionality change is that implementation-defined
>> interrupts are no longer set for amplifiers - those interrupts are
>> typically for jack detection or acoustic event detection/hotwording.
>>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/bus.c         | 12 ++++++------
>>  include/linux/soundwire/sdw.h   |  2 ++
>>  sound/soc/codecs/max98373-sdw.c |  3 +++
>>  sound/soc/codecs/rt1308-sdw.c   |  2 ++
>>  sound/soc/codecs/rt5682-sdw.c   |  4 ++++
>>  sound/soc/codecs/rt700-sdw.c    |  4 ++++
>>  sound/soc/codecs/rt711-sdw.c    |  4 ++++
>>  sound/soc/codecs/rt715-sdw.c    |  4 ++++
>>  sound/soc/codecs/wsa881x.c      |  1 +
> 
> This touches codecs, can you Ack it please

Mark, could you ack the ASoC change to accept this patch via the soundwire repo?

> 
> Ideally this should have been split up to header, the codec updates and
> finally the bus change!

I don't think that the split is ideal in this case. I tested the code and it
looks straight enough.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
