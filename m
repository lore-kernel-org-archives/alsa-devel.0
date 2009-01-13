From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC scenarii API
Date: Tue, 13 Jan 2009 23:14:29 +0000
Message-ID: <20090113231425.GA20748@sirena.org.uk>
References: <87iqojqvyq.fsf@free.fr> <20090113155602.GD11651@sirena.org.uk>
	<87tz82yh1c.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 75B531037EE
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 00:16:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87tz82yh1c.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 13, 2009 at 11:31:27PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> > You can still carry on submitting the core machine support and then
> > patch it to add the scenario stuff later.  That'd probably make review
> > slightly easier too since it'd identify the new stuff explicitly.

> Mmm ... at the risk of having another hardware incident ... why not ? Let's take
> chances and see if another mio overheats.

As said elsewhere in the thread you should be able to prevent this by
preventing the affected outputs being simultaneously enabled (or
whatever the configuration was that caused the trouble - output
amplifiers are the things most likely to produce heat).

> > In general I'd like to see more exploration of the use cases that this
> > is intended to satisfy, including in terms of the mioa701 itself.  The
> > documentation should make it clear that this is not intended to be a
> > scalable solution and is only intended to be useful for hardware that is
> > very limited.  

> More comments then ? You know how poor my english is, you'll have to cope with

Your standards for what good English is are very high :) .

What I mean is that we need to make sure that the case for in-kernel
support has been made before it goes in and we also need to make sure
that if it does go in it's made clear that this shouldn't be the
standard way of doing scenarios.

> > What are you using for user space - is it one of the standard stacks
> > like FSO?  Looking at the features you've got I'm a bit concerned that

> No. Userspace is Trolltech's Qtopia over alsa-lib.

Hrm.  That's what OpenMoko used for their initial GTA02 release - they
were using user space scenarios for that.

> > to OpenMoko is WiFi.  For example, with your current scenarios I'm not
> > sure if it'd be possible to record a call or do simultaneous record and
> > playback?

> You're right. That functionnality is not available. That's the price to pay,
> somehow.

This was the major part of the push to keep this out of kernel: it's
difficult to impossible to figure out all the scenarios that users might
want to run in and express them in a clean fashion.  How the audio is
routed ends up being a runtime policy decision since so much of it is
about the needs of the user space applications at any given moment
rather than on the properties of the hardware.

The other part was that it makes scenario development much easier (since
you can use standard UIs and don't need to rebuild the kernel).

> >  For dealing with overheating I *expect* that you only need to
> > have the machine driver prevent particular combinations of outputs being
> > simultaneously enabled.

> Ah, I feel you're right. The problem is, we don't have the specification, so we
> cannot be sure what creates the overheating.

Oh, I see.  If you're not sure restricting it to one output from the
device (ie, only those that make the device itself make noise) at once
would *probably* cover it.  There may be some interaction with the heat
output from the RF stuff, though that'd be an issue anyway since the
scenario stuff has no knowledge of that.

> > The main issues I can see are with how state transitions are
> > managed and with how machine drivers interact with this if they need to
> > update the configuration at run time.

> Ah, the missing pre_scenario() and post_scenario() handlers in snd_soc_scenario
> I guess. I thought about these and forgot them. Will these deal with your
> concern ?

That doesn't give the machine drivers any way to do stuff other than on
a user-initiated change.

> >> 			  char *pin_names[], int nb_pins);

> > I'm not sure why the pin names are specified separately here?  Would it
> > not be better to just use the pin lists in the scenarios.

> There are _no_ pin lists in scenarios. The scenarios only define a transition
> for each pin index. The actual pins are initialized once in the init function
> (ie. pin_names[0] = "Rear Speaker" for example). Then, in each scenario,
> pin_setup[0] will tell what to do to "Rear Speaker" : leave it, activate it or
> deactivate it.

Ah, ouch.  That does become hard to read...
