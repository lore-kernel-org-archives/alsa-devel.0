From: Jason Holmes <jason@exonerated.net>
Subject: Re: DELL SP2309W Monitor with Integrated microphone
Date: Wed, 18 Mar 2009 09:01:37 -0700
Message-ID: <ea9198010903180901o22c6a09bvb816e1c3973cfa55@mail.gmail.com>
References: <ea9198010903170224k1493b353r2a683766b955f7de@mail.gmail.com>
	<s5hzlfjm7wa.wl%tiwai@suse.de>
	<ea9198010903180824r7a9ff71cgc466f8f1f7f722cf@mail.gmail.com>
	<s5h7i2mn8ra.wl%tiwai@suse.de>
	<ea9198010903180841r19d3cd37wf9a241e019c593c1@mail.gmail.com>
	<s5h4oxqn83g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id B3C5B10380B
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 17:01:38 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 4so88987yxp.2
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 09:01:37 -0700 (PDT)
In-Reply-To: <s5h4oxqn83g.wl%tiwai@suse.de>
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

Here are the results
arecord -Dplughw:Webcam -fdat test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not usable
arecord: set_params:939: Broken configuration for this PCM: no
configurations available


On Wed, Mar 18, 2009 at 8:50 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 18 Mar 2009 08:41:55 -0700,
> Jason Holmes wrote:
> >
> > arecord --device=plughw:Webcam test
> > Recording WAVE 'test' : Unsigned 8 bit, Rate 8000 Hz, Mono
> > ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not
> usable
> > arecord: set_params:939: Broken configuration for this PCM: no
> configurations
> > available
>
> Hm, what about
>
>        % arecord -Dplughw:Webcam -fdat test.wav
>
> ??
>
>
> Takashi
>



-- 
Jason Holmes
