From: Jason Holmes <jason@exonerated.net>
Subject: Re: DELL SP2309W Monitor with Integrated microphone
Date: Wed, 18 Mar 2009 09:51:16 -0700
Message-ID: <ea9198010903180951y896149crdfc2756294ed452f@mail.gmail.com>
References: <ea9198010903170224k1493b353r2a683766b955f7de@mail.gmail.com>
	<s5hzlfjm7wa.wl%tiwai@suse.de>
	<ea9198010903180824r7a9ff71cgc466f8f1f7f722cf@mail.gmail.com>
	<s5h7i2mn8ra.wl%tiwai@suse.de>
	<ea9198010903180841r19d3cd37wf9a241e019c593c1@mail.gmail.com>
	<s5h4oxqn83g.wl%tiwai@suse.de>
	<ea9198010903180901o22c6a09bvb816e1c3973cfa55@mail.gmail.com>
	<s5h1vsun6ng.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2126E2442A
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 17:51:17 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 5so106575ywr.2
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 09:51:17 -0700 (PDT)
In-Reply-To: <s5h1vsun6ng.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Using -Dhw:1 instead of plughw gives
arecord -Dhw:1 -fdat test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
arecord: set_params:939: Broken configuration for this PCM: no
configurations available


On Wed, Mar 18, 2009 at 9:21 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 18 Mar 2009 09:01:37 -0700,
> Jason Holmes wrote:
> >
> > Here are the results
> > arecord -Dplughw:Webcam -fdat test.wav
> > Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
> Stereo
> > ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not
> usable
> > arecord: set_params:939: Broken configuration for this PCM: no
> configurations
> > available
>
> In this case you can use -Dhw:1 instead of plughw.
>
>
> Takashi
>



-- 
Jason Holmes
