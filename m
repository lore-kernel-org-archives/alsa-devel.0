Return-Path: <SRS0=gM+V=GD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D3C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Dec 2020 15:31:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015F620798
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Dec 2020 15:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015F620798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CD2D1699;
	Thu, 31 Dec 2020 16:31:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CD2D1699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609428712;
	bh=461qu8Sat/4rXWnutos8EWd7prfi4k6bwTzFkOGuyIE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nsCkr8CoUrNHv/rcU1pYUvFRIhFIUGQdxW5pzPT4qTK4oheRk0qXa+XM9N9J9Id09
	 0zR4x7ZCHa4Z75FBCNl7KSq25jKInyWQGp75HY27hd6psS5omin7+tZ2olN13RpTGj
	 uOilAlH21QEAFGGF4ycbeYQ2f3BjTh4JxFGXw048=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E763F8020C;
	Thu, 31 Dec 2020 16:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55AE6F8022B; Thu, 31 Dec 2020 16:31:00 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D662F8015F
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2020 16:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D662F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="N1ivUMAP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rCmzRgQ4NmzJnsW5QkY3AiIeE1tWx7YUFCjih+Ynqbg=; b=N1ivUMAPLwLWggWj371K7B2mJe
 eZE5c/Az11eJjsxRlr8Gb4b3Fioimr7Hd8UdKhjaipeVoLrSR7UVZqBx0NUW/1noJ4/eSJlj5OMnE
 VGJ7i5hnoIT+r3wbGHZCO0/ZAWFGFxqFh/uO12RvTPTVW7Onh5ivQsDEmRty6QIfaVxUj6zjpmeo0
 yhVuO6riWgwB6OSGjjEmNIh0lQPtf5rezg1/S6wUPU/4iMw9CUE8pCGzGzujjxPrZW9FhPvw4VlhF
 Z4mWrK/Sx/x9D4DIktPkUmOhjJQoVpKrwoNMWXPu5Sn5xbQiI03Dhko7/Edtm9X84r5bWRfB4v/ek
 7R63Kn7w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1kuzub-0005ay-Qs; Thu, 31 Dec 2020 16:30:50 +0100
Received: from [2001:a61:2af4:a201:9e5c:8eff:fe01:8578]
 by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1kuzub-0008af-M8; Thu, 31 Dec 2020 16:30:49 +0100
Subject: Re: Haswell audio no longer working with new Catpt driver
To: Christian Labisch <clnetbox@gmail.com>,
 amadeuszx.slawinski@linux.intel.com, gregkh@linuxfoundation.org,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>
References: <8b005c64fe129fc2a283da90b2949b1fcb42e8c2.camel@gmail.com>
 <1ad341b1b0e0eefb83d157ac24d162eaad53ab32.camel@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0111f282-f044-47ed-f93e-5a19de61bdce@metafoo.de>
Date: Thu, 31 Dec 2020 16:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1ad341b1b0e0eefb83d157ac24d162eaad53ab32.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26034/Thu Dec 31 13:42:27 2020)
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

Hi,

I'm taking this conversation back to the mailinglist. Hope you don't mind.

On 12/31/20 2:15 PM, Christian Labisch wrote:
> Hi Amadeusz, Greg, and Lars-Peter,
>
> Do you have a suggestion for a workaround ?
> A special boot parameter that I could add ?
> Will the drivers work in the next version ?

I had a quick look at the changes to the HDA driver between v5.9 and 
v5.10. And there isn't that much, expect some changes to power management.

Curiously enough pretty much your only difference between your v5.9 and 
v5.10 alsa-info.sh is that a few of the nodes are in D3 state (meaning 
powered down) in v5.10. One of them is the internal speaker.

But this could also be a coincidence, would be interesting to see what 
the output of alsa-info.sh looks like when the you are trying to play 
some audio. If it is still powered down then there is a bug.

- Lars


>
> Regards,
> Christian
>
>
>> On Thu, 2020-12-31 at 12:20 +0100, Amadeusz Sławiński wrote:
>>> On 12/31/2020 11:50 AM, Christian Labisch wrote:
>>>> Hi Lars-Peter,
>>>>
>>>> Thank you, please find attached the requested information from both kernels.
>>>> I freshly installed the fedora kernel 5.10.4 to give you the latest results.
>>>>
>>>> Regards,
>>>> Christian
>>>>
>>>> Christian Labisch
>>>> Red Hat Accelerator
>>>> clnetbox.blogspot.com
>>>> access.redhat.com/community
>>>> access.redhat.com/accelerators
>>>>
>>>>
>>>> On Thu, 2020-12-31 at 11:04 +0100, Lars-Peter Clausen wrote:
>>>>> On 12/31/20 9:33 AM, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Dec 30, 2020 at 07:10:16PM +0100, Christian Labisch wrote:
>>>>>>> Update :
>>>>>>>
>>>>>>> I've just tested the kernel 5.10.4 from ELRepo.
>>>>>>> Unfortunately nothing changed - still no sound.
>>>>>> Ah, sad.  Can you run 'git bisect' between 5.9 and 5.10 to determine the
>>>>>> commit that caused the problem?
>>>>> The problem is that one driver was replaced with another driver. git
>>>>> bisect wont really help to narrow down why the new driver does not work.
>>>>>
>>>>> Christian can you run the alsa-info.sh[1] script on your system and send
>>>>> back the result?
>>>>>
>>>>> You say sound is not working, can you clarify that a bit? Is no sound
>>>>> card registered? Is it registered but output stays silent?
>>>>>
>>>>> - Lars
>>>>>
>>>>> [1] https://www.alsa-project.org/wiki/AlsaInfo
>>>>> <https://www.alsa-project.org/wiki/AlsaInfo>
>>>>>
>>>>>
>>> Hi,
>>>
>>> from reading provided files it seems that you use snd_intel_hda driver,
>>> it should be possible to git bisect it between 5.9 and 5.10 as it wasn't
>>> replaced.
>>>
>>> Catpt driver is used on machines using DSP.
>>>
>>> Amadeusz


