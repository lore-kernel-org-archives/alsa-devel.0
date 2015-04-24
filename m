From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bebob and PrismSound Orpheus fails
	with	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 10:29:00 +0200
Message-ID: <5539FECC.8050609@ladisch.de>
References: <CAJ0eYfXCX_0C-v0cGOwieDDCOn6q4Mt9JvBG7CxA51yOrALSpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9610F260513
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 10:29:01 +0200 (CEST)
In-Reply-To: <CAJ0eYfXCX_0C-v0cGOwieDDCOn6q4Mt9JvBG7CxA51yOrALSpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Mike Ood wrote:
> Clemens wrote:
>> Any error message in the system log?
>
> this is just after % aplay -D plughw:2,0 test.wav
> ...
> [  110.580310] firewire_core 0000:08:00.0: created device fw1: GUID 00119800010001f9, S400
> [  113.660273] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
> [  128.010593] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
> [  133.416998] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
> [  136.275142] snd-bebob fw1.0: Detect discontinuity of CIP: 50 70
> [  137.654178] snd-bebob fw1.0: Detect discontinuity of CIP: 70 90

This means that some packet to be received from the device is (or
appears to be) missing.  In theory, this is supposed to happen only when
noise on the cable has corrupted the signal, but this might be a problem
with this device's firmware.

Does this device (with this cable) work in Windows or OS X?


At the moment, a missing packet results in the driver just stopping the
stream.  There would be better ways to handle this, but I haven't yet
found the time to implement this.


Regards,
Clemens
