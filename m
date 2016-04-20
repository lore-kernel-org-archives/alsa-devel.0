From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Wed, 20 Apr 2016 16:09:03 +0000
Message-ID: <CA+aoAJeY5jaz2N5MrFBmpiNebwr3N6JnYNmSmkQwNj8QRBSoeQ@mail.gmail.com>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 20F93266558
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:09:13 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id e201so56446669wme.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 09:09:13 -0700 (PDT)
In-Reply-To: <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is Jack startup log using FFADO.
This shows all ports available.

Thu Apr 21 02:07:05 2016: Starting jack server...

Thu Apr 21 02:07:05 2016: JACK server starting in realtime mode with
priority 85

Thu Apr 21 02:07:05 2016: self-connect-mode is "Don't restrict self connect
requests"

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH1/CH1/2_in'

Thu Apr 21 02:07:07 2016: New client 'firewire_pcm' with PID 0

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH2/CH1/2_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH3/CH3/4_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH4/CH3/4_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH5/CH5/6_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH6/CH5/6_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH7/CH7/8_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH8/CH7/8_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH9/CH9/10_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH10/CH9/10_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH11/CH11/12_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH12/CH11/12_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH13/CH13/14_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH14/CH13/14_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH15/CH15/16_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH16/CH15/16_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_midi 0_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_L/MAIN L/R_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_R/MAIN L/R_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT1/ADAT1/2_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT2/ADAT1/2_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT3/ADAT3/4_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT4/ADAT3/4_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT5/ADAT5/6_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT6/ADAT5/6_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT7/ADAT7/8_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT8/ADAT7/8_in'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH1/CH1/2_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH2/CH1/2_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH3/CH3/4_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH4/CH3/4_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH5/CH5/6_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH6/CH5/6_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH7/CH7/8_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH8/CH7/8_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH9/CH9/10_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH10/CH9/10_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH11/CH11/12_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH12/CH11/12_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH13/CH13/14_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH14/CH13/14_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH15/CH15/16_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_CH16/CH15/16_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_L/MAIN L/R_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_R/MAIN L/R_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT1/ADAT1/2_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT2/ADAT1/2_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT3/ADAT3/4_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT4/ADAT3/4_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT5/ADAT5/6_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT6/ADAT5/6_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT7/ADAT7/8_out'

Thu Apr 21 02:07:07 2016: graph reorder: new port
'firewire_pcm:0004c4040001c14f_ADAT8/ADAT7/8_out'

Thu Apr 21 02:07:07 2016: New client 'catia' with PID 3396

On Thu, Apr 21, 2016 at 2:03 AM Allan Klinbail <aklinbail@gmail.com> wrote:

