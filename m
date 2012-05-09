From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Use DAPM routes to hook
 AIF widgets to DAI's
Date: Wed, 9 May 2012 12:18:13 -0500
Message-ID: <alpine.DEB.2.02.1205091217520.6547@heelrod.ad.cirrus.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
	<1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe004.messaging.microsoft.com [213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 15FA8104540
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:21:03 +0200 (CEST)
In-Reply-To: <1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 9 May 2012, Brian Austin wrote:

> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
> sound/soc/codecs/cs42l73.c |   15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> index 1cf2206..d8b325c 100644
> --- a/sound/soc/codecs/cs42l73.c
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -773,6 +773,14 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
> 	{"HL Left Mixer", NULL, "VSPIN"},
> 	{"HL Right Mixer", NULL, "VSPIN"},
>
> +	{"ASPINL", NULL, "ASP Playback"},
> +	{"ASPINM", NULL, "ASP Playback"},
> +	{"ASPINR", NULL, "ASP Playback"},
> +	{"XSPINL", NULL, "XSP Playback"},
> +	{"XSPINM", NULL, "XSP Playback"},
> +	{"XSPINR", NULL, "XSP Playback"},
> +	{"VSPIN", NULL, "VSP Playback"},
> +
> 	/* Capture Paths */
> 	{"MIC1", NULL, "MIC1 Bias"},
> 	{"PGA Left Mux", "Mic 1", "MIC1"},
> @@ -819,6 +827,13 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
>
> 	{"VSPOUTL", NULL, "VSPL Output Mixer"},
> 	{"VSPOUTR", NULL, "VSPR Output Mixer"},
> +
> +	{"ASP Capture", NULL, "ASPOUTL"},
> +	{"ASP Capture", NULL, "ASPOUTR"},
> +	{"XSP Capture", NULL, "XSPOUTL"},
> +	{"XSP Capture", NULL, "XSPOUTR"},
> +	{"VSP Capture", NULL, "VSPOUTL"},
> +	{"VSP Capture", NULL, "VSPOUTR"},
> };
I forgot to add the other part in the SND_SOC_DAPM_AIF_IN and 
SND_SOC_DAPM_AIF_OUT Widgets.

I'll resend this one, sorry
