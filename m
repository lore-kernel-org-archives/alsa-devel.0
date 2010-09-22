From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 22 Sep 2010 14:20:53 +0100
Message-ID: <20100922132052.GC32476@sirena.org.uk>
References: <alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E7724457
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 15:20:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
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
Cc: Chris Winter <elwintro@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 21, 2010 at 08:11:35PM +0200, Jaroslav Kysela wrote:

> There are two things and I think that we both talking about different 
> ones.

> 1) Which devices can be used simultaneously in the system
>     (basically determining the number of handled streams).
> 2) Physical output (or input) switching (I mean physical jacks etc.).

> I don't want to add any complex manager. I just think that the UCM layer 
> should give the information to the application which PCM streams can be 
> used concurrently for a named card. Something like stream grouping.

This is what the snd_use_case_*_pcm() functions are all about -
identifying which of the many available streams should be used for a
given output stream.  With modern mobile audio architectures the ability
to route different kind of audio to different PCM streams is essential.

Now, it's true that it doesn't explicitly support grouping multiple PCMs
together into a single use case which is probably a good extension to
think about - perhaps returning arrays would cover it, though to be
honest I'm not sure how often that'd get used (and I'd expect apps to
fail to cope).

> The problem is that you think in the "ASoC" way to handle just one 
> input and output stream for phones etc. and I think in "multiple 
> independant streams" per card way.

This is not the case at all.  As I said previously the sort of systems
that run ASoC already support pretty much all the use cases you have on
PCs and then some to the point where PC audio requirements are generally
noticably less complex than those for mobile platforms.  PCs have much
more regular hardware than the more complex embedded systems which helps
a lot with software complexity.

I previously pointed you at the WM8994 as an example of the sort of
device one sees in modern smartphones:

    http://www.wolfsonmicro.com/products/WM8994

This supports many bidirectional audio streams, with two being delivered
using TDM on one physical audio interface intended for connection to the
CPU and a more complex routing arragement available on the other two
physical audio interfaces for connection with the radios though it's
also possible to connect additional links to the CPU if the application
demands it.

These sorts of features aren't that new - even something several years
old like the Marvell Zylonite reference platform offers multiple streams
to the CPU.

> This is really point why I switched from "many functions returning 
> just values" to "one function with a universal string identifier 
> returning requested value". It makes API much flexible for future 
> extensions and the library will not export a next bunch of similar 
> functions.

I think there's a balance here in interface complexity terms - there's
value in having some structure provided by default with a more advanced
interface for more general use.  This provides some guidance and code
simplification for basic use while providing room for more complex use
cases.

> The question is how we can make much flexible the passing of these values 
> from the configuration files. I think that we may use just a direct way 
> between the "identifier" from the snd_use_case_get/set function and the 
> configuration files, having syntax something like:

There's some scaling issues that need to be dealt with - for example, if
you're asking for the controls for an EQ you likely want to be able to
get an array back with the per-band gains and possibly trimming options
for the bands since there's quite a bit of range in the control offered
by EQs.  This means we will need to be able to return a variably sized
set of controls.

> SectionDevice."Headphones".0 {
>  	...
>  	Value."_ctl_/_pctlsw" "name='Master Playback Switch'"
>  	...
> }

This sort of thing is quite different to what you were suggesting
previously and much less problematic.
