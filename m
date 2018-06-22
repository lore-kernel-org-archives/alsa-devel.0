From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 3/3] ASoC: Add multiple CPU DAI support
 in DAPM
Date: Fri, 22 Jun 2018 11:18:01 -0500
Message-ID: <ee94d4bc-6307-ae14-e542-ac119473ba70@linux.intel.com>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-4-git-send-email-shreyas.nc@intel.com>
 <49d55d2e-5773-7279-f699-7509a290288f@linux.intel.com>
 <20180622055307.GR3116@snc-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C75266D04
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 18:18:05 +0200 (CEST)
In-Reply-To: <20180622055307.GR3116@snc-desk>
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
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/22/18 12:53 AM, Shreyas NC wrote:
> On Thu, Jun 21, 2018 at 09:55:54PM -0500, Pierre-Louis Bossart wrote:
>>
>>
>> On 06/20/2018 05:54 AM, Shreyas NC wrote:
>>> DAPM handles DAIs during soc_dapm_stream_event() and during addition
>>> and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
>>> dapm_connect_dai_link_widgets().
>> can you split this patch in two, one where you add
>> dapm_add_valid_dai_widget() and the second one where you add the multi-cpu
>> stuff? the current diff format is really hard to read with the two changes
>> lumped together.
> 
> As I had replied earlier, the change is really moving the same code from one
> function to a new one. So, a patch split would mean we would have the same
> duplicated code in one patch which surely is not desirable.

I don't understand your answer. It's fine to have a small preparation 
patch that just moves one piece of code to another function, and they 
change how that function is called.

> I just realized that in my earlier reply I had excluded the list and replied
> only to you :)
> 
>>
>>> +	for (i = 0; i < rtd->num_codecs; i++) {
>>> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
>>> +
>>> +		for (j = 0; j < rtd->num_cpu_dai; j++) {
>>> +			cpu_dai = rtd->cpu_dais[j];
>>> +
>>> +			dapm_add_valid_dai_widget(card, rtd,
>>> +						codec_dai, cpu_dai);
>>
>> I didn't click on this earlier, but what makes you think all codec_dais are
>> connected to all cpu_dais?
> 
> Yes, there need not be a M:N connectivity. But, how do you find that out ?
> 
>> That doesn't seem quite right.
>> For the multi-codec case, all the codec_dais hang from a single cpu_dai.
>> it's a stretch for me to have a full M:N connectivity. And that's clearly
>> not the case for SoundWire stream in the multi-link case.
> 
> I mostly do not disagree with you here..
> 
>> Can't we use the dai_link information here to only connect cpu_ and
>> codec_dais that are related?
> 
> Which DAI Link information are you referring to here ?
> Other than the machine driver which sets the audio route, I am unable to
> figure out how we will find out the connected cpu_dai and codec_dais at
> ASoC core level.
> 
> May be I am missing something :(

How is it different from the multi-codec support? You must have a 
description somewhere that tells you how the cpu_dai is connected to 
various codec_dais.

Maybe we should start with the examples you provided for Soundwire and 
describe how the dailinks would be represented.

With the M:N connectivity you'd end-up having spurious events with 
non-existent connections, it's not necessarily fatal but certainly not 
elegant and may or may not work depending on state management in codec 
drivers.
