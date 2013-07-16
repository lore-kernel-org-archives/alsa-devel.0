From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsa USB Audio regression
Date: Tue, 16 Jul 2013 10:14:19 +0800
Message-ID: <CAN8ccib8nF3bjneUQcQ6q29=iR2WfbXQEufOfxAg51_N_77j2w@mail.gmail.com>
References: <51E2AA11.8090500@gmx.at> <51E2AB84.9070603@gmx.at>
 <CAN8ccia_6vUYKm2noaQ3nNh=rr6kJq76vtZ1t3==cQ-cPr2-jA@mail.gmail.com>
 <51E40970.2040801@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E79C2619D7
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 04:14:21 +0200 (CEST)
Received: by mail-ie0-f182.google.com with SMTP id s9so384516iec.13
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 19:14:20 -0700 (PDT)
In-Reply-To: <51E40970.2040801@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ulrich_G=C3=BCnther?= <ulrich.guenther@gmx.at>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

>>>
>>> After Ubuntu 10.04 LTS (Ubuntu 10.10 works, Ubuntu 11.04 doesn't work at
>>> all, Ubuntu 11.10 and newer have the bug), the headset only plays sound
>>> at maximum volume level if the volume is turned down just a little no
>>> sound is being played.
>>>
>>> I have filled a Ubuntu bug for 12.04 LTS at:
>>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1200925 .
>>> I was advised to contact this mailing list.
>>>
>>> AlsaInfo for Ubuntu 12.04 LTS with the bug:
>>>
http://www.alsa-project.org/db/?f=3bde76b15a15f585418a6a4a4703ca67fd4cdf42 .
>>> AlsaInfo for Ubuntu 10.04 LTS without the bug:
>>>
http://www.alsa-project.org/db/?f=5824e55345c3f7128937405254485a489886b9dc
>>
>>
>>
>> It is strange that dB range of your usb audio is 0 to 0.14 (only small
gain and no attenuation)
>>
>> In 10.04 LTS pulseaudio provide software volume control
>>
>>
>> ( 1.095| 0.000) I: alsa-sink.c: Driver does not support hardware volume
control, falling back to software volume control.
>>
>>
>> control.6 {
>> comment.access 'read write'
>> comment.type INTEGER
>> comment.count 1 comment.range '0 - 37'
>> comment.dbmin 0 comment.dbmax 14
>> iface MIXER
>> name 'Speaker Playback Volume' value 30 }
>>
>>
>>  In 12.04 pulseaudio did not provide software volume attenuation and use
the speaker playback volume control
>
>
> So does that mean that the bug is in pulseaudio, or could it be even
deeper like in the kernel or something?

Are there any significant change in volume when you use "alsamixer -c0" to
change speaker playback volume from min 0dB to 0.14dB ?

Did pulseaudio provide software attuentation -1.61dB when the range of
hardware volume control is only 0.14dB ?

* index: 0
name: <alsa_output.usb-0d8c_USB_Audio-00-Audio.analog-surround-71>
driver: <module-alsa-card.c>
flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY
DYNAMIC_LATENCY
state: SUSPENDED
suspend cause: IDLE
priority: 9049
volume: 0:  94% 1:  94% 2:  94% 3:  94% 4:  94% 5:  94% 6:  94% 7:  94%
        0: -1,61 dB 1: -1,61 dB 2: -1,61 dB 3: -1,61 dB 4: -1,61 dB 5:
-1,61 dB 6: -1,61 dB 7: -1,61 dB
        balance 0,00
base volume:  99%
             -0,14 dB
volume steps: 65537
muted: no

It is strange that 5.1 headset only support 8 channels playback
