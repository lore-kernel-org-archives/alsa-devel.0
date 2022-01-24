Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5ACC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jan 2022 20:53:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4D701FC5;
	Mon, 24 Jan 2022 21:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4D701FC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643057583;
	bh=+DNGFlxJpec0prr/HhvnV79CA38jd9Qx/NRP3w8irSk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lojYpNceWCA+QZ+NEmWnZlKSdbO436aXLS58WLnpRa5z1mlwj8noj0dTptCGy6HDd
	 hJUck6IBqdfvks3OyOd5M90X20uC+MkSXKyHtJ5h/0QRwcmDNDIy0khsefbOT4HxX9
	 CqJqCHabUzwLhYCQFGty0v0uidLZrjRC5q0q1kf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A5CCF80163;
	Mon, 24 Jan 2022 21:52:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13CE7F8027C; Mon, 24 Jan 2022 21:52:12 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFE65F80161
 for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2022 21:52:02 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5466DA0040;
 Mon, 24 Jan 2022 21:52:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5466DA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1643057521; bh=Bdb2/K1KILOJF111ixqo07LXtR51VlXcC6nOaMq5wTI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ro/R2pILaiqtQ6YqNXIY3YuNix7LqqFrSvJ0UdDl9P3VcGZ9Uw1zxMCl6x8jPqWbB
 PaK+f9kpIF5h6Lk5cStkb/9APASNIp0f+aXdZ+XFORdwWWUWT8aogdtypOJV/QptGW
 hK/7hmVaatFAlLI5lKaY3V1FdoZeWkUKDjXf7fd8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 24 Jan 2022 21:51:57 +0100 (CET)
Message-ID: <b2261da9-e2ab-eede-9a08-d084f7ee7e4f@perex.cz>
Date: Mon, 24 Jan 2022 21:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/3] ASoC: Add bounds checking for written values
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220124153253.3548853-1-broonie@kernel.org>
 <9eecf478-b705-7273-7553-24bafaec5404@perex.cz>
 <Ye7ZXvIK3sVkvzQJ@sirena.org.uk> <s5hzgnloycd.wl-tiwai@suse.de>
 <b4f715f5-7a52-f433-e11d-53b23ed3f3ad@perex.cz>
 <Ye8JCQdN0hfgr/Z8@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <Ye8JCQdN0hfgr/Z8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

On 24. 01. 22 21:16, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 08:20:25PM +0100, Jaroslav Kysela wrote:
>> On 24. 01. 22 18:08, Takashi Iwai wrote:
> 
>>> Jaroslav, is you concern only about the compatibility of user-space?
>>> Or anything else?  The compatibility is always certainly a slight
>>> issue; if this breaks really something useful and actually working
>>> stuff, we need to consider the workaround...
> 
>> My concern is only based on the fact that this code is normally not
>> reachable. It only costs some CPU ticks and adds extra code to the drivers
>> without any other benefit. The applications should not use out of range
>> values and if they do, the behavior is not defined (the drivers should only
>> avoid crashes).
> 
>> The code seems to be added only to make things consistent for the test
>> applications. I don't think that it's worth to care only for this reason.
>> What is the goal for this code? The result with the proposed code will be -
>> the SoC core has the extra validation conditions.
> 
> We need these checks all the time for the generic ASoC controls since
> the values for the controls are stored in the underlying device's
> register map so the out of range values will be written to the hardware,
> pushing it out of specified use.  That's not a great idea in general and
> in extreme cases could result in physical damage to the system.  The
> biggest risk I see here is around speaker drivers since they deal with
> high powers, even ignoring silicon requirements we also don't currently
> enforce platform maximums that the machine drivers specify - that
> feature was added after an inexperienced user burnt out the speakers in
> their Chromebook since the speakers in the system were rated for much
> lower powers than the CODEC was able to deliver.

It may be good to add this to the comment for two related patches. It's not 
obvious from the first glance. So one condition is a must.

>> Basically, I think that those checks should be marked as debug and they
>> should be optional like we do for CONFIG_SND_CTL_VALIDATION and enable only
>> the fast path by default.
> 
> Note also that for everything using these helpers the underlying
> register map will be regmap based and with the possible exception of
> MMIO based regmaps the cost of writing out the new register value will
> be overwhelmingly greater than that of the bounds checks.  It is
> extremely hard to envision a scenario in which even a pathological
> application would be able to observe a meaningful performance impact.

It's true that your patches are touching the universal code.

I stop complain for now. I just don't like to add chunks of the extra code 
just to resolve something which is not eventually a problem.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
