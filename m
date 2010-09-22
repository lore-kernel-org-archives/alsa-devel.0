From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 22 Sep 2010 19:48:17 +0100
Message-ID: <20100922184817.GT26395@rakim.wolfsonmicro.main>
References: <alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
	<20100922132052.GC32476@sirena.org.uk>
	<alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
	<20100922151419.GF26395@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.1009221950540.6226@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D265A103918
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 20:48:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009221950540.6226@eeebox2.perex-int.cz>
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
Cc: Chris Winter <elwintro@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 08:05:12PM +0200, Jaroslav Kysela wrote:
> On Wed, 22 Sep 2010, Mark Brown wrote:

> >...this, though I think the blocking concept is most likely a higher
> >level one than UCM since there's a lot of of overlap between this and
> >policy decisons about which outputs are active.  It might be easier to
> >implement blocking by setting up the use case with a /dev/null stream
> >instead of a real one so applications don't need to cope, though
> >obviously some things will want to know if their audio is being
> >blackholed.

> If the blocking state can be set only from the ucm code (not from an
> application), there is no policy. It's just a reflection about
> actual hardware state. Yours and other comments persuaded me that we
> should not apply any policy in the ucm level.

OK, I think we agree here - my suggestion for using a /dev/null stream
is just an example of something the policy level could configure in the
UCM rather than UCM functionality.

> >Random points since there's no patch to quote:

> >- For the list of known identifiers would it not make sense to just say
> >  that standard ALSA control names are used for things like Capture
> >  Volume?  Just say something like "Use standard ALSA control names or
> >  one of the following additional things with an optional /modifier"

> I don't have any trouble to use the usuall control naming. These
> rules must be documented somewhere, otherwise they might be useless.
> I made this information completely optional and the names are not
> fixed (my code does not look to these values at all).

Right, broadly agree but think we should be providing guidance to users
otherwise the API might be overwhelming - look at the issues we have
with selecting appropriate control names with the current APIs.

> Basically, it's my idea. The major thing for ucm is the verb /
> device / modifier / transition handling and device listing. All
> other optional data might have many usages and it depends on the
> final purpose. So call
> strings like data containers. We can even carry XML or so if necessary :-)

I'm all for having the ability to annoate the use cases with other data
but I do feel that this should be within a much more structured framework
than is present here.  However...

> Also, I plan to add to alsa-lib all parsers for the control ID,
> control value stuff, but to the right API - the control API
> (snd_ctl_*). So there is no requirement to implement these parsers
> in applications. The parsers will return standard structures like
> 'snd_ctl_elem_id_t' or so.

...this is pretty much exactly what I was suggesting with layering on
higher level APIs which provide more useful formats to users.  I'm
therefore not sure if this would actually be resolved or not.  If we're
going to have these more packaged APIs then it would probably be good to
steer people away from the UCM API itself through a combination of
documentation and API naming - make it clear that this is for advanced
users and that for basic usage you're supposed to go via the simpler
APIs.  

Does that sound like a good plan to you?

Having looked at the implementation briefly I also note that you've
kept the procedural specification of the control settings in your
configuration file format.  As I outlined previously I do have serious
concerns about this as a model for users to work with (orthogonally to
the actual implementation which must come down to a procedure at present
due to the ALSA API, something I hope to provide features to avoid in
the future).

If we make everything procedural now it will become much harder to back
out of it later, and I would hope that one of the things that use case
management can do is ensure that users only need to specify their goal
states and don't need to deal with the mechanics of how to achieve them
except in exceptional circumstances.
