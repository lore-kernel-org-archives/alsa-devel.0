From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 22 Sep 2010 16:14:19 +0100
Message-ID: <20100922151419.GF26395@rakim.wolfsonmicro.main>
References: <alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
	<20100922132052.GC32476@sirena.org.uk>
	<alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4BC1F103903
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 17:14:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
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

On Wed, Sep 22, 2010 at 04:06:56PM +0200, Jaroslav Kysela wrote:
> On Wed, 22 Sep 2010, Mark Brown wrote:

> >This is what the snd_use_case_*_pcm() functions are all about -
> >identifying which of the many available streams should be used for a
> >given output stream.  With modern mobile audio architectures the ability
> >to route different kind of audio to different PCM streams is essential.

> But it's not possible to guess if streams are independant from the
> PCM device name. Some hardware has restrictions or driver can offer
> more PCM devices for one hardware (for example stereo only devices
> and multichannel devices sharing same hardware portion).

That sounds like an annotation for...

> >Now, it's true that it doesn't explicitly support grouping multiple PCMs
> >together into a single use case which is probably a good extension to
> >think about - perhaps returning arrays would cover it, though to be
> >honest I'm not sure how often that'd get used (and I'd expect apps to
> >fail to cope).

> Maybe a simple extension to the current API might cover also this
> issue: Add a third state for devices and modifiers - "blocked". This
> state will be active when hardware has inter-device/modifier
> contraints or when another application uses hardware in the blocking
> way.

...this, though I think the blocking concept is most likely a higher
level one than UCM since there's a lot of of overlap between this and
policy decisons about which outputs are active.  It might be easier to
implement blocking by setting up the use case with a /dev/null stream
instead of a real one so applications don't need to cope, though
obviously some things will want to know if their audio is being
blackholed.

> >>The question is how we can make much flexible the passing of these values
> >>from the configuration files. I think that we may use just a direct way
> >>between the "identifier" from the snd_use_case_get/set function and the
> >>configuration files, having syntax something like:

> >There's some scaling issues that need to be dealt with - for example, if
> >you're asking for the controls for an EQ you likely want to be able to
> >get an array back with the per-band gains and possibly trimming options
> >for the bands since there's quite a bit of range in the control offered
> >by EQs.  This means we will need to be able to return a variably sized
> >set of controls.
> 
> Sure, but you can describe this array in a string with some delimiters.

That's not going to be terribly pleasant as an API, though - I'd expect
the library to have demangled the data before applications are expected
to work with it.  Otherwise you end up with lots of people implementing
the same parsing code.

> I just finished the implementation for all functions in my GIT tree
> (except card listing). Also, the "Value {}" section is implemented
> as I proposed - it means that users can pass any read-only values to
> the API user.
> 
> The code is not tested, I need to write a simple command line tool
> for testing the API and also move the control/mixer ID and value
> handling code from the alsa-utils/amixer utility to alsa-lib.

> So, please, check the use-case.h again:

> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/use-case.h;h=fdbcaca04c032b22de41cce2d42ab5b84edd37f4;hb=404cd090b279b329c86514984dc74439dedf2e90

Random points since there's no patch to quote:

 - For the list of known identifiers would it not make sense to just say
   that standard ALSA control names are used for things like Capture
   Volume?  Just say something like "Use standard ALSA control names or
   one of the following additional things with an optional /modifier"

 - For standard string identifiers it'd be nice to provide definitions
   to provide compile time checking for typos - if we just use strings
   then they'll only be noticed at runtime, if there's standard defines
   the build will fail if people use them with typos.

 - As I said above I don't like the idea of returning just a string for
   _get() - if the string needs any sort of parsing to be intelligable
   we shouldn't be forcing users to do all that.

In general I'm nervous about the usability and robustness here; there's
an awful lot of stuff getting passed around as strings which may or may
not need parsing.  This is much more of a concern for me on the output
side than on the input side since it pushes complexity onto client code
without any safety features at all and causes clients to have to
implement very similar code to understand the more complex strings.

What might work here would be to use this as a core API for advanced
users then layer on more specific APIs which make stronger guarantees
about what comes back (eg, guaranteeing to return only a single control
name).  We could perhaps merge something like what you've got here and
then add such features incrementally.
