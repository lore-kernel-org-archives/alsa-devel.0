From: Naveen M <naveen.m@intel.com>
Subject: Re: [alsa-devel] [PATCH v1] ASoC: Intel: kbl_da7219_max98927: fix
 the audio jack button remapping
Date: Mon, 10 Dec 2018 22:08:43 +0530
Message-ID: <20181210163837.GA11058@intel.com>
References: <20181207090552.105205-1-zhuohao@chromium.org>
 <90b46425-5dbd-2ba7-d57d-270d0ab68632@linux.intel.com>
 <CABD5ybm1E4=XQRt0zhviLzgXvUmo+C06AHr4wnXHF2QYbF=d8Q@mail.gmail.com>
 <c11cb754-b01f-3e53-f07f-7fd186b45bdf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c11cb754-b01f-3e53-f07f-7fd186b45bdf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Zhuohao Lee <zhuohao@chromium.org>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Dan Carpenter <dan.carpenter@oracle.com>, Max Chang <changmax@chromium.org>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 10, 2018 at 08:41:23AM -0600, Pierre-Louis Bossart wrote:
> 
> On 12/9/18 10:29 PM, Zhuohao Lee wrote:
> > Thanks Pierre-Louis.
> > I saw a patch https://patchwork.kernel.org/patch/10493135/ which changed
> > the KEY_MEDIA to KEY_PLAYPAUSE, will you merge that patch?
> > Combined with this patch, the key remapping should be consistent.
> 
> I don't have merge superpowers here, and I don't want to submit something I
> cannot test.
> 
> I was only flagging that the behavior is not aligned across patches, and
> some of these patches were never merged (some since April). Yong Zhi and
> Naveen M, can you help resubmit a patchset that aligns the handling of
> buttons for DA7219-based devices?
> 
> Thanks!
> 
> 
Sure Pierre, we will soon post the change for all DA7219 based boards.
Thanks
> > 
> > I'll submit a patch to remove the Change-Id.
> > 
> > On Sat, Dec 8, 2018 at 1:57 AM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com
> > <mailto:pierre-louis.bossart@linux.intel.com>> wrote:
> > 
> > 
> >     On 12/7/18 3:05 AM, Zhuohao Lee wrote:
> >     >  From the da7219 spec, the button A, B, C and D are remapped to
> >     > 0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
> >     > B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND
> > 
> >     Ok, but could fix all da7219-based machine drivers then, the mappings
> >     are completely inconsistent:
> > 
> >     kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_0,
> >     KEY_MEDIA);
> >     kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_1,
> >     KEY_VOLUMEUP);
> >     kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_2,
> >     KEY_VOLUMEDOWN);
> >     kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_3,
> >     KEY_VOICECOMMAND);
> >     kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_0,
> >     KEY_PLAYPAUSE);
> >     kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_1,
> >     KEY_VOICECOMMAND);
> >     kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_2,
> >     KEY_VOLUMEUP);
> >     kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack,
> >     SND_JACK_BTN_3,
> >     KEY_VOLUMEDOWN);
> > 
> >     Thanks!
> > 
> >     >
> >     > Change-Id: I67f929f226883bd289cb7beb0a7b23f40e7121e2
> >     You want to remove those Change-Ids for upstream.
> >     > Signed-off-by: Zhuohao Lee <zhuohao@chromium.org
> >     <mailto:zhuohao@chromium.org>>
> >     > Signed-off-by: Max Chang  <changmax@chromium.org
> >     <mailto:changmax@chromium.org>>
> >     > ---
> >     >   sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
> >     >   1 file changed, 3 insertions(+), 3 deletions(-)
> >     >
> >     > diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c
> >     b/sound/soc/intel/boards/kbl_da7219_max98927.c
> >     > index 3fa1c3ca6d37..d3531f0eb357 100644
> >     > --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> >     > +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> >     > @@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct
> >     snd_soc_pcm_runtime *rtd)
> >     >
> >     >       jack = &ctx->kabylake_headset;
> >     >       snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> >     > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_1,
> >     KEY_VOICECOMMAND);
> >     > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> >     > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> >     > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> >     > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> >     > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
> >     KEY_VOICECOMMAND);
> >     >
> >     >       da7219_aad_jack_det(component, &ctx->kabylake_headset);
> >     >
> > 

-- 
