Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA9C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 14:00:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5565AA5DA;
	Wed, 19 Oct 2022 16:00:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5565AA5DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666188056;
	bh=EWyrwET6bzT3F09mrFQhviQacw6z83EDxxDKj85ELzk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8a4JaWHrn/tNPzWOC2CZuBIq1+7tWwJvQKAaSMG3z44jKzznL/60MmHMi6yZl8PN
	 wYDIb+j0b3ov/fL+HyAdzM72IKH8aIqNbjAk8UQmWdsglvvuJmw9zTVufSRsP2+2zX
	 xBnZvrz4G7hxLcOrwcPDcPmUarM43B7Pjg5Z9hwQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFE66F804CB;
	Wed, 19 Oct 2022 16:00:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 041F8F804CC; Wed, 19 Oct 2022 16:00:05 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06F8CF80137
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 16:00:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F8CF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="VLS+hefP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666188003; x=1697724003;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EWyrwET6bzT3F09mrFQhviQacw6z83EDxxDKj85ELzk=;
 b=VLS+hefP2maydFnDn/Oz6xxqqIyypP7R7pZJJK1c+5UkvmHIAisVWP4w
 ZQJQr3JtJGq+YSbxdAjXqmFzE87T4iDUz4buTSZMZgF5m+eAhZWvW0Tkf
 K9TJkDS5g084xIzedocZcTF75LFKM5PolLnMsJyaWChKvhyLCDR05Neai
 1/iZr6Zcm1ukn9foKZTZbMCO6vGf28zFCw8SoVyRDpfI/mqQ3vNwbpt3d
 fRXEhXCz0M99ZYsnk1vk6lDHGkpwAbjCc8tcDJ0GcC2l8RIs38Z0NiSss
 LdeSIUCSVSzMN/F8lc9U7o5n5IFWg5oSXxdwCMXEyJI0vQo6I/Y/Z2oce A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306405847"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="306405847"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 06:59:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="734229046"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="734229046"
Received: from shutongz-mobl.amr.corp.intel.com (HELO [10.212.57.63])
 ([10.212.57.63])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 06:59:58 -0700
Message-ID: <364a7284-5a5e-a283-d68d-17a108587950@linux.intel.com>
Date: Wed, 19 Oct 2022 08:59:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH -next] ASoC: soc-component: using
 pm_runtime_resume_and_get instead of pm_runtime_get_sync
Content-Language: en-US
To: Maxime Ripard <maxime@cerno.tech>, Zhang Qilong <zhangqilong3@huawei.com>
References: <20220922145846.114312-1-zhangqilong3@huawei.com>
 <20221019135610.ini2kkqltwasjpvu@houat>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221019135610.ini2kkqltwasjpvu@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 lgirdwood@gmail.com, tiwai@suse.com
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



On 10/19/22 08:56, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Sep 22, 2022 at 10:58:46PM +0800, Zhang Qilong wrote:
>> Using the newest pm_runtime_resume_and_get is more appropriate
>> for simplifing code here.
>>
>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>> ---
>>  sound/soc/soc-component.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
>> index e12f8244242b..659b9ade4158 100644
>> --- a/sound/soc/soc-component.c
>> +++ b/sound/soc/soc-component.c
>> @@ -1213,11 +1213,9 @@ int snd_soc_pcm_component_pm_runtime_get(struct snd_soc_pcm_runtime *rtd,
>>  	int i;
>>  
>>  	for_each_rtd_components(rtd, i, component) {
>> -		int ret = pm_runtime_get_sync(component->dev);
>> -		if (ret < 0 && ret != -EACCES) {
>> -			pm_runtime_put_noidle(component->dev);
>> +		int ret = pm_runtime_resume_and_get(component->dev);
>> +		if (ret < 0 && ret != -EACCES)
>>  			return soc_component_ret(component, ret);
>> -		}
>>  		/* mark stream if succeeded */
>>  		soc_component_mark_push(component, stream, pm);
> 
> This creates an issue on the RaspberryPi4 on 6.1-rc1.
> 
> At boot time, we now have a bunch of:
> [   35.536496] hdmi-audio-codec hdmi-audio-codec.1.auto: Runtime PM usage count underflow!
> 
> They were bisected back to that commit, and reverting it makes it go
> away.
> 
> I think this is due to the fact that the function here used to call
> pm_runtime_put_noidle() only if there was an error, and that error
> wasn't EACCES. However, pm_runtime_resume_and_get() will call
> pm_runtime_put_noidle() for any error.
> 
> Thus, if our __pm_runtime_resume() call return EACCES, we used to keep
> the our reference but we will now drop it. So I guess we should just
> revert it, possibly with a comment?

This is already reverted, see patch from Peter:

[PATCH] Revert "ASoC: soc-component: using pm_runtime_resume_and_get
instead of pm_runtime_get_sync"
