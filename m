Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE9C4332B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:22:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236212080C
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HVncFFX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236212080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 988F31780;
	Thu, 19 Mar 2020 18:21:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 988F31780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584638567;
	bh=qle14U5RfawReGq1aPYjQql6XI0bEW9IxeSd5FhSk/o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HVncFFX7o4fuImICIdUvvCLNVmddxnEDd82QbglW02m4wX8DLW86kAY6yPlpqQxbZ
	 oiBthCAxgq18D+p4UjFnBdqFD9KRmkev6a48unAng0sxSw11P11gEGg1GxfiMcfYLb
	 ykQIP6QZcFEriI5WpcAzwbxm2uJG9ZiiMcbcY7p4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DC43F80217;
	Thu, 19 Mar 2020 18:21:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10589F8022B; Thu, 19 Mar 2020 18:21:55 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08D80F800C0
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 18:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08D80F800C0
IronPort-SDR: +gmKC9lJT1ZdVIPgLiaGRXrMi5KEG5LZfMPTqeVZUcEZXm1Gpv0fknkNmohSSvEXHPz+KU7wj8
 v5LvQEtXJOgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2020 10:21:49 -0700
IronPort-SDR: uhvihpBxhcKPDcFU+cU4PT8LMnYRGNXufez+qTl2y/miMWDn7R+AHq2l/iLIuFqEwYpy4+CCCh
 A5VqQaktpONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; d="scan'208";a="444650210"
Received: from tvanlang-mobl.ger.corp.intel.com (HELO [10.255.34.72])
 ([10.255.34.72])
 by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2020 10:21:48 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
Date: Thu, 19 Mar 2020 12:21:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319165157.GA2254@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 curtis@malainey.com, Keyon Jie <yang.jie@linux.intel.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com, liam.r.girdwood@linux.intel.com,
 Mark Brown <broonie@kernel.org>
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



On 3/19/20 11:51 AM, Dominik Brodowski wrote:
> On Thu, Mar 19, 2020 at 04:48:03PM +0100, Cezary Rojewski wrote:
>> On 2020-03-19 14:41, Mark Brown wrote:
>>> On Thu, Mar 19, 2020 at 02:00:49PM +0100, Dominik Brodowski wrote:
>>>
>>>> Have some good news now, namely that a bisect is complete: That pointed to
>>>> 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
>>>> therefore I've added Kuninori Morimoto to this e-mail thread.
>>>
>>> If that's an issue it feels more like a driver bug in that if the driver
>>> asked for ignore_suspend then it should expect not to have the suspend
>>> callback called.
>>>
>>
>> Requested for tests with following diff applied:
>>
>> diff --git a/sound/soc/intel/boards/broadwell.c
>> b/sound/soc/intel/boards/broadwell.c
>> index db7e1e87156d..6ed4c1b0a515 100644
>> --- a/sound/soc/intel/boards/broadwell.c
>> +++ b/sound/soc/intel/boards/broadwell.c
>> @@ -212,7 +212,6 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] =
>> {
>>                  .init = broadwell_rt286_codec_init,
>>                  .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>                          SND_SOC_DAIFMT_CBS_CFS,
>> -               .ignore_suspend = 1,
>>                  .ignore_pmdown_time = 1,
>>                  .be_hw_params_fixup = broadwell_ssp0_fixup,
>>                  .ops = &broadwell_rt286_ops,
> 
> That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
> ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
> on top of that. But you can assess better whether that patch needs care for
> other reasons; for me, this one-liner you have suggested is perfect.

.ignore_suspend is set for bdw-rt5677.c and bdw-rt5650.c as well. I 
don't know if that was intentional.
