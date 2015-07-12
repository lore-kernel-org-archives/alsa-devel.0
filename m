From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: max98357a: Specify digital input
 as a dapm widget
Date: Sun, 12 Jul 2015 12:33:30 +0200
Message-ID: <55A2427A.30501@metafoo.de>
References: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
 <1436684202-16461-2-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-235.synserver.de
 [212.40.185.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A8C2606FB
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 12:33:34 +0200 (CEST)
In-Reply-To: <1436684202-16461-2-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/12/2015 08:56 AM, Anatol Pomozov wrote:
> Spec does not say anything about DAC called SDMode.
> Create a dapm path that consists of path from I2S input to Speaker output.
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>   sound/soc/codecs/max98357a.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
> index 6d4246a..0d87d35 100644
> --- a/sound/soc/codecs/max98357a.c
> +++ b/sound/soc/codecs/max98357a.c
> @@ -51,12 +51,12 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
>   }
>
>   static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
> -	SND_SOC_DAPM_DAC("SDMode", NULL, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("AIFRX", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
>   	SND_SOC_DAPM_OUTPUT("Speaker"),
>   };
>
>   static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
> -	{"Speaker", NULL, "SDMode"},
> +	{"Speaker", NULL, "AIFRX"},

ASoC automatically creates a widget for the playback stream. You can connect 
that directly here without the need for the AIF_IN widget. E.g.:

	{ "Speaker", NULL, "HiFi Playback" },

>   };
>
>   static int max98357a_codec_probe(struct snd_soc_codec *codec)
>
