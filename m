From: Zhuohao Lee <zhuohao@chromium.org>
Subject: Re: [PATCH v1] ASoC: Intel: kbl_da7219_max98927: fix
 the audio jack button remapping
Date: Mon, 10 Dec 2018 12:29:10 +0800
Message-ID: <CABD5ybm1E4=XQRt0zhviLzgXvUmo+C06AHr4wnXHF2QYbF=d8Q@mail.gmail.com>
References: <20181207090552.105205-1-zhuohao@chromium.org>
 <90b46425-5dbd-2ba7-d57d-270d0ab68632@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BEE67267996
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 05:29:21 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id v13so9028673wrw.5
 for <alsa-devel@alsa-project.org>; Sun, 09 Dec 2018 20:29:21 -0800 (PST)
In-Reply-To: <90b46425-5dbd-2ba7-d57d-270d0ab68632@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Max Chang <changmax@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Thanks Pierre-Louis.
I saw a patch https://patchwork.kernel.org/patch/10493135/ which changed
the KEY_MEDIA to KEY_PLAYPAUSE, will you merge that patch?
Combined with this patch, the key remapping should be consistent.

I'll submit a patch to remove the Change-Id.

On Sat, Dec 8, 2018 at 1:57 AM Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

>
> On 12/7/18 3:05 AM, Zhuohao Lee wrote:
> >  From the da7219 spec, the button A, B, C and D are remapped to
> > 0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
> > B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND
>
> Ok, but could fix all da7219-based machine drivers then, the mappings
> are completely inconsistent:
>
> kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0,
> KEY_MEDIA);
> kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1,
> KEY_VOLUMEUP);
> kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2,
> KEY_VOLUMEDOWN);
> kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
> KEY_VOICECOMMAND);
> kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0,
> KEY_PLAYPAUSE);
> kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1,
> KEY_VOICECOMMAND);
> kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2,
> KEY_VOLUMEUP);
> kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
> KEY_VOLUMEDOWN);
>
> Thanks!
>
> >
> > Change-Id: I67f929f226883bd289cb7beb0a7b23f40e7121e2
> You want to remove those Change-Ids for upstream.
> > Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> > Signed-off-by: Max Chang  <changmax@chromium.org>
> > ---
> >   sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c
> b/sound/soc/intel/boards/kbl_da7219_max98927.c
> > index 3fa1c3ca6d37..d3531f0eb357 100644
> > --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> > +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> > @@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct
> snd_soc_pcm_runtime *rtd)
> >
> >       jack = &ctx->kabylake_headset;
> >       snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > -     snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> >
> >       da7219_aad_jack_det(component, &ctx->kabylake_headset);
> >
>
