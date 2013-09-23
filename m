From: Nicolin Chen <b42378@freescale.com>
Subject: Re: fsl_ssi: Cannot do simultaneous capture and
	playback
Date: Mon, 23 Sep 2013 10:13:42 +0800
Message-ID: <20130923021341.GA18203@MrMyself>
References: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D7032650F9
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 04:32:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
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

Hi Fabio,

On Sun, Sep 22, 2013 at 11:05:03PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I am trying to do simultaneous capture and playback on mx6 wandboard
> and I noticed that it only works if I run 'aplay first'.
> 
> Here is the sequence that works:
> 
> 1) aplay file.wav
> 
> 2) Run 'alsamixer' and select line-in in the capture tab
> 
> 3) Connect audio via line-in input
> 
> 4) arecord -f cd -c 2 | aplay -f cd
> 
> Then I am able to hear the playback.
> 
> However, if I do not do step 1, and try to do the arecord/aplay directly I get:
> 
> $ arecord -f cd  | aplay -f cd
> imx-sgtl5000 sound.13: set sample size in capture stream first

We can pinpoint the issue by the log "set sample size in":

450                 if (synchronous) {                             
451                         struct snd_pcm_runtime *first_runtime =
452                                 ssi_private->first_stream->runtime;
453                         /*
454                          * This is the second stream open, and we're in
455                          * synchronous mode, so we need to impose sample
456                          * sample size constraints. This is because STCCR is
457                          * used for playback and capture in synchronous mode,
458                          * so there's no way to specify different word
459                          * lengths.
460                          *
461                          * Note that this can cause a race condition if the
462                          * second stream is opened before the first stream is
463                          * fully initialized.  We provide some protection by
464                          * checking to make sure the first stream is   
465                          * initialized, but it's not perfect.  ALSA sometimes
466                          * re-initializes the driver with a different sample
467                          * rate or size.  If the second stream is opened
468                          * before the first stream has received its final
469                          * parameters, then the second stream may be         
470                          * constrained to the wrong sample rate or size.
471                          */                                              
472                         if (!first_runtime->sample_bits) {                 
473                                 dev_err(substream->pcm->card->dev,
474                                         "set sample size in %s stream first\n",
475                                         substream->stream ==                
476                                         SNDRV_PCM_STREAM_PLAYBACK          
477                                         ? "capture" : "playback");
478                                 return -EAGAIN;                       
479                         }
480 
481                         snd_pcm_hw_constraint_minmax(substream->runtime,
482                                 SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
483                                 first_runtime->sample_bits,
484                                 first_runtime->sample_bits);
485                 }  


In freescale internal branch, I had a patch to drop this part of code because
the hw_params() in fsl_ssi.c is already considering about the wl configuration,
so it won't change the wl value even if two streams' sample bits are different.

But if we think about the benefit of snd_pcm_hw_constraint() for a case like
"(arecord -d10 xx.wav &);sleep 1;aplay yy.wav", yea the non-simultaneous case,
we might also just turn the dev_err() into dev_warn() from my point of view:

			if (first_runtime->sample_bits)
				snd_pcm_hw_constraint_minmax(substream->runtime,
                                	SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
                                 	first_runtime->sample_bits,
                                 	first_runtime->sample_bits);
			else
				dev_warn(substream->pcm->card->dev,
                                        "Not enforcing sample bits due to race\n");

You can try this two solutions and find a better one.

Best regards,
Nicolin Chen

> fsl-ssi-dai 2028000.ssi: ASoC: can't open interface 2028000.ssi: -11
> ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_
> open) unable to open slave
> aplay: main:660: audio open error: Device or resource busy
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> 
> I will try to debug this, but if anyone has any suggestions, please let me know.
> 
> Thanks,
> 
> Fabio Estevam
> 
