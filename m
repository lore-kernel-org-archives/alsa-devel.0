Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C242AC25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 13:51:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DC041637;
	Wed, 17 Aug 2022 15:51:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DC041637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660744312;
	bh=9Yaqi+m8ChFNbfaROQijtuQQ66gButpRyuitR8CaRyE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RkTt6DXrVvqnZNq/Kuv+9CdwiPcjG6PJDevzls0aP0WSF97ungeWARF+zaPPVjypV
	 8ioy9f0pW/52rMIo1bZNCwRGZSBApiLofurDeVD2WIV9ED2p+x/jsKMxoIhQo8zpm2
	 wwdnAptiOy6dRZOJH9xlTzoRaXsYB99isBmsJVx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8D5EF800EE;
	Wed, 17 Aug 2022 15:51:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34E35F80130; Wed, 17 Aug 2022 15:51:00 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47870F80088
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 15:50:53 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 70125A003F;
 Wed, 17 Aug 2022 15:50:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 70125A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1660744253; bh=kWNM/l4cGXtRNJNnJUjIWx7kir9qzl4BpMfWPCBvNFA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dwHrBH3I2wyNIpL5K+++2lfccffo6SVwUuRvYO8b0+g2R41HNCim/EzznH6DRQChs
 iZyeiFRJzi+miUvTi0xuuX13UcbMiJMpZ0UQALVkf5R5pI1/fKgbjlp7FFX+fFaDe/
 d/s2Efs/Xgsj6vyQzIkiDcA6zW/APSpVoGNwtPmM=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 17 Aug 2022 15:50:48 +0200 (CEST)
Message-ID: <333f43c3-f8f6-694d-5aa7-4878bf7a8dd5@perex.cz>
Date: Wed, 17 Aug 2022 15:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND][PATCH] ALSA: info: Fix llseek return value when using
 callback
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
References: <20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com>
 <7324df1d-0424-a589-f7c9-df089a6cbefe@linux.intel.com>
 <87ilmrauad.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87ilmrauad.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

On 17. 08. 22 15:12, Takashi Iwai wrote:
> On Wed, 17 Aug 2022 14:56:05 +0200,
> Amadeusz Sławiński wrote:
>>
>> On 8/17/2022 2:49 PM, Amadeusz Sławiński wrote:
>>> When using callback there was a flow of
>>>
>>> 	ret = -EINVAL
>>> 	if (callback) {
>>> 		offset = callback();
>>> 		goto out;
>>> 	}
>>> 	...
>>> 	offset = some other value in case of no callback;
>>> 	ret = offset;
>>> out:
>>> 	return ret;
>>>
>>> which causes the snd_info_entry_llseek() to return -EINVAL when there is
>>> callback handler. Fix this by setting "ret" directly to callback return
>>> value before jumping to "out".
>>>
>>> 73029e0ff18d ("ALSA: info - Implement common llseek for binary mode")
>>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>> ---
>>>    sound/core/info.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/core/info.c b/sound/core/info.c
>>> index b8058b341178..0b2f04dcb589 100644
>>> --- a/sound/core/info.c
>>> +++ b/sound/core/info.c
>>> @@ -111,9 +111,9 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
>>>    	entry = data->entry;
>>>    	mutex_lock(&entry->access);
>>>    	if (entry->c.ops->llseek) {
>>> -		offset = entry->c.ops->llseek(entry,
>>> -					      data->file_private_data,
>>> -					      file, offset, orig);
>>> +		ret = entry->c.ops->llseek(entry,
>>> +					   data->file_private_data,
>>> +					   file, offset, orig);
>>>    		goto out;
>>>    	}
>>>    
>>
>> Doing resend, because I did copy paste mistake when pasting Takashi
>> email to git command, additionally alsa-devel blocked my previous
>> mail.
>> I've seen that Cezary already discussed this issue, and it doesn't
>> seem to be fixed, can this be somehow investigated? I guess we can
>> provide response we get from server when email fails?
> 
> It seems working now.  Jaroslav mentioned that it was some DNS
> problem.

It seems that my MTA was affected by this problem:

https://www.claudiokuenzler.com/blog/1231/postfix-reject-mails-blocked-using-zen-spamhaus-dnsbl-open-resolver

I changed DNS servers, so the problem should be fixed. I will monitor the 
situation next days.

Thank you all for the feedback.

						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