> Thanks for your reply.
>
>
> This isn't really suitable yet to replace FFADO
> .
> It provides this as separate devices so I cannot access all channels at
> the same time in jack as in FFADO.
>
> Although I don't typically use the ADAT ports other might, however I am
> always using a combination of channels 1-16 and channels 17 & 18 combined,
> sometimes all of them.
> The device is a hardware mixing desk and all ports are designed to be used
> simultaneously..
>
> Latency performance is also much worse. FFADO will allow a buffer size of
> 64, ALSA will not start below 256.
> I prefer to work at 128 or lower.
>
>
> Here is the output you requested.
>
>
>
> root@kxdaw:/home/allan/Downloads#  cat /proc/asound/card1/dice
> sections:
>   global: offset 10, size 95
>   tx: offset 105, size 142
>   rx: offset 247, size 282
>   ext_sync: offset 529, size 4
>   unused2: offset 0, size 0
> global:
>   owner: ffc1:000100000000
>   notification: 00000040
>   nick name: ZED R16
>   clock select: internal 44100
>   enable: 1
>   status: locked 44100
>   ext status: 000000c0
>   sample rate: 44100
>   version: 1.0.11.0
>   clock caps: 44100 48000 88200 96000 adat internal
>   clock source names: AES12\AES34\AES56\AES78\AES_ANY\ADAT\ADAT_AUX\Word
> Clock\Unused\Unused\Unused\Unused\Internal\\
> tx 0:
>   iso channel: 0
>   audio channels: 16
>   midi ports: 1
>   speed: S400
>   names:
> CH1/CH1/2\CH2/CH1/2\CH3/CH3/4\CH4/CH3/4\CH5/CH5/6\CH6/CH5/6\CH7/CH7/8\CH8/CH7/8\CH9/CH9/10\CH10/CH9/10\CH11/CH11/12\CH12/CH11/12\CH13/CH13/14\CH14/CH13/14\CH15/CH15/16\CH16/CH15/16\\
>   ac3 caps: 00000000
>   ac3 enable: 00000000
> tx 1:
>   iso channel: 1
>   audio channels: 10
>   midi ports: 0
>   speed: S400
>   names: L/MAIN L/R\R/MAIN
> L/R\ADAT1/ADAT1/2\ADAT2/ADAT1/2\ADAT3/ADAT3/4\ADAT4/ADAT3/4\ADAT5/ADAT5/6\ADAT6/ADAT5/6\ADAT7/ADAT7/8\ADAT8/ADAT7/8\\
>   ac3 caps: 00000000
>   ac3 enable: 00000000
> rx 0:
>   iso channel: 2
>   sequence start: 0
>   audio channels: 16
>   midi ports: 0
>   names:
> CH1/CH1/2\CH2/CH1/2\CH3/CH3/4\CH4/CH3/4\CH5/CH5/6\CH6/CH5/6\CH7/CH7/8\CH8/CH7/8\CH9/CH9/10\CH10/CH9/10\CH11/CH11/12\CH12/CH11/12\CH13/CH13/14\CH14/CH13/14\CH15/CH15/16\CH16/CH15/16\\
>   ac3 caps: 00000000
>   ac3 enable: 00000000
> rx 1:
>   iso channel: 3
>   sequence start: 0
>   audio channels: 10
>   midi ports: 0
>   names: L/MAIN L/R\R/MAIN
> L/R\ADAT1/ADAT1/2\ADAT2/ADAT1/2\ADAT3/ADAT3/4\ADAT4/ADAT3/4\ADAT5/ADAT5/6\ADAT6/ADAT5/6\ADAT7/ADAT7/8\ADAT8/ADAT7/8\\
>   ac3 caps: 00000000
>   ac3 enable: 00000000
> ext status:
>   clock source: internal
>   locked: 1
>   rate: 44100
>   adat user data: -
>
>
>
>
>
>
> On Thu, Apr 21, 2016 at 1:21 AM Takashi Sakamoto <o-takashi@sakamocchi.jp>
> wrote:
>
>> Hi,
>>
>> On Apr 20 2016 23:31, Allan Klinbail wrote:
>> > Using kernel 4.4.0 from Ubuntu
>> >
>> > The ALSA driver limited the device to only 16 inputs and outputs,
>> however
>> > it has a total capability of 26
>> > This is comprises of 16 inputs and outputs on the desk channels, a
>> stereo
>> > main pair of outputs and inputs for the master bus
>> > 8 additional ins and outs to support the ADAT ports on the back
>> (availoable
>> > in 44.1 and 48 khz modes, but not 88.2 or 96 Khz
>>
>> This is fixed in Linux kernel 4.6.
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105462.html
>>
>> The backported codes are available in my private repository. After
>> installing, You can see two PCM character devices to handle these PCM
>> channels.
>> https://github.com/takaswie/snd-firewire-improve
>>
>> To clarify the capabilities of your model, please show me output of proc
>> node, like
>>
>> $ cat /proc/asound/card1/dice
>> sections:
>>   global: offset 10, size 95
>>   tx: offset 105, size 142
>> ...
>>
>>
>> Regards
>>
>> Takashi Sakamoto
>>
>
