From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: wm8580: Add the wm8581 codec to the
 driver
Date: Tue, 18 Oct 2016 08:56:36 +0100
Message-ID: <20161018075636.GG3207@localhost.localdomain>
References: <1476657738-17020-1-git-send-email-flatmax@flatmax.org>
 <20161017103700.GA3207@localhost.localdomain>
 <8a0452ed-fab3-7ba4-b61c-c7f99e00a4b3@flatmax.org>
 <20161017105950.GF3207@localhost.localdomain>
 <54546e80-7d07-6959-af28-b7905980fc5d@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8940E266D8A
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 09:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <54546e80-7d07-6959-af28-b7905980fc5d@flatmax.org>
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

On Tue, Oct 18, 2016 at 06:15:28AM +1100, Matt Flax wrote:
> 
> 
> On 17/10/16 21:59, Charles Keepax wrote:
> >On Mon, Oct 17, 2016 at 09:46:20PM +1100, Matt Flax wrote:
> >>
> >>On 17/10/16 21:37, Charles Keepax wrote:
> >>>On Mon, Oct 17, 2016 at 09:42:18AM +1100, Matt Flax wrote:
<snip>
> >>I didn't understand your first suggestion, can you give an example of how to
> >>do that in the startup callback ? Sounds like a good idea.
> >If you look in arizona_startup in sound/soc/codecs/arizona.c we
> >specify constraints for the sample rates based off our clocking,
> >there is an equivalent SNDRV_PCM_HW_PARAM_CHANNELS that you
> >should be able to you to specify the supported channels with.
> OK - started on this ... however I get the following problem when trying to
> set the stream name :
> [    6.331002] wm8580 1-001a: ASoC: error - multiple DAI 1-001a registered
> with no name
> 
> I think this is happening in i2c probe. I was wanting to set the stream name
> dynamically to match the codec model number.
> I was planning to do the following :
> static int wm8580_playback_startup(struct snd_pcm_substream *substream,
>                struct snd_soc_dai *dai)
> {
>     struct snd_soc_codec *codec = dai->codec;
>     struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
> 
>     strncpy(substream->name, wm8580->drvdata->name_playback,
> sizeof(wm8580->drvdata->name_playback) - 1);
> 
>     return snd_pcm_hw_constraint_single(substream->runtime,
>         SNDRV_PCM_HW_PARAM_CHANNELS, wm8580->drvdata->num_dacs * 2);
> }
> 
> Do you think perhaps I should set a new name in the snd_soc_dai_driver to
> the following :
>     .name = "wm858x-hifi-playback",
>     .name = "wm858x-hifi-capture",

I don't think you need to bother setting the DAI name to match
the CODEC, I am happy with a generic name.

Thanks,
Charles
