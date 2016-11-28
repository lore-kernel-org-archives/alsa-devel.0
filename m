From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 0/2] alsa-lib: dynamically adapt the
 avail_min on the slave
Date: Mon, 28 Nov 2016 17:31:07 +0900
Message-ID: <533868aa-2182-d712-11ae-d236243d1eb7@mentor.com>
References: <20161110073443.1192-1-jiada_wang@mentor.com>
 <s5h7f8a6zn9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 886AE266A39
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 09:31:09 +0100 (CET)
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

Hello Takashi-san

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
Sorry, I missed your comment
Following is the error scenario
use plugin which uses the generic plugin implementation from pcm_plugin.c
(e.g linear plugin or the easiest one: 'copy' plugin)
-use MMAP capture access on that plugin
-configure slave hardware to 4ms period
-configure avail_min to 8ms
-enter snd_pcm_wait after 4ms are already available.
-->user may unexpectedly wait for 4ms too long

> In general, I prefer having this only in the rate plugin, as the rate
> plugin is the only one that suffers from the problem for now.
> If the issue is really reproduced on other plugins, make it generic in
> the plugin code later.
>
> About your fix: the dynamic changing sw_params is hackish, so I wonder
> whether it's the best solution.  Let's see.
>
> Last but not least, please try to fit within 80 chars like kernel
> patches.  It's not strictly required for alsa-lib codes, but still the
> too long lines like in your patches are difficult to read.
>
Sure, I will update commit message in next update

Thanks,
Jiada

>
> thanks,
>
> Takashi
>
