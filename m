From: Adarsh <punia.adarsh@gmail.com>
Subject: Re: Need Help: Repeated Jackhammer noise after several
 hours of play and heavy cpu usage in snd_pcm_dmix_sync_area
Date: Thu, 20 Feb 2014 16:37:55 +0530
Message-ID: <CANxfbX8HWaMBtshGU25kxSV=SWAig5+0VNMd4UM91bn_=kFXjg@mail.gmail.com>
References: <CANxfbX_o=UcTz0Sjno=zkEns4MGdrjnsbJmP0J=7O8owu7_8+g@mail.gmail.com>
 <5305D1A6.6060401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 600F8261A3B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 12:07:56 +0100 (CET)
Received: by mail-wi0-f182.google.com with SMTP id f8so1645894wiw.15
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:07:56 -0800 (PST)
In-Reply-To: <5305D1A6.6060401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, gabrbedd@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Gabe and Clemens, Thanks for your replies.
There is still some confusion about why alsa is behaving in this manner.

> GDB is good for a lot of things, but solving problems in real-time systems (like audio) has never been one of them. So, chances are that gdb is the wrong tool for what you're trying to do.
A brief background:
Yes, you are right, gdb is not the proper tool. We are trying to solve
random jackhammer issue happening on some production systems. One way
to reproduce this is thread starvation for cpu which we are inducing
by either SIGSTOP/SIGCONT or gdb or lowering
the priority of sound thread.

> This is probably because of all the 'catch-up' samples that are being mixed.
What we have observed is that when the process is freshly started and
has not run for significant amount of time,
sending SIGSTOP/SIGCONT to sound process properly stops and resumes sound.

However when run for over 12 hours, any starvation or stopping of
sound thread sends dmix into a tight loop inside
'snd_pcm_dmix_sync_area' function of pcm_dmix.c. Dmix calculates the
'size' that needs to be transferred to be a huge
value.

Here is the piece of code from snd_pcm_dmix_sync_area that starts the
size calculations:

  /* calculate the size to transfer */
  /* check the available size in the local buffer
   * last_appl_ptr keeps the last updated position
   */
  size = dmix->appl_ptr - dmix->last_appl_ptr;
  if (! size)
    return;
  if (size >= pcm->boundary / 2)
    size = pcm->boundary - size;
    .
    .
    .
When the issue happens value of dmix->last_appl_ptr is greater than
dmix->appl_ptr and subsequent calcualtion of
size turns out to be very large number probably because of wrap around
behavior of unsigned arithmetic.
A typical case is:
dmix->appl_ptr = 217121792, dmix->last_appl_ptr = 233882624
size = 1018295296
This causes 'mix_areas' to be called repeatedly until this size is exhausted.

When process is running for shorter duration, dmix->appl_ptr is always
bigger than dmix->last_appl_ptr.
For eg. dmix->appl_ptr = 26124288, dmix->last_appl_ptr = 26123264

The software boundary is 1 GB.

> Hmmm, this might be a bug in the dmix plugin.
So, is it possible that the buffer wrap around could cause the
pointer/size miscalcualtions inside dmix?
Is it expected to have dmix->last_appl_ptr greater than
dmix->appl_ptr? If so, why the issue seen only when
the thread is stopped.

Please suggest. Thanks.
Adarsh


On Thu, Feb 20, 2014 at 3:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adarsh wrote:
>> 2. However to disable the underruns, the
>> snd_pcm_sw_params_set_stop_threshold is set to 0x7fffffff
>
> This does not disable underruns; it just disables stopping the device
> when an underrun happens.
>
>> which is greater than boundary value.
>
> Guess what happens on a 64-bit machine.
>
>> 3.Period size is 1024 and buffer size is 2048.
>
> Do you actually need that low a latency?
>
>> 2. gdb is attached to the process and continued inside gdb.
>
> This will result in an underrun.
>
> When an underrun happens, the buffer is reported to contain less than
> zero frames (i.e., the "avail" value is larger than the buffer size).
>
> The program has to write samples _faster_ than normally to catch up.
> Alternately, it could advance the pointer by calling snd_pcm_forward
> (which might be a better idea because those samples won't be played
> at the correct time anyway.)
>
> You should reconsider setting the stop threshold.
>
>> 3. At this point, the thread went into a tight loop taking >100% cpu
>
> This is probably because of all the 'catch-up' samples that are being
> mixed.
>
>> Stack trace shows that 'snd_pcm_dmix_sync_area' in pcm_dmix.c is taking a
>> very long time to return because the 'size' is
>> a large unsinged interger and mix_areas is getting called with 'transfer'
>> value of <=2048.
>
> Hmmm, this might be a bug in the dmix plugin.
>
>
> Regards,
> Clemens
