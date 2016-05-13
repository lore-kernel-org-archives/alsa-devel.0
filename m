From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Thu, 12 May 2016 23:54:55 -0300
Message-ID: <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 394EE260439
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 04:54:57 +0200 (CEST)
Received: by mail-io0-f174.google.com with SMTP id d62so117490326iof.2
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 19:54:57 -0700 (PDT)
In-Reply-To: <20160509142210.GH1646@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi again

2016-05-09 11:22 GMT-03:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
>> alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1 Volume' 32
>> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1' AIF1RX2
>> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1 Volume' 32
>> alsa_amixer -Dhw:0 cset name='Headset Mic Switch' on
>
> From your machine driver I would have expected this last control
> to be "Headphone Switch", although I do appear to see things
> turning on in your log so I guess that switch is already on?

It was already on. But just in case, I've added it to alsa_amixer cmd list

Added also the routes/controls that Pierre pointed on his github UCM ( see [1] )


> Overall, I would say it looks good. One thing I would perhaps
> try, connect up this path as you have been doing, but whilst the
> audio is playing (or attempting to at least) connect the route:
>
> 'HPOUT1R Input 1' 'Tone Generator 1'
>
> This will hook the right headphone channel up to the chips
> internal 1k tone generator. Careful it will be loud, but its
> a good check to make sure the clocks are all happy inside the
> chip. If you hear that tone, I would say the CODEC side looks
> happy, but let me know how you get on.

We tried, but unfortunatelly no tone when hooking the tone generator.
Saved dmesg, logcat and alsa_amixer output in case you want to take a look [2]

I'm still having this message on logcat:
"out_write: error -1 - cannot prepare channel: Device or resource busy"
which happens when trying to ioctl
SNDRV_PCM_IOCTL_PREPARE to /dev/snd/pcmC0D0p

Maybe the problem is something wrong/missing on Machine Driver...
Pierre said It would be good base the code on bytcr_5640...

* * *

I tried also other thing. So far I've been changing host_ipc_index
from 5 to 0 on atom/sst/sst_acpi, because this device's DSDT uses a
different
IRQ order from what drivers expect. It allows fw loading and card
registering, but I was wondering if the other index entries are mapped
by the driver.

To ensure all indexes are read in the position driver wants, I
modified irq order on DSDT, reverted ipc_host_index to 5 and tried
booting it.
I tested it, but the results are the samewhen using original DSDT and
changing host_ipc_index to 0. Saved replaced DSDT and logs here [3]

* * *

Regards
Pstglia

[1] - https://drive.google.com/file/d/0BxO6THtB865fQnQyZkx6c05Nbjg/view?usp=sharing
[2] - https://drive.google.com/folderview?id=0BxO6THtB865fZk5sSEdrbTVsREU&usp=sharing
[3] - https://drive.google.com/folderview?id=0BxO6THtB865fWGU1MTlJazBnZzg&usp=sharing
