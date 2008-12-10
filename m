From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 06/18] ASoC: TWL4030: DAPM mapping of
	the	Headset outputs
Date: Wed, 10 Dec 2008 16:27:44 +0800
Message-ID: <1228897664.6799.3.camel@localhost>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A2DC24354
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 09:21:04 +0100 (CET)
In-Reply-To: <1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-12-09 at 14:01 +0000, Mark Brown wrote:
> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Adds DAPM muxing, routing for the Headset outputs.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/twl4030.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
<snip>
>  
>  	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
>  	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
> @@ -744,6 +775,12 @@ static const struct snd_soc_dapm_route intercon[] = {
>  	{"PredriveR Mux", "DACR1", "ARXR1_APGA"},
>  	{"PredriveR Mux", "DACR2", "ARXR2_APGA"},
>  	{"PredriveR Mux", "DACL2", "ARXL2_APGA"},
> +	/* HeadsetL */
> +	{"HeadsetL Mux", "DACL1", "ARXL1_APGA"},
> +	{"HeadsetL Mux", "DACL2", "ARXL2_APGA"},

The control names "DACR1","DACR2","DACL1","DACL2" have the same name
with the widgets in the first patch. I suggest you change a different
name to avoid confusion.

Stanley.

> +	/* HeadsetR */
> +	{"HeadsetR Mux", "DACR1", "ARXR1_APGA"},
> +	{"HeadsetR Mux", "DACR2", "ARXR2_APGA"},
>  
>  	/* outputs */
>  	{"OUTL", NULL, "ARXL2_APGA"},
> @@ -751,6 +788,8 @@ static const struct snd_soc_dapm_route intercon[] = {
>  	{"EARPIECE", NULL, "Earpiece Mux"},
>  	{"PREDRIVEL", NULL, "PredriveL Mux"},
>  	{"PREDRIVER", NULL, "PredriveR Mux"},
> +	{"HSOL", NULL, "HeadsetL Mux"},
> +	{"HSOR", NULL, "HeadsetR Mux"},
>  
>  	/* inputs */
>  	{"ADCL", NULL, "INL"},
