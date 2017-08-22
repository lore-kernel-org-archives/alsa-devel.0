From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Tue, 22 Aug 2017 11:43:55 +0900
Message-ID: <3f8e535b-8607-6b15-6e17-da755a06cc1e@sakamocchi.jp>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
 <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
 <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Oleksandr Grytsov <al1img@gmail.com>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 18 2017 16:23, Oleksandr Andrushchenko wrote:
 >> You mean that any alsa-lib or libpulse applications run on Dom0 as a
 >> backend driver for the frontend driver on DomU?
 >>
 > No, the sound backend [1] is a user-space application (ALSA/PulseAudio
 > client)
 > which runs as a Xen para-virtual backend in Dom0 and serves all the
 > frontends running in DomU(s).
 > Other ALSA/PulseAudio clients in Dom0 are also allowed to run at the
 > same time.
 >
 > [1] https://github.com/xen-troops/snd_be

Actually, you did what I meant.

Playback                                                     Capture
  delay       DomU-A    DomU-B    DomU-C                      delay
             --------- --------- ---------
             |       | |       | |       |
(queueing)  | App-A | | App-B | | App-C |                   (handling)
     |       |       | |       | |       |                       ^
     |       | (TSS) | | (TSS) | | (TSS) |                       |
     |       |       | |       | |       |                       |
     |       ---^----- ----^---- ----^----                       |
     |       ===|==========|=========|==== XenBus and            |
     |       ---|----------|-------- |----   mapped page frame   |
     |  Dom0 |  v          v         v   |                       |
     |       |App-0      App-1     App-2 |                       |
     |       |  ^          ^         ^   |                       |
     |       |  |-> App-3<-|         |   |                       |
     |       |(IPC)  ^   (IPC)       |   |                       |
     |       |       v               v   |                       |
     |       |==HW abstraction for TSS ==|                       |
     |       |          ^     ^          |                       |
     |       -----------|-----|-----------                       |
     |                  |     |    (TSS = Time Sharing System)   |
     |                  v     v                                  |
     |                  Hardwares                                |
     v                     v                                     |
(presenting)          physical part                         (sampling)

I can easily imagine that several applications (App[0|1|2]) run in Dom0
as backend drivers of this context, to add several 'virtual' sound
device for DomU, via Xenbus. The backend drivers can handle different
hardware for the 'virtual' sound devices; e.g. it can be BSD socket
applications.  Of course, this is a sample based on my imagination.
Actually, you assume that your application exclusively produces the
'virtual' sound cards, I guess.  Anyway, it's not a point of this
discussion.

 > In order to implement option 1) discussed (Interrupts to respond 
events from
 > actual hardware) we did number of experiments to find out if it can be
 > implemented in the way it satisfies the requirements with respect to 
latency,
 > interrupt number and use-cases.
 >
 > First of all the sound backend is a user-space application which uses 
either
 > ALSA or PulseAudio to play/capture audio depending on configuration.
 > Most of the use-cases we have are using PulseAudio as it allows to
 > implement more complex use cases then just plain ALSA.

When assuming App-3 in the above diagram as PulseAudio, a combination
of App-0/App-1/App-3 may correspond to the backend driver in your
use-case.

 > We started to look at how can we get such an event so it can be used as
 > a period elapsed notification to the backend.
 >
 > In case of ALSA we used poll mechanism to wait for events from ALSA:
 > we configured SW params to have period event, but the problem here is 
that
 > it is notified not only when period elapses, but also when ALSA is 
ready to
 > consume more data. There is no mechanism to distinguish between these
 > two events (please correct us if there is one). Anyways, even if ALSA 
provides
 > period event to user-space (again, backend is a user-space application)
 > latency will consist of: time from kernel to user-space, user-space 
Dom0 to
 > frontend driver DomU. Both are variable and depend on many factors,
 > so the latency is not deterministic.
 >
 > (We were also thinking that we can implement a helper driver in Dom0 
to have
 > a dedicated channel from ALSA to the backend to deliver period 
elapsed event,
 > so for instance, it can have some kind of a hook on 
snd_pcm_period_elapsed,
 > but it will not solve the use-case with PulseAudio discussed below.
 > Also it is unclear how to handle scenario when multiple DomU plays 
through
 > mixer with different frame rates, channels etc.).

