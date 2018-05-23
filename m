From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Date: Wed, 23 May 2018 09:29:46 -0700
Message-ID: <CABXOdTf4GhycxC6TNyigS6YyiLXbZK=DHpP2Wzhw7405xVB3BA@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com> <s5hmuwqpjdd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmuwqpjdd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 6:54 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 22 May 2018 18:58:42 +0200,
> Guenter Roeck wrote:
> >
> > +struct skl_dfw_v4_module_caps {
> > +     u32 set_params:2;
> > +     u32 rsvd:30;
> > +     u32 param_id;
> > +     u32 caps_size;
> > +     u32 caps[HDA_SST_CFG_MAX];
> > +};

> Missing __packed attribute?


Yes and no. The original structure (see
sound/soc/intel/skylake/skl-tplg-interface.h
in v4.5.y and earlier) doesn't have the __packed attribute either. I guess
it doesn't hurt,
since it is all u32, so I'll add it in.

Guenter

> And I'm wondering whether we should move these definitions to uapi
> headers.


> thanks,

> Takashi
