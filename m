From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need Help: Repeated Jackhammer noise after several
 hours of play and heavy cpu usage in snd_pcm_dmix_sync_area
Date: Thu, 20 Feb 2014 10:57:58 +0100
Message-ID: <5305D1A6.6060401@ladisch.de>
References: <CANxfbX_o=UcTz0Sjno=zkEns4MGdrjnsbJmP0J=7O8owu7_8+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B83FF261A6C
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 10:58:02 +0100 (CET)
In-Reply-To: <CANxfbX_o=UcTz0Sjno=zkEns4MGdrjnsbJmP0J=7O8owu7_8+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adarsh <punia.adarsh@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adarsh wrote:
> 2. However to disable the underruns, the
> snd_pcm_sw_params_set_stop_threshold is set to 0x7fffffff

This does not disable underruns; it just disables stopping the device
when an underrun happens.

> which is greater than boundary value.

Guess what happens on a 64-bit machine.

> 3.Period size is 1024 and buffer size is 2048.

Do you actually need that low a latency?

> 2. gdb is attached to the process and continued inside gdb.

This will result in an underrun.

When an underrun happens, the buffer is reported to contain less than
zero frames (i.e., the "avail" value is larger than the buffer size).

The program has to write samples _faster_ than normally to catch up.
Alternately, it could advance the pointer by calling snd_pcm_forward
(which might be a better idea because those samples won't be played
at the correct time anyway.)

You should reconsider setting the stop threshold.

> 3. At this point, the thread went into a tight loop taking >100% cpu

This is probably because of all the 'catch-up' samples that are being
mixed.

> Stack trace shows that 'snd_pcm_dmix_sync_area' in pcm_dmix.c is taking a
> very long time to return because the 'size' is
> a large unsinged interger and mix_areas is getting called with 'transfer'
> value of <=2048.

Hmmm, this might be a bug in the dmix plugin.


Regards,
Clemens
