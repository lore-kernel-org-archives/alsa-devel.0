From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Sat, 14 May 2016 20:14:57 -0300
Message-ID: <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id BC1C52614BB
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2016 01:15:00 +0200 (CEST)
Received: by mail-io0-f195.google.com with SMTP id i75so8830589ioa.2
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 16:15:00 -0700 (PDT)
In-Reply-To: <20160513114136.GM1646@localhost.localdomain>
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

Hi Charles,

>> 2016-05-09 11:22 GMT-03:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
>> > 'HPOUT1R Input 1' 'Tone Generator 1'
>> >
>> > This will hook the right headphone channel up to the chips
>> > internal 1k tone generator. Careful it will be loud, but its
>> > a good check to make sure the clocks are all happy inside the
>> > chip. If you hear that tone, I would say the CODEC side looks
>> > happy, but let me know how you get on.
>>
>> We tried, but unfortunatelly no tone when hooking the tone generator.
>> Saved dmesg, logcat and alsa_amixer output in case you want to take a look [2]
>
> Hmm... that is really odd, I would very much have expected that
> to work or the FLL to have given us a lock timed out error, which
> it didn't appear to be from your log.
>
> Could perhaps send through a register dump of the CODEC whilst in
> this state? You can do this through the regmap debugfs it would
> be good to turn cache_bypass on as well whilst doing it to make
> sure we capture the actual hardware status.

Here's the link for info collected [1]. Got info from the following
files while attempting to play audio, with cache_bypass set to "Y"
and with 'HPOUT1R Input 1' hooked to 'Tone Generator 1':

name
registers
access
range
rbtree

Thanks again for your help!

[1] - https://drive.google.com/folderview?id=0BxO6THtB865fSUZ3MDdFYktHanc&usp=sharing
