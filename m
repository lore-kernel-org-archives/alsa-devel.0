From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v2 2/2] ASoC: es8316: fix inverted L/R of headphone mixer volume
Date: Tue, 27 Aug 2019 10:43:38 +0800
Message-ID: <CAD8Lp45zqUsTJKV4QCF59AkDX4qh3HZ7=Ympxm2HD7VV0WCLrA@mail.gmail.com>
References: <20190826153900.25969-1-katsuhiro@katsuster.net> <20190826153900.25969-2-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826153900.25969-2-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 26, 2019 at 11:39 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch fixes inverted Left-Right channel of headphone mixer
> volume by wrong shift_left, shift_right values.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

Agrees with the spec

Reviewed-by: Daniel Drake <drake@endlessm.com>
