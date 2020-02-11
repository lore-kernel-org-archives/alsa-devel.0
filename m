Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03946C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:36:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE5320873
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CnyEQPdW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1tAsP1W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AD2C15E2;
	Tue, 11 Feb 2020 10:35:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AD2C15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581413781;
	bh=MWkNcP6X0Qjhuu8vI9FSjKlSQvTuaTsO1G2hYSt/VeU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CnyEQPdWrCWWjKCTdVGfR/IFK5H1QxmInZyclRxu8lD9vjmFs+eLtc7PSxDBZhIyh
	 k/aKbWD9LTnu/QG6RyoI5dhlrqCNkOrTOl5IWIs95t0Llh8pqBUbHWnDJ08bopMNtx
	 3tqM1ze+SOGF6psnOAv3nww210qc9GqS8LOPcF6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFD06F8013E;
	Tue, 11 Feb 2020 10:35:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD75DF80145; Tue, 11 Feb 2020 10:35:28 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9329F800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 10:35:25 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D4441A0040;
 Tue, 11 Feb 2020 10:35:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D4441A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1581413724; bh=9IvGzzJGYDpncBJXTDMIMmetMvPwcS5FQO6sWG2ZxZw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=1tAsP1W7o90yfr++XbusgfY8zfv4DAXfLPRYYILiXMMlAqIlryn66KifzDWpXbhJk
 g1UeIqDxhktfoUsaJHSGVLpu6adOeEFYzUkRjZ//2GOP7AusIvsx7+Njcgn3Fqsa+s
 iPy1whLIQ627dViOqlOXVUp3y3DfP7IQaMEDR6TI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 11 Feb 2020 10:35:19 +0100 (CET)
To: Benjamin Poirier <benjamin.poirier@gmail.com>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
 <20200211055651.4405-2-benjamin.poirier@gmail.com>
 <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz> <20200211081604.GA8286@f3>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <901c395a-7fb5-5672-5955-d6d211824177@perex.cz>
Date: Tue, 11 Feb 2020 10:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211081604.GA8286@f3>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo
 Thinkpad X1 Carbon 7th quirk value
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

Dne 11. 02. 20 v 9:16 Benjamin Poirier napsal(a):
> On 2020/02/11 08:40 +0100, Jaroslav Kysela wrote:
> [...]
>>>
>>> In summary, Node 0x17 DAC connection 0x3 offers the loudest max volume and
>>> the most detailed mixer controls. That connection is obtained with quirk
>>> ALC295_FIXUP_DISABLE_DAC3. Therefore, change the ThinkPad X1 Carbon 7th to
>>> use ALC295_FIXUP_DISABLE_DAC3.
>>
>> The volume split (individual volume control) will cause trouble for the UCM
>> volume control at the moment which is the target for this device to get the
>> digital microphone working. If there is no possibility to share DAC, it
>> would be probably more nice to join the volume control in the driver.
>>
>> Have you tried to use 0x03 as source for all four speakers?
> 
> Front speakers are fixed to 0x02. Node 0x14
>    Connection: 1
>       0x02
> 

Yes, you're right. I forgot that.

>>
>> Why PA handles the rear volume control with the current driver code in the
>> legacy ALSA driver? It should be handled like standard stereo device. I'll
>> check.
> 
> The device comes up with "Analog Stereo Output" profile by default. I
> changed it to "Analog Surround 4.0 Output" to test controlling each
> channel individually:

Yes, but does the volume control work (does PA change the appropriate ALSA 
mixer volume)? Sometimes, it's difficult to see the difference between soft 
volume attenuation and the hardware volume control.

> 
>>> pavucontrol controls are reported with the device configured with the
>>> "Analog Surround 4.0 Output" profile.
> 
>>
>> You should also test PA with UCM.
> 
> Please let me know what do I need to test exactly? I'm not familiar with
> UCM.

Just install the latest pulseaudio (latest from repo), alsa-lib and 
alsa-ucm-conf (also from repo). If pulseaudio detects UCM, it has the preference.

						Jaroslav

> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
