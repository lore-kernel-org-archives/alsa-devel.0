From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Need Help: Repeated Jackhammer noise after several
 hours of play and heavy cpu usage in snd_pcm_dmix_sync_area
Date: Wed, 19 Feb 2014 07:16:51 -0800
Message-ID: <5304CAE3.1000303@gmail.com>
References: <CANxfbX_o=UcTz0Sjno=zkEns4MGdrjnsbJmP0J=7O8owu7_8+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 131D92658E5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:16:59 +0100 (CET)
Received: by mail-pb0-f54.google.com with SMTP id uo5so518565pbc.13
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 07:16:59 -0800 (PST)
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

Hi Adarsh,

On 02/19/2014 04:07 AM, Adarsh wrote:
> Hi,
>
> We are facing a issue where if gdb is attached to the our long running
> sound process and continued,
> jackhammer sound is played over and over again abusing the speakers.
>
> Process details:
> 1. We are using RW_INTERLEAVED access as described in write_loop method in
> /test/pcm.c and opening 'default' device.
> 2. However to disable the underruns, the
> snd_pcm_sw_params_set_stop_threshold is set to 0x7fffffff which is greater
> than boundary
> value.

This doesn't prevent underruns. Underruns happen when the software 
doesn't keep up with the hardware.

What this disables is your ability to detect and recover from an 
underrun. So, what you're experiencing is expected behavior.  If you 
never reach the stop threshold but userspace fails to write new audio to 
the buffer.  Since you instructed the driver/hardware to *not* stop in 
the event of an underrun, it repeatedly cycles on the same, stale 
buffer. This gives you the "jackhammer" sound.

> 3.Period size is 1024 and buffer size is 2048. We try to write period_size
> no of frames using snd_pcm_writei.
> (I am attaching a sample program which shows this behaviour.)
>
> Steps to Reproduce:
> 1. Left process running for over 12 hours.
> 2. gdb is attached to the process and continued inside gdb.

When gdb attached to the process, you certainly stopped writing new 
audio to the buffer because your process got a SIGSTOP... causing all 
threads to freeze.

> 3. At this point, the thread went into a tight loop taking >100% cpu and
> repeatedly playing same sound. It did not recover for a long time.

...I'm not sure what you're seeing here.  Possibly dmix is trying to 
make the best of a bad situation.

> Is it that setting of stop threshold to 0x7fffffff is triggering this and
> attaching gdb is making the buffer pointers misbehave?
> If so, what can be done if we do not want PCM to stop? I have tried by
> setting silence threshold and silence size to let alsa
> play silence by itself but still observed the issue.

It depends on what you're trying to solve by attaching with gdb.

GDB is good for a lot of things, but solving problems in real-time 
systems (like audio) has never been one of them. So, chances are that 
gdb is the wrong tool for what you're trying to do.

-gabe
