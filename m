From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Mon, 7 Sep 2009 22:18:21 +0800
Message-ID: <4f3252890909070718g745b37f2v39ef0f57c44fd9bd@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de> <1252330155.3283.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f176.google.com (mail-px0-f176.google.com
	[209.85.216.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 454162435B
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:18:23 +0200 (CEST)
Received: by pxi6 with SMTP id 6so2226600pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 07:18:21 -0700 (PDT)
In-Reply-To: <1252330155.3283.5.camel@localhost>
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

audacious.i386                     1.5.1-9.fc10  which use the old plugin
did not play any music  on my au8830 even with the patch and select hw:0,0
in the output plugin perference

CHECK (snd_pcm_hw_params_set_access, alsa_handle, params,
<http://hg.atheme.org/audacious-plugins/file/c44c39dd30b5/src/alsa-gapless/alsa.c#l159>SND_PCM_ACCESS_RW_INTERLEAVED);

CHECK (snd_pcm_hw_params_set_format, alsa_handle, params, format);
CHECK (snd_pcm_hw_params_set_channels, alsa_handle, params, channels);
CHECK (snd_pcm_hw_params_set_rate, alsa_handle, params, rate, 0);
CHECK (snd_pcm_hw_params_set_buffer_time_min, alsa_handle, params, & time,
0);
CHECK (snd_pcm_hw_params, alsa_handle, params);
CHECK (snd_pcm_prepare, alsa_handle);

alsa_format = format;
alsa_channels = channels;
alsa_rate = rate;

alsa_buffer_length = snd_pcm_frames_to_bytes (alsa_handle, (gint64)
LARGE_BUFFER * rate / 1000);

If you are using SND_CS46XX_NEW_DSP which support multiple stream, the
driver has a constraint on the buffer size (don't expect that you can get
exactly a one second or 0.1 second buffer for all alsa drivers )

#ifdef CONFIG_SND_CS46XX_NEW_DSP

static unsigned int period_sizes[] = { 32, 64, 128, 256, 512, 1024, 2048 };

static struct snd_pcm_hw_constraint_list hw_constraints_period_sizes = {
    .count = ARRAY_SIZE(period_sizes),
    .list = period_sizes,
    .mask = 0
};

#endif

The documentation did not mention that you can get a default value if you
did not set the period time , buffer_time

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#g98ba19d2800b7d601277fd8c068505da

snd_pcm_hw_params()

The configuration is chosen fixing single parameters in this order: first
access, first format, first subformat, min channels, min rate, min period
time, max buffer size, min tick time

After this call,
snd_pcm_prepare()<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#g692ad9e5902d0623b56a0decee0fa686>is
called automatically and the stream is brought to
SND_PCM_STATE_PREPARED<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ggfff41b69676ea4a7efa64dd5642505ddfa179425d00d012af07ef15e1c066ea6>state.
The hardware parameters cannot be changed when the stream is running
(active). The software parameters can be changed at any tim


2009/9/7 Tony Vroon <tony@linx.net>

> On Mon, 2009-09-07 at 14:32 +0200, Takashi Iwai wrote:
> > Hm, I don't know of "safe API"...
>
> It is described here:
> http://0pointer.de/blog/projects/guide-to-sound-apis.html
>
> Should this be incomplete or otherwise incorrect it would be useful to
> have a rebuttal.
>
> > A small test case, preferably a short C program just to reproduce
> > the problem would be really needed in such a case.  It's very hard to
> > guess what's going on and what is actually wrong in the driver only
> > from your problem description, because of no obvious debug logs.
>
> If it is anything like the Aureal Vortex bug, the minimum period size
> doesn't make sense. Unlike the older the ALSA plugin, the new ALSA-NG
> plugin in Audacious opens the audio device with defaults and does not
> attempt to set period sizes.
> The code is available here:
> http://hg.atheme.org/audacious-plugins/file/c44c39dd30b5/src/alsa-ng
>
> > thanks,
> > Takashi
>
> Regards,
> Tony V.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
