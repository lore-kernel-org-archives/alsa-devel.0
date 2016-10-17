From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoc: wm8580: Add the wm8581 codec to the
 driver
Date: Tue, 18 Oct 2016 06:14:47 +1100
Message-ID: <1bd1550e-fe26-2c8e-37e8-b283de149a3a@flatmax.org>
References: <1476657738-17020-1-git-send-email-flatmax@flatmax.org>
 <20161017103700.GA3207@localhost.localdomain>
 <8a0452ed-fab3-7ba4-b61c-c7f99e00a4b3@flatmax.org>
 <20161017105950.GF3207@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas06p.mx.bigpond.com (nskntmtas06p.mx.bigpond.com
 [61.9.168.152]) by alsa0.perex.cz (Postfix) with ESMTP id D0908266B69
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 21:14:52 +0200 (CEST)
Received: from nskntcmgw07p ([61.9.169.167]) by nskntmtas06p.mx.bigpond.com
 with ESMTP
 id <20161017191449.JXUJ2096.nskntmtas06p.mx.bigpond.com@nskntcmgw07p>
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 19:14:49 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1bwDRM-0003RT-Vj
 for alsa-devel@alsa-project.org; Tue, 18 Oct 2016 06:19:17 +1100
In-Reply-To: <20161017105950.GF3207@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 17/10/16 21:59, Charles Keepax wrote:
> On Mon, Oct 17, 2016 at 09:46:20PM +1100, Matt Flax wrote:
>>
>> On 17/10/16 21:37, Charles Keepax wrote:
>>> On Mon, Oct 17, 2016 at 09:42:18AM +1100, Matt Flax wrote:
>>>> This patch adds support for the wm8581 codec to the wm8580 driver.
>>>> The wm8581 codec hardware adds a fourth DAC and otherwise is
>>>> compatible with the wm8580 codec.
>>>>
>>>> of_device_id data is used to allow the driver to select the
>>>> suitable software variables from the device tree codec selection.
>>>> The wm8580_driver_data struct is used to store the number of DACs
>>>> as well as the required stream names for both codecs.
>>>>
>>>> The snd_soc_dai_driver no longer lists the stream names and for
>>>> playback the channels_max. These variables are set during i2c
>>>> probe from the of_device_id supplied wm8580_driver_data struct.
>>>>
>>>> With knowledge of the number of DACs in use, the DAC4 controls,
>>>> widgets and routes are added as required for DAC4.
>>>>
>>>> The device tree documentation for the wm8580 is altered to list
>>>> the wm8581 codec support, as is the Kconfig file.
>>>>
>>>> Signed-off-by: Matt Flax <flatmax@flatmax.org>
>>>> ---
> <snip>
>>>> +static const struct snd_kcontrol_new wm8580_dac4_snd_controls[] = {
>>>> +SOC_DOUBLE_R_EXT_TLV("DAC4 Playback Volume",
>>>> +		     WM8580_DIGITAL_ATTENUATION_DACL4,
>>>> +		     WM8580_DIGITAL_ATTENUATION_DACR4,
>>>> +		     0, 0xff, 0, snd_soc_get_volsw, wm8580_out_vu, dac_tlv),
>>>> +
>>>> +SOC_SINGLE("DAC4 Deemphasis Switch", WM8580_DAC_CONTROL3, 3, 1, 0),
>>>> +
>>>> +SOC_DOUBLE("DAC4 Invert Switch", WM8580_DAC_CONTROL4,  8, 7, 1, 0),
>>>> +
>>>> +SOC_SINGLE("DAC4 Switch", WM8580_DAC_CONTROL5, 3, 1, 1),
>>>> +};
>>> Ditto here and so on for the next couple.
>> That would mean replicating the WM8580_DAC_CONTROL[345] definitions where :
>> WM8581_DAC_CONTROL3==WM8580_DAC_CONTROL3
>> WM8581_DAC_CONTROL4==WM8580_DAC_CONTROL4
>> WM8581_DAC_CONTROL5==WM8580_DAC_CONTROL5
>> Is that what you are after ?
> Ah apologies that wasn't what I meant if the register already
> exists then don't change the name. I was referring to
> wm8580_dac4_snd_controls I would probably name that
> wm8581_dac4_snd_controls.
>
>>>> +	/* Each dac supports stereo input */
>>>> +	wm8580_dai[0].playback.channels_max = wm8580->drvdata->num_dacs * 2;
>>>> +	wm8580_dai[0].name = wm8580->drvdata->name_playback;
>>>> +	wm8580_dai[1].name = wm8580->drvdata->name_capture;
>>> You can't patch the dai_driver struct like this its a static
>>> struct that is shared between all instanciations of the driver it
>>> is possible someone could put a 8580 and 8581 on the same board.
>> Oh  - That is a good point. Strangely, the cs42xx8 driver has the same
>> problem ! Hmmm ...
> Yeah someone should probably look at fixing that at some point,
> I will try to find some time to have a gander.
>
>>> I guess you really have two options here, you could specify the
>>> maximum in the dai_driver and then apply constraints in the
>>> startup callback to limit things to the correct chip dependant
>>> number of channels, or just have two copies of the dai_driver
>>> struct one for each chip.
>> I didn't understand your first suggestion, can you give an example of how to
>> do that in the startup callback ? Sounds like a good idea.
> If you look in arizona_startup in sound/soc/codecs/arizona.c we
> specify constraints for the sample rates based off our clocking,
> there is an equivalent SNDRV_PCM_HW_PARAM_CHANNELS that you
> should be able to you to specify the supported channels with.
OK - started on this ... however I get the following problem when trying 
to set the stream name :
[    6.331002] wm8580 1-001a: ASoC: error - multiple DAI 1-001a 
registered with no name

I think this is happening in i2c probe. I was wanting to set the stream 
name dynamically to match the codec model number.
I was planning to do the following :
static int wm8580_playback_startup(struct snd_pcm_substream *substream,
                struct snd_soc_dai *dai)
{
     struct snd_soc_codec *codec = dai->codec;
     struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);

     strncpy(substream->name, wm8580->drvdata->name_playback,
sizeof(wm8580->drvdata->name_playback) - 1);

     return snd_pcm_hw_constraint_single(substream->runtime,
         SNDRV_PCM_HW_PARAM_CHANNELS, wm8580->drvdata->num_dacs * 2);
}

Do you think perhaps I should set a new name in the snd_soc_dai_driver 
to the following :
     .name = "wm858x-hifi-playback",
     .name = "wm858x-hifi-capture",


> Thanks,
> Charles
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
