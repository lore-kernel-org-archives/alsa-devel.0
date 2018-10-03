From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: intel8x0: Fix fall-through
	annotations
Date: Wed, 3 Oct 2018 20:08:31 +0200
Message-ID: <787e9aeb-34e0-3075-d816-7963cca61020@embeddedor.com>
References: <20181003103836.GA21649@embeddedor.com>
 <s5hftxnovx4.wl-tiwai@suse.de> <s5hbm8boven.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 356B82677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 20:08:43 +0200 (CEST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id E283B1420BBB
 for <alsa-devel@alsa-project.org>;
 Wed,  3 Oct 2018 13:08:42 -0500 (CDT)
In-Reply-To: <s5hbm8boven.wl-tiwai@suse.de>
Content-Language: en-GB
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/3/18 6:19 PM, Takashi Iwai wrote:
> On Wed, 03 Oct 2018 18:08:07 +0200,
> Takashi Iwai wrote:
>>
>> On Wed, 03 Oct 2018 12:38:36 +0200,
>>  Gustavo A. R. Silva  wrote:
>>>
>>> Replace "fallthru" with a proper "fall through" annotation.
>>>
>>> This fix is part of the ongoing efforts to enabling
>>> -Wimplicit-fallthrough
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> Thanks, applied.
> 
> BTW, does "fallthru" really cause a warning?  I thought it's also
> accepted as well as "fall-through".  At least, my gcc-8 doesn't give a
> warning with "fallthru".
> 

You are correct. It does not trigger a warning.

There are about 50 similar instances in the whole codebase. And, as they
are just a few, what I'm trying to do is to replace them with the most
commonly used form: "fall through"

Thanks
--
Gustavo
