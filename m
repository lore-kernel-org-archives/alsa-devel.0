From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Sat, 7 May 2016 00:40:34 -0300
Message-ID: <CAJcYhpYXasOeMX=0LJtO18wrSV+ch7PNq_rO6jXkTy_65L6TFw@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <cd77211c-ec34-ef93-5601-f7adeb3e1fc3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 76DD52612CC
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2016 05:40:35 +0200 (CEST)
Received: by mail-io0-f178.google.com with SMTP id d62so131171973iof.2
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2016 20:40:35 -0700 (PDT)
In-Reply-To: <cd77211c-ec34-ef93-5601-f7adeb3e1fc3@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Pierre, how are you?

>> I also ported a machine driver code from a kernel Lenovo made available
>> for a similar hardware (Lenovo yoga 2 1050 - uses the same baytrail
>> Z3745 and wolfson wm5102 audio) [4]
>
>
> There are quite a few references in the machine driver to concepts related
> to Clovertrail+ and early versions of Baytrail. I am fairly convinced the
> mentions of 'BYT_COMMS_BT' or 'modem mixing' are no longer supported with
> the DPCM platform driver/firmware you used.

Yes, the code I ported was originally wrote for kernel 3.10.x targeted
for Android

In any case, I didn't enable this option on our kernel config

>
> To enable this codec it would be simpler to start with a newer machine
> driver derived from the bytcr_rt5640 one, with just a basic SSP0-aif1 link
> for starters (+ MCLK).

Thanks for the tip. I can try it ( create a machine driver derived
from bytcr_rt5640 ). Will just wait for Charles help on analyzing
CODEC output I provided. [1]
If he says this part seems ok, I will work on machine driver

I'm not sure this hardware uses SSP0 or SSP2, so I'm testing with both
firmwares. Is there any method I can confirm it? (querying an ACPI
entry listed on DSDT maybe?)

> Better yet, do this work with a MinnowBoard and an
> WM5102 eval board and test all this with more control on how the hardware is
> setup.

This is probably the best approach (minnowboard + WM5102 eval board).
But unfortunatelly my skills are limited...


> If you stick to working directly on the Lenovo device, make sure you use all
> the DSP controls set in the UCM files used for baytrail/baytrail-CR (see
> github.com/plbossart/UCM).

In fact, currently I don't have this device. Some volunteers from
Android-x86 google group are testing changes made on their hardware
and provide the info I ask for (logcat / dmesg / mixer output, etc)


Thanks
Pstglia

[1] - https://drive.google.com/file/d/0BxO6THtB865fS2NxUkdOa18zUlE/view?usp=sharing
