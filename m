From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/8] add device specific command
Date: Fri, 07 Jun 2013 07:49:03 +0900
Message-ID: <51B111DF.6030602@sakamocchi.jp>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
 <1370102158-24389-3-git-send-email-o-takashi@sakamocchi.jp>
 <51AC7B83.3060708@ladisch.de> <51B0C7F4.6020200@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D715261B24
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 00:49:10 +0200 (CEST)
In-Reply-To: <51B0C7F4.6020200@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

 > I got packet dump and confirm there is no EFC over AVC. As you say,
 > it commands to 0xecc0 00000 0000 and receives response at
 > 0xecc 8000 0000.

0xecc0 8000 0000 is correct address.


Regards

Takashi Sakamoto

(Jun 7 2013 02:33), Takashi Sakamoto wrote:
> Clemens,
>
>  > Do you have the latest firmware in your AFPre8?
>
> I use AFPre8 with firmware version 5.5 (0x5050000). I have never updated
> it after I bought so it's factory setting.
>
>  > It can also be controlled by sending the commands directly (without
>  > the AV/C header) to address 0xecc000000000.  This is one of the
>  > differences between FFADO and the Echo drivers,
>
> I got packet dump and confirm there is no EFC over AVC. As you say, it
> commands to 0xecc0 00000 0000 and receives response at 0xecc 8000 0000.
>
> Then I implemented it and it looks to work fine. I also think it good to
> use EFC without AVC.
>
>  > and might be related to the problems that FFADO has with the
>  > latest Fireworks firmware versions.
>
> Later I'll update firmware in my device and search for this issue. But
> it may be far future...
>
>  > That was part of my old driver, but most if this device-specific stuff
>  > is not needed for a simple kernel streaming driver.
>
> OK. I use this transaction to confirm the device can respond but it's
> needless. I'll remove it till posting improved patch.
>
>
> Regards
>
> Takashi Sakamoto
> o-takashi@sakamocchi.jp
>
> (Jun 3 2013 20:18), Clemens Ladisch wrote:
>> o-takashi@sakamocchi.jp wrote:
>>> Fireworks can be controlled by device specific commands over IEEE1394
>>> TA's
>>> AV/C Digital Interface Command Set.
>>
>> It can also be controlled by sending the commands directly (without the
>> AV/C header) to address 0xecc000000000.  This is one of the differences
>> between FFADO and the Echo drivers, and might be related to the problems
>> that FFADO has with the latest Fireworks firmware versions.
>>
>> Do you have the latest firmware in your AFPre8?
>>
>>> +struct avc_fields {
>>> +    unsigned short cts:4;
>>> +    unsigned short ctype:4;
>>>        ...
>>
>> The layout of bit fields are very unportable.  And if you do *not*
>> actually rely on the memory layout, you do not actually save space
>> because the code to access the fields becomes more complex.
>>
>>> +efc_over_avc(struct snd_efw *efw, unsigned int category,
>>
>>> +    /* AV/C fields */
>>> +    struct avc_fields avc_fields = {
>>> +        .cts        = AVC_CTS,
>>> +        .ctype        = AVC_CTYPE,
>>> +        .subunit_type    = AVC_SUBUNIT_TYPE,
>>> +        .subunit_id    = AVC_SUBUNIT_ID,
>>> +        .opcode        = AVC_OPCODE,
>>> +        .company_id    = AVC_COMPANY_ID
>>> +    };
>>
>> The compiler has to construct this on the stack.  Use "static const".
>>
>>> +    /* calcurate buffer size*/
>>
>>             calculate
>>
>>> +    if (param_count > response_quadlets)
>>> +        cmdbuf_bytes = 32 + param_count * 4;
>>> +    else
>>> +        cmdbuf_bytes = 32 + response_quadlets * 4;
>>
>> max()
>>
>>> +int snd_efw_command_identify(struct snd_efw *efw)
>>> +{
>>> +    return efc_over_avc(efw, EFC_CAT_HWCTL,
>>> +                EFC_CMD_HWCTL_IDENTIFY,
>>
>> That was part of my old driver, but most if this device-specific stuff
>> is not needed for a simple kernel streaming driver.
>>
>>
>> Regards,
>> Clemens
