From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: add Icelake support
Date: Fri, 16 Nov 2018 08:11:27 -0600
Message-ID: <7f7c8349-c329-9789-ddb6-4779c56668fb@linux.intel.com>
References: <20181110211846.23667-1-yung-chuan.liao@linux.intel.com>
 <s5hftw8ngd4.wl-tiwai@suse.de>
 <ac9cecd2-7321-34dd-a317-4d6d3c21635e@linux.intel.com>
 <s5h5zx3o6um.wl-tiwai@suse.de>
 <ad05386f-af75-3bf2-bc76-628928fc4fea@linux.intel.com>
 <s5hpnv7aexo.wl-tiwai@suse.de> <s5ho9ap6sjk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2372679C0
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 15:11:30 +0100 (CET)
In-Reply-To: <s5ho9ap6sjk.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 11/16/18 7:49 AM, Takashi Iwai wrote:
> On Wed, 14 Nov 2018 15:53:23 +0100,
> Takashi Iwai wrote:
>> On Mon, 12 Nov 2018 15:00:36 +0100,
>> Pierre-Louis Bossart wrote:
>>> And btw the big topic is still how we provide distributions the means
>>> to handle a 'graceful' fallback from DSP-enabled solutions (SST or
>>> SOF) to legacy HDAudio, it's already popped up for cases where we have
>>> HDaudio solutions with DMICs.
>> Yeah, that's a long-standing problem.  I've experimented some
>> scenarios in the past, and the conclusion is that there is no really
>> working fallback mechanism in general in Linux driver binding.
>> That is, the only reasonable way seems to make a dedicated driver for
>> the specific PCI ID (SKL+) doing the probe-and-fallback by itself,
>> while excluding these IDs from other existing driver entries.
>>
>> I'd love to proceed this but unfortunately I have no machine that can
>> run SKL+ SST driver right now.  I have a new CFL devel box, but it has
>> no support (PCI ID 8086:a348) as well as no firmware...
> So, with a working machine, I could finally hack this a bit.
> Below is a freshly cooked patch(set).  The first one is just to add
> the support for my CFL machine, and another one is to add the fallback
> binding with the legacy HD-audio on snd-soc-skl.
>
> The changes aren't that big.  And you can still control the binding
> via a module option, e.g. snd_soc_skl.legacy=1 will let it bound only
> with the legacy driver, snd_soc_skl.legacy=2 for ASoC only.  The
> default is 0, the fallback to legacy if ASoC binding fails.
>
> It's still a PoC, no proper patch description is put yet.

Thanks Takashi, much appreciate. will give it a try later today.

One comment is that we will have to deal with SOF as well. While the 
end-goal is to converge on a single SOF-based driver, it'll take time to 
support all shipping platforms and deal with firmware authentication 
issues, so the fallback could be SOF->SST->legacy (hopefully on a small 
set of platforms). SST->SOF will likely never happen.

I also wanted to try what happens with your solution if the 
authentication fails with SST (as in your case with the current CNL 
firmware). It's my understanding that the firmware download is deferred 
with a work queue and takes time anyways, so maybe the decision not to 
go back to legacy would be made too early? We'd also need to check with 
a platform where the DSP is not enabled to see if the fallback happens 
immediately (no need to try and download firmware to a non-enabled DSP).

And while I am at it, we may want to think about a single table for PCI 
IDs so that by construction we remove the risk of a platform supported 
with legacy but not the others, and vice versa.

Just my 2 cents before coffee.

>
> Comments / suggestions appreciated.
>
>
> thanks,
>
> Takashi
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
