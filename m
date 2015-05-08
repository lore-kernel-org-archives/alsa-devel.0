From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Fri, 8 May 2015 20:47:13 -0300
Message-ID: <CAOMZO5AGXuLLP5DtWX1TZ14T98jN-s0rDSpUqCpUbZqa-Cyzjg@mail.gmail.com>
References: <554D27A6.4040602@maciej.szmigiero.name>
	<CAOMZO5A=M2oW47r8_MPrxkd9z6kDj6FG68fVAdKAzngPX0mn=Q@mail.gmail.com>
	<554D4367.6070500@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554D4367.6070500@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Fri, May 8, 2015 at 8:14 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> I currently have audio running on this board at kernel based on
> vanilla 3.19 and porting required changes part-by-part to linux-next.
>
> Changes required on vanilla 3.19 to have it working are:
> * AC'97 audio support needs to be added to fsl-asoc-card,
>
> * AC'97 CODEC platform device needs to be instantiated in fsl_ssi,
>
> * IPG clock needs to be enabled in fsl_ssi AC'97 mode,
> so AC'97 regs can be accessed,
>
> * Few small fixes for AC'97 mode in fsl_ssi (missing switch label
> for format, missing  fsl_ssi_dai_probe entry in fsl_ssi_ac97_dai,
> etc.).
>
> There also is a problem with this CODEC that it seems to pull samples
> for S/PDIF output from time to time even if S/PDIF output is disabled.
>
> By default this requests samples in AC'97 slots 10/11 via SLOTREQ,
> which in turn causes SSI to enable these slots in SACCST register
> and start sending half of the sound samples there.
>
> The end result is that audio suddenly starts to play two times
> too fast.
>
> Currently, I have a workaround of setting S/PDIF slot assignment
> in CODEC to first front pair so at least it doesn't affect
> playback rate.
>
> If you like to have these changes or DT file diff then naturally
> I can share them, just they aren't production-quality as of now.

Good job!

Please keep me on Cc when you submit further ac97 patches / udoo dts,
so that I can help testing them.

Thanks,

Fabio Estevam
