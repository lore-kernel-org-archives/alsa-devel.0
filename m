Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CB7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 06:56:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C9C207D0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9C207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 855F8179E;
	Tue, 26 Jan 2021 07:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 855F8179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611644196;
	bh=AtPJziPA/LRhtdSsrfS0xfQxO3j6joBVNfMGn5M0igo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWhEFKxy6RtN0FY4ybAdSkdtAtPEBUCx7aB1iKoMF7TMBI0ZMEPeHae64a8CBf7L6
	 jfXQtoV2C/YL692AYUIXNEY2Dffg/6wMiDPnHehppFjqL7s9BtWWTs8gjhGWOZ2x8/
	 9eCJnkv4WBjGOcLdQVgxlwtJbsF8P+Ms3fbQy3+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D164AF80158;
	Tue, 26 Jan 2021 07:55:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B3C7F8015B; Tue, 26 Jan 2021 07:55:43 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A41B5F80108
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 07:55:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A41B5F80108
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=[192.168.1.24]) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1l4IGE-0000xD-R1; Tue, 26 Jan 2021 06:55:35 +0000
Subject: Re: [PATCH v7 1/1] alsa: jack: implement software jack injection via
 debugfs
To: Takashi Iwai <tiwai@suse.de>
References: <20210125032118.13269-1-hui.wang@canonical.com>
 <20210125032118.13269-2-hui.wang@canonical.com>
 <s5ha6sx3x5i.wl-tiwai@suse.de>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <ecb8450b-c7be-52ff-e6f2-876c2177cb21@canonical.com>
Date: Tue, 26 Jan 2021 14:55:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <s5ha6sx3x5i.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com
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


On 1/25/21 10:32 PM, Takashi Iwai wrote:
> On Mon, 25 Jan 2021 04:21:18 +0100,
> Hui Wang wrote:
>> This change adds audio jack injection feature through debugfs, with
>> this feature, we could validate alsa userspace changes by injecting
>> plugin or plugout events to the non-phantom audio jacks.
>>
>> With this change, the sound core will build the folders
>> $debugfs_mount_dir/sound/cardN if SND_DEBUG and DEBUG_FS are enabled.
<snip>
>> +		return -ENOMEM;
>> +
>> +	/* replace the chars which are not suitable for folder's name with _ */
>> +	for (i = 0; i < strlen(tname); i++)
> No need to use strlen(), just check the NUL character on tname[i].
OK, will change it to:     for (i = 0; tname[i] != '\0'; i++)
>
>> --- a/sound/core/sound.c
>> +++ b/sound/core/sound.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/time.h>
>>   #include <linux/device.h>
>>   #include <linux/module.h>
>> +#include <linux/debugfs.h>
>>   #include <sound/core.h>
>>   #include <sound/minors.h>
>>   #include <sound/info.h>
>> @@ -39,6 +40,9 @@ MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
>>   int snd_ecards_limit;
>>   EXPORT_SYMBOL(snd_ecards_limit);
>>   
>> +struct dentry *sound_debugfs_root;
>> +EXPORT_SYMBOL_GPL(sound_debugfs_root);
> I guess this should be wrapped with CONFIG_SND_DEBUG ifdef?

OK, will add the wrap.

thanks,

Hui.

>
>
> thanks,
>
> Takashi
