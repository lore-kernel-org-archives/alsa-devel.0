From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Wed, 24 Jun 2009 10:10:35 -0400
Message-ID: <9e4733910906240710y2e5bdb21qfbd03af256094c3f@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
	<9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
	<20090623095444.GC5422@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B9D3C247CB
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 16:10:36 +0200 (CEST)
Received: by qyk1 with SMTP id 1so953024qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 07:10:35 -0700 (PDT)
In-Reply-To: <20090623095444.GC5422@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2009 at 5:54 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 22, 2009 at 12:43:52PM -0400, Jon Smirl wrote:
>> On Mon, Jun 22, 2009 at 12:27 PM, James
>
>> > DMA transfers on sound cards are a ring buffer. There is no automatic
>> > stop feature.
>
>> I don't about all hardware, but all of the hardware I've worked with
>> works both ways, ring or stop at the end.
>
>> DMA transfers for network packets wouldn't work in the ring buffer
>> model, you need the stop at the end capability.
>
> Remember, you're working with a general purpose SoC which shares the DMA
> controller with a large selection of other hardware. =A0A DMA controller
> that's part of a sound device and can't be used in anything else doesn't
> need to worry about any other applications.
>

>From what I have observed the current ALSA DMA design does not
reliably deal with over/underrun.  On the hardware I'm using it is
possible to construct a system which will always behave predictably
but I can't build it using the ALSA driver interface.

These issues probably indicates that the DMA interface between ALSA
and the driver has been designed at the wrong level. For example those
timers trying to fix glitches in HDA belong down in the HDA driver,
not the core. Why did my DMA code needs to peak back into ALSA core at
appl pointer?  The proliferation of flags on the DMA interface is also
an indication that it is too low level.

I'm still working on solutions for my embedded application but I may
be forced to add private IOCTLs to the driver and by-pass ASLA.  That
will work for me since I'm not building a general purpose system.



-- =

Jon Smirl
jonsmirl@gmail.com
