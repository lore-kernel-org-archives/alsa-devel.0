From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
Date: Fri, 02 Nov 2018 19:21:07 -0400
Message-ID: <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
         <20181102041120.7603-4-ayman.bagabas@gmail.com>
         <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kailang@realtek.com, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2018-11-02 at 20:12 +0200, Andy Shevchenko wrote:
> On Fri, Nov 2, 2018 at 6:12 AM Ayman Bagabas <ayman.bagabas@gmail.com
> > wrote:
> > 
> > Some of Huawei laptops come with a LED in the mic mute key. This
> > patch
> > enables and disable this LED accordingly.
> > --- a/drivers/platform/x86/huawei_wmi.c
> > +++ b/drivers/platform/x86/huawei_wmi.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/input/sparse-keymap.h>
> >  #include <linux/acpi.h>
> >  #include <linux/wmi.h>
> > +#include <linux/huawei_wmi.h>
> 
> Keep it in order and put under
> include/linux/platform_data/x86/
> folder.
> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __HUAWEI_WMI_H__
> > +#define __HUAWEI_WMI_H__
> > +
> > +int huawei_wmi_micmute_led_set(bool on);
> > +
> > +#endif
> 
> This has to cover !HUAWEI_LAPTOP case.
> 
> > +/* Helper functions for Huawei WMI Mic Mute LED;
> > + * to be included from codec driver
> > + */
> 
> Comment style.

/* Helper functions for Huawei WMI micmute led;
 * to be included from codec driver
 */

> 
> > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> 
> See above
> 
> > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> 
> Why is that?

This is used with symbol_request and then in the update function to
locate the function from the wmi device. But I guess you are right, we
could use the function defined in the header file directly.

> 
> > +       if (action == HDA_FIXUP_ACT_PROBE) {
> > +               if (!huawei_wmi_micmute_led_set_func)
> > +                       huawei_wmi_micmute_led_set_func =
> > symbol_request(huawei_wmi_micmute_led_set);
> > +               if (!huawei_wmi_micmute_led_set_func) {
> > +                       codec_warn(codec, "Failed to find
> > huawei_wmi symbol huawei_wmi_micmute_led_set\n");
> > +                       return;
> > +               }
> > +               removefunc =
> > (huawei_wmi_micmute_led_set_func(false) < 0)
> > +                       || (snd_hda_gen_add_micmute_led(codec,
> > update_huawei_wmi_micmute_led) < 0);
> > +
> > +       }
> > +
> > +       if (huawei_wmi_micmute_led_set_func && (action ==
> > HDA_FIXUP_ACT_FREE || removefunc)) {
> > +               symbol_put(huawei_wmi_micmute_led_set);
> > +               huawei_wmi_micmute_led_set_func = NULL;
> > +       }
> > +}
> 
> Takashi, is it a way how the rest sound drivers are written? B/c this
> symbol_request(s) look to me a bit ugly.
> 
> > +/* for alc_fixup_huawei_micmute_led */
> > +#include "huawei_wmi_helper.c"
> 
> Ditto.
> 
> Include *.c?! Huh?

Is that the wrong way? Should I define the functions directly into
patch_realtek.c?

> 
