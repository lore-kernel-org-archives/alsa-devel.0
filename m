From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] ASoC: fsl/pcm030 add unique dai_link names
Date: Wed, 10 Oct 2012 10:06:47 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459868BB40@dekaexchange07.deka.local>
References: <1349877602-93663-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B1F892616C1
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 16:06:49 +0200 (CEST)
In-Reply-To: <1349877602-93663-1-git-send-email-emillbrandt@dekaresearch.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Shoot, I mangled the committer in this patch.  I'll resend.

On 2012-10-10 Eric Millbrandt wrote:
> From: Eric Millbrandt <emillbrandt@dekaresearch.com
>
> Assign each dai_link a unique name to avoid this run-time error.
>
> [   18.978043] pcm030-audio-fabric sound.2:  wm9712-hifi <-> mpc5200-
> psc-ac97.0 mapping ok [   19.003179] sysfs: cannot create duplicate
> filename '/devices/sound.2/AC97'
>
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
>  sound/soc/fsl/pcm030-audio-fabric.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> diff --git a/sound/soc/fsl/pcm030-audio-fabric.c
> b/sound/soc/fsl/pcm030-audio-fabric.c index 4b63ec8..4d26192 100644 ---
> a/sound/soc/fsl/pcm030-audio-fabric.c +++
> b/sound/soc/fsl/pcm030-audio-fabric.c @@ -29,14 +29,14 @@ struct
> pcm030_audio_data {
>
>  static struct snd_soc_dai_link pcm030_fabric_dai[] = {
>  {
> -     .name = "AC97",
> +     .name = "AC97.0",
>       .stream_name = "AC97 Analog",
>       .codec_dai_name = "wm9712-hifi",
>       .cpu_dai_name = "mpc5200-psc-ac97.0",
>       .codec_name = "wm9712-codec",
>  },
>  {
> -     .name = "AC97",
> +     .name = "AC97.1",
>       .stream_name = "AC97 IEC958",
>       .codec_dai_name = "wm9712-aux",
>       .cpu_dai_name = "mpc5200-psc-ac97.1",






This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
