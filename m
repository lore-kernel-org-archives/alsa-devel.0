From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Scheduled alsa-lib release?
Date: Wed, 9 Mar 2016 14:39:30 +0100
Message-ID: <56E02792.6080207@perex.cz>
References: <s5hr3fk9apc.wl-tiwai@suse.de> <20160309061624.GU11154@localhost>
 <s5hbn6ob2fc.wl-tiwai@suse.de> <56DFD4FD.8090701@sakamocchi.jp>
 <s5h1t7kay1k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C1F2726071E
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 14:39:31 +0100 (CET)
In-Reply-To: <s5h1t7kay1k.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 9.3.2016 v 08:52 Takashi Iwai napsal(a):
> On Wed, 09 Mar 2016 08:47:09 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Mar 9 2016 15:17, Takashi Iwai wrote:
>>> On Wed, 09 Mar 2016 07:16:24 +0100,
>>> Vinod Koul wrote:
>>>>
>>>> On Tue, Mar 08, 2016 at 05:49:19PM +0100, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> in the previous meeting, there have been requests about the regular
>>>>> "predictable" release of alsa-lib.  We thought of aligning with kernel
>>>>> release cycle, judging from the nature of alsa-lib.
>>
>> As a quick glance of the number of commits per month (see in the end of 
>> this message), alsa-lib is not so actively developed recently. (except 
>> for topology APIs)
>>
>> I think releasing every 2 months makes the release maintenance effort 
>> more hard than its actual advantage. It better to release alsa-lib for 2 
>> or more kernel release cycles.
> 
> Yes, that was the proposal in the meeting.  It wasn't meant to release
> every cycle.
> 
> The point is to align with the kernel release cycle so that people can
> know the possible release point beforehand.  The actual release can be
> skipped easily if nothing happens, of course.

I agree. I'll release ALSA packages in the week after 4.5 kernel release
(next week?). And I (we) can do a decision after every kernel release,
if we have enough changes (or there are any required changes to support
new kernels).

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
