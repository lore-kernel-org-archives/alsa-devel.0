From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/14] conf/ucm: bytcr-rt5651: Various
 improvements + long-name profiles addition
Date: Mon, 6 Aug 2018 09:41:22 +0200
Message-ID: <5cbb6923-a042-ab55-cc83-cf863cd33126@redhat.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
 <38e43d0a-12e0-7594-d698-4dfb72672bcd@linux.intel.com>
 <s5hfu0b3b4y.wl-tiwai@suse.de> <s5hbmagu5fj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id CF733267692
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 09:41:24 +0200 (CEST)
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so4661978eds.1
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2018 00:41:24 -0700 (PDT)
In-Reply-To: <s5hbmagu5fj.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 05-08-18 18:46, Takashi Iwai wrote:
> On Sun, 22 Jul 2018 10:52:45 +0200,
> Takashi Iwai wrote:
>>
>> On Fri, 20 Jul 2018 15:51:55 +0200,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 7/20/18 2:27 AM, Hans de Goede wrote:
>>>> Hi All,
>>>>
>>>> Here is a set of patches to the bytcr-rt5651 UCM profiles. This series
>>>> also adds a bunch of long-name profiles so that users automatically
>>>> only see the inputs / outputs which their device actually has.
>>>>
>>>> The long-names are based on the long-names set by the kernel after
>>>> the rt5651 patch series which is currently queued in -next:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next
>>>>
>>>> With these UCM profile patches and the kernel changes in place all
>>>> inputs and outputs as well as jack-detect will work 100% OOTB on
>>>> supported bytcr-rt5651 devices, without the user needing to do any
>>>> manual config or mixer settings.
>>>
>>> Impressive work, thanks. I only had minor comments but it's already
>>> great, so here's my tag for the series
>>>
>>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> OK, Hans, care to resubmit v2?  Then I'll happily merge them.
> 
> This seems to be forgotten?

I was on vacation, I'm back now and I will create a v2 of the patch-set
soon.

Regards,

Hans
