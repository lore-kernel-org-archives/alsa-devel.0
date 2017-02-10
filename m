From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH 0/6] Yet another experiments with LPE audio
Date: Fri, 10 Feb 2017 03:01:21 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552CD6FAC@BGSMSX104.gar.corp.intel.com>
References: <20170207131122.6345-1-tiwai@suse.de>
 <s5hlgtiatv7.wl-tiwai@suse.de> <s5hzihvb1t9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3AB26680F
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 04:01:27 +0100 (CET)
In-Reply-To: <s5hzihvb1t9.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Anand,
 Jerome" <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
>project.org] On Behalf Of Takashi Iwai
>Sent: Friday, February 10, 2017 12:59 AM
>To: alsa-devel@alsa-project.org
>Cc: Ian W MORRISON <ianwmorrison@gmail.com>; Pierre-Louis Bossart
><pierre-louis.bossart@linux.intel.com>; Anand, Jerome
><jerome.anand@intel.com>
>Subject: Re: [alsa-devel] [PATCH 0/6] Yet another experiments with LPE audio
>
>On Tue, 07 Feb 2017 16:44:12 +0100,
>Takashi Iwai wrote:
>>
>> On Tue, 07 Feb 2017 14:11:16 +0100,
>> Takashi Iwai wrote:
>> >
>> > Another day, another patchset.  Here I put a largish cleanup patch to
>> > just shuffle the code, in addition to the new S16 and S32 formats
>> > support and the support for a single period with no period wakeup as
>> > we've discussed in the previous thread.  One patch to remove BATCH
>> > flag is same and kept in the middle of this series.
>> >
>> > I guess I can merge the first three patches now.
>>
>> It turned out that S16 and S32 causes xrun with dmix by some reason.
>> Still investigating, but we can postpone these, too.
>
>And this gave some interesting result.  At first I thought this being
>a bug in the kernel driver.  Then I found out that this is no kernel
>driver bug but some performance problem of dmix code, appearing only
>when accessing uncached pages on Cherrytrail.  (The same issue may
>happen likely on other Atom platforms, but need to check.)
>
>By using a generic dmix code with semaphore, this performance problem
>is resolved.  So, S16/S32 supports are OK in the end.
>
>But this leads to another question wrt the kernel driver code:
>why the driver allocates / maps with uncached page, not with write-
>combined?  Pierre, Jerome, any clue?
>

In CHT and BYT the organization of the hardware fabric is such that
the HDMI DMA transactions are not snooped and so it will fetch
data only from DDR. In most non-atom platforms it is snooped, and so
fabric will return data from cache if it is updated.

In the past we faced problem where the DMA was fetching some
old data because cache was not flushed into DDR. That's where
we marked the pages as uncached.
