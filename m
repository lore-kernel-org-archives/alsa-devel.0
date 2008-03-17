From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: query about snd_pcm_hw_refine
Date: Mon, 17 Mar 2008 16:08:11 -0700
Message-ID: <61445c750803171608k355b69d5i1da99a946538b6f@mail.gmail.com>
References: <61445c750803171515n38748127l6becaca008f46bb1@mail.gmail.com>
	<61445c750803171558m43a94d04m29b933d708344f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 4223B103875
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:08:14 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 50so4272295wri.2
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 16:08:12 -0700 (PDT)
In-Reply-To: <61445c750803171558m43a94d04m29b933d708344f10@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2008 at 3:58 PM, Pharaoh . <pharaoh137@gmail.com> wrote:

>
>
> On Mon, Mar 17, 2008 at 3:15 PM, Pharaoh . <pharaoh137@gmail.com> wrote:
>
> > Hi
> >
> > I get following error when trying to run  aplay with my plugin:
> >
> > #aplay -D myplug test.wav
> >
> > Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, St
> > ereo
> > aplay: set_params:882: Broken configuration for this PCM: no
> > configurations available.
> >
> > After looking at the code, I figured out that its snd_pcm_hw_refine
> > which is causing problem.
> > It looks like following in pcm_params.c in alsa lib 1.0.13,
> >
> >
> > int snd_pcm_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
> > {
> >     int res;
> >
> > #ifdef REFINE_DEBUG
> >     snd_output_t *log;
> >     snd_output_stdio_attach(&log, stderr, 0);
> >
> > #endif
> >     printf("#####%s \n", __FUNCTION__);
> >     assert(pcm && params);
> > #ifdef REFINE_DEBUG
> >     snd_output_printf(log, "REFINE called:\n");
> >     snd_pcm_hw_params_dump(params, log);
> > #endif
> >     printf("#####%s calling hw_refine\n", __FUNCTION__);
> >     res = pcm->ops->hw_refine(pcm->op_arg, params);
> >     printf("#####% return val of hw_refine = %d\n", res);
> > #ifdef REFINE_DEBUG
> >     snd_output_printf(log, "refine done - result = %i\n", res);
> >     snd_pcm_hw_params_dump(params, log);
> >     snd_output_close(log);
> > #endif
> >     return res;
> > }
> >
> > I have modified the alsa.conf for my plugin by adding following in it at
> > the end,
> >
> > pcm.myplug {
> >         type myplug
> >         card 0
> > }
> >
> > What could be the problem?
> > -pharaoh.
> >
> >
> Problem solved, I modified my alsa.conf to look like this:
>
> pcm.myplug {
>         @args [ FORMAT ]
>            type myplug
>            card 0
>            rate 44100
>            bitrate 128
>            channels 2
>         format $FORMAT
> }
>
>
> -pharaoh.



No the error is still there, I still get, what should I do now?


#aplay -D myplug startup.wav

aplay: set_params:882: Broken configuration for this PCM: no configurations
available.
