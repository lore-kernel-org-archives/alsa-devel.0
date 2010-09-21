From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 21 Sep 2010 20:11:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
	<1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 201BE243FB
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 20:11:37 +0200 (CEST)
In-Reply-To: <AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Winter <elwintro@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Sep 2010, Chris Winter wrote:

> On Mon, Sep 20, 2010 at 11:26 AM, Colin Guthrie <gmane@colin.guthr.ie> wrote:
>> Hi Jaroslav,
>>
>> 'Twas brillig, and Jaroslav Kysela at 07/09/10 15:42 did gyre and gimble:
>>> On Tue, 7 Sep 2010, Liam Girdwood wrote:
>>>
>>>> Hi Jaroslav,
>>>>
>>>> Any update on this ? I have someone scheduled to write new use case
>>>> files and someone else ready to add PA support.
>>>
>>> Hi,
>>>
>>> I'm working on this. Unfortunately, I have other things which interrupts
>>> this work. The actual code is at:
>>>
>>> http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ucm
>>
>> Has there been any progress on the UCM stuff? I'm quite interested to
>> see how this will develop from a PA perspective. It does have some
>> impact on work that I've been wanting to do for a while in PA so the
>> sooner this is available in ALSA the sooner I can start thinking about
>> some of the knock on effects. I know Liam is intending to do some work
>> on PA too to integrate UCM once the API has stabilised, so I'm obviously
>> keen to encourage that too :D
>
> Since progress on UCM seems to have stalled, I'd also like to chip in
> and say that it would be great to see UCM pushed to mainline as soon
> as possible. I'm a software engineer at Garmin, responsible for
> system-level audio support on Linux-based personal navigation devices,
> and UCM would *really* help to simplify the management of audio state
> on those devices. In fact, I've been hurting for something like UCM
> for so long that I'm already developing against the version that Liam
> has posted to the list.

Hi all,

 	I'm sorry to be silent in the last week, but the reason was quite 
simple - vacation. As my life goes, my second son was born and I decided 
to be with my family, so I was able to handle only really urgent things.

> I not entirely convinced that Jaroslav's proposed changes to UCM will
> add much value to overall functionality. The reworked API seems more
> clumsy and confusing to me, and I think it's a bad idea to make UCM
> responsible for coordinating audio state management throughout
> userspace -- as Mark B. said, that responsibility would seem to be
> better left to some other entity who would be the sole consumer of UCM
> API in the system (e.g., pulseaudio), which is really no different
> from the current situation for basic playback or capture through Alsa,
> i.e., if multiple processes want to playback/capture PCM data at the
> same time, then some other entity must coordinate access (e.g., dmix,
> pulseaudio).

There are two things and I think that we both talking about different 
ones.

1) Which devices can be used simultaneously in the system
    (basically determining the number of handled streams).
2) Physical output (or input) switching (I mean physical jacks etc.).

I don't want to add any complex manager. I just think that the UCM layer 
should give the information to the application which PCM streams can be 
used concurrently for a named card. Something like stream grouping.

The problem is that you think in the "ASoC" way to handle just one 
input and output stream for phones etc. and I think in "multiple 
independant streams" per card way.

>> From the PND perspective, there is often a complex intermix of
> business logic and asynchronous system events (from both hardware and
> software) driving the audio hardware state changes. I can tell you
> from experience that it is a nightmare to have to pass such arbitrary
> information between processes for the purposes of making even the
> simplest of policy decisions for system-wide audio state. If it is
> truly desired to turn UCM into userspace's central manager and
> coordinator for audio state, then it absolutely must provide a clear
> and flexible way to pass arbitrary state variables through the system,
> and also a generic mechanism for specifying how the audio policy must
> change based on those state variables. A superb and worthy ideal,
> perhaps, but it's a tall order, and I don't see it becoming a viable
> reality any time soon.

I agree.

> I think the proposed switch to using alsa-lib's present conf file
> parser code may be worth doing (even though I find the syntax to be
> uglier). Otherwise, the only thing I would really like to see added to
> UCM (after it gets mainlined!) is a more generic mechanism for
> aliasing mixer control names, instead of how it is currently limited
> to aliasing master playback/capture volumes and master
> playback/capture switches. On PNDs at least, it is often necessary to
> read/write some mixer controls directly, e.g., for mic gain, and so
> it's a pain when mixer control names differ across codecs. It would be
> great if Alsa provided for such aliasing, instead of leaving
> developers to rely on custom solutions.

This is really point why I switched from "many functions returning 
just values" to "one function with a universal string identifier 
returning requested value". It makes API much flexible for future 
extensions and the library will not export a next bunch of similar 
functions.

The question is how we can make much flexible the passing of these values 
from the configuration files. I think that we may use just a direct way 
between the "identifier" from the snd_use_case_get/set function and the 
configuration files, having syntax something like:

SectionDevice."Headphones".0 {
 	...
 	Value."_ctl_/_pctlsw" "name='Master Playback Switch'"
 	...
}

Note that we may talk about the API, identifier names etc.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
