From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: Move pcm_mutex up to card
 level from snd_soc_pcm_runtime
Date: Thu, 15 Aug 2019 08:56:24 -0500
Message-ID: <8558e96c-f78b-56d8-82be-3756617bdfc2@linux.intel.com>
References: <20190813104532.16669-1-peter.ujfalusi@ti.com>
 <1968e008-5311-e624-c997-9433ac624341@linux.intel.com>
 <c040ea94-37c7-3896-3d3b-7baa9f6399fc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57C39F801DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 15:56:27 +0200 (CEST)
In-Reply-To: <c040ea94-37c7-3896-3d3b-7baa9f6399fc@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org



On 8/15/19 2:07 AM, Peter Ujfalusi wrote:
> 
> 
> On 14/08/2019 21.14, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/13/19 5:45 AM, Peter Ujfalusi wrote:
>>> The pcm_mutex is used to prevent concurrent execution of snd_pcm_ops
>>> callbacks. This works fine most of the cases but it can not handle setups
>>> when the same DAI is used by different rtd, for example:
>>> pcm3168a have two DAIs: one for Playback and one for Capture.
>>> If the codec is connected to a single CPU DAI we need to have two
>>> dai_link
>>> to support both playback and capture.
>>>
>>> In this case the snd_pcm_ops callbacks can be executed in parallel
>>> causing
>>> unexpected races in DAI drivers.
>>>
>>> By moving the pcm_mutex up to card level this can be solved
>>> while - hopefully - not breaking other setups.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>> Hi,
>>>
>>> I have tested the patch on several boards. it fixes the issue with
>>> single card
>>> with multiple dai_links where the CPU side (mcasp) is the same.
>>>
>>> However I can not test with anything which use DPCM. It would be great
>>> if the
>>> patch would gather few tested-by from folks having access to more
>>> complicated
>>> setups.
>>
>> Actually you *can* test by submitting a PR for SOF, it'll trigger some
>> tests on Intel platforms using DPCM. It's not going to test anything
>> related to the compressed API but it's better than nothing.
> 
> Good to know and thanks.
> I would not thought of abusing the SOF project to run tests, not that I
> know how to trigger the right tests ;)

well we will run those tests anyways when we do the weekly merges, and 
when in doubt it might be more productive for an ALSA contributor to run 
the tests ahead of time than report that things are broken after the 
merge (as seen 2 weeks in a row with the module_put and compilation issues)

> 
>>
>> I took this patch and created one PR as an example
>> https://github.com/thesofproject/linux/pull/1132
> 
> Should I be worried because of your comment there saying 'I have no idea
> why the BYT_NOCODEC mode fails, there's no information provided.' ?

Redoing the tests removes that error, so this looks fine. Must have been 
a CI glitch

>> Will share results when I have them.

So far no issues. so FWIW since it's just 1st order automatic testing

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
