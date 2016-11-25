From: marve <marve@xs4all.nl>
Subject: Re: problem with the driver for ALC3260 sound chip
Date: Fri, 25 Nov 2016 22:22:59 +0100
Message-ID: <763c7ae9-9f12-484d-e1ec-0bc7a09cb066@xs4all.nl>
References: <5e459889-c43b-6327-9928-b5a890a3c65e@xs4all.nl>
 <s5htwav5vyg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud3.xs4all.net (lb3-smtp-cloud3.xs4all.net
 [194.109.24.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 35F70266685
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 22:23:00 +0100 (CET)
In-Reply-To: <s5htwav5vyg.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 11/25/2016 06:08 PM, Takashi Iwai wrote:
> On Wed, 23 Nov 2016 21:42:26 +0100,
> marve wrote:
>> Dear all,
>>
>> Here a rephrase of my issue with TOSLINK SPDIF output of my Dell XPS One
>> 2710 system running Linux.
>>
>>
>> First: I have tried other hardware with my DTS receiver and the receiver
>> worked fine. Also I have checked the HDMI output of my computer, also
>> working!
>>
>> Second: The SPDIF output worked fine on a Windows 7 installation with
>> PCM and DTS. I stopped using Windows privately.
>>
>> Most success I got with debugging the SPDIF TOSLINK is:
>> - With the HDA Intel sound cards Jack Retasking tool:
>>      - Check Showing unconnected pins. Actually, the TOSLINK is
>> connected but shows "not connected" in the tool.
>>      - Manually override Pin ID 0x1e
>>      - Select "SPDIF Out" and "Apply Now"
> You're sure that this pin is correct?  I mean, did you get *any*
> signal from the SPDIF I/O by enabling this pin?
>
 No signal at all from the SPDIF Toslink port! The reason trying this
pin is that when overridden, it shows "SPDIF Out".
>> - Then with PulseAudio Volume Control:
>>     -  In the Configuration Tab, select "Profile: Digital Stereo
>> (IEC958) Output"
>>     -  In the Output Devices "Digital Output (S/PDIF)" appears and is
>> the only option and in the advanced tab PCM, DTS, AC3, MPEG, EAC3, AAC
>> are selected
>>
>>  - I check if in alsamixer tool that the SPDIF channel is unmuted
>>
>> When I play a sound, the vumeter of PulseAudio Volume Control does
>> react, see png attachment (https://postimg.org/image/5tu4rax9t/), but my
>> external DTS receiver doesn't get input!
> First off, you should try the normal audio PCM stream instead of DTS
> or such.  It's possible that the SPDIF status bits aren't properly set
> and the receiver doesn't accept the non-audio signals.
 Ok, I deselected all other streams except PCM, no signal.. (Will do
this in future tests).

> And, as a primary testing, please test with aplay.  You can pass
> -Dspdif or -Dspdif:1 option to transmit over the SPDIF device.
 I was able to run "aplay -Dspdif" without errors. I also checked in
another terminal if the alsamixer showed the s/pdif channels unmuted.
They are unmuted, but I didn't get a signal to my audio receiver. 

"aplay -Dspdif:1" didn't work: "Cannot find card".
> Last but not least, check the IEC958 status bits of the assigned PCM.
> You can use iecset program in alsa-utils for checking / setting the
> bits.
>
iecset -x shows:

AES0=0x05,AES1=0x82,AES2=0x00,AES3=0x00

Best,
Marijn
> Takashi
>
