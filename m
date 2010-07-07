From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Wed, 07 Jul 2010 15:19:51 +0200
Message-ID: <4C347EF7.2030401@web.de>
References: <4C32E3B2.5080707@web.de> <4C344340.8060804@web.de>
	<4C3476BD.4090702@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id AB3D5244C3
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:19:52 +0200 (CEST)
In-Reply-To: <4C3476BD.4090702@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 07.07.2010 14:44, schrieb Clemens Ladisch:
> The descriptors already list these rates, so in theory, the existing
> code that sets UAC_EP_CS_ATTR_SAMPLE_RATE should already have enabled
> this.  Didn't it?  In other words, what is the difference in the
> explicitly specified audioformat?

I can only tell you the difference to the behaviour of latest git Alsa 
before this patch:

44100 and 88200 Hz had already been enabled. But the device could not 
properly be used at these sampling rates. Everything would sound 
distorted. After a while of running the device at these sample rates, my 
systems had a tendency to crash/freeze.

> (I have the suspicion that we don't actually need a AUDIO_FIXED_ENDPOINT
> quirk for these devices.)
>
>    

Something must be in this AUDIO_FIXED_ENDPOINT quirk, since the device 
now works properly and stable @44.1/88.2 kHz. I don't know the exact 
reason, since I really don't understand all this stuff. I just have this 
device and try to fix it's behaviour.

>> * apparently, fixes some crashes, too
>>      
> When do these crashes happen?
>    

See above: System crashes occured when using the device at 44.1/88.2 kHz.

> If you don't have the exclusive copyright for the code in this patch,
> there needs to be a Signed-off-by line from him, too.  OTOH, a table
> like this probably isn't copyrightable at all.
>    

If the patch is copyrightable then its copyright belongs to you: The 
patch I send some time ago to enable basic support for these devices was 
an updated version of *your* patch send some time ago to a mailing list. 
The patch dhubsith posted was explicitly based on existing code in 
quirks-table.h and the existing quirk.

Take a look at the entry for the Digidesign Mbox (credited to you): It's 
essentially the same.

>> -	USB_DEVICE(0x0763, 0x2080),
>> +		USB_DEVICE(0x0763, 0x2081),
>> ...
>>      
> This replaces the ID of the Ultra 8 ID with that of the Ultra 8R ...
>    

Ooops. I've messed it up... (I've just got the 8R version so I didn't 
notice...)

>>   	USB_DEVICE(0x0763, 0x2081),
>> -	.driver_info = ...
>> +		.driver_info = ...
>>      
> ... and this just changes the other 8R entry.  So now the 8 doesn't
> have an entry.
>
>    

Actually both quirk blocks shoud be the same except for the USB_DEVICE 
lines:

USB_DEVICE(0x0763, 0x2080) <- Fast Track Ultra
USB_DEVICE(0x0763, 0x2081) <- Fast Track Ultra 8R

(Actually there's no "Fast Track Ultra 8")


Sorry for having messed the patch up and sending it too soon. Shall I 
send a new patch, or would you consider manually editing it yourself 
before eventually putting it into git?

Kind regards,

Felix
