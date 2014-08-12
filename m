From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 12/15] oxfw: Add support for
	Behringer/Mackie	devices
Date: Wed, 13 Aug 2014 08:21:01 +0900
Message-ID: <53EAA15D.1030306@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
 <53E795C5.1010506@ladisch.de> <53E95664.7020707@sakamocchi.jp>
 <53E9C33A.2090508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 132AC265357
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 01:21:06 +0200 (CEST)
In-Reply-To: <53E9C33A.2090508@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, "fen >> Jay Fenlason" <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Aug 12 2014 16:33, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Aug 11 2014 00:54, Clemens Ladisch wrote:
>>> Takashi Sakamoto wrote:
>>>> +	/* IDs are unknown but able to be supported */
>>>> +	/*  Mackie(Loud), d.2 pro */
>>>> +	/*  Mackie(Loud), d.4 pro */
>>>> +	/*  Mackie(Loud), U.420 */
>>>> +	/*  Mackie(Loud), U.420d */
>>>
>>> To support all Mackie devices, use one ID entry with only the vendor ID,
>>> and abort with -ENODEV from the _probe function if the hardware is not
>>> actually an OXFW97x device (try to read the HARDWARE_ID and/or
>>> FIRMWARE_ID registers).
>>
>> In this idea, OXFW driver transfers the transaction(s) for all of
>> Mackie(Loud) devices on IEEE 1394 bus when they're probed. I want to
>> avoid such changes possible to affects the other models on the same bus
>> because I'm afraid of side effects.
> 
> The only other known Mackie devices are the 400F/1200F.  The Fireworks
> firmware doesn't blow up if you try to read unsupported registers, but
> if you want to be sure, you can blacklist these two IDs.

As long as I know, Mackie (Loud) produced FireWire sound devices with
Fireworks, OXFW and Dice. But I don't know all models at all. There may
be models with the other chipset.

Furthermore, hardware vendors sometimes add customization to firmware
for their models.

I think we should not stand on such assumption.

> Or just do the detection like the Windows driver, through the vendor/
> model name strings (this is what my old Fireworks driver did because
> I didn't know all model IDs; see match_echofire_device_name).  The
> Mackie driver's .inf file has this list of device identifiers:
> 
> "AVC\Loud_Technologies_Inc.&Onyxi&typ_1"
> "AVC\Loud_Technologies_Inc.&Onyx_1640i&typ_1"
> "AVC\Loud_Technologies_Inc.&Onyx-i&typ_1"
> "AVC\Loud_Technologies_Inc.&d.Pro&typ_1"
> "AVC\Loud_Technologies_Inc.&Mackie_Onyx_Satellite&typ_1"
> "AVC\Loud_Technologies_Inc.&Tapco_LINK.firewire_4x6&typ_1"
> "AVC\Loud_Technologies_Inc.&U.420&typ_1"
> "AVC\Mackie&Onyx_Firewire&typ_1"
> 
> (This format is documented at <http://msdn.microsoft.com/en-us/library/windows/hardware/ff556371.aspx>;
> apparently, spaces are replaced with "_".)

This is a good idea.

I note that Mackie Onyx-i series has two revisions. OXFW was used for
the former revision. Dice is used for the latter revision. See:
http://www.mackie.com/products/onyxiseries/drivers/

When using this idea, we have a need to distinguish these two revisions
for prevention from applying OXFW driver to the latter revision. Do you
have any good idea?


Regards

Takashi Sakamoto
(In summer vacation)
o-takashi@sakamocchi.jp
