Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4AAC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:34:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC03022229
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CkgADPGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC03022229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3869D1614;
	Tue, 14 Jul 2020 17:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3869D1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594740847;
	bh=LUabsqC4SyKVTuWcClJd0WkLAFOOofsmJd2vv9pdRgQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CkgADPGSaiy/vUDz1vvRT0IAgPTsp7TFt3ByvOTbEV2jjCiDKhyW6bVuOJqGljtKp
	 enH6vq+VADrRn8s43uJ7IZephhpiM6eZ6lEHTFnEVvH4GWED4ApYJkCev9jwV5mgpD
	 hctJenHtm2V4xRpHtsqtQ6MU4Ll/RKlRh4UBzvC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4827F800E5;
	Tue, 14 Jul 2020 17:33:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CEC6F8019B; Tue, 14 Jul 2020 17:33:14 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAEF4F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAEF4F800E5
IronPort-SDR: Hsnn6Z2SVrxoHeD4+TdTvcRdm7T+reRPyP6zNuPCeZ2BZ0xhfoeeioZkVfwVllZTBykhV3vsAo
 S1eO4cYxAIrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136390364"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="136390364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 08:33:02 -0700
IronPort-SDR: jpLl8Z91CHrJMTPg3t0J7aTW5y2Vqu6HL+js7/SNral8HdnSKvyg1gNcK1cIg8t/WVHXCucWtk
 kjh/xIzkwcnQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="317756331"
Received: from pbusser-mobl1.amr.corp.intel.com (HELO [10.252.136.7])
 ([10.252.136.7])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 08:33:00 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
To: Hans de Goede <hdegoede@redhat.com>,
 Jing Xiangfeng <jingxiangfeng@huawei.com>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 kuninori.morimoto.gx@renesas.com, paul@crapouillou.net
References: <20200714080918.148196-1-jingxiangfeng@huawei.com>
 <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <48bdc22e-a0fc-0402-a003-1d0736107e8a@linux.intel.com>
Date: Tue, 14 Jul 2020 10:32:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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



On 7/14/20 8:33 AM, Hans de Goede wrote:
> Hi,
> 
> On 7/14/20 10:09 AM, Jing Xiangfeng wrote:
>> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
>> path. Add the missed function call to fix it.
>>
>> Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for 
>> inverted jack detect")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> 
> Patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Actually the existing code looks quite odd to me:

if (cnt) {
	ret = device_add_properties(codec_dev, props);
	if (ret)
		return ret;
}

devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
priv->speaker_en_gpio =
	gpiod_get_index(codec_dev, "speaker-enable", 0,
			/* see comment in byt_cht_es8316_resume */
			GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
put_device(codec_dev);

if the first branch is not taken the put_device() will not be balanced.

Shouldn't this be:

if (cnt) {
	ret = device_add_properties(codec_dev, props);
	put_device(codec_dev);
	if (ret)
		return ret;
}

devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
priv->speaker_en_gpio =
	gpiod_get_index(codec_dev, "speaker-enable", 0,
			/* see comment in byt_cht_es8316_resume */
			GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
/* removed put_device(codec_dev); */

> 
> Regards,
> 
> Hans
> 
> 
>> ---
>>   sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/boards/bytcht_es8316.c 
>> b/sound/soc/intel/boards/bytcht_es8316.c
>> index 9e5fc9430628..ecbc58e8a37f 100644
>> --- a/sound/soc/intel/boards/bytcht_es8316.c
>> +++ b/sound/soc/intel/boards/bytcht_es8316.c
>> @@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct 
>> platform_device *pdev)
>>       if (cnt) {
>>           ret = device_add_properties(codec_dev, props);
>> -        if (ret)
>> +        if (ret) {
>> +            put_device(codec_dev);
>>               return ret;
>> +        }
>>       }
>>       devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
>>
> 
