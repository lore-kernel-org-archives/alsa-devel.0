From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: DMA over run on playback
Date: Wed, 13 May 2009 13:37:03 -0400
Message-ID: <9e4733910905131037l1489e8efu372d030ee35fa8ab@mail.gmail.com>
References: <9e4733910905130608u63a924cam25dca6af929ec82b@mail.gmail.com>
	<alpine.LNX.2.00.0905131510480.25064@eeebox2.perex-int.cz>
	<9e4733910905130638y4de40cc1vdd7b682fef867f95@mail.gmail.com>
	<s5hiqk5vvbz.wl%tiwai@suse.de>
	<9e4733910905131029u2dc43d50y178daccf66d59524@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4731038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 19:37:05 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1411472qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:37:04 -0700 (PDT)
In-Reply-To: <9e4733910905131029u2dc43d50y178daccf66d59524@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 1:29 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, May 13, 2009 at 12:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Wed, 13 May 2009 09:38:50 -0400,
>> Jon Smirl wrote:
>>>
>>> On Wed, May 13, 2009 at 9:25 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>>> > On Wed, 13 May 2009, Jon Smirl wrote:
>>> >
>>> >> There's a long thread over on the pulse list about glitch free
>>> >> playback. The glitches they are encountering are caused by CPU
>>> >> scheduling latency. =A0They are trying to fix this by setting HZ up =
to
>>> >> 1000 and constantly polling the audio DMA queue to keep it 99% full.
>>> >>
>>> >> This doesn't seem like the right solution to me. It is fixing the
>>> >> symptom not the cause. The cause is 200-300ms scheduling latency. The
>>> >> source of that needs to be tracked down and fixed in the kernel. =A0=
But
>>> >> we have to live with the latencies until they are fixed.
>>> >>
>>> >> The strategy of checking the queue at 1000Hz works but it is very
>>> >> inefficient. The underlying problem is that the buffer ALSA is using
>>> >> is too small on systems with 300ms latency. =A0The buffer is just big
>>> >> enough to cover 300ms so they rapidly check and fill it at 1000Hz to
>>> >> ensure that it is full if the 300ms latency strikes.
>>> >
>>> > ??? The ring buffer size is not limited if hw allows that.
>>> >
>>> >> On my hardware with period interrupts ALSA is only checking the buff=
er
>>> >> at 8Hz. Since I'm checking appl_ptr I know when DMA over runs the
>>> >> buffers. This allows me to insert silence and I could indicated this
>>> >
>>> > Inserting silence might be wrong, if you broke stream timing. The ela=
psed()
>>> > callback should be called at exact timing (and position should be upd=
ated,
>>> > too).
>>> >
>>> >> condition to ALSA if there was a mechanism for doing so. ALSA could
>>> >> use this over run knowledge to measure scheduling latency and adjust
>>> >> the buffering.
>>> >>
>>> >> But the DMA interface between ALSA and the driver has been fixed at
>>> >> stream creation time. There's no way to dynamically alter it (like
>>> >> window size changes in TCP/IP). =A0With networking you get a list of
>>> >> buffers to send. As you send these buffers you mark them sent. The
>>> >> core is free to hand you buffers straight from user space or do copi=
es
>>> >> and use internal ring buffers. The network driver just gets a list of
>>> >> physical addresses to send. This buffer bookkeeping could occur in
>>> >> snd_pcm_period_elapsed().
>>> >>
>>> >> A dynamic chaining mechanism allows you to alter the buffering
>>> >> mid-stream. If the driver indication a DMA over run error this tells
>>> >> ALSA that it needs to insert another buffer. After a while these
>>> >> errors will stop and ALSA will have measured worst case CPU scheduli=
ng
>>> >> latency. From then on it will know the exact size of buffering needed
>>> >> for the kernel it it running on and it can use this knowledge at
>>> >> stream creation time. Now filling the buffer at 8Hz or lower will wo=
rk
>>> >> and you don't have to spend the power associated with 1000Hz timer
>>> >> interrupts.
>>> >
>>> > Nothing prevents to application to allocate a big ring buffer and wri=
te
>>> > samples only as necessary. Application is a producer and controller i=
n this
>>> > case. The midlevel layer can hardly do something if samples are not
>>> > available. The situation will be more or less bad.
>>>
>>> Who is going to dynamically measure the scheduling latency of the
>>> kernel and compute the correct buffer size for the low level driver?
>>> You can't expect every app to do that.
>>>
>>> > The whole problem is that standard Linux kernel is not realtime, but =
audio
>>> > is realtime task.
>>>
>>> By that definition networking is a real time task too, but it's not.
>>>
>>> Playing MP3s is not a real-time task. The buffering system between the
>>> app and ALSA's DMA system is not properly communicating feedback and
>>> that's what is causing the problem. =A0Networking has a correct feedback
>>> look and doesn't get into trouble. ALSA's buffering system isn't
>>> flexible enough to hide these big scheduling latencies without losing
>>> data.
>>
>> It's not about flexibility. =A0The current audio system itself is
>> flexible enough to solve the problem you mentioned. =A0But you just need
>> to do everything by yourself. =A0A car with manual gears is as flexible
>> as a car with automatic gears from the performance POV, but a driver
>> needs more work to run it smoothly.
>>
>> Also, the automation isn't the best thing. =A0For example, think about
>> automatic resizing the buffer and restarting the stream: do you really
>> want this for the system like JACK? =A0No...
>
> The automation I proposed would only kick in on a kernel with poor
> latencies. You could write a message into the log saying that buffer
> sizes were increase due to latency problems.
>
> This would also be a clear message to anyone running Jack that their
> kernel was not performing adequately. On a good, low latency kernel
> these mechanisms would never trigger.

BTW, logging messages saying that audio buffer sizes were increased
due to poor kernel latency would be a good way of providing incentive
to fix these latency problems. This would make it clear to more people
that this was the cause of their audio being garbled (instead of some
other cause).

You don't want this logic in an app, it needs to be in the kernel. You
want the kernel to remember the longest observed latency. You don't
want each app to have to rediscover this value.


> I'd much rather see a mechanism like this in the middle layer rather
> than relying on ever app to get it right. Once this gets into the apps
> it will be there forever, if it is in the kernel it can be
> disabled/removed on a kernel that is known to not have problems.
>
> It's also not obvious to me if there is any way for an app to measure
> the size of buffer needed. All of the needed info is easily available
> in the kernel drivers.
>
>>
>> However, obviously, there is a big missing piece here - some
>> automation for an easy stream handling, including the automatic buffer
>> optimization for lazy jobs like MP3 player. =A0IMO, this isn't
>> necessarily in the kernel driver at all. =A0It's rather far better
>> implemented in the user space.
>>
>> A question is whether this should be in alsa-lib or not. =A0Maybe yes,
>> if it's really needed...
>>
>>
>> Takashi
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
