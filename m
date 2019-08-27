From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v2 1/2] ASoC: es8316: fix headphone mixer volume table
Date: Tue, 27 Aug 2019 10:43:58 +0800
Message-ID: <CAD8Lp44a0i2Z9YV0tOKB=QuoZzU-ALSqTr_X8XaMVrGbw-DfQg@mail.gmail.com>
References: <20190826153900.25969-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826153900.25969-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 26, 2019 at 11:39 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch fix setting table of Headphone mixer volume.
> Current code uses 4 ... 7 values but these values are prohibited.
>
> Correct settings are the following:
>   0000 -12dB
>   0001 -10.5dB
>   0010 -9dB
>   0011 -7.5dB
>   0100 -6dB
>   1000 -4.5dB
>   1001 -3dB
>   1010 -1.5dB
>   1011 0dB
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Reviewed-by: Daniel Drake <drake@endlessm.com>
