From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/2] Two fixes for ca0132
Date: Mon, 20 Aug 2012 11:27:08 +0200
Message-ID: <503202EC.5060700@canonical.com>
References: <1345454220-4233-1-git-send-email-david.henningsson@canonical.com>
 <s5hharxrk7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 607D6265D9F
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 10:57:22 +0200 (CEST)
In-Reply-To: <s5hharxrk7u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

On 08/20/2012 11:22 AM, Takashi Iwai wrote:
> At Mon, 20 Aug 2012 11:16:58 +0200,
> David Henningsson wrote:
>>
>> I came across the following codec:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1038651/+attachment/3267820/+files/Card0.Codecs.codec.0.txt
>>
>> ...and the codec wouldn't load due to mixer errors. I don't know more about the codec than the codec proc shows,
>> and looking at that file it seems a bit broken, but maybe Ian would be able to make it work, with the help of
>> some secret verbs? At least now the codec would load correctly, so that the output side could be used.
>
> Both fixes already have existed in my local queue for weeks and
> provided to some people who reported CA0132 problems (including Ian).
> Basically they are for fixing the missing SPDIF controls.

In my case, it was about input (mic and mic boost).

> But they
> were pending because of the upcoming DSP loading stuff, which seem to
> be pretty delayed.
>
> So I'm going to apply the fixes for 3.6 kernel.

At least the latter one (don't create dysfunctional...) should go to 
stable, too.

>
>
> thanks,
>
> Takashi
>
>>
>> David Henningsson (2):
>>    ALSA: hda - Fix "Line" and "Mic" names for CA0132
>>    ALSA: hda - don't create dysfunctional mixer controls for ca0132
>>
>>   sound/pci/hda/patch_ca0132.c |   12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
