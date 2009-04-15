From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] add missing definitions(letters) to
	HD-Audio.txt
Date: Wed, 15 Apr 2009 08:56:25 -0700
Message-ID: <49E603A9.2010004@oracle.com>
References: <dd18b0c30904141431x231a3251v438e365d512f9f95@mail.gmail.com>	
	<s5hiql618mt.wl%tiwai@suse.de>
	<dd18b0c30904150835l6d246bbes648ad50e20690e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rgminet12.oracle.com (rcsinet12.oracle.com [148.87.113.124])
	by alsa0.perex.cz (Postfix) with ESMTP id 3011424499
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:55:54 +0200 (CEST)
In-Reply-To: <dd18b0c30904150835l6d246bbes648ad50e20690e7e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Justin Mattock wrote:
> On Wed, Apr 15, 2009 at 4:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Tue, 14 Apr 2009 14:31:21 -0700,
>> Justin Mattock wrote:
>>> impact: Add missing definitions(letters).
>>>
>>> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
>> Thanks, applied now.
>>
>> (BTW, your patch couldn't be applied cleanly, partly because of
>>  a wrong format and partly because of your MUA breaking the lines...)
>>
>>
>> Takashi
>>
>>> ---
>>>  Documentation/sound/alsa/HD-Audio.txt | 3 +++
>>>  1 files changed,3 insertions(+),0 deletions(-)
>>>
>>> ===========================================================================================
>>> ---- Documentation/sound/alsa/HD-Audio.txt        2009-04-14
>>> 17:03:14.000000000 -0700
>>> ++++ Documentation/sound/alsa/HD-Audio.txt        2009-04-14
>>> 21:15:22.000000000 -0700
>>> @@ -162,7 +162,7 @@
>>>  What `model` option values are available depends on the codec chip.
>>>  Check your codec chip from the codec proc file (see "Codec Proc-File"
>>>  section below).  It will show the vendor/product name of your codec
>>> -chip.  Then, see Documentation/sound/alsa/HD-Audio-Modelstxt file,
>>> +chip.  Then, see Documentation/sound/alsa/HD-Audio-Models.txt file,
>>>  the section of HD-audio driver.  You can find a list of codecs
>>>  and `model` options belonging to each codec.  For example, for Realtek
>>>  ALC262 codec chip, pass `model=ultra` for devices that are compatible
>>> @@ -170,7 +170,7 @@
>>>
>>>  Thus, the first thing you can do for any brand-new, unsupported and
>>>  non-working HD-audio hardware is to check HD-audio codec and several
>>> -different `model` option values.  If you have a luck, some of them
>>> +different `model` option values.  If you have any luck, some of them
>>>  might suit with your device well.
>>>
>>>  Some codecs such as ALC880 have a special model option `model=test`.
>>>
>>> --
> 
> I went diff -u file.old file.new
> (I'm not sure how to generate the
> 1 files changed,2 etc... stuff)

It's listed in Documentation/SubmittingPatches:  /diffstat/
along with the expected patch format etc.
Please read/use it.

> And yes I will be honest I didn't test the patch.
> (figured it wasn't that complicated, and I was tired).
> 
> If I find more I'll let you know.
> (back to trying to get sound working on my imac).


-- 
~Randy
