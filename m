From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 8 Apr 2016 08:00:14 +0900
Message-ID: <5706E67E.5060908@sakamocchi.jp>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause> <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
 <20160407201041.GB26683@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C67E260824
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 01:00:17 +0200 (CEST)
In-Reply-To: <20160407201041.GB26683@mail.zuhause>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Koegler <martin.koegler@chello.at>, Adam Goode <agoode@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 8 2016 05:10, Martin Koegler wrote:
> On Thu, Apr 07, 2016 at 03:23:01PM -0400, Adam Goode wrote:
>> Have you heard any objections?
>>
>> Also, would you plan to do a 1.1.2 release soon after accepting this, to
>> get this functionality out quickly?
> 
> Distributions already start to pick 1.1.1 up:
> https://build.opensuse.org/request/show/382608
> https://build.opensuse.org/request/show/382611
> 
> I would object merging that patch, if there is no immediate patched 1.1.2 release available, 
> as otherwise 1.1.1 with a different API will get used by the mass. 

Let's be careful. I also consider about this issue for this week, but
still have no good idea. Band-aid sometimes fixes issues, but in this
case, it's not better.


The design of alsa-lib is based on backend modules splitted from
frontend API to applications. When a new feature is introduced, we tend
to change the frontend API directly, ignoring the series of backends.
This is not good in a view of the design. When adding new features to
frontend API and the feature is just handled to one backend module, how
do we implement it to the others.


Well, I think this issue of sequencer APIs includes below issues lying
on the whole alsa-lib:
- How to pass information of unsupported feature to frontend APIs from
backend of the backend modules (i.e. kernel/userspace interface or
perhaps IPC peer such as PulseAudio).
- Some frontend APIs are designed as an accessor to structure members of
opaque pointer. How to notify the information of unsupported feature to
applications via the APIs.
- How to prevent applications from confusion comes from implementation
difference between the backend modules.


I think alsa-lib still has no good framework to solve these, against its
long history of 15 years... Or long history might bring this issue.

Of cource, if few persons have interests in these issues to keep a good
shape or quick fixes are more important than API consistency, it's
better to apply your band-aid.


Regards

Takashi Sakamoto
