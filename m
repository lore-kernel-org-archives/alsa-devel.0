From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] topology: Include <linux/types.h> in API
 header file
Date: Tue, 10 Nov 2015 13:29:23 +0100
Message-ID: <5641E323.5070203@perex.cz>
References: <1446813576-29295-1-git-send-email-mengdong.lin@linux.intel.com>
 <s5hoaf7z3k2.wl-tiwai@suse.de> <20151106133118.GA18120@localhost>
 <s5hfv0jz200.wl-tiwai@suse.de> <1446820647.2776.19.camel@loki>
 <s5h4mgzyyve.wl-tiwai@suse.de> <1446821837.2776.27.camel@loki>
 <20151109140425.GA5572@subhransu-desktop> <20151110122939.GE25173@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 795C8261299
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 13:29:24 +0100 (CET)
In-Reply-To: <20151110122939.GE25173@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Dne 10.11.2015 v 13:29 Vinod Koul napsal(a):
> On Mon, Nov 09, 2015 at 07:34:29PM +0530, Subhransu S. Prusty wrote:
>> On Fri, Nov 06, 2015 at 02:57:17PM +0000, Liam Girdwood wrote:
>>> On Fri, 2015-11-06 at 15:40 +0100, Takashi Iwai wrote:
>>>> On Fri, 06 Nov 2015 15:37:27 +0100,
>>>> Liam Girdwood wrote:
>>>>>
>>>>>
>>>>> >From 568f769269122e90fceee605a98a1a526db2b3d4 Mon Sep 17 00:00:00 2001
>>>>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>>>> Date: Fri, 6 Nov 2015 14:30:36 +0000
>>>>> Subject: [PATCH] topology: remove little endian type from userspace header.
>>>>>
>>>>> Use a generic unsigned long long for formats instead of an ABI endian
>>>>> specific __le64 type.
>>>>
>>>> Or use uint64_t instead.  This is the standard definition of 64bit
>>>> integer.  I thought we already include stdint.h somewhere, but you can
>>>> included it there again to be sure, too.
>>>>
>>>
>>> I didn't see stdint.h so used unsigned long long on the first patch. The
>>> patch below fixes this though :-
>>>
>>> From 52d3023e482ac856692bf27819d97d9a037a055b Mon Sep 17 00:00:00 2001
>>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>> Date: Fri, 6 Nov 2015 14:30:36 +0000
>>> Subject: [PATCH] topology: remove little endian type from userspace header.
>>>
>>> Use a generic uint64_t for formats instead of an ABI endian specific
>>> __le64 type.
>>
>> Tested and it works fine.
> 
> Hi Takashi,
> 
> Is this fix okay, was this applied ?
> 

Yes, it's in alsa-lib-1.1.0, too:

http://git.alsa-project.org/?p=alsa-lib.git;a=summary

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
