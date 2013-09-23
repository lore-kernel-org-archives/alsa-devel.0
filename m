From: Fabio Estevam <festevam@gmail.com>
Subject: Re: fsl_ssi: Cannot do simultaneous capture and
	playback
Date: Sun, 22 Sep 2013 23:56:17 -0300
Message-ID: <CAOMZO5AKAnJxRpHB5AyaXfL2GoU=Ek5-qsb77Jw2ZuW1EyaJMw@mail.gmail.com>
References: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
 <20130923021341.GA18203@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 007EA2650F9
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 04:56:17 +0200 (CEST)
Received: by mail-vc0-f173.google.com with SMTP id if17so1751758vcb.18
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 19:56:17 -0700 (PDT)
In-Reply-To: <20130923021341.GA18203@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Sun, Sep 22, 2013 at 11:13 PM, Nicolin Chen <b42378@freescale.com> wrote:

> In freescale internal branch, I had a patch to drop this part of code because
> the hw_params() in fsl_ssi.c is already considering about the wl configuration,
> so it won't change the wl value even if two streams' sample bits are different.
>
> But if we think about the benefit of snd_pcm_hw_constraint() for a case like
> "(arecord -d10 xx.wav &);sleep 1;aplay yy.wav", yea the non-simultaneous case,
> we might also just turn the dev_err() into dev_warn() from my point of view:
>
>                         if (first_runtime->sample_bits)
>                                 snd_pcm_hw_constraint_minmax(substream->runtime,
>                                         SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
>                                         first_runtime->sample_bits,
>                                         first_runtime->sample_bits);
>                         else
>                                 dev_warn(substream->pcm->card->dev,
>                                         "Not enforcing sample bits due to race\n");
>
> You can try this two solutions and find a better one.

Yes, tried both and none of them worked for me.

Could you try linux-next if you have a chance?

Thanks,

Fabio Estevam
