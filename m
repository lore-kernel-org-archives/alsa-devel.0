Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63BFC433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F7F206B7
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AbQMepIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F7F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABEA316A5;
	Fri,  3 Jul 2020 11:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABEA316A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593768018;
	bh=DZcZU3xg5SzUkGaUrVFAJ4BIUxEhp+hzmja6AgpUO9g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AbQMepIOitBjgddZz6szDEel5SF4k1VoKxQtM1ID8SyVCpTE3X6dyn+mE2f701nkT
	 ROktvhKpXBOVzOLJ91nTFx3vIzSh3NbmjBXtXKv/I+s4Ovr/2kdhne7ldOHMupnm6c
	 BhBNAcKU+B82dOhVfVXcOlD7eq6dJuTA1A7VK5+c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 332B8F8020C;
	Fri,  3 Jul 2020 11:19:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14E75F80217; Fri,  3 Jul 2020 11:19:26 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E679BF800ED
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 11:19:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E679BF800ED
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id DB03F2A2D53
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>
References: <20200703071913.2358882-1-yuhsuan@chromium.org>
 <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com>
 <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cea2bc7e-035b-2c97-73bf-25dc55ab8801@collabora.com>
Date: Fri, 3 Jul 2020 11:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

Hi Yu-Hsuan,

On 3/7/20 10:48, Yu-Hsuan Hsu wrote:
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年7月3日 週五 下午4:38寫道：
>>
>> Hi Yu-Hsuan,
>>
>> Thank you for your patch
>>
>> On 3/7/20 9:19, Yu-Hsuan Hsu wrote:
>>> Log results of failed EC commands to identify a problem more easily.
>>>
>>> Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the result
>>> has already been checked in this function. The wrapper is not needed.
>>>
>>
>> Nack, we did an effort to remove all public users of cros_ec_cmd_xfer() in
>> favour of cros_ec_cmd_xfer_status() and you are reintroducing again. You can do
>> the same but using cros_ec_cmd_xfer_status(). In fact, your patch will not build
>> on top of the upcoming changes.
> Thanks! But I have a question about implementing it. Does it look like
> the one below?
> ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> if (ret < 0) {

In this case will already print an error.

What are you trying to achieve?

If the only reason is of this patch is print a message you should either, or
enable dynamic printk and enable dev_dbg or event better use the kernel trace
functionality. There is no need to be more verbose.

Example:
    $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
    $ cat /sys/kernel/debug/tracing/trace

    369.416372: cros_ec_request_start: version: 0, command: EC_CMD_USB_PD_POWER_INFO
    369.420528: cros_ec_request_done: version: 0, command:
EC_CMD_USB_PD_POWER_INFO, ec result: EC_RES_SUCCESS, retval: 16

Cheers,
 Enric

>   if (ret == -EPROTO)
>     dev_err(..., msg->result)
>   goto error;
> }
> I'm not sure whether it makes sense to check ret == -EPROTO here.
> 
>>
>>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>>> ---
>>>  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
>>> index 8d45c628e988e..a4ab62f59efa6 100644
>>> --- a/sound/soc/codecs/cros_ec_codec.c
>>> +++ b/sound/soc/codecs/cros_ec_codec.c
>>> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
>>>       if (outsize)
>>>               memcpy(msg->data, out, outsize);
>>>
>>> -     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>>> +     ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>       if (ret < 0)
>>>               goto error;
>>>
>>> +     if (msg->result != EC_RES_SUCCESS) {
>>> +             dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
>>> +                     msg->result);
>>> +             ret = -EPROTO;
>>> +             goto error;
>>> +     }
>>> +
>>>       if (insize)
>>>               memcpy(in, msg->data, insize);
>>>
>>>
