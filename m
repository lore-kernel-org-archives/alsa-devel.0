From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Tue, 9 Nov 2010 16:44:16 +0530
Message-ID: <AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00313103835
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 12:14:17 +0100 (CET)
Received: by wwi17 with SMTP id 17so4660473wwi.20
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 03:14:17 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 26, 2010 at 12:54 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 26 Oct 2010, Manu Abraham wrote:
>
>> Hi,
>>
>> I have been wondering how to interface a Scatter Gather region as a DMA
>> buffer for an Audio Grabbing device.
>> The device is a NOC type device, similar to a SOC, the audio grabber is a
>> part of it, for realizing the audio
>> capabilities on the device.
>>
>> The hardware DMA is mostly a Scatter Gather based engine, and it can be
>> described thus, briefly.
>
> Use snd_pcm_lib_preallocate_pages_for_all() - type SNDRV_DMA_TYPE_DEV_SG and
> snd_pcm_sgbuf_* routines. Check hda_intel.c source for more details.
>

I have something like this: http://202.88.242.108:8000/saa7231_audops.c

testbox ~ # arecord -L
default:CARD=SB
    HDA ATI SB, ALC889A Analog
    Default Audio Device
front:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    Front speakers
surround40:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=SB,DEV=0
    HDA ATI SB, ALC889A Digital
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=BGT35950
    BGT3595-0, SAA7231 PCM
    Default Audio Device

testbox ~ # arecord -Dhw:2,0
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: set_params:957: Broken configuration for this PCM: no
configurations available


[  719.292194] saa7231_capture_open (0): ()
[  719.292390] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  719.292393] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  719.292395] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  719.292397] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  719.292398] saa7231_capture_close (0): DEBUG: Closing stream

Any idea, why saa7231_hw_params is not getting invoked ?

Thanks,
Manu
