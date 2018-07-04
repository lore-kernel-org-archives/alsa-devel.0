From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Wed, 4 Jul 2018 14:11:11 +0200
Message-ID: <CAL-i0qERNjW-0kUE5xj8u2roCU0p0wVmscKiqUV7pxiFtO84mQ@mail.gmail.com>
References: <CAL-i0qF80jHGH_7Cwxik3HO86Ng3PZH18fxf0vABk4cMUY5OdQ@mail.gmail.com>
 <s5hwoubwar6.wl-tiwai@suse.de>
 <CAL-i0qFbukDczTtgnkbfpE=Giu6piv6dvcMi-D=QtnYy69Q5FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 510E6267214
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 14:11:13 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so10292605oib.9
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 05:11:12 -0700 (PDT)
In-Reply-To: <CAL-i0qFbukDczTtgnkbfpE=Giu6piv6dvcMi-D=QtnYy69Q5FQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>> The recent kernel puts the xrun debug messages in trace buffer instead
>> of the kernel messages.  Try to enable the tracing in
>> /sys/kernel/debug/tracing/events/snd_pcm/xrun/enable, and watch the
>> trace buffer (/sys/kernel/debug/tracing/trace).
>
> Thanks for your very quick reply, I'll try this now.

I must do this wrong again.

So I kept echo 5 > /proc/asound/card2/pcm0p/xrun_debug
(not sure if still relevant with ftrace)

And I mounted tracefs
mount -t tracefs nodev /sys/kernel/tracing

And then I can
echo 1 > /sys/kernel/tracing/events/snd_pcm/xrun/enable

I can verify that
cat /sys/kernel/tracing/events/snd_pcm/xrun/enable gives 1
and all enable upper returns X

cat /sys/kernel/tracing/tracing_on is 1

But then
cat /sys/kernel/tracing/trace
Starts with # tracer: nop
and then the header for tracing, and that doesn't change over time.

No event gets logged.

Is tracer "nop" the right one?

As for my kernel configuration I have currently, regarding what seems
to be related to FTRACE :

CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set

I guess I might need to enable one of the config like FUNCTION_TRACER?

Sorry, I just started Linux, so my knowledge of it is very low.

Thanks,

Raphael
