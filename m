From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 20 Oct 2015 10:06:40 +1030
Message-ID: <20151019233640.GB8953@marvin.atrad.com.au>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
 <5624FA84.70208@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 012222652C5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:36:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5624FA84.70208@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

On Mon, Oct 19, 2015 at 11:13:24PM +0900, Takashi Sakamoto wrote:
> On Oct 13 2015 23:15, Stefan Richter wrote:
> > I was just generally wondering what the extent of protocol similarities
> > are.  Personally I don't own a Digidesign, TASCAM, RME or MOTU at this
> > time.  Thanks to you and to Jonathan for explaining.
> 
> These protocols use different format of data block, while I guess that
> the number of data blocks transferred per second and the number of data
> blocks in packets follow to IEC 61883-6. In this developing period, I
> re-design AMDTP functionality in firewire-lib according to this assumption.

As far as I remember IEC 61883-6 uses a fixed number of frames per packet
(is this what you meant by "blocks in packets"?): 8, 16 or 32 depending on
sample rate.  My recollection could be wrong here though.  In any case:

 * For RME the number of frames per packet is not fixed which allows the
   software to utilise whichever number it needs in order to effect an
   efficient data transfer.  Within a given running stream this number can
   vary by +/- 1 as required to maintain audio sync with the interface.

 * Neither RME or the MOTU protocols sync to the firewire clock.  They have
   a separate audio clock which is not locked to the firewire clock under
   any circumstances, nor does the firewire clock ever lock to the audio
   clock (or the master oscillator from which it is derived).  As a result
   the "number of data blocks transferred per second" is not fixed and
   depends on the relationship between the audio clock and the firewire bus
   clock.  It's a long time since I read the relevant portions of IEC
   61883-6 so I can't recall exactly how this fits with the reality of these
   interfaces.

It should be noted that neither of these devices make claims about using IEC
61883-6 in any way, although it happens that there are some similarities.

> ... while, to tell the truth, I'm not willing to add my mixer/control
> programs to the project anymore for several reasons:

I'm disappointed to hear this, but each to their own.  I think it would be
good to evolve FFADO such that ultimately the control/mixer applications for
firewire devices were all developed under this one project so users had a
one-stop shop whenever they needed a control/mixer application for firewire
devices.

There are also other reasons to seriously consider a common project for
these control/mixer programs.  Perhaps most significantly, while the layout
and capabilities of each device vary markedly the low level controls
required are often common.  For example, most devices require a matrix mixer
of some sort.  If a new generation of control programs were to live under a
common project then there is the opportunity to share these elements between
all such programs.  If each is developed in isolation this can't happen,
resulting in many implementations of the same thing.

Of course one option would be to incorporate such programs into alsa-tools
or alsa-utils.  However, due to the divergent nature of the programs the
collection would quickly become quite sizable which warrants consideration
keeping them separate.  FFADO is already established and could easily act as
the repository for these new tools.

>  * code base is too old.
>   * Especially for python3 support. Many distributions start to suppress
>     python2 supports and near future ffado packages may be grouped
>     as 'deprecated'.

There is no reason at all that new control/mixer applications within FFADO
have to use the existing infrastructure.  If someone were to submit a pure
python3 mixer/control application for inclusion within FFADO which did not
utilise the existing FFADO infrastructure I would have no problem with that
and would be happy to include it in the project.

As an aside, it would be great if the existing python mixer code could be
migrated to python3 (with or without reliance on libffado as it exists
presently) since there is a lot of useful things in there.  As always the
issue is time and developer resources (and the fact that none of the
currently active FFADO developers are python3 experts).  In the meantime,
any new program that's written could make use of python3 from the start if
that's what the developer thought was best.

Another option to consider would be the creation of a ffado3 development
which is designed from the outset to work only in conjunction with the
kernel streaming drivers.  This makes the break from the old infastructure
explicit while still being able to provide a common framework to support
mixer/control programs.

>  * over-specification
>   * For most of mixer/control applications, it's just enough to
>     send/receive asynchronous transactions. On the other hand, FFADO
>     framework force developers to implement more codes unrelated to it.
>     For example, D-Bus programming.

I think there is a misunderstanding here.  Firstly, as above, there is
nothing forcing developers to use any of the existing framework.  If someone
were to write a new mixer application for some device which utilised native
async send/receive without any reliance on the rest of the FFADO
infrastructure I would have no problem with that.

Secondly, it should be said that the existing FFADO framework does not force
developers to deal with D-Bus programming directly.  The details are taken
care of in the lower layers of libffado.  I have personally written two
drivers and the corresponding mixer modules and have never once done what I
would consider to be "D-Bus programming".

Finally, I agree completely that the existing FFADO device infrastructure is
overkill if control/mixer applications are the only target.  However, it's
not compulsary to utilise it, as explained previously.  For control/mixer
programs it would make sense to implement a simple direct usage of async
commands.

>   * Libffado also includes streaming functionality and this is used to
>     jackd. It's not so easy to modify without regressions, especially
>     discover routine.

The streaming functionality is part of the existing infrastructure which
does not need to be used in new support programs if it is not needed.  In
any case, the streaming code remains completely dormant unless explicitly
called.  Therefore a control/mixer program can - if it wishes - make use of
the existing driver layer without those drivers ever attempting to do any
streaming.  As streaming functionality is moved into the kernel and debugged
against relevant interfaces there will clearly be no need to update the
FFADO streaming components, and in time I see that they will in fact be
removed.

>  * defectives as service application for IEEE 1394 bus
>   * Libffado cannot handle bus-reset correctly, thus libffado cannot
>     handle device hot-plugging. Although, ffado-dbus-server performs as
>     system service. This is due to wrong usage of libraw1394 API.

This is not something I've had any personal problem with.  Perhaps it
depends on the device being used.  FFADO does include bus reset handling. 
While it may not work reliably during streaming, it seems to work at least
for some devices in the context of control/mixer programs.  If there is an
issue during streaming it could be argued that it's irrelevant since the
streaming portion of FFADO will be deprecated once all drivers are present
in the kernel and in any case, if streaming audio and a device goes away you
clearly have other issues to solve.

All that aside, new control/mixer programs would not need to use libffado if
the author didn't want to.

> But this is in my case. In this thread, it's better to continue to
> discuss with ignoring it.

I think the discussion about where future control/mixer programs will live
should happen sooner rather than later.  As stated, I think they ought to be
collected under a single coordinated project to facilitate the sharing of
basic building blocks and I can see no reason why this can't be FFADO. 
However, obviously I'm open to other suggestions.  Having the coordinated
project for all such programs also provides a natural place to have and
maintain any udev rules which are required, much like FFADO already does.

> >> If possible, I'd like to add enough rules to udevd, including RME and 
> >> MOTU models before working for them.
> > 
> > For those RME and MOTU models whose mixer program continues to be
> > developed in the FFADO project, the FFADO-maintained ruleset is obviously
> > sufficient.
> 
> As long as mixer/controls programs are developed by FFADO project only.

No, not necessarily.  Yes, FFADO (in whatever incarnation) would need to be
installed to pick up the udev rules.  But once this was done there is no
requirement to actually use the programs provided by FFADO if you don't want
to, and it's not as if FFADO takes up hundreds of megabytes of storage
space.  If the rules are present then any user in the "audio" group can
access the fw device node of the audio interface in whatever way they
choose: they don't have to use libffado.

Having said that, I think it is a natural evolution for the next generation
of control/mixer programs to be developed under the FFADO umbrella.

Regards
  jonathan
