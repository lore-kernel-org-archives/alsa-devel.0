From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb: "delay: estimated 0, actual 352"
Date: Thu, 06 Sep 2012 16:40:18 +0200
Message-ID: <5048B5D2.5030105@gmail.com>
References: <20120906060220.GA252@x4> <504843BA.2040808@gmail.com>
 <s5hehmfir46.wl%tiwai@suse.de> <20120906065340.GA257@x4>
 <50484BEB.4020103@gmail.com> <20120906071757.GB257@x4>
 <s5h627rioxt.wl%tiwai@suse.de> <s5hsjavh88c.wl%tiwai@suse.de>
 <20120906094348.GA257@x4> <s5hvcfrxpsc.wl%tiwai@suse.de>
 <20120906131758.GA256@x4> <s5hharbxlxf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 23E19260306
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 16:40:25 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so718410bku.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2012 07:40:24 -0700 (PDT)
In-Reply-To: <s5hharbxlxf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Markus Trippelsdorf <markus@trippelsdorf.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 06.09.2012 16:31, Takashi Iwai wrote:
> At Thu, 6 Sep 2012 15:17:58 +0200,
> Markus Trippelsdorf wrote:
>>
>> On 2012.09.06 at 15:08 +0200, Takashi Iwai wrote:
>>> At Thu, 6 Sep 2012 11:43:48 +0200,
>>> Markus Trippelsdorf wrote:
>>>>
>>>> On 2012.09.06 at 10:21 +0200, Takashi Iwai wrote:
>>>>> At Thu, 06 Sep 2012 09:35:26 +0200,
>>>>> Takashi Iwai wrote:
>>>>>
>>>>> In short, a patch like below may fix the issue (note: completely
>>>>> untested!)
>>>>
>>>> No it doesn't, unfortunately...
>>>
>>> OK, I start tracking down the problem a bit more deeply now.
>>>
>>> The issue happens when the first two URBs are passed to
>>> retire_playback_urb().  These are URBs filled before start_endpoints()
>>> are set, so they contain actually zero size.  Even though these are
>>> a sort of dummy packets, the driver still tries to check with the
>>> queued delay account, and gives bogus errors.
>>>
>>> So, essentially the messages are harmless and nothing to worry too
>>> much, but surely it doesn't look sexy.
>>>
>>> The patch below should fix the problem.  Please give it a try.
>>
>> Yes, your patch finally fixes the problem. 
>> Thank you Takashi-san.
> 
> Thanks for your quick test!
> 
> If Daniel has no objection with that patch, I'm going to merge it.

No objections from my side. I also gave it a quick test, and even though
I never saw the problem Markus was seeing, I agree to your findings.

Many thanks, everyone :)


Daniel
