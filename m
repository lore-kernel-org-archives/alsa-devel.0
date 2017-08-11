From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] ASoC: hdmi-codec: Use different name for
	playback streams
Date: Fri, 11 Aug 2017 09:59:09 -0700
Message-ID: <20170811165908.GA67191@google.com>
References: <1502440173-23429-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f46.google.com (mail-pg0-f46.google.com [74.125.83.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9491F26768D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 18:59:14 +0200 (CEST)
Received: by mail-pg0-f46.google.com with SMTP id v189so17721890pgd.2
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 09:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1502440173-23429-1-git-send-email-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dianders@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Jeffy,

You need to be more careful about the addressee's of your patches. No
one on To/CC is a maintainer or a sufficiently-targeted mailing list. I
doubt any of the maintainers will read your patch. (I've added
alsa-devel for you, but given my understanding of at least Mark's
patchwork workflow -- and of general patch etiquette -- it's important
the patch is actually sent there in the first place.)

Probably worth resending.

Brian

On Fri, Aug 11, 2017 at 04:29:33PM +0800, Jeffy Chen wrote:
> Currently the hdmi i2s playback stream and hdmi spdif playback stream
> are using the same name. So when they are enabled at the same time,
> kernel will print this warning:
> 
> [    2.201835] hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: Failed to
> create Playback debugfs file
> 
> Assign different names to them to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  sound/soc/codecs/hdmi-codec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 509ab51..a2af440 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -696,7 +696,7 @@ static struct snd_soc_dai_driver hdmi_i2s_dai = {
>  	.name = "i2s-hifi",
>  	.id = DAI_ID_I2S,
>  	.playback = {
> -		.stream_name = "Playback",
> +		.stream_name = "I2S Playback",
>  		.channels_min = 2,
>  		.channels_max = 8,
>  		.rates = HDMI_RATES,
> @@ -711,7 +711,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
>  	.name = "spdif-hifi",
>  	.id = DAI_ID_SPDIF,
>  	.playback = {
> -		.stream_name = "Playback",
> +		.stream_name = "SPDIF Playback",
>  		.channels_min = 2,
>  		.channels_max = 2,
>  		.rates = HDMI_RATES,
> -- 
> 2.1.4
> 
> 
