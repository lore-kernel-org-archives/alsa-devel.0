From: Jason Holmes <jason@exonerated.net>
Subject: Re: DELL SP2309W Monitor with Integrated microphone
Date: Wed, 18 Mar 2009 08:41:55 -0700
Message-ID: <ea9198010903180841r19d3cd37wf9a241e019c593c1@mail.gmail.com>
References: <ea9198010903170224k1493b353r2a683766b955f7de@mail.gmail.com>
	<s5hzlfjm7wa.wl%tiwai@suse.de>
	<ea9198010903180824r7a9ff71cgc466f8f1f7f722cf@mail.gmail.com>
	<s5h7i2mn8ra.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AA9C424418
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 16:41:56 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 5so82543ywr.2
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 08:41:55 -0700 (PDT)
In-Reply-To: <s5h7i2mn8ra.wl%tiwai@suse.de>
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

arecord --device=plughw:Webcam test
Recording WAVE 'test' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not usable
arecord: set_params:939: Broken configuration for this PCM: no
configurations available


On Wed, Mar 18, 2009 at 8:36 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 18 Mar 2009 08:24:09 -0700,
> Jason Holmes wrote:
> >
> > No the device doesn't work either when using plughw:Webcam.
>
> What error did you get?
>
>
> Takashi
>



-- 
Jason Holmes
