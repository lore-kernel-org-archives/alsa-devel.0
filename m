From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: DMA over run on playback
Date: Wed, 13 May 2009 09:47:41 -0400
Message-ID: <9e4733910905130647i40a6d68fh9bb84a9b329e84b8@mail.gmail.com>
References: <9e4733910905130608u63a924cam25dca6af929ec82b@mail.gmail.com>
	<alpine.LNX.2.00.0905131510480.25064@eeebox2.perex-int.cz>
	<9e4733910905130638y4de40cc1vdd7b682fef867f95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 03FAD10388B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 15:47:42 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1154065qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 06:47:42 -0700 (PDT)
In-Reply-To: <9e4733910905130638y4de40cc1vdd7b682fef867f95@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 9:38 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, May 13, 2009 at 9:25 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Wed, 13 May 2009, Jon Smirl wrote:
>>
>>> There's a long thread over on the pulse list about glitch free
>>> playback. The glitches they are encountering are caused by CPU
>>> scheduling latency. =A0They are trying to fix this by setting HZ up to
>>> 1000 and constantly polling the audio DMA queue to keep it 99% full.
>>>
>>> This doesn't seem like the right solution to me. It is fixing the
>>> symptom not the cause. The cause is 200-300ms scheduling latency. The
>>> source of that needs to be tracked down and fixed in the kernel. =A0But
>>> we have to live with the latencies until they are fixed.
>>>
>>> The strategy of checking the queue at 1000Hz works but it is very
>>> inefficient. The underlying problem is that the buffer ALSA is using
>>> is too small on systems with 300ms latency. =A0The buffer is just big
>>> enough to cover 300ms so they rapidly check and fill it at 1000Hz to
>>> ensure that it is full if the 300ms latency strikes.
>>
>> ??? The ring buffer size is not limited if hw allows that.
>>
>>> On my hardware with period interrupts ALSA is only checking the buffer
>>> at 8Hz. Since I'm checking appl_ptr I know when DMA over runs the
>>> buffers. This allows me to insert silence and I could indicated this
>>
>> Inserting silence might be wrong, if you broke stream timing. The elapse=
d()
>> callback should be called at exact timing (and position should be update=
d,
>> too).
>>
>>> condition to ALSA if there was a mechanism for doing so. ALSA could
>>> use this over run knowledge to measure scheduling latency and adjust
>>> the buffering.
>>>
>>> But the DMA interface between ALSA and the driver has been fixed at
>>> stream creation time. There's no way to dynamically alter it (like
>>> window size changes in TCP/IP). =A0With networking you get a list of
>>> buffers to send. As you send these buffers you mark them sent. The
>>> core is free to hand you buffers straight from user space or do copies
>>> and use internal ring buffers. The network driver just gets a list of
>>> physical addresses to send. This buffer bookkeeping could occur in
>>> snd_pcm_period_elapsed().
>>>
>>> A dynamic chaining mechanism allows you to alter the buffering
>>> mid-stream. If the driver indication a DMA over run error this tells
>>> ALSA that it needs to insert another buffer. After a while these
>>> errors will stop and ALSA will have measured worst case CPU scheduling
>>> latency. From then on it will know the exact size of buffering needed
>>> for the kernel it it running on and it can use this knowledge at
>>> stream creation time. Now filling the buffer at 8Hz or lower will work
>>> and you don't have to spend the power associated with 1000Hz timer
>>> interrupts.
>>
>> Nothing prevents to application to allocate a big ring buffer and write
>> samples only as necessary. Application is a producer and controller in t=
his
>> case. The midlevel layer can hardly do something if samples are not
>> available. The situation will be more or less bad.
>
> Who is going to dynamically measure the scheduling latency of the
> kernel and compute the correct buffer size for the low level driver?
> You can't expect every app to do that.
>
>> The whole problem is that standard Linux kernel is not realtime, but aud=
io
>> is realtime task.
>
> By that definition networking is a real time task too, but it's not.
>
> Playing MP3s is not a real-time task. The buffering system between the

I should clarify that. It's not real-time in the sense of needing
millisecond response times. It is real-time in that it's response time
is bounded by the buffers involved. But those buffers can be set
arbitrarily large. By setting those buffers large enough to allow for
worst case system latency the real-time bounding constraint is
removed.

> app and ALSA's DMA system is not properly communicating feedback and
> that's what is causing the problem. =A0Networking has a correct feedback
> look and doesn't get into trouble. ALSA's buffering system isn't
> flexible enough to hide these big scheduling latencies without losing
> data.
>
>
>>
>> The result is to set optimal ring buffer parameters in the application.
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0Jaroslav
>>
>> -----
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Kernel Sound Maintainer
>> ALSA Project, Red Hat, Inc.
>>
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
