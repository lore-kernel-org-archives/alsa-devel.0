From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Thu, 22 May 2008 20:46:21 +0100
Message-ID: <20080522194621.GA12490@sirena.org.uk>
References: <200805221120.08815.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8950C2443F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 21:46:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805221120.08815.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 22, 2008 at 11:20:08AM -0500, Geoffrey Wossum wrote:

> stream.  A patch is found a the bottom of this email.  With this patch, the 
> registers on the WM8510 seem to be getting configured properly (all the clock 
> rates and such look correct), but I get no signal at the speaker outputs or 

Almost of this looks good, thanks for spotting these!  I've applied the
bits I was able to check, see below for one issue.  Note that when
submitting changes it's always best to supply a Signed-off-by, though
for changes like this it's probably OK not to.

> the mono output, no matter what the mixer settings are.  They just sit VMID 
> after the initial power up of the chip.  

Check that all the required DAPM widgets are powered up by looking in
/sys/bus/platform/devices/soc-audio/dapm_widget during playback - if
they aren't then enabling DAPM_DEBUG in sound/soc/soc-dapm.c will make
DAPM display information about the decisions it's making.  If you can't
see anything there could you please supply a register dump from during
playback (availible in /sys/bus/platform/devices/soc-audio/codec_reg)?

I'm out of the office at the minute so can't test on actual hardware
myself right now.

> @@ -597,14 +597,14 @@ struct snd_soc_codec_dai wm8510_dai = {
>  	.name = "WM8510 HiFi",
>  	.playback = {
>  		.stream_name = "Playback",
> -		.channels_min = 1,
> -		.channels_max = 1,
> +		.channels_min = 2,
> +		.channels_max = 2,
>  		.rates = WM8510_RATES,

I'll need to check this out in more detail - the WM8510 is a mono codec
so it can only play one channel.
