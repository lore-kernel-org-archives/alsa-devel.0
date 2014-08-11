From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 12/15] oxfw: Add support for
	Behringer/Mackie devices
Date: Tue, 12 Aug 2014 08:48:52 +0900
Message-ID: <53E95664.7020707@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
 <53E795C5.1010506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C28261A53
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 01:48:59 +0200 (CEST)
In-Reply-To: <53E795C5.1010506@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Aug 11 2014 00:54, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Some devices produced by Behringer/Mackie are based on OXFW970/971. This
>> commit adds support for them.
>>
>> +++ b/sound/firewire/oxfw/oxfw.c
>> @@ -16,6 +16,8 @@
>>
>>  #define VENDOR_GRIFFIN		0x001292
>>  #define VENDOR_LACIE		0x00d04b
>> +#define VEN_BEHRINGER		0x001564
>> +#define VEN_LOUD		0x000ff2
> 
> These IDs were supposed to be ordered. :)

OK, indeed.

> And why "VEN_" instead of "VENDOR_"?

I avoided to type three letters "DOR" and use the same way as BeBoB
driver. But I don't mind to use "VENDOR_" instead.

>> +	...
>> +	{
>> +		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
>> +				  IEEE1394_MATCH_MODEL_ID,
>> +		.vendor_id	= VEN_LOUD,
>> +		.model_id	= 0x000460,
>> +	},
>> +	/* IDs are unknown but able to be supported */
>> +	/*  Mackie(Loud), d.2 pro */
>> +	/*  Mackie(Loud), d.4 pro */
>> +	/*  Mackie(Loud), U.420 */
>> +	/*  Mackie(Loud), U.420d */
> 
> To support all Mackie devices, use one ID entry with only the vendor ID,
> and abort with -ENODEV from the _probe function if the hardware is not
> actually an OXFW97x device (try to read the HARDWARE_ID and/or
> FIRMWARE_ID registers).

In this idea, OXFW driver transfers the transaction(s) for all of
Mackie(Loud) devices on IEEE 1394 bus when they're probed. I want to
avoid such changes possible to affects the other models on the same bus
because I'm afraid of side effects.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
