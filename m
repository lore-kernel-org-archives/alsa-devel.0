From: Chris Winter <elwintro@gmail.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 21 Sep 2010 12:13:33 -0500
Message-ID: <AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DB95243DE
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 19:14:04 +0200 (CEST)
Received: by iwn4 with SMTP id 4so2138180iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 10:14:04 -0700 (PDT)
In-Reply-To: <i781vn$nhb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 20, 2010 at 11:26 AM, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> Hi Jaroslav,
>
> 'Twas brillig, and Jaroslav Kysela at 07/09/10 15:42 did gyre and gimble:
>> On Tue, 7 Sep 2010, Liam Girdwood wrote:
>>
>>> Hi Jaroslav,
>>>
>>> Any update on this ? I have someone scheduled to write new use case
>>> files and someone else ready to add PA support.
>>
>> Hi,
>>
>> I'm working on this. Unfortunately, I have other things which interrupts
>> this work. The actual code is at:
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ucm
>
> Has there been any progress on the UCM stuff? I'm quite interested to
> see how this will develop from a PA perspective. It does have some
> impact on work that I've been wanting to do for a while in PA so the
> sooner this is available in ALSA the sooner I can start thinking about
> some of the knock on effects. I know Liam is intending to do some work
> on PA too to integrate UCM once the API has stabilised, so I'm obviously
> keen to encourage that too :D

Since progress on UCM seems to have stalled, I'd also like to chip in
and say that it would be great to see UCM pushed to mainline as soon
as possible. I'm a software engineer at Garmin, responsible for
system-level audio support on Linux-based personal navigation devices,
and UCM would *really* help to simplify the management of audio state
on those devices. In fact, I've been hurting for something like UCM
for so long that I'm already developing against the version that Liam
has posted to the list.

I not entirely convinced that Jaroslav's proposed changes to UCM will
add much value to overall functionality. The reworked API seems more
clumsy and confusing to me, and I think it's a bad idea to make UCM
responsible for coordinating audio state management throughout
userspace -- as Mark B. said, that responsibility would seem to be
better left to some other entity who would be the sole consumer of UCM
API in the system (e.g., pulseaudio), which is really no different
from the current situation for basic playback or capture through Alsa,
i.e., if multiple processes want to playback/capture PCM data at the
same time, then some other entity must coordinate access (e.g., dmix,
pulseaudio).

>From the PND perspective, there is often a complex intermix of
business logic and asynchronous system events (from both hardware and
software) driving the audio hardware state changes. I can tell you
from experience that it is a nightmare to have to pass such arbitrary
information between processes for the purposes of making even the
simplest of policy decisions for system-wide audio state. If it is
truly desired to turn UCM into userspace's central manager and
coordinator for audio state, then it absolutely must provide a clear
and flexible way to pass arbitrary state variables through the system,
and also a generic mechanism for specifying how the audio policy must
change based on those state variables. A superb and worthy ideal,
perhaps, but it's a tall order, and I don't see it becoming a viable
reality any time soon.

I think the proposed switch to using alsa-lib's present conf file
parser code may be worth doing (even though I find the syntax to be
uglier). Otherwise, the only thing I would really like to see added to
UCM (after it gets mainlined!) is a more generic mechanism for
aliasing mixer control names, instead of how it is currently limited
to aliasing master playback/capture volumes and master
playback/capture switches. On PNDs at least, it is often necessary to
read/write some mixer controls directly, e.g., for mic gain, and so
it's a pain when mixer control names differ across codecs. It would be
great if Alsa provided for such aliasing, instead of leaving
developers to rely on custom solutions.

Regards,

Chris Winter
