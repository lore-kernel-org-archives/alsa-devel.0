From: Ben Firshman <ben@firshman.co.uk>
Subject: Re: Hda-intel: AC_VERB_SET_PIN_WIDGET_CONTROL appears
	to do nothing for HDMI device
Date: Sun, 9 Mar 2008 13:05:39 +0000
Message-ID: <0E87486E-FCE3-49CB-AB88-343FB6FB468E@firshman.co.uk>
References: <0617DD65-FC77-47C7-922E-FD9202375816@firshman.co.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.firshman.co.uk (unknown [81.2.121.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C3D224629
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2008 14:05:42 +0100 (CET)
Received: from macbook.intra ([192.168.211.179])
	by mail.firshman.co.uk with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63) (envelope-from <ben@firshman.co.uk>) id 1JYLDf-0005O7-NM
	for alsa-devel@alsa-project.org; Sun, 09 Mar 2008 13:05:41 +0000
In-Reply-To: <0617DD65-FC77-47C7-922E-FD9202375816@firshman.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It appears that on boot, nothing gets set, but if I reload the module  
it works:

ben@mythfrontend:~$ cat /proc/asound/card0/codec#1
Codec: Generic 1095 SI1390 HDMI
Address: 1
Vendor Id: 0x10951390
Subsystem Id: 0xffffffff
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
     rates [0x0]:
     bits [0x0]:
     formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6211: Stereo Digital
   Converter: stream=0, channel=0
   Digital: Enabled Copyright GenLevel
   Digital category: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0x1e]: 16 20 24 32
     formats [0x5]: PCM AC3
Node 0x03 [Pin Complex] wcaps 0x40738d: Stereo Digital Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0894: OUT Detect R/L
   Pin Default 0x98460010: [Fixed] SPDIF Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x02
ben@mythfrontend:~$

The unmuting looks like it's working too (Amp-Out vals:  [0x00 0x00]).  
I'm still not getting any sound though - my amp just says  
"Detecting...".

Is the GPIO line significant? As far as I can tell from the docs, that  
just means there are no GPIOs.

Ben

On 9 Mar 2008, at 00:10, Ben Firshman wrote:

> This is on 1.0.16. Forgive me if I appear clueless, I have only been
> working on this for the past few hours.
>
> In an attempt to get HDMI audio working on the AppleTV, I have added
> this line to the presets in patch_atihdmi.c:
>
> { .id = 0x10951390, .name = "SI1390 HDMI", .patch = patch_atihdmi },
>
> The device is detected fine:
>
> ben@mythfrontend:~$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC882 Analog [ALC882 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 1: ALC882 Digital [ALC882 Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 3: ATI HDMI [ATI HDMI]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> ben@mythfrontend:~$
>
> and I can send audio to the device, but it doesn't work. I presume
> this because this is doing nothing:
>
> static struct hda_verb atihdmi_basic_init[] = {
> 	/* enable digital output on pin widget */
> 	{ 0x03, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
> 	{} /* terminator */
> };
>
> ben@mythfrontend:~$ cat /proc/asound/card0/codec#1
> Codec: Generic 1095 SI1390 HDMI
> Address: 1
> Vendor Id: 0x10951390
> Subsystem Id: 0xffffffff
> Revision Id: 0x100000
> No Modem Function Group found
> Default PCM:
>     rates [0x0]:
>     bits [0x0]:
>     formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
> Node 0x02 [Audio Output] wcaps 0x6211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x5]: PCM AC3
> Node 0x03 [Pin Complex] wcaps 0x40738d: Stereo Digital Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0894: OUT Detect R/L
>   Pin Default 0x98460010: [Fixed] SPDIF Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x02
>
> "Pin-ctls: 0x00:" should be reading "Pin-ctls: 0x40: OUT" should it
> not? What is wrong?
>
> Thanks
>
> Ben
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
