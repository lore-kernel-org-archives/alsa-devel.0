From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
Date: Fri, 2 Nov 2018 20:33:38 +0200
Message-ID: <CAHp75VfkyqWRrUND=U9Mb+2-HqpEZhpbUYKs5iTSn0mWK+W_sA@mail.gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
 <20181102041120.7603-4-ayman.bagabas@gmail.com> <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
 <s5hlg6bfi26.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlg6bfi26.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, kailang@realtek.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 2, 2018 at 8:30 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 02 Nov 2018 19:12:44 +0100,
> Andy Shevchenko wrote:
> >
> > > +       if (action == HDA_FIXUP_ACT_PROBE) {
> > > +               if (!huawei_wmi_micmute_led_set_func)
> > > +                       huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
> > > +               if (!huawei_wmi_micmute_led_set_func) {
> > > +                       codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
> > > +                       return;
> > > +               }
> > > +               removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
> > > +                       || (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
> > > +
> > > +       }
> > > +
> > > +       if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
> > > +               symbol_put(huawei_wmi_micmute_led_set);
> > > +               huawei_wmi_micmute_led_set_func = NULL;
> > > +       }
> > > +}
> >
> > Takashi, is it a way how the rest sound drivers are written? B/c this
> > symbol_request(s) look to me a bit ugly.
>
> It's a workaround for not having a hard dependency.  The HD-audio
> codec driver is generic, and we don't want to load the multiple WMI
> drivers always for using a Realtek codec.
>
> Ugly, yes, but simple enough.

Okay, thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
