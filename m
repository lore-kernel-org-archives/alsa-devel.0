Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DC6C00144
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jul 2022 14:58:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CC5F15CC;
	Fri, 29 Jul 2022 16:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CC5F15CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659106736;
	bh=kpXPXDEKt8EWRIsz7zZNVRA+jmEVLhwG5JCEoBZEhYw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C9S0TxMzg7txhoSHzRfn+9ybRuse5GpTdt2gM4oI5eaSUfjm1t8PSw+jpnWzre8l/
	 Kqu1Ql3swDZzPRKFxHwpuzKQUQcCi5BhaJmMcjZaSbP5mqkkObV3HfpE4A6yi8gB7H
	 3O9WtVxYTUJj1hsGs/7Ra8S+pbf5mpy0Slb+0NME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E44CBF80430;
	Fri, 29 Jul 2022 16:58:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D554CF8049C; Fri, 29 Jul 2022 16:58:04 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82FACF8015B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2022 16:57:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82FACF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Ur57oCAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659106679; x=1690642679;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kpXPXDEKt8EWRIsz7zZNVRA+jmEVLhwG5JCEoBZEhYw=;
 b=Ur57oCATZXVJxVL7CWNWYH6fpDA40HMAQGoTTVahsUAbAO0IPu1l6K08
 nm2klPkTHy1CRNMzpcFb4k4+m1ktGRfEIHyOaEgieHuIqyW2xPyXSGiII
 Wj60HoZJV5V0loVG2iuJ1JUnvD5r1sx/YFqo+XRP3LFszN7M7yPKHaspR
 EzFx8W+4tigbuvdqzGWHr4ctgTgLd3IQAS3X35F4eBGyvEwaj2NECMMrT
 3MJhUq9osKrEW9KFZacaLL4DzFlt8bHuCHP6CO9olPXK6AODjHzucmmrw
 9NO/gPHZq0unK+spor0LU8i3bPbV3TnlYHcnkmwZpBzC1E8eU5fBRz9pw g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286332768"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; d="scan'208";a="286332768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2022 07:57:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; d="scan'208";a="604985399"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86])
 ([10.212.97.86])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2022 07:57:52 -0700
Message-ID: <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
Date: Fri, 29 Jul 2022 09:57:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuP0Ffs3G7ZBR0AC@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-kernel@vger.kernel.org,
 Sanyog Kale <sanyog.r.kale@intel.com>
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



On 7/29/22 09:52, Greg Kroah-Hartman wrote:
> On Fri, Jul 29, 2022 at 09:46:26AM -0500, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/29/22 08:50, Greg Kroah-Hartman wrote:
>>> There's no need to special-case the dp0 sysfs attributes, the
>>> is_visible() callback in the attribute group can handle that for us, so
>>> add that and add it to the attribute group list making the logic simpler
>>> overall.
>>>
>>> This is a step on the way to moving all of the sysfs attribute handling
>>> into the default driver core attribute group logic so that the soundwire
>>> core does not have to do any of it manually.
>>>
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
>>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
>>> Cc: alsa-devel@alsa-project.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
>>> index 83e3f6cc3250..3723333a5c2b 100644
>>> --- a/drivers/soundwire/sysfs_slave.c
>>> +++ b/drivers/soundwire/sysfs_slave.c
>>> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
>>>  }
>>>  static DEVICE_ATTR_RO(words);
>>>  
>>> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
>>> +			      int n)
>>> +{
>>> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
>>> +
>>> +	if (slave->prop.dp0_prop)
>>> +		return attr->mode;
>>> +	return 0;
>>> +}
>>
>> This changes the results slightly by creating an empty 'dp0' directory
>> with no attributes inside.
>>
>> Before:
>>
>> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
>> [root@fedora sdw:3:025d:0714:01]# ls dp0
>> ls: cannot access 'dp0': No such file or directory
>>
>> After:
>> [root@fedora sdw:3:025d:0714:01]# ls dp0
> 
> That should be fine, tools should just be looking for the attributes,
> not the existance of a directory, right?

The idea what that we would only expose ports that actually exist.
That's helpful information anyone with a basic knowledge of the
SoundWire specification would understand.

The attributes are really details that few people/applications would
understand, and unfortunately the information reported in DSDT is more
often than not complete garbage.

