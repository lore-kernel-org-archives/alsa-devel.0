From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v6 3/3] ASoC: Add multiple CPU DAI support
 in DAPM
Date: Tue, 26 Jun 2018 16:05:55 +0530
Message-ID: <20180626103554.GG15119@snc-desk>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-4-git-send-email-shreyas.nc@intel.com>
 <49d55d2e-5773-7279-f699-7509a290288f@linux.intel.com>
 <20180622055307.GR3116@snc-desk>
 <ee94d4bc-6307-ae14-e542-ac119473ba70@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A824267891
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 12:37:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ee94d4bc-6307-ae14-e542-ac119473ba70@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

> >>>DAPM handles DAIs during soc_dapm_stream_event() and during addition
> >>>and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
> >>>dapm_connect_dai_link_widgets().
> >>can you split this patch in two, one where you add
> >>dapm_add_valid_dai_widget() and the second one where you add the multi-cpu
> >>stuff? the current diff format is really hard to read with the two changes
> >>lumped together.
> >
> >As I had replied earlier, the change is really moving the same code from one
> >function to a new one. So, a patch split would mean we would have the same
> >duplicated code in one patch which surely is not desirable.
> 
> I don't understand your answer. It's fine to have a small preparation patch
> that just moves one piece of code to another function, and they change how
> that function is called.
> 

Ok, I will give it a try :)

> >I just realized that in my earlier reply I had excluded the list and replied
> >only to you :)
> >
> >>
> >>>+	for (i = 0; i < rtd->num_codecs; i++) {
> >>>+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> >>>+
> >>>+		for (j = 0; j < rtd->num_cpu_dai; j++) {
> >>>+			cpu_dai = rtd->cpu_dais[j];
> >>>+
> >>>+			dapm_add_valid_dai_widget(card, rtd,
> >>>+						codec_dai, cpu_dai);
> >>
> >>I didn't click on this earlier, but what makes you think all codec_dais are
> >>connected to all cpu_dais?
> >
> >Yes, there need not be a M:N connectivity. But, how do you find that out ?
> >
> >>That doesn't seem quite right.
> >>For the multi-codec case, all the codec_dais hang from a single cpu_dai.
> >>it's a stretch for me to have a full M:N connectivity. And that's clearly
> >>not the case for SoundWire stream in the multi-link case.
> >
> >I mostly do not disagree with you here..
> >
> >>Can't we use the dai_link information here to only connect cpu_ and
> >>codec_dais that are related?
> >
> >Which DAI Link information are you referring to here ?
> >Other than the machine driver which sets the audio route, I am unable to
> >figure out how we will find out the connected cpu_dai and codec_dais at
> >ASoC core level.
> >
> >May be I am missing something :(
> 
> How is it different from the multi-codec support? You must have a
> description somewhere that tells you how the cpu_dai is connected to various
> codec_dais.
> 

No, there is no such description that I could find.

My reference was skl_nau88l25_ssm4567.c machine driver:

/* Back End DAI links */
        {
                /* SSP0 - Codec */
                .name = "SSP0-Codec",
                .id = 0,
                .cpu_dai_name = "SSP0 Pin",
                .platform_name = "0000:00:1f.3",
                .no_pcm = 1,
                .codecs = ssm4567_codec_components,
                .num_codecs = ARRAY_SIZE(ssm4567_codec_components),
                ..
        },

The only way I could infer the connection was from DAPM route:
{
        /* CODEC BE connections */
        { "Left Playback", NULL, "ssp0 Tx"},
        { "Right Playback", NULL, "ssp0 Tx"},
        { "ssp0 Tx", NULL, "codec0_out"},
}

> Maybe we should start with the examples you provided for Soundwire and
> describe how the dailinks would be represented.
> 

Ok , sure. Let me describe a case where we would want to play a 2 ch stream
and we have two Masters "int-sdw.1" and "int-sdw.2"

So, DAI Link would look this way:

Here I specify the multi CPU DAIs
static struct snd_soc_dai_link_component sdw_multi_cpu_comp[] = {
        { /* Left */
                .name = "int-sdw.1",
                .dai_name = "SDW1 Pin0",
        },
        { /* Right */
                .name = "int-sdw.2",
                .dai_name = "SDW2 Pin0",
        },
};

static struct snd_soc_codec_conf rt700_codec_conf[] = {
        {
                .dev_name = "sdw:1:25d:700:0:0",
                .name_prefix = "Left",
        },
        {
                .dev_name = "sdw:2:25d:701:0:0",
                .name_prefix = "Right",
        },
};

And the DAI Link as:
struct snd_soc_dai_link cnl_rt700_msic_dailink[] = {
{
        ...
        {
                .name = "SDW0-Codec",
                .cpu_dai = sdw_multi_cpu_comp,
                .num_cpu_dai = ARRAY_SIZE(sdw_multi_cpu_comp),
                .platform_name = "0000:00:1f.3",
                .codecs = sdw_multi_codec_comp,
                .num_codecs = ARRAY_SIZE(sdw_multi_codec_comp),
	..
        },
}

And it is in the DAPM route that I would specify :
{
         ...
        { "Left DP1 Playback", NULL, "SDW1 Tx0"},
        { "SDW1 Tx0", NULL, "codec0_out"},

        { "Right DP1 Playback", NULL, "SDW2 Tx0"},
        { "SDW2 Tx0", NULL, "codec0_out"},
        ...
}

> With the M:N connectivity you'd end-up having spurious events with
> non-existent connections, it's not necessarily fatal but certainly not
> elegant and may or may not work depending on state management in codec
> drivers.
>

What are the events that you are referring to here?
The reason I ask that is because my understanding is that we will get these
events only for those widgets marked connected by DAPM after parsing the DAPM
route map.
I will check further if you can let me know of the events you are suspecting
:)

Sorry for the longish mail. I thought it would be better to put in the
details rather than go back and forth over them :)

--Shreyas
>

-- 
