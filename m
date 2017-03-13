From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Mon, 13 Mar 2017 14:41:28 -0700
Message-ID: <20170313214127.GC4586@google.com>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <87zigvz4q3.wl%kuninori.morimoto.gx@renesas.com>
 <20170309002129.GA99773@google.com>
 <87varjz31k.wl%kuninori.morimoto.gx@renesas.com>
 <20170311003939.GB4586@google.com>
 <87a88pj105.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87a88pj105.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 03:46:00AM +0000, Kuninori Morimoto wrote:
> > There are 4 drivers calling that:
> > 
> >   snd_soc_dummy_probe
> >   rt5514_spi_probe
> >   2 instances of snd_dmaengine_pcm_register, via rockchip_i2s_probe
> > 
> > Only the latter two seem to run the assignment here:
> > 
> > 	if (platform_drv->pcm_new)
> > 		platform->component.pcm_new = snd_soc_platform_drv_pcm_new;
> > 
> > Both snd_soc_dummy_probe and rt5514_spi_probe find ->pcm_new NULL here.
> 
> Hmm...
> 
> The crasher was snd_dmaengine_pcm_register's platform ?

No, actually it wasn't. It was spi2.0, which was a dummy, from
snd_soc_dummy_probe(). But somehow snd_soc_platform_drv_pcm_new() got
called for it...

> This means, in your current kernel, dmaengine platform dosn't call
> its .pcm_new (= dmaengine_pcm_new) somehow ?

I believe not. I'm still thoroughly confused though :)

> I'm wondering why ->pcm_new became NULL which exists on probe timing ?
> Can you check component and driver by this patch ?
> This is very rough but enough for debug

I added this (along with a bunch of debugging, including a form of my
current patch, to avoid still crashing on the NULL pointer). Trimmed
log (with some of the framework's dev_dbg() enabled):

[    2.521638] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
[    2.523532] da7219 8-001a: codec register 8-001a
[    2.523850] max98357a max98357a: codec register max98357a
[    2.530256] rt5514 1-0057: codec register 1-0057
[    2.531615] -------add name: ff880000.i2s, ffffff800888a598
[    2.531976] -------add name: ff8a0000.i2s, ffffff800888a598
[    2.532706] rk3399-gru-sound sound: ASoC: binding MAX98357A
[    2.532721] rk3399-gru-sound sound: ASoC: binding RT5514
[    2.532736] rk3399-gru-sound sound: ASoC: binding DA7219
[    2.532745] rk3399-gru-sound sound: ASoC: binding RT5514 DSP
[    2.537327] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 0 late -2
[    2.537332] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 1 late -2
[    2.537336] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 2 late -2
[    2.537340] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 3 late -2
[    2.537344] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 0 late -1
[    2.537347] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 1 late -1
[    2.537351] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 2 late -1
[    2.537354] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 3 late -1
[    2.537358] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 0 late 0
[    2.537362] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 1 late 0
[    2.537365] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 2 late 0
[    2.537369] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 3 late 0
[    2.537373] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 0 late 1
[    2.537376] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 1 late 1
[    2.537380] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 2 late 1
[    2.537383] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 3 late 1
[    2.537387] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 0 late 2
[    2.537569] -------use name: ff880000.i2s, ffffff800888a598
[    3.543003] rk3399-gru-sound sound: HiFi <-> ff880000.i2s mapping ok
[    3.550150] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 1 late 2
[    3.558828] -------use name: ff880000.i2s, ffffff800888a598
[    3.746799] rk3399-gru-sound sound: rt5514-aif1 <-> ff880000.i2s mapping ok
[    3.754635] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 2 late 2
[    3.764970] -------use name: ff880000.i2s, ffffff800888a598
[    3.976496] rk3399-gru-sound sound: da7219-hifi <-> ff880000.i2s mapping ok
[    3.984292] rk3399-gru-sound sound: ASoC: probe rk3399-gru-sound dai link 3 late 2
[    3.992927] -------use name: spi2.0, ffffff80090aeb90
[    4.170426] *** pcm_new was NULL ***
[    4.174426] rk3399-gru-sound sound: snd-soc-dummy-dai <-> spi2.0 mapping ok
[    4.186804] input: rk3399-gru-sound Headset Jack as /devices/platform/sound/sound/card0/input5
