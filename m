From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Packages 1.0.30 - release pending
Date: Thu, 5 Nov 2015 14:12:45 +0100
Message-ID: <563B55CD.5070207@perex.cz>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <s5hlhaomjem.wl-tiwai@suse.de> <1445959655.7199.12.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B866C43@shsmsx102.ccr.corp.intel.com>
 <563A1641.1070503@perex.cz> <1446653827.2801.19.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B879250@shsmsx102.ccr.corp.intel.com>
 <563B53C6.7000503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 86AF1265AB2
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 14:12:46 +0100 (CET)
In-Reply-To: <563B53C6.7000503@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 5.11.2015 v 14:04 Mengdong Lin napsal(a):
> On 11/05/2015 11:08 AM, Lin, Mengdong wrote:
>>> -----Original Message-----
>>> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
>>> Sent: Thursday, November 05, 2015 12:17 AM
>>> To: Jaroslav Kysela
>>> Cc: Lin, Mengdong; Takashi Iwai; Koul, Vinod; ALSA development
>>> Subject: Re: [alsa-devel] Packages 1.0.30 - release pending
>>>
>>> On Wed, 2015-11-04 at 15:29 +0100, Jaroslav Kysela wrote:
>>>> Dne 28.10.2015 v 16:06 Lin, Mengdong napsal(a):
>>>>
>>>>> I expect the other kernel and user space patches will be submitted next week
>>> after the internal review.
>>>>
>>>> Any progress for the user space? If I don't receive the updates for
>>>> the user space packages until Friday CEST morning, I'll release 1.1.0
>>>> without them. We can release 1.1.1 quickly when all things are
>>>> finished for the topology code. The distributions can adapt to new
>>>> tools (like
>>>> alsatplg) in 1.1.0 and then just receive the updated code (1.1.1).
>>>>
>>>
>>> It's all going through internal review and testing now. Mengdong can probably
>>> post to the list tomorrow if all is OK, otherwise we can go for 1.1.1.
> 
> I've sent out the alsa-lib patches for topology ABI update. Please 
> review.The thread name is "topology: Align ABI with kernel to version 4".
> 
> All ABI updates have been merged in sound kernel except this one: 
> topology: ABI - Rename dai_elems to pcm_elems in manifest
> This patch is still in ASoC kernel, topic/topology branch.

I did a quick review and I've no issue with it.

Takashi, any comments to include these patches ?

Lin, do we need a change to the topology utility in alsa-utils ?

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
