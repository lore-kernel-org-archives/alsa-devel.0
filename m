From: Yue Wang <yuleopen@gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
Date: Mon, 23 Jul 2018 01:53:04 -0700
Message-ID: <CA+C1jua9ZVDStQwwRBw7mQE4CTZkwfED99oJNV1Cwo=6Hgim6g@mail.gmail.com>
References: <20180723080208.44235-1-yuleopen@gmail.com> <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nobutaka Okabe <nob77413@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Daniel Mack <daniel@zonque.org>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Alberto Aguirre <albaguirre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the comment Jussi. Let's drop this patch, and I will send a
new patch with this generic approach shortly. The new patch will have
a different commit title and message.
On Mon, Jul 23, 2018 at 1:26 AM Jussi Laako <jussi@sonarnerd.net> wrote:
>
> Hi,
>
> > +     case USB_ID(0x152a, 0x8750): /* Topping DX7s */
> 0x152a is Thesycon's VID and if it's based on XMOS I'd recommend to try
> adding the 0x152a VID to the generic DSD capability auto-detect list
> instead of this old device specific list.
>
> I consider it very likely that it would work that way and at the same
> time also cover all other devices with the same firmware and Thesycon's VID.
>
>
> Best regards,
>
>         - Jussi
