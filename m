From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_rule_noresample
Date: Fri, 23 Sep 2011 09:19:36 +0800
Message-ID: <CAN8cciask6QSBuoj2n87_Po1Xxi3v=FQHdbfnRM+ZvmyvtshQA@mail.gmail.com>
References: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
	<4E785362.2090808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 813B8246DD
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 03:19:36 +0200 (CEST)
Received: by fxe22 with SMTP id 22so3517701fxe.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 18:19:36 -0700 (PDT)
In-Reply-To: <4E785362.2090808@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> ALSA: pcm: add snd_pcm_hw_rule_noresample()
>> ...
>>
>> ymfpci and emu10k1 have SNDRV_PCM_RATE_CONTINUOUS and support 8000Hz to =
48000Hz
>>
>> after this patch and if application using
>> snd_pcm_hw_params_set_rate_resample(,pcm , params ,0)
>>
>> why the supported rate is only 48000Hz ?
>
> Because these cards run at 48 kHz and resample anything else. =A0That
> the resampler is implemented in hardware does not make a conceptual
> difference, and just means that the resampler has low quality.
>
>> but snd_pcm_hw_params_get_rate_min() is still 8000Hz
>
> This should not happen. =A0I'd guess the rules engine hasn't noticed
> that some parameters affected by the new rule need to change.
>
> Please try the patch below. =A0But there might be drivers where other
> parameters are affected by SND_PCM_HW_PARAMS_NORESAMPLE, so I guess
> all parameter bits need to be set.
>
>> This patch won't affect the accuracy of the playback position of the ymf=
pci
>
> Why should it?
>

I think the correct way for ymfpci is to add a period_bytes constraint
(just like emu10k1 and au88x0) in addition of a switch to fixed rate
at 48000Hz to force the application to choose a period time which is
close to the interval of timer interrupt

 snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 10=
24);

are there any problem in snd_pcm_drain(), snd_pcm_rewind() and
snd_pcm_forward() when the driver let the application select any
period time when those hardware mixing sound card 's DSP have to mix
audio streams?

since hwptr is inaccurate, snd_pcm_rewindable() may need to return
zero if it can only rewind to period boundary
