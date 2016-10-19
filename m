From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [SAMPLE-PATCH 0/x] ASoC: replace snd_soc_read/write
Date: Wed, 19 Oct 2016 09:57:20 +0200
Message-ID: <2e008145-062d-948e-0839-0aef9acf11db@metafoo.de>
References: <87oa2g3nhl.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh988g5ie.wl-tiwai@suse.de>
 <87d1iw3i9d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 42C60266DC0
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 09:57:27 +0200 (CEST)
In-Reply-To: <87d1iw3i9d.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/19/2016 09:43 AM, Kuninori Morimoto wrote:
> 
> Hi Takashi-san
> 
> Thank you for your feedback
> 
>>> These are part of "replace snd_soc_read/write to snd_soc_component_read/write"
>>> patch-set. Full-patch-set will be over 100 patches.
>>>
>>> 	[0/x] - [x-1/x] : ASoC: use snd_soc_component_read/write on xxxx
>>> 	[x/x]           : ASoC: remove snd_soc_component_read/write
>>>
>>> [0/x] - [x-1/x] are almost same patches.
>>> so, I pickuped few of them for reviewing to avoid patch flood on ML.
>>>
>>> If these review were OK, I will post full-patch-set,
>>> or send git-pull-request.
>>>
>>> Main purpose of these patches are replace current snd_soc_read/write
>>> to snd_soc_component_read/write to remove codec related function.
>>
>> I really don't see any big merits by these changes.
>> What's wrong with keeping as is?  The driver is accessing the codec
>> register, after all.
>>
>> For keeping consistency, replacing a few exceptions would be OK.  But
>> replacing hundreds of callers needs a proper justification to do it
>> so.
> 
> Now, ALSA SoC is planning to remove "struct snd_soc_codec" and
> "struct snd_soc_platform", and merge these into "struct snd_soc_component".
> New ALSA SoC will be based on "component", and additional new feature (= bridge ?).
> 
> As 1st phase, I would like to cleanup these.
> my 1st step is removing codec related read/write (= use component read/write),
> and 2nd step is remove codec probe/remove (= use component probe/remove).
> and 3rd, 4th... I don't know how many steps are exist.

I agree with Takashi, in my opinion this is not the right change at this
point in time. snd_soc_{write,read}() are not problematic they are simple
wrapper functions around snd_soc_component_{write,read}() that make it more
convenient to use them in a CODEC driver. Same for the CODEC specific
probe()/remove() callbacks.

And while we are phasing out the concept of differentiating between
different types of components, since the hardware landscape has changed so
that there is no longer a really meaningful differentiating factor,
snd_soc_codec and snd_soc_codec drivers will still be around for a while.


The problematic bits are in the ASoC core where we have code that needs to
know whether a component is a CODEC or not. These are the issue we need to
resolve before we can think about converting more driver snd_soc_codec to
snd_soc_component.

Doing these partial conversions only leaves us with a lot of drivers that
are more convoluted than they need to be. In my opinion a driver should be
converted in one go, making it a complete component driver. But not leave it
partially component and partially CODEC. We've done this for the drivers
where it is possible, e.g. see [1].

But now it is time to fix the hard problems in the core first before we
start converting other drivers.

- Lars


[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs/max9768.c?id=04b5cbd80af899c6a4d51835b069b96ae8864e5a
