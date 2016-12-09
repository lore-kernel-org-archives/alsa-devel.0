From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 0/2] alsa-lib: dynamically adapt the
 avail_min on the slave
Date: Fri, 9 Dec 2016 14:41:05 +0900
Message-ID: <3b1d22c0-6ed6-16a1-31a7-62bc9c5b7d94@mentor.com>
References: <20161110073443.1192-1-jiada_wang@mentor.com>
 <s5h7f8a6zn9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ACC3266A33
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 06:41:00 +0100 (CET)
In-Reply-To: <s5h7f8a6zn9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: wens@csie.org, broonie@kernel.org, apape@de.adit-jv.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi

On 11/11/2016 08:10 PM, Takashi Iwai wrote:
> On Thu, 10 Nov 2016 08:34:41 +0100,
> Jiada Wang wrote:
>>
>> When configuring avail_min to multiple of slave period size it can happen
>> that user waits one slave period longer than needed for available data.
>> Root cause is implicit grabbing of slave samples in avail_update operation.
>> On next entering poll, the slave will wait for the avail_min threshold
>> reached again, as he is not aware that there are already pending samples
>> in the above layer which are not yet provided to user.
>> Solution is to dynamically adapt the avail_min on the slave.
>
> Can you give a test case?  Then it's easier to check what's going on.
>
> In general, I prefer having this only in the rate plugin, as the rate
> plugin is the only one that suffers from the problem for now.
> If the issue is really reproduced on other plugins, make it generic in
> the plugin code later.
>
not only the rate plugin is suffering from this issue,
but also other plugins which use the generic plugin implementation
(for example linear and copy plugin), so only have the fix in rate 
plugin, won't prevent the issue we are seeing.

> About your fix: the dynamic changing sw_params is hackish, so I wonder
> whether it's the best solution.  Let's see.
>
Yes, we also think this change is risky, and would like to have it be 
reviewed by community, so that we can have a more robust solution

> Last but not least, please try to fit within 80 chars like kernel
> patches.  It's not strictly required for alsa-lib codes, but still the
> too long lines like in your patches are difficult to read.
>
I will update ChangeLog in next update

Thanks,
Jiada
>
> thanks,
>
> Takashi
>
