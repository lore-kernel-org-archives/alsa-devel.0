From: Nicolin Chen <b42378@freescale.com>
Subject: Re: fsl_ssi: Cannot do simultaneous capture and
	playback
Date: Mon, 23 Sep 2013 10:40:29 +0800
Message-ID: <20130923024028.GA18268@MrMyself>
References: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
 <20130923021341.GA18203@MrMyself>
 <CAOMZO5AKAnJxRpHB5AyaXfL2GoU=Ek5-qsb77Jw2ZuW1EyaJMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 729D6265113
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 05:00:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AKAnJxRpHB5AyaXfL2GoU=Ek5-qsb77Jw2ZuW1EyaJMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 22, 2013 at 11:56:17PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Sun, Sep 22, 2013 at 11:13 PM, Nicolin Chen <b42378@freescale.com> wrote:
> 
> > In freescale internal branch, I had a patch to drop this part of code because
> > the hw_params() in fsl_ssi.c is already considering about the wl configuration,
> > so it won't change the wl value even if two streams' sample bits are different.
> >
> > But if we think about the benefit of snd_pcm_hw_constraint() for a case like
> > "(arecord -d10 xx.wav &);sleep 1;aplay yy.wav", yea the non-simultaneous case,
> > we might also just turn the dev_err() into dev_warn() from my point of view:
> >
> >                         if (first_runtime->sample_bits)
> >                                 snd_pcm_hw_constraint_minmax(substream->runtime,
> >                                         SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> >                                         first_runtime->sample_bits,
> >                                         first_runtime->sample_bits);
> >                         else
> >                                 dev_warn(substream->pcm->card->dev,
> >                                         "Not enforcing sample bits due to race\n");
> >
> > You can try this two solutions and find a better one.
> 
> Yes, tried both and none of them worked for me.
> 
> Could you try linux-next if you have a chance?

I want to, but I don't have a wandboard. Could you please give me the new
printed log? I think after the modification there should be little different
for the case.

> 
> Thanks,
> 
> Fabio Estevam
>
