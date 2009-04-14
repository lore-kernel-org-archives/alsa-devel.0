From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
	mode
Date: Tue, 14 Apr 2009 11:20:16 +0300
Message-ID: <20090414112016.c0dec32a.jarkko.nikula@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239695131-30367-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F58D244A0
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 10:19:42 +0200 (CEST)
In-Reply-To: <1239695131-30367-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 09:45:30 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> Use correct DSP_B mode configuration for omap-mcbsp.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 9c09b94..4440bab 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -283,7 +283,7 @@ static int omap_mcbsp_dai_hw_params(struct
> snd_pcm_substream *substream, break;
>  	case SND_SOC_DAIFMT_DSP_B:
>  		regs->srgr2	|= FPER(wlen * channels - 1);
> -		regs->srgr1	|= FWID(wlen * channels - 2);
> +		regs->srgr1	|= FWID(0);
>  		break;
>  	}

Grr, I have some practical problems with my Beagle refusing to mount my
SD card root but I give a test when I get it working.

But I fear this change makes it into DSP_B with inverted FS polarity.
Register srgr1 defines the FS length and it's active low. I think this
will be correct if you switch the polarity in
omap_mcbsp_dai_set_dai_fmt.

At least defining pulse witdth with FWID(0) is more clear than FWID
(wlen * channels - 2) :-)


Jarkko
