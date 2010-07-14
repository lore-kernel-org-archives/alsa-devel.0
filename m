From: Niels Mayer <nielsmayer@gmail.com>
Subject: Re: [LAD] FIxed alsa-tools' envy24control missing peak
	level meters and "Reset Peaks"
Date: Tue, 13 Jul 2010 21:54:58 -0700
Message-ID: <AANLkTil3bV075Ef5-e-UGMDj-3Mmee2fJtUjf3h5U88Y@mail.gmail.com>
References: <AANLkTimVnkZjBLxxhx4I8OtFiu9oOH0cPpX4V9wNimIa@mail.gmail.com>
	<20100712234002.GF4069@zita2>
	<AANLkTim7LFEk8VzJgJmlLvgJPJcAfT0uhfRE6nRBbLFH@mail.gmail.com>
	<20100713081908.GA4083@zita2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F4811037F1
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 06:55:00 +0200 (CEST)
Received: by vws9 with SMTP id 9so6758014vws.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 21:54:58 -0700 (PDT)
In-Reply-To: <20100713081908.GA4083@zita2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: fons@kokkinizita.net
Cc: alsa-devel@alsa-project.org, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 13, 2010 at 1:19 AM,  <fons@kokkinizita.net> wrote:
>On Mon, Jul 12, 2010 at 06:18:29PM -0700, Niels Mayer wrote:
>> Speaking of making my brain hurt -- I really would not have done the
>> meters as done in envy24control. I really hate the concept of
>> emulating the look of real gear down to the level that you have to
>> "quantize" to individual LED's...
>
> That is indeed quite absurd.

Yes, the meters in envy24control --
http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=envy24control/levelmeters.c;hb=HEAD
-- are absurd! What's even more absurd, is to have the benefits of the
ice1712's hardware metering squandered by drawing thousands of
rectangles per second (each individual "LED" on each meter is a
separate x draw-rectangle call). The existing envy24control meters are
an abomination of inefficiency! Especially when used with a remote X
display.

As a second patch (coming soon), I've rewritten  the meters in a more
sensible fashion, drawing a single rectangle to represent the
instantaneous level (2-3 X-primitive draws per meter total and one
blit, versus hundreds of draws and a blit per value change per meter
in the original code). I'm also being a little more careful about not
needing to redraw the entire meter for each change -- using the
monotonicity of the audio signal being represented to optimize the way
you draw it; not redrawing if nothing has changed, etc.

And since the hardware metering already quantizes to 256 levels --
there's no point in re-quantizing those to individual "virtual LEDs"
as is done w/ the current envy24control.

The result so far are promising: Here's 'top' output (*) using the new
envy24control. Note the load is lower, and 'envy24control' and 'X'
both use much less CPU. In fact running this meter lowers the system
load. whereas running the old envy24control raises it (and makes the
fans run faster!).

 top - 21:30:13 up 11:30,  9 users,  load average: 0.02, 0.11, 0.06
 2664 root      20   0  544m 134m  34m S  2.6  3.4  26:03.51 X
 9404 npm       20   0  192m 9340 6908 S  0.7  0.2   0:01.72
envy24control

The new metering gives 2.6% CPU for X, and 0.7% CPU for the
new-metered envy24control; Versus 6.3% CPU for X and 2.7% for the old
metering in envy24control (the one from my first patch):

 top - 21:25:57 up 11:25,  9 users,  load average: 0.10, 0.09, 0.03
 2664 root      20   0  544m 134m  34m S  6.3  3.4  25:50.67 X
 9398 npm       20   0  192m 9368 6940 S  2.7  0.2   0:16.81 envy24control

Now granted this is not a scientific test, and "top" is not exactly
the best way to gauge performance. But it does suggest that the
computational complexity caused by the bad metering algorithm directly
translates to higher-power consumption, higher loads, and poorer
performance.

Compared to the existing envy24control metering -- It would probably
me more efficient to actually compute RMS levels off the audio stream
-- or even hook up jkmeter through jack -- instead of using the
hardware metering data through these computationally wasteful level
meters.

-- Niels
http://nielsmayer.com
