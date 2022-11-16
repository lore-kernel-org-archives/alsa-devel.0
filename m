Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0D0C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 14:18:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D391C1689;
	Wed, 16 Nov 2022 15:17:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D391C1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668608308;
	bh=bw9qraiFl0JW+cXyOG+yJVuDURCN0jPi2XHmbs1LrFA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U2hbSItvZA4TuJwAdOiuF4ykRgCQqLbhwJBmphoQnvUoqti9rm32MVfuU1O5FbIXF
	 FYe2merUoSrwwjwKSteO5iQkSn6Tdit+w5HCereQLOhIbnBe1BwZNUmt3soKfsnnpZ
	 pcC/GDvR66oDCH1QZb7fAhWWpib8BaFg+eqIVR/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E363F80089;
	Wed, 16 Nov 2022 15:17:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20D30F80169; Wed, 16 Nov 2022 15:17:38 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA46EF80089
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 15:17:30 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7BD04A003F;
 Wed, 16 Nov 2022 15:17:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7BD04A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1668608250; bh=u1k0pJgKfOkbSwJetqs0cxn5niMzUrW1bk82nJvK7Tc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=3Pd4GBnBRj+MkRzT0Xhw+H4PBLiul2FrChagXnvkz9ReNQRpl3ZF8jm+RAA3ySfOg
 xcaH/OJN9KhfRHTaYnvEFqGszk4GOyW16+1rd8c6Iz888UXL47R6re4hl3FJedfSt/
 oMXKTniDwpBB3XBZScd8CMXzgVcnaGIJ1rmXTfPQ=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 16 Nov 2022 15:17:21 +0100 (CET)
Message-ID: <ab82415a-4378-9999-4a82-d647e7a8215e@perex.cz>
Date: Wed, 16 Nov 2022 15:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] [RFC] selftests: alsa - add PCM test
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20221108115914.3751090-1-perex@perex.cz>
 <87pmdn3sj8.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87pmdn3sj8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Curtis Malainey <cujomalainey@google.com>,
 Brian Norris <briannorris@chromium.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@intel.com>, Jesse Barnes <jsbarnes@google.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

On 16. 11. 22 15:03, Takashi Iwai wrote:
> On Tue, 08 Nov 2022 12:59:14 +0100,
> Jaroslav Kysela wrote:
>>
>> This initial code does a simple sample transfer tests. By default,
>> all PCM devices are detected and tested with short and long
>> buffering parameters for 4 seconds. If the sample transfer timing
>> is not in a +-100ms boundary, the test fails. Only the interleaved
>> buffering scheme is supported in this version.
>>
>> The configuration may be modified with the configuration files.
>> A specific hardware configuration is detected and activated
>> using the sysfs regex matching. This allows to use the DMI string
>> (/sys/class/dmi/id/* tree) or any other system parameters
>> exposed in sysfs for the matching for the CI automation.
>>
>> The configuration file may also specify the PCM device list to detect
>> the missing PCM devices.
>>
>> v1..v2:
>>    - added missing alsa-local.h header file
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
>> Cc: Liam Girdwood <liam.r.girdwood@intel.com>
>> Cc: Jesse Barnes <jsbarnes@google.com>
>> Cc: Jimmy Cheng-Yi Chiang <cychiang@google.com>
>> Cc: Curtis Malainey <cujomalainey@google.com>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> 
> Sorry for the late reply.
> 
> The patch looks good and works fine on the smoke test, so I applied it
> now.  There are a few issues Mark already commented on, and we can fix
> or improve them in incremental manner later.

Thanks. I will try to work the Mark's comments when I find a free time.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
