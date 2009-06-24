From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Wed, 24 Jun 2009 12:07:43 -0400
Message-ID: <9e4733910906240907x63dee45fy66e86ed6cc6f03e2@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
	<9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
	<20090623095444.GC5422@sirena.org.uk>
	<9e4733910906240710y2e5bdb21qfbd03af256094c3f@mail.gmail.com>
	<s5hvdml8zmw.wl%tiwai@suse.de>
	<9e4733910906240814j3dc920dfy6b9c795e7f2339e9@mail.gmail.com>
	<s5hr5x98xix.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f183.google.com (mail-pz0-f183.google.com
	[209.85.222.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F8CC103850
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 18:07:44 +0200 (CEST)
Received: by pzk13 with SMTP id 13so672622pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 09:07:43 -0700 (PDT)
In-Reply-To: <s5hr5x98xix.wl%tiwai@suse.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2009 at 11:24 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Wed, 24 Jun 2009 11:14:33 -0400,
> Jon Smirl wrote:
>>
>> On Wed, Jun 24, 2009 at 10:39 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> > The glitch-free problem of PA comes from the fact that PA assumes that
>> > the driver returns the current hw position accurately at any time.
>> > But, in many hardwares, including HDA, this is not true. =A0The hardwa=
re
>> > lies. =A0It doesn't report the right position at all. =A0Thus, there a=
re
>> > many workarounds implemented in HD-audio side.
>>
>> Why does pulse need to know the DMA position?
>>
>> If it is so that it can write into the buffer with minimal latency
>> there are other ways to accomplish that. The simplest is to just add
>> an entry into ALSA core that says, play this buffer with minimal
>> latency. That would let the transfer be pushed down into the specific
>> driver and that driver could handle it in an optimal way.
>
> To get a minimum latency, you need to program the sound hardware
> to notify that. =A0And, most hardware can't do anything but issue IRQs
> periodically at buffer, fragment or period or whatever boundary.
>
> Instead of the hardware irqs (that can wake up too often), PA uses the
> timer. =A0Then it must check the position because the clock on the
> hardware isn't quite accurate and very likely you'll get a drift
> sooner or later if you use the other timer source.

Pulse should not need to mess with this.  Doesn't pulse need to do
just two things?
1) play this buffer as soon as possible - abandon previously queued samples
2) ALSA call back saying I have room for more data in my queue
  2a) ALSA call back saying underrun happen

When pulse gets new low latency data from a client app, it should make
a new buffer, call into ALSA core and say, play this buffer ASAP. This
new buffer would replace the old one. Pulse does not need to know
where the DMA pointer is or mess with timers. Messing with those
should be internal to ALSA and it's drivers.  The ring buffer hardware
model should not be exposed to pulse, especially since not all
hardware has ring buffers.

Inside ALSA this play-ASAP buffer should just be passed into the
driver. Only the driver really know how to play something ASAP. The
implementation of play-ASAP will be quite different on ring buffer
hardware, scatter/gather DMA hardware or hardware that needs indirect
access to the buffer.

Trying to directly expose the ring buffer to the app seems like a good
way to avoid a copy, but it isn't achieving that. pulse is not
decoding audio straight into the ring buffer, it decodes first and
then copies into the buffer. Pulse is using the timers to estimate the
destination for the copy.  Move this copy down into the drivers, the
drivers know the correct destination for the copy.

>
> Yes, there can be optimizations for hardwares that are capable to
> notify any free size chunks. =A0This is a missing piece.
>
>> Optimal on my hardware would be to reprogram the DMA hardware to
>> immediately start playing from the new buffer. No copies involved. The
>> FIFO will hide the buffer swap from the audio hardware.
>
> Yes. =A0But it's rather a rare case that you can do such an operation.
>
>> Optimal on ring buffer hardware would be to locate where DMA was in
>> the ring and copy to a position in front of it.
>
> That's exactly what PA does. =A0But you must know where to copy
> beforehand. =A0And the hardware lies where is the current position.
>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
