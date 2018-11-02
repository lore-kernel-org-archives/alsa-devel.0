From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date: Fri, 2 Nov 2018 20:07:10 +0200
Message-ID: <CAHp75VfOxX-hULNyV0BzMW9VKnh7nReXW7kNfauXORSqp_CQUA@mail.gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com> <20181102041120.7603-3-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102041120.7603-3-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kailang@realtek.com, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 2, 2018 at 6:11 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This patch solves bug 200501 'Only 2 of 4 speakers playing sound.'
> https://bugzilla.kernel.org/show_bug.cgi?id=200501
> It enables the front speakers on Huawei Matebook X Pro laptops.
> These laptops come with Dolby Atmos sound system and these pins
> configuration enables the front speakers.

> +       [ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
> +               .type = HDA_FIXUP_PINS,
> +               .v.pins = (const struct hda_pintbl[]) {
> +                       {0x12, 0x90a60130},
> +                       {0x13, 0x40000000},
> +                       {0x14, 0x90170110},
> +                       {0x18, 0x411111f0},
> +                       {0x19, 0x04a11040},
> +                       {0x1a, 0x411111f0},
> +                       {0x1b, 0x90170112},
> +                       {0x1d, 0x40759a05},
> +                       {0x1e, 0x411111f0},
> +                       {0x21, 0x04211020},


> +                       { },

Terminators better w/o comma.

> +               },
> +       },

-- 
With Best Regards,
Andy Shevchenko
