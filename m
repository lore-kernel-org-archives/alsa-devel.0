From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] SoC: cht_bsw_rt5645: Fix writing to string
 literal
Date: Sat, 20 Feb 2016 09:01:49 -0600
Message-ID: <56C87FDD.9080801@linux.intel.com>
References: <1455572189-11724-1-git-send-email-carlo@caione.org>
 <56C57A8F.9030306@linux.intel.com>
 <CAL9uMOGi=HPAM_Ao=6XurV7utriZnUo+OEmxcmNF3zGq6xNLTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B6E226145B
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 16:01:52 +0100 (CET)
In-Reply-To: <CAL9uMOGi=HPAM_Ao=6XurV7utriZnUo+OEmxcmNF3zGq6xNLTw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, lgirdwood@gmail.com, yang.a.fang@intel.com, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 02/18/2016 02:31 AM, Carlo Caione wrote:
> On Thu, Feb 18, 2016 at 9:02 AM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 2/15/16 1:36 PM, Carlo Caione wrote:
>>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> We cannot use strcpy() to write to a const char * location. This is
>>> causing a 'BUG: unable to handle kernel paging request' error at boot
>>> when using the cht-bsw-rt5645 driver.
>>>
>>> With this patch we also fix a wrong indexing in the driver where the
>>> codec_name of the wrong dai_link is being overwritten.
>>>
>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>> ---
>>>   sound/soc/intel/atom/sst-atom-controls.h | 1 +
>>>   sound/soc/intel/boards/cht_bsw_rt5645.c  | 4 ++--
>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/intel/atom/sst-atom-controls.h
>>> b/sound/soc/intel/atom/sst-atom-controls.h
>>> index e011311..6f88d1c 100644
>>> --- a/sound/soc/intel/atom/sst-atom-controls.h
>>> +++ b/sound/soc/intel/atom/sst-atom-controls.h
>>> @@ -30,6 +30,7 @@ enum {
>>>         MERR_DPCM_AUDIO = 0,
>>>         MERR_DPCM_DEEP_BUFFER,
>>>         MERR_DPCM_COMPR,
>>> +       MERR_DPCM_BE,
>>>   };
>>>
>>>   /* define a bit for each mixer input */
>>> diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c
>>> b/sound/soc/intel/boards/cht_bsw_rt5645.c
>>> index e6cf800..89b4c032 100644
>>> --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
>>> +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
>>> @@ -282,7 +282,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
>>>         },
>>>         /* CODEC<->CODEC link */
>>>         /* back ends */
>>> -       {
>>> +       [MERR_DPCM_BE] = {
>>>                 .name = "SSP2-Codec",
>>>                 .be_id = 1,
>>>                 .cpu_dai_name = "ssp2-port",
>>> @@ -357,7 +357,7 @@ static int snd_cht_mc_probe(struct platform_device
>>> *pdev)
>>>         card->dev = &pdev->dev;
>>>         sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
>>>         /* set correct codec name */
>>> -       strcpy((char *)card->dai_link[2].codec_name, codec_name);
>>> +       card->dai_link[MERR_DPCM_BE].codec_name = kstrdup(codec_name,
>>> GFP_KERNEL);
>>
>>
>> It's probably less problematic to find the index in a different way. Adding
>> a new definition in the platform driver doesn't seem quite right.
> 
> MERR_DPCM_BE is intended to be the last dai link index corresponding
> to the BE dai. Or at least that was my idea.
> What about finding the index using a cycle and stopping one 
> !strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00")?

Yes that was the idea. My concern is that if someone adds a front-end or conversely does not enable the link in the machine driver the index will be off. btw we have a fix coming to change the codec name, in some cases the BIOS is somewhat broken and the extension can be :01. If you go ahead with the loop I'll add the changes on top of yours in a follow-up patch. Thanks!
