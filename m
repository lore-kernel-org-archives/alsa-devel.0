From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: wm8580: Add the wm8581 codec to the
	driver
Date: Mon, 17 Oct 2016 11:59:50 +0100
Message-ID: <20161017105950.GF3207@localhost.localdomain>
References: <1476657738-17020-1-git-send-email-flatmax@flatmax.org>
 <20161017103700.GA3207@localhost.localdomain>
 <8a0452ed-fab3-7ba4-b61c-c7f99e00a4b3@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E28AA266A8F
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 12:59:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8a0452ed-fab3-7ba4-b61c-c7f99e00a4b3@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2016 at 09:46:20PM +1100, Matt Flax wrote:
> 
> 
> On 17/10/16 21:37, Charles Keepax wrote:
> >On Mon, Oct 17, 2016 at 09:42:18AM +1100, Matt Flax wrote:
> >>This patch adds support for the wm8581 codec to the wm8580 driver.
> >>The wm8581 codec hardware adds a fourth DAC and otherwise is
> >>compatible with the wm8580 codec.
> >>
> >>of_device_id data is used to allow the driver to select the
> >>suitable software variables from the device tree codec selection.
> >>The wm8580_driver_data struct is used to store the number of DACs
> >>as well as the required stream names for both codecs.
> >>
> >>The snd_soc_dai_driver no longer lists the stream names and for
> >>playback the channels_max. These variables are set during i2c
> >>probe from the of_device_id supplied wm8580_driver_data struct.
> >>
> >>With knowledge of the number of DACs in use, the DAC4 controls,
> >>widgets and routes are added as required for DAC4.
> >>
> >>The device tree documentation for the wm8580 is altered to list
> >>the wm8581 codec support, as is the Kconfig file.
> >>
> >>Signed-off-by: Matt Flax <flatmax@flatmax.org>
> >>---
<snip>
> >>+static const struct snd_kcontrol_new wm8580_dac4_snd_controls[] = {
> >>+SOC_DOUBLE_R_EXT_TLV("DAC4 Playback Volume",
> >>+		     WM8580_DIGITAL_ATTENUATION_DACL4,
> >>+		     WM8580_DIGITAL_ATTENUATION_DACR4,
> >>+		     0, 0xff, 0, snd_soc_get_volsw, wm8580_out_vu, dac_tlv),
> >>+
> >>+SOC_SINGLE("DAC4 Deemphasis Switch", WM8580_DAC_CONTROL3, 3, 1, 0),
> >>+
> >>+SOC_DOUBLE("DAC4 Invert Switch", WM8580_DAC_CONTROL4,  8, 7, 1, 0),
> >>+
> >>+SOC_SINGLE("DAC4 Switch", WM8580_DAC_CONTROL5, 3, 1, 1),
> >>+};
> >Ditto here and so on for the next couple.
> That would mean replicating the WM8580_DAC_CONTROL[345] definitions where :
> WM8581_DAC_CONTROL3==WM8580_DAC_CONTROL3
> WM8581_DAC_CONTROL4==WM8580_DAC_CONTROL4
> WM8581_DAC_CONTROL5==WM8580_DAC_CONTROL5
> Is that what you are after ?

Ah apologies that wasn't what I meant if the register already
exists then don't change the name. I was referring to
wm8580_dac4_snd_controls I would probably name that
wm8581_dac4_snd_controls.

> >>+	/* Each dac supports stereo input */
> >>+	wm8580_dai[0].playback.channels_max = wm8580->drvdata->num_dacs * 2;
> >>+	wm8580_dai[0].name = wm8580->drvdata->name_playback;
> >>+	wm8580_dai[1].name = wm8580->drvdata->name_capture;
> >You can't patch the dai_driver struct like this its a static
> >struct that is shared between all instanciations of the driver it
> >is possible someone could put a 8580 and 8581 on the same board.
> Oh  - That is a good point. Strangely, the cs42xx8 driver has the same
> problem ! Hmmm ...

Yeah someone should probably look at fixing that at some point,
I will try to find some time to have a gander.

> >I guess you really have two options here, you could specify the
> >maximum in the dai_driver and then apply constraints in the
> >startup callback to limit things to the correct chip dependant
> >number of channels, or just have two copies of the dai_driver
> >struct one for each chip.
> I didn't understand your first suggestion, can you give an example of how to
> do that in the startup callback ? Sounds like a good idea.

If you look in arizona_startup in sound/soc/codecs/arizona.c we
specify constraints for the sample rates based off our clocking,
there is an equivalent SNDRV_PCM_HW_PARAM_CHANNELS that you
should be able to you to specify the supported channels with.

Thanks,
Charles
