Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066D4C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Nov 2022 09:35:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35AD516AE;
	Tue, 22 Nov 2022 10:34:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35AD516AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669109707;
	bh=ZtpOz3XNEb9aHrnZH6zKs5llxJjIX501g+xjG1WgWL8=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rd8o/MpzvnfHrWH/YGrB5IroQ5FNo3lVkmlAuwzeRUVGyzVjI2PeWm4HBr645D5ei
	 XmbW4IlPy9y7uG+E2uYCnNjgptQckWWUBpvzhhdn//avHF68nrEFkSIrc28QZFvwzs
	 Rf5r9Ljvcu6tP9PrcMfeVmhB1hAeEuPBD6LnWh9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 201BBF8061D;
	Tue, 22 Nov 2022 10:27:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABE8EF80272; Tue, 22 Nov 2022 09:54:45 +0100 (CET)
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com
 [115.124.28.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26B01F80115
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 09:54:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26B01F80115
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07855445|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.19499-0.000630966-0.804379;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047204; MF=michael@allwinnertech.com;
 NM=1; PH=DS; RN=8; RT=8; SR=0; TI=SMTPD_---.QE5zelE_1669107271; 
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com
 fp:SMTPD_---.QE5zelE_1669107271) by smtp.aliyun-inc.com;
 Tue, 22 Nov 2022 16:54:34 +0800
Message-ID: <80d747aa-df0e-88e1-7b62-c119bd469153@allwinnertech.com>
Date: Tue, 22 Nov 2022 16:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ALSA: usb-audio: fix urb timeout with URB_ISO_ASAP flag
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20221122082040.48591-1-michael@allwinnertech.com>
 <87tu2rv0kj.wl-tiwai@suse.de>
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <87tu2rv0kj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Nov 2022 10:27:19 +0100
Cc: alsa-devel@alsa-project.org, wanjiabing@vivo.com, aichao@kylinos.cn,
 ubizjak@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org
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

On 11/22/2022 4:46 PM, Takashi Iwai wrote:
> On Tue, 22 Nov 2022 09:20:40 +0100,
> Michael Wu wrote:
>>
>> When the loglevel is greater than 4, with a long messages printed on the
>> console while playing or recording audios, the usb controller may become
>> abnormal.
>> `usb 1-2: timeout: still 1 active urbs on EP #1`
>>
>> Fix it by configuring the transfer_flags URB_ISO_ASAP flag.
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> 
> Hrm, that's somewhat backward action to the change we've done years
> ago, commit c75c5ab575af7db707689cdbb5a5c458e9a034bb:
> 
>      ALSA: USB: adjust for changed 3.8 USB API
>      
>      The recent changes in the USB API ("implement new semantics for
>      URB_ISO_ASAP") made the former meaning of the URB_ISO_ASAP flag the
>      default, and changed this flag to mean that URBs can be delayed.
>      This is not the behaviour wanted by any of the audio drivers because
>      it leads to discontinuous playback with very small period sizes.
>      Therefore, our URBs need to be submitted without this flag.
> 
> I rather suspect that your problem is in the USB controller side.
> 
> 
> thanks,
> 
> Takashi
> 
Dear Takashi, thanks for the reminding. Let me check...

-- 
Regards,
Michael Wu