In design of ALSA PCM core, processes are awakened from poll wait by
the other running tasks, which calculate available space on PCM buffer.
This is done by a call of 'snd_pcm_hw_prw0()' in 'sound/core/pcm_lib.c'
in kernel land. In this function, ALSA PCM core calls implementation of
'struct snd_pcm_ops.pointer()' in each driver and get current position
of data transmission within buffer size, then 'hw_ptr' of PCM buffer
is updated, then calculates the avail space.

Typical ALSA PCM drivers call the function in any hw IRQ context for
interrupts generated by hardware, or sw IRQ context for interrupts
generated by packet-oriented drivers for general-purpose buses such as
USB. This is a reason that the drivers configure hardware to generate
interrupts.

Actually, the value of 'avail_min' can be configured by user threads
as 'struct snd_pcm_sw_params'. As a default, this equals to the size of
period of PCM buffer.

On the other hand, any user thread can also call the function in a
call graph of ioctl(2) with some commands; e.g. SNDRV_PCM_IOCTL_HWSYNC.
Even if a user thread is on poll wait, the other user thread can awake
the thread by calling ioctl(2) with such commands. But usual program
processes I/O in one user thread and this scenario is rare.

The above is a typical scenario to use ALSA stuffs for semi-realtime
data transmission for sound hardware. Programs rely on the IRQ
generated by hardware. Drivers are programmed to configure the
hardware generating the IRQ. ALSA PCM applications are awakened by IRQ
handlers and queue/handle PCM frames in avail space on PCM buffer.

For efficiency, the interval of IRQ is configured as the same size
as a period of PCM buffer in frame unit. This is a concept of the
'period'. But there's a rest not to configure the interval per period;
e.g. IEC 61883-1/6 engine in ALSA firewire stack configures 1394 OHCI
isochronous context for callback per 2msec in its sw IRQ context while
the size of period is restricted to get one interrupt at least.
Therefore, the interval of interrupt is not necessarily as the same as
the size of period as long as IRQ handler enables applications to handle
avail space.


In a recent decade, ALSA PCM core supports the other scenario, which
rely on system timer with enough accuracy. In this scenario,
applications get an additional descriptor for system timer and
configure the timer to wake up as applications' convenience, or use
precise system call for multiplexed I/O such as ppoll(2). Applications
wake up as they prefer, the applications call ioctl(2) with
SNDRV_PCM_IOCTL_HWSYNC and calculate the avail space, then process PCM
frames. When all of handled PCM frames are queued, they schedule to
wake up far enough. Else, they schedule to wake up soon to reduce delay
for handled PCM frames.

In this scenario, any hw/sw interrupt is not necessarily required as
long as system timer is enough accurate and data transmission
automatically runs regardless of IRQ handlers. For this scenario, a few
drivers have conditional code to suppress hw/sw intervals; e.g. drivers
for 'Intel HDA' and 'C-Media 87xx' because this scenario requires
actual hardware to transfer data frames automatically but make it
available for drivers to get precise position of the transmission.
Furthermore, there's a application which supports this scenario. As
long as I know, excluding PulseAudio, nothing.

As a supplement, I note that audio timestamp is also calculated in the
function, 'snd_pcm_hw_prw0()'.


Well, as I indicated, the frontend driver works without any
synchronization to data transmission by actual sound hardware. It
relies on system timer on each of DomU and Dom0. I note my concern
against this design at last.

Linux is a kind of Time Sharing System. CPU time is divided for each
tasks. Thus there's delay of scheduling. ALSA is designed to rely on
hw/sw interrupts, because IRQ context can run regardless of the task
scheduling. (actually many exceptions I know.). This design dedicates
data transmission for actual time frame.

In a diagram of top of this message, the frontend driver runs on each
of DomU. Timer functionality of the DomU is based on scheduling on Dom0
somehow, thus there's a delay due to scheduling. At least, it has a
restriction for its preciseness. Additionally, applications on DomU are
schedulable tasks, thus they're dominated by task scheduler on DomU.
There's no reliance for actual time frame. Furthermore, libpulse
applications on Dom0 perform IPC to pulseaudio daemon. This brings
an additional overhead to synchronize to the other processes.

This is not an issue for usual applications. But for applications to
transfer data against actual time frame, it's a problem. Totally,
there's no guarantee of the data transmission for semi-realtime
capability. Any applications on DomU must run with large delay for safe
against timing gap.


Regards

Takashi Sakamoto
