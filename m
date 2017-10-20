From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: HDMI LPE audio on Intel Compute Stick 2nd Gen (CHT)
Date: Sat, 21 Oct 2017 00:45:30 +1100
Message-ID: <CAFXWsS8THagHnx9BPurw4+3a+xH6DP653MjwjTSkYhU3zLmZHQ@mail.gmail.com>
References: <CAFXWsS_V=nG8C+NM8qmtjdoZoWrsTnTFNR16kU05NNsx=c0-5Q@mail.gmail.com>
 <7827e954-d9d0-4737-5e47-13e0e69fd92d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EA9F3267096
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 15:45:31 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id m72so22122349wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 06:45:31 -0700 (PDT)
In-Reply-To: <7827e954-d9d0-4737-5e47-13e0e69fd92d@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I've just noticed that non of the kernels from v4.13 and up run on my
>> Intel Compute Stick (2nd gen Cherry Trail STK1AW32SC) unit and have
>> HDMI LPE audio working.
>>
>
> I have not tested HDMI in a while but I am not aware of any issues either.
> There were some patches recently to fix PulseAudio problems and I suppose
> some folks used a recent kernel?
>
>
It actually happened since v4.12 as now I get three HDMI LPE Audio devices
show up with 'aplay -l' rather than just one. Only 'device 2' works so if I
change the sink to use that device I get sound. So basically it can be
fixed in userland however I'm seeing others with different devices also
complaining how audio is broken and I think it is something that many users
don't know to fix. Is it worth looking into further or just leaving it as a
known issue?
