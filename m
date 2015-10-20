From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 20 Oct 2015 13:22:14 +1030
Message-ID: <20151020025214.GE8953@marvin.atrad.com.au>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
 <5624FA84.70208@sakamocchi.jp>
 <20151019233640.GB8953@marvin.atrad.com.au>
 <56258FE6.9000304@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C168265E0C
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 04:52:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56258FE6.9000304@sakamocchi.jp>
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

On Tue, Oct 20, 2015 at 09:50:46AM +0900, Takashi Sakamoto wrote:
> > As far as I remember IEC 61883-6 uses a fixed number of frames per packet
> > (is this what you meant by "blocks in packets"?): 8, 16 or 32 depending on
> > sample rate.  My recollection could be wrong here though.
> 
> No. It's so called as 'blocking transmission', while IEC 61883-6:2000
> describes 'non-blocking transmission' in its clause 6.4. The blocking
> transmission is in its Annex A, so optional.

Ok.

> > I think the discussion about where future control/mixer programs will live
> > should happen sooner rather than later.  As stated, I think they ought to be
> > collected under a single coordinated project to facilitate the sharing of
> > basic building blocks and I can see no reason why this can't be FFADO. 
> > However, obviously I'm open to other suggestions.  Having the coordinated
> > project for all such programs also provides a natural place to have and
> > maintain any udev rules which are required, much like FFADO already does.
> 
> ...It seems to be my mistake to have described current FFADO status.
> Just ignoring it, sorry but I'm not willing to take my time for such
> discussion. It's waste of time due to differences of our stance on this
> softwares and a lack of understanding about Linux system.

I am not sure it was intended, but this response unfortunately comes across
to me as abrasive and confrontational.  Misleading and incorrect claims were
made about FFADO and what would be possible within the confines of that
project, and these were then used to justify a particular view.  Since these
were made in a public forum I felt that the record should be corrected.

It was not a mistake for you to describe what you thought to be the current
status of FFADO because it gives a much clearer picture of what your views
are with regard to FFADO.  My response was an attempt to continue the
discussion so we could better understand where the other was coming from,
and come up with a coordinated plan to migrate some remaining firewire audio
device streaming support into the kernel.  I am disappointed that you view
such a discussion as a "waste of time".

It remains my view that control and mixer programs for firewire audio
interfaces should be developed under a single project due to the opportunity
to share control widgets and other features.  Unfortunately I do not know
the details of your "stance on this softwares" (sic) which has lead to you
the conclusion that this is not a good idea and could not be done under the
FFADO umbrella (perhaps as a ffado3 development, starting with a clean
slate).  As a result, all I can really see at this point is you prefer to go
it alone with the development of your control programs for reasons unknown
to me.

It is unclear to me who "a lack of understanding about Linux system" is
directed to.  If it was towards me I dispute the assertion, having been
using Linux since 1992, contributing to various projects since the early
2000s and writing Linux firewire audio drivers for over 8 years.

> > No, not necessarily.  Yes, FFADO (in whatever incarnation) would need to be
> > installed to pick up the udev rules.  But once this was done there is no
> > requirement to actually use the programs provided by FFADO if you don't want
> > to, and it's not as if FFADO takes up hundreds of megabytes of storage
> > space.  If the rules are present then any user in the "audio" group can
> > access the fw device node of the audio interface in whatever way they
> > choose: they don't have to use libffado.
> 
> Exactly. I don't want to install ffado packages just for udev rules.

Under the scenario I envisaged (which was looking to a future time when the
transistion to kernel streaming drivers was complete), a "ffado" install
would consist of the necessary udev rules plus the control/mixer programs
for the interfaces.  In other words, it would be the things that most people
would be using.  FFADO would no longer need or include any of the existing
driver infrastructure because streaming would be handled in the kernel.  But
whatever, the location of udev rules isn't something I intend to loose sleep
over.  Besides, if the control utilities are maintained in isolation from
each other then it's a moot point anyway.

> > Having said that, I think it is a natural evolution for the next generation
> > of control/mixer programs to be developed under the FFADO umbrella.
> 
> I prefer imagination to subsistence for discussion. Especially, 'A is
> better but actually where A is and who works for A' is meaningless for
> discussion.

I don't quite follow this statement but it seems to be dismissive of the
usefulness of ongoing discussion.

If I have understood the tone of your post correctly it seems you don't
really wish to collaborate on the streaming driver work for either RME or
MOTU, nor engage in a constructive discussion about the finer details of
these interfaces which I have deduced, observed and worked around over the
past 8 years.  Instead your preference seems to be to work on this yourself
without external input.  If this is the case, then while it disappoints me
I'm fine with that; life is too short to get upset about things like this.

As I have stated publicly on various occasions, it has been my intent to
start porting the RME and MOTU streaming drivers to the kernel for the last
12-18 months.  Unfortunately, while I have developed some ideas about how
this might be done, real life and family responsibilities have prevented me
from doing the coding.  Clearly you have far more time than I and can make a
start earlier than me so it makes sense for you to move on this - that's how
it works in the FOSS world.  However, I am sadened that you don't wish to
discuss the development with people who have been working with these
interfaces for many years.

When writing these drivers, please include acknowledgements to the people
who are responsible for the community's knowledge about these interfaces, as
currently embodied in the FFADO source and documentation.  This knowledge is
the result of many hundreds of hours work over eight years, and without the
FFADO source and documentation it would be impossible or very difficult to
write these remaining kernel streaming drivers.  The MOTU protocol discovery
was done entirely by myself on the Traveler, with adjustments for the other
devices being subsequently deduced between myself and owners of the
respective interfaces.  Determination of the RME programming details was
done by myself with some input from RME themselves.

I am pleased that there is ongoing work to move the FFADO audio streaming
functionality into the kernel by new developers who are able to spend
significant amounts of time on the effort over a relatively short period of
time.  It is just unfortunate that the knowledge, experience and views of
existing developers are being abruptly dismissed.

Regards
  jonathan
