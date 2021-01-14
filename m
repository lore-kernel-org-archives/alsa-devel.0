Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 22:39:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A974223977
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 22:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A974223977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54A7616B4;
	Thu, 14 Jan 2021 23:38:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54A7616B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610663958;
	bh=6IJ7an25kWTUZGrqXZb6wJ4PINnoe+XnPSstPyQjPHo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAS/RDecR113lnh3iFzVZnZMO/dQKm+rPhzfYTXn14m1V/x7O9z3Zl8zJvlsN77Im
	 beYGfTdtw5g8ulmY5UWDTYgTUiNVHRoU3V6UDRrOI8Prk3xkZ6RdffZ8m1gmEVezx+
	 u0O3RF8ofuFFq1FtKgJ4hNYcfPCjT7SzMG/6UQhQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCE7BF8026F;
	Thu, 14 Jan 2021 23:38:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AC28F80113; Thu, 14 Jan 2021 23:38:16 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0551CF80113;
 Thu, 14 Jan 2021 23:37:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0551CF80113
IronPort-SDR: mGuh40dQIqACcsCwwjgUJqMPy9uMZMNOmqPcuZOCSOnSMJFih8j+ls1E0/DwxSFJeydy0kHypi
 bmYleromU+Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="157635947"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="157635947"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 14:37:41 -0800
IronPort-SDR: KHgXeEdpxIlPNe0MxMGFDkb299iXzzebbc5xM6orunBROyeg2fM1cURMj3CDtIdA4x+V3ckWRM
 KcgDJ5DjdAgA==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="382431963"
Received: from dvarelam-mobl1.amr.corp.intel.com (HELO [10.212.182.202])
 ([10.212.182.202])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 14:37:39 -0800
Subject: Re: [Sound-open-firmware] [PATCH 1/2] [v2] ALSA: hda: fix
 SND_INTEL_DSP_CONFIG dependency
To: Arnd Bergmann <arnd@kernel.org>
References: <20210112203250.2576775-1-arnd@kernel.org>
 <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
 <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
 <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b9b5b3c7-43ac-b856-6783-2c430fa098af@linux.intel.com>
Date: Thu, 14 Jan 2021 16:37:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Arnd Bergmann <arnd@arndb.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Rander Wang <rander.wang@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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



On 1/14/21 3:19 PM, Arnd Bergmann wrote:
> On Thu, Jan 14, 2021 at 7:07 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 1/14/21 9:09 AM, Arnd Bergmann wrote:
>>> On Tue, Jan 12, 2021 at 9:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>>> ---
>>>> v2: fix various build issues in the first version, now passes
>>>>       all randconfig builds I tried
>>>
>>> Please disregard this version, while I have a tree that passes
>>> the randconfig builds now, this was not the patch from it that
>>> I wanted to send...
>>
>> No worries, I reworked the PCI case completely. Still running tests to
>> make sure there's no regression
>> https://github.com/thesofproject/linux/pull/2683
> 
> Ok, I see. I had not realized that you already did the PCI bits as well,
> and applied my original patch to your tree, as I had meant to
> resend my "ASoC: SOF: ACPI: avoid reverse module dependency"
> patch after fixing some additional build failures in it. I have
> now applied the relevant commits from your branch to my
> randconfig tree, and will let you know if that finds anything more.
> 
>  From what I can tell so far, you already included the fixups that I had
> locally, and more.

Thanks Arnd.

Yes we added a couple of things. I missed the fact that we hard-coded 
'sof-acpi' to determine if we use the legacy or SOF driver, and other 
problems with driver names that I screwed-up.

The dependencies part should be finished now, I am just testing on my 
side that nothing broke on the test devices (which is slower than I 
wanted due to other ACPI scan things I had to revert locally). I will 
add a couple of suggestions from Guennadi but this should be done tomorrow.


