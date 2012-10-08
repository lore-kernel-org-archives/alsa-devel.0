From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Mon, 08 Oct 2012 14:50:56 +0300
Message-ID: <5072BE20.9040400@ti.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog136.obsmtp.com (na3sys009aog136.obsmtp.com
 [74.125.149.85])
 by alsa0.perex.cz (Postfix) with ESMTP id AFE4526167D
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 13:49:33 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id n12so3557458oag.38
 for <alsa-devel@alsa-project.org>; Mon, 08 Oct 2012 04:49:30 -0700 (PDT)
In-Reply-To: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 10/01/2012 12:29 PM, Peter Ujfalusi wrote:
> soc-dmaengine-pcm library need to be part of the snd-soc-core in order to
> be able to compile ASoC as modules when dmaengine is enabled on the platf=
orm.

Would it be possible to schedule this patch for 3.7? I'm sure if you build =
any
platform which uses dmaegine for audio and compile the audio as module you
will also have errors about missing symbols.

Thank you,
P=E9ter
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index bcbf1d0..99f32f7 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,8 +1,9 @@
>  snd-soc-core-objs :=3D soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-=
utils.o
>  snd-soc-core-objs +=3D soc-pcm.o soc-compress.o soc-io.o
>  =

> -snd-soc-dmaengine-pcm-objs :=3D soc-dmaengine-pcm.o
> -obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) +=3D snd-soc-dmaengine-pcm.o
> +ifneq ($(CONFIG_SND_SOC_DMAENGINE_PCM),)
> +snd-soc-core-objs +=3D soc-dmaengine-pcm.o
> +endif
>  =

>  obj-$(CONFIG_SND_SOC)	+=3D snd-soc-core.o
>  obj-$(CONFIG_SND_SOC)	+=3D codecs/
> =
