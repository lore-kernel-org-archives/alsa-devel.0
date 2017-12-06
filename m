From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 12:13:22 -0600
Message-ID: <caea9bc4-94f3-41bc-5940-5769917962cf@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com> <20171206123908.GB1827@finisterre>
 <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
 <20171206172924.mrd233uipzorrymc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 8490B2679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 19:13:24 +0100 (CET)
In-Reply-To: <20171206172924.mrd233uipzorrymc@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/06/2017 11:29 AM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 10:06:34AM -0600, Andrew F. Davis wrote:
> 
>> Your wording seems a bit inconsistent to me, what do you mean by "IP
>> drivers", CODEC or SoC internal IP? For clarity I'll try to use only the
>> three driver type labels: codec, platform, and machine. This is all in
>> Documentation/sound/soc/overview.rst which I'm sure you are familiar
>> with as you seem to have had a hand in writing it.
> 
> IPs in SoCs.
> 
>> Anyway, I'm working under the assumption that we should try to enforce a
>> logical separation between component drivers: codec drivers should be
>> agnostic to what machine they are placed, platform drivers should do the
>> same and not make special arrangements to work with one machine in
>> particular. Machine drivers on the other hand will need to dig into
>> specifics of the codec and platform drivers that they use and connect.
> 
> Machine and drivers for SoC internal stuff tend to be bound fairly
> closely together, simiarly the various drivers for an IP on a SoC often
> know things about each other for various reasons.
> 

This is the problem, we don't want them to be so tightly bound, and
luckily, for the most part they are not. Even a complex and history rich
platform like OMAP was rather trivial to split from its various machine
drivers.

>> With this in mind I do not see any reason not to have platform drivers
>> in a platforms/ directory just like we do with codecs/. In case there
>> was any confusion, I still want to keep the platform drivers' files all
>> grouped in directories by IP holder, just moved under this platforms/.
> 
> Moving everything around is at the very least going to be a pain for
> anyone doing backports and anyone actively working on patches, splitting
> the machine drivers from the rest of the drivers for systems based on
> that SoC means it's going to be a little harder for people to find
> relevant system specific machine drivers.  Generic machine drivers are
> already split out.
> 
> Any benefits seem very weak here and it's an awfully disruptive change.
> 

While it may still be a small pain for people currently building patches
against the old structure, for back-ports, git seems to handle these
renames well and follows the file patches back to the old location.

>> This has the benefit of reducing exactly what you are talking about,
>> platform drivers working in concert with machine drivers, instead of the
>> other way around.
> 
> What I am saying is that they go together very closely.  Moving the code
> around isn't going to change that.
> 

Not at first, but this partition will discourage future machine-platform
mash-ups (like omap-hdmi-audio.c, yuck).

My end-goal here is to start trimming the needed machine drivers and
replacing them with generics, a couple OMAP machine drivers do nothing
that couldn't be done with the "asoc-simple-card" driver. With the
machine drivers split out form the platform drivers it becomes easier to
target them.

>> This isn't only confusing to me, but other first time ASoC devs:
>> https://stackoverflow.com/questions/20110801/asoc-drivers-which-files-are-platform-machine-and-codec-drivers
> 
> I rather suspect the confusion they're having is more to do with the
> fact that the documentation isn't very good than it is to do with where
> the files are.
> 

The documentation wont have to explain why platform and machine drivers
are mashed together in top-level directories if we fix this here :)

>> even the answerer seems to assume there is a
>> sound/soc/platforms/, for the same reason we have sound/soc/codecs/.
> 
> Or possibly just because they're not very familiar with what they're
> talking about here.
> 

That does seems to be the case, but the assumption was still that a
partitioning should exist.

>>> If you want to make a common directory for TI stuff do that, there's no
>>> need to mess up all the other platforms to do that though.
> 
>> Do you mean sounds/soc/ti/{platforms,machines}/ ? I could do this, but I
>> don't see how what I've done in my example patches has any effect on
>> other IP holders, they are free to migrate as the please.
> 
> Oh, right.  Your commit message sounded like you wanted to dump
> everything into a single directory for all SoC side drivers which
> doesn't seem like an obviously useful thing, my best guess had been that
> you were trying to get all the TI drivers into one directory.  I don't
> see a pressing need to do that, but I can see it might potentially be
> causing issues for people.
> 

I don't have any need to group the TI platforms (Davinci / OMAP) right
now, but I *have* been thinking about grouping the TI CODECs, they share
a lot of code that could be factored out if they were stored in their
own space sound/soc/codecs/ti/. Plus it would make it easy to add myself
as a reviewer for them (I seem to be getting a lot of internal support
requests for these drivers these days). That can be a re-org for another
day, unless you would like me to post an RFC with what I had in mind?

> If we were going to do this reshuffling then we *really* shouldn't be
> doing it randomly for only a few vendors.  Doing it inconsistently is
> not going to make anything clearer.
> 

I can send patches for rest of the vendors if you would like to see that
and what the end result would look like.
