Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFAC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8879661954
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879661954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 338741676;
	Fri, 19 Mar 2021 19:11:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 338741676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616177552;
	bh=Ocsc8BZ25Ib3RG1yUV+GWtusdsaiM4vGTciw88pDbpc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7sKBZqATW6t+SOW0vFN8OWggfIMQVNs6/A7UbPgg+M9NbtI7sTt2vjaFi0FeKPQV
	 AUUgiHVduulpqusKnb9qHxGUd72F+u2GCko95ybquzd5fKZHXXmvV7HIxLvMClAdru
	 gF+yaLaTFo7+JExNeCoUimdPmBuU1f0Xki7WaQgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D539F801F7;
	Fri, 19 Mar 2021 19:11:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD07FF8021C; Fri, 19 Mar 2021 19:11:40 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51A12F80124
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 19:11:32 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 069DBA003F;
 Fri, 19 Mar 2021 19:11:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 069DBA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616177492; bh=C7iyN8k86TZMDc8qtgZ4qdQmUe9RUpP9eCva1jyw7QI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BLaR6I/Eog9VyCa1yVVOic/TuUiZ0pGKiuXEUJdpEQsdAE6w/UfYFIqIZQjf5rQet
 7v4KPIv3UHbBKdt9JnjpchmrpCOEhNH2an2y0gsBCctARUxlVsGWN7MlcgdTwErh65
 wjaKf+6ZUdHRasfv/+Tpd/a3FcvXZJ7Nkc6Hezik=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 19 Mar 2021 19:11:28 +0100 (CET)
Subject: Re: [PATCH v4 6/6] ALSA: led control - add sysfs kcontrol LED marking
 layer
To: Hans de Goede <hdegoede@redhat.com>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20210317172945.842280-1-perex@perex.cz>
 <20210317172945.842280-7-perex@perex.cz>
 <a3ddb881-6580-cd25-ef3c-734e686e6942@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ba480ab5-80b7-d911-052b-53b1e8d43695@perex.cz>
Date: Fri, 19 Mar 2021 19:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a3ddb881-6580-cd25-ef3c-734e686e6942@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>
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

Dne 19. 03. 21 v 17:34 Hans de Goede napsal(a):
> Hi,
> 
> On 3/17/21 6:29 PM, Jaroslav Kysela wrote:
>> We need to manage the kcontrol entries association for the LED trigger
>> from the user space. This patch adds a layer to the sysfs tree like:
>>
>> /sys/devices/virtual/sound/ctl-led/mic
>>    + card0
>>    |  + attach
>>    |  + detach
>>    |  ...
>>    + card1
>>       + attach
>>       ...
>>
>> Operations:
>>
>>   attach and detach
>>     - amixer style ID is accepted and easy strings for numid and
>>       simple names
>>   reset
>>     - reset all associated kcontrol entries
>>   list
>>     - list associated kcontrol entries (numid values only)
>>
>> Additional symlinks:
>>
>> /sys/devices/virtual/sound/ctl-led/mic/card0/card ->
>>   /sys/class/sound/card0
>>
>> /sys/class/sound/card0/controlC0/led-mic ->
>>   /sys/devices/virtual/sound/ctl-led/mic/card0
>>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> 
> Thank you so much for this patch.
> 
> I've given this new version a try, dropping my sound/soc/codecs/rt56??.c patches to set the access-flags directly.
> 
> And with these 3 lines in /etc/rc.d/rc.local I get nicely working control of the mute
> LED build into the (detachable) USB-keyboard's mute hot-key:
> 
> modprobe snd_ctl_led
> echo -n name="Speaker Channel Switch" > /sys/class/sound/card1/controlC1/led-speaker/attach
> echo -n name="HP Channel Switch" > /sys/class/sound/card1/controlC1/led-speaker/attach
> 
> This needs to be replaced by some UCM profile code doing the equivalent of course,
> but for a proof-of-concept test of the kernel API this introduces the above will do.

I added already the FixedBootSequence support to alsa-lib and alsactl and the "sysset" sequence command. But looking to this command now, it may be better to rename it to "sysw" ("double s" does not look so great).

> Only complaint which I have is the need to add "-n" to the echo commands,
> it would be nice if set_led_id() would check if the copy which it stores in buf2
> ends with "\n" and if it does if it would then strip that from the copy in buf2.

Yes, I will fix that. It's possible to use the shorter string:

echo "Speaker Channel Switch" > /sys/class/sound/card1/controlC1/led-speaker/attach


				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
