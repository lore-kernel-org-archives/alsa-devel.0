From: Joachim  Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ASoC: Fix idma build after update for
 channel count check
Date: Mon, 9 Jan 2012 08:07:54 +0100
Message-ID: <CAGhQ9VzN-BWtM4XC1uL3VrTNFZN-j4xE1LXzO92zfTB80aWLbQ@mail.gmail.com>
References: <1326092003-21997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C4FE4243C8
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 08:07:55 +0100 (CET)
Received: by obcwm4 with SMTP id wm4so3736145obc.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 23:07:54 -0800 (PST)
In-Reply-To: <1326092003-21997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jan 9, 2012 at 7:53 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0sound/soc/samsung/idma.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
> index 3ba6aba..c227c31 100644
> --- a/sound/soc/samsung/idma.c
> +++ b/sound/soc/samsung/idma.c
> @@ -398,6 +398,7 @@ static int idma_new(struct snd_soc_pcm_runtime *rtd)
> =A0 =A0 =A0 =A0if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D preallocate_idma_buffer(pcm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_=
STREAM_PLAYBACK);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> --

I accidentally added the brace to the if test in "ASoC: check for
substream not channels_min in pcm engines".
So you either remove the brace from the if test or add another one as you d=
id.

Acked-by: Joachim Eastwood <joachim.eastwood@jotron.com>

regards
Joachim Eastwood

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
