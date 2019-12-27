Return-Path: <SRS0=I0CO=2S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC23C2D0C3
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Dec 2019 00:18:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF0020882
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Dec 2019 00:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UrTnZoZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF0020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8AF51768;
	Sat, 28 Dec 2019 01:17:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8AF51768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577492281;
	bh=B7JFMacq3dwGu/i4+zh2ISbOeMBJ7XA8S72plIWVkLo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrTnZoZ6St2gTiwKvvLQTmEebzHN9Kwd3ru2qGpMFhQpsOostnBW0tClp9nb1+CWd
	 r8eLK6aEj9HrAVQIEPFdtB+XgDwkKMzaLIm5ivv8zuQiVucsEfhKOH3wOA6s8Z54bu
	 QMpF/+UVU19h/KhuS6l4tJIiKZfsCVcm9LBdS0ZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D395FF800CD;
	Sat, 28 Dec 2019 01:16:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BBABF800AE; Sat, 28 Dec 2019 01:16:17 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29932F800AE
 for <alsa-devel@alsa-project.org>; Sat, 28 Dec 2019 01:16:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29932F800AE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Dec 2019 16:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; d="scan'208";a="243364220"
Received: from vdoan2-mobl.ccr.corp.intel.com (HELO [10.251.152.151])
 ([10.251.152.151])
 by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 16:16:10 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
Date: Fri, 27 Dec 2019 17:38:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227071433.GL3006@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial
 definitions for sdw_master_device
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



On 12/27/19 1:14 AM, Vinod Koul wrote:
> On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
>> Since we want an explicit support for the SoundWire Master device, add
>> the definitions, following the Greybus example of a 'Host Device'.
>>
>> A parent (such as the Intel audio controller) would use sdw_md_add()
>> to create the device, passing a driver as a parameter. The
>> sdw_md_release() would be called when put_device() is invoked by the
>> parent. We use the shortcut 'md' for 'master device' to avoid very
>> long function names.
> 
> I agree we should not have long name :) but md does not sound great. Can
> we drop the device and use sdw_slave and sdw_master for devices and
> append _driver when we are talking about drivers...
> 
> we dont use sd for slave and imo this would gel well with existing names

In SoundWire parlance, both 'Slave' and 'Master' are 'Devices', so yes 
we do in the standard talk about 'Slave Devices' and 'Master Devices'.

Then we have Linux 'Devices' which can be used for both.

If we use 'sdw_slave', would we be referring to the actual physical part 
or the Linux device?

FWIW the Greybus example used 'Host Device' and 'hd' as shortcut.

> 
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -66,7 +66,10 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   		 * callback is set to use this function for a
>>   		 * different device type (e.g. Master or Monitor)
>>   		 */
>> -		dev_err(dev, "uevent for unknown Soundwire type\n");
>> +		if (is_sdw_master_device(dev))
>> +			dev_err(dev, "uevent for SoundWire Master type\n");
> 
> see below [1]:
> 
>> +static void sdw_md_release(struct device *dev)
> 
> sdw_master_release() won't be too long!

yes, but there is no such operation as 'Master Release' in SoundWire.
At least the 'md' shortcut conveys the implicit convention that this is 
a Linux device only.

I really would like to avoid overloading the standard definitions with 
the Linux ones...

> 
>> +{
>> +	struct sdw_master_device *md = to_sdw_master_device(dev);
>> +
>> +	kfree(md);
>> +}
>> +
>> +struct device_type sdw_md_type = {
> 
> sdw_master_type and so on :)
> 
>> +	.name =		"soundwire_master",
>> +	.release =	sdw_md_release,
> 
> [1]:
> There is no uevent added here, so sdw_uevent() will never be called for
> this, can you check again if you see the print you added?

as explained this is to avoid errors at a later point. I don't see any 
harm in providing error checks for a routine that can only be used for 1 
of the 3 devices defined in the standard?

>>   
>> +struct sdw_master_device {
> 
> we have sdw_slave, so would be better if we call this sdw_master
> 
>> +	struct device dev;
>> +	int link_id;
>> +	struct sdw_md_driver *driver;
>> +	void *pdata;
> 
> no sdw_bus pointer and I dont see bus adding this object.. Is there no
> link between bus and master device objects?

There is currently no bus device object, see the structure definition 
it's a pointer to a device (which leads to all sorts of issues because 
we can't use container_of).

when the master device gets added, that's where the Linux device is 
created and the pointer saved in the bus structure, with IIRC 
sdw_add_bus_master().


  	ret = sdw_add_bus_master(&sdw->cdns.bus);
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
