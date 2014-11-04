From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [RFC] AXD Audio Processing IP ALSA support -
	Questions
Date: Tue, 4 Nov 2014 12:04:26 +0000
Message-ID: <5458C0CA.9080903@imgtec.com>
References: <20141104104002.GH1870@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 51C842605EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:04:36 +0100 (CET)
In-Reply-To: <20141104104002.GH1870@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Neil Jones <neil.jones@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/04/2014 10:40 AM, Vinod Koul wrote:
> On Tue, Nov 04, 2014 at 09:48:18AM +0000, Qais Yousef wrote:
>> Hi,
>>
>> I have several questions on the best way to add AXD support in ALSA.
> 1st rule pls CC maintainers, so that it gets rights attention.
>

OK sorry about that.

>> The discussion of the previous patch can be found here:
>>
>> https://lkml.org/lkml/2014/10/28/465
>>
>> Questions:
>>
>> 1- What is the best example to follow to add a simple mp3 support
>> for AXD? The only one I find is in sst-mfld-platform-compress.c in
>> sound/soc/intel directory but it's a bit confusing. I think because
>> it's sharing code with several other sst drivers/platforms.
> There are two ways
> 1. If you are a ASoC driver which is most likely the case, then add a
> compress dai and then a compress dai-link. The device with compress device
> will be created.
> 2. Directly call compress_register the way asoc does
>
> For both you need to implement the compressed ops

Thanks for the pointers :)

>> I find the documentation for compress_offload generally lacking. Is
>> there a plan to improve on that? Being a new comer to ALSA framework
>> api, I'm confused what is the correct way to do things :-/
> Are you talking about kernel API or driver API? Can you please elaborate

Driver API. A new section in 'Writing an ALSA Driver' for compress 
offload would be helpful for example.

snd_compress_register() for example is not clear in what context it 
needs to be called. I failed to find any reference to a user. In your 
pointers above I was trying to do 1 and 2 simultaneously - I didn't 
realise that 1 makes 2 unnecessary.

It might be that I just need to spend more time on it to get it.

>> So far I know I need to call snd_soc_register_card(). I thought
>> snd_compress_register() (from compress_driver.h) is how you add
>> compressed nodes to the card but apparently not. It looks like I
>> need to define a compress_dai? Hmmm.
> You need to define a compress_dai if you are a asoc device just like the pcm
> dai's, it is similar to what you would need to do for PCM
>
>> 2- Is tinycompress the only userland support for compress_offload?
>> Is there anyone working on gstreamer and omx plugins to support
>> that?
> Yes, I don't know of anyone working on omx support.
>> Would tinycompress be part of alsa-utils and alsa-libs in the
>> future? I know it needs more work at the moment but it'd be nice if
>> compress_offload support is part of the standard alsa-utils and
>> alsa-libs.
> It is alsa-lib, for packaging we can make it part of alsa packages. Most
> users are right now in Android so no one asked yet

I'm using buildroot for my testing. So if it's included part of alsa 
packages that would be helpful.
Also it'll help with getting gstreamer support.

>> 3- Can we get an example of how transcoding (back to disk) is
>> supposed to be working?
> As I have replied to you last week, it would be done using two FEs and these
> FEs should be "routed"

OK. I need to read more to completely understand this to be honest. I 
don't know what's an FE and I don't know how they can be 'routed'. 
That's why I was hoping to get an example or a pointer to anything that 
does a similar thing.
Just to clarify, all the necessary bits are there and I just need to use 
them?

>> 4- How can we reconfigure complex audio effect components (like
>> shelving filters) which need filter co-effecient changes to be
>> applied all at once atomically to avoid instability?
> Add an ALSA control which models sync, then in driver apply once you
> get sync control
>

OK. It's good to know the support for this type of operations is already 
available.

Thanks,
Qais
