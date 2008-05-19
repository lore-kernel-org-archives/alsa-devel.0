From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Mon, 19 May 2008 17:15:58 +0300
Message-ID: <20080519171558.c37b980b.jarkko.nikula@nokia.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D16124642
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 16:15:49 +0200 (CEST)
In-Reply-To: <1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2008 11:20:39 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> Currently the ASoC core configures the bias levels in the system using
> a callback on codecs and machines called "dapm_event", passing it PCI
> style power levels as SNDRV_CTL_POWER_ constants. This is more obscure
> than it needs to be and has caused confusion to driver authors,
> especially given that DAPM is also performing power management.
> 
> Address this by renaming the callback function to "set_bias_level" and
> using constants explicitly representing the off, standby, pre-on and
> on states which DAPM transitions through.
> 
First impression: Is that somewhat confusing to refer power state event
as a bias level? First what comes to my is this related to mic bias...

If there's a need to change name of dapm_event callback, probably some
dapm_device_event etc. would be better if need to separate from other
dapm events?

> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> +enum snd_soc_bias_level {
> +	SND_SOC_BIAS_ON,
> +	SND_SOC_BIAS_PREPARE,
> +	SND_SOC_BIAS_STANDBY,
> +	SND_SOC_BIAS_OFF,
 
Yeah, those SNDRV_CTL_POWER_ constants are not so clear and I think
some more meaningful naming like here would be better.


Jarkko
