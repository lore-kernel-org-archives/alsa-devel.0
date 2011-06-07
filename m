From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V4 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Tue, 07 Jun 2011 09:06:09 +0200
Message-ID: <4DEDCDE1.80404@metafoo.de>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<4DEC7275.7010603@metafoo.de> <4DEC7CFB.60405@st.com>
	<4DEC8358.9000705@metafoo.de> <4DECA9B2.5080600@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id D626124334
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 09:07:15 +0200 (CEST)
In-Reply-To: <4DECA9B2.5080600@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/06/2011 12:19 PM, rajeev wrote:
> Hi Lars
> 
> [...]
> OK,I Wlll.
> Please check the steps I need to do for dapm update. 
> 1. static const struct snd_soc_dapm_widget sta529_dapm_widgets[] = {
> 	SND_SOC_DAPM_ADC("ADC", "Capture", STA529_ADCCGF, 3, 0),

Even if your DAC itself does not support dynamic power management you probably
still want to define it. Use SND_SOC_NOPM as the register value in this case.
This will allow DAPM determine, whether the outputs are active or not. i.e. if
there is audio playback on the DACs stream, DAPM will know that the outputs
connected to the DAC are active. This will allow for example to turn speakers
connected to the outputs dynamically on or off based on DAPM events.

> 	
> 	SND_SOC_DAPM_OUTPUT("HPL"),
>         SND_SOC_DAPM_OUTPUT("HPR"),
>     	SND_SOC_DAPM_OUTPUT("SPKL"),
> 	SND_SOC_DAPM_OUTPUT("SPKR"),
> 
> 	SND_SOC_DAPM_INPUT("MIC1"),
> };
> 
> 2. static const struct snd_soc_dapm_route sat529_audio_map[] = {
>       {"ADC", NULL, " ADC Mixer"},
>       
>       {"HPL", NULL, "HP Left Out"},
>       {"HPR", NULL, "HP Right Out"},
>       {"SPKL", NULL, "SPK Left Out"},
>       {"SPKR", NULL, "SPK Right Out"},                 
>       {"Left HP Mixer", "MIC Switch", "MIC Input"},
> };
> 
>[...]
> Please let me know is it fine for you?

Your routinges seem to be a bit off. You use path elements which are not
defined in your widget list, like "HP Left Out", "MIC Switch", ...
Since your codec seems to be quite simple, I guess what you basically want to
do is route all inputs to the ADC and route the DAC to all outputs, without any
mixers or switches in between.

- Lars
