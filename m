From: Yue Wang <yuleopen@gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
Date: Mon, 23 Jul 2018 00:41:15 -0700
Message-ID: <CA+C1juadkNrQ+jcA6BP=FmoVfjxgQBW=m=Gv8htDMC=RzPihvA@mail.gmail.com>
References: <20180723072536.39240-1-yuleopen@gmail.com> <s5h8t621k9m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8t621k9m.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kai.heng.feng@canonical.com, albaguirre@gmail.com, nob77413@gmail.com, ruslan.bilovol@gmail.com, perex@perex.cz, jussi@sonarnerd.net, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi

My apologies, it's my first time sending a patch to the kernel, so
there're quite a few things I need to improve.

This patch adds the support for native DSD for Topping DX7s DAC. The
product description is on
http://en.tpdz.net/products_detail/productId=32.html and it's
available on https://www.amazon.com/Balanced-Headphone-Amplifier-Topping-2ES9038Q2M/dp/B07B4VFS21

The DAC uses XMOS chip but uses a special vendor id and product id.
The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
hence enable native DSD playback up to DSD512 format.

Thanks again.

Yue
On Mon, Jul 23, 2018 at 12:30 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 23 Jul 2018 09:25:34 +0200,
> <yuleopen@gmail.com> wrote:
> >
> > From: Yue Wang <yuleopen@gmail.com>
> >
> > Signed-off-by: Yue Wang <yuleopen@gmail.com>
>
> Please give more explanation.
> No commit message already indicates that something is very wrong, no
> matter what the change is.
>
>
> thanks,
>
> Takashi
