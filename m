From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 21 Jun 2011 00:40:54 +0100
Message-ID: <20110620234053.GA1905@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4D5624367
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 01:40:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFF973A.1080404@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 08:53:46PM +0200, David Henningsson wrote:
> On 2011-06-20 19:07, Mark Brown wrote:
> >On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:

> >Looking at the patch the main thing that jumps out at me without
> >any knowledge of the udev code is that the patch will end up classifying
> >video output jacks as audio even if they've no audio capability which is
> >obviously not correct.

> In suggested implementation, they will only be marked audio jacks if
> their parent object is a sound card.

Oh, then in that case we've got another issue in that jacks that happen
not to be associated directly with a sound card for some reason (they're
implemented by the embedded controller and exposed via ACPI for example)
won't be made available to applications.

> >I still don't entirely understand the technical issue you're trying to
> >address here - this doesn't seem specific to audio.

> I think this is a difference between embedded space and desktop
> space. In embedded space, a hardware designer can decide to connect
> the "take a camera picture" button to "line in jack detect" just
> because that saves him an extra GPIO chip (and "line in" isn't
> connected anyway). Those things don't happen on normal PC [1], but
> instead, things must be auto-detectable.

I'm sorry but I'm not sure I follow the connection between the text
you've written above and the point made in the text you're quoting.  The
physical implementation of the hardware doesn't seem strongly related to
how Linux distributions manage permissions for the interfaces exposed by
the drivers that manage that hardware.

If you're talking about the support for buttons that's nothing to do
with wiring random unrelated controls to jack detection circuits (which
would be highly unusual as pretty much any detection specific
electronics are highly specialised and difficult to use for anything
else).  It's there because most headsets have at least one button on
them, implemented by shorting the mic to ground and used for
play/pause/call functionality, and some have more complex arrangements.
I've got a laptop sitting on this table which implements such
functionality.

As far as the implementation stuff goes you do get all sorts of odd
stuff on PCs, anything you've done that involves ACPI interaction (like
the Thinkpad extra volume control that was being discussed recently) is
going to be that sort of oddity.

> >only aren't working correctly in at least this case.  It feels like if
> >we understood why the heuristics are making a bad call here we might be
> >able to come up with a better solution.

> AFAICT, the current "heuristics", is to assign all input devices to
> root and root only.

OK, well that doesn't seem like an immediately obvious choice.  I can
imagine there might be some concern around keyboards due to passwords
but in general it doesn't seem obvious that the console user shouldn't
be able to read physical input devices on the box (which is the case
we're trying to implement here; we don't need write support).  Do all
classes of input device currently have some root only service to mediate
access to them, and if that is the model we're using perhaps it'd make
sense to have one for this with a dbus interface or whatever that
PulseAudio can talk do rather than to have it talking direct to the
device?

> >>For options 2a) and 2b) I guess the existing /dev/input thing should
> >>be deprecated and/or removed. So part of decision should maybe be
> >>based on information about how widespread the usage of these devices
> >>are currently...?

> >There's a reasonable amount of usage in the embedded space.

> But maintaining two different implementations of input jacks without
> at least strongly deprecating one of them, lead to application
> programmers being confused, kernel being big and bloated, and so
> on...

"But"?
