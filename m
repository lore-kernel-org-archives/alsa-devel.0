From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio support
Date: Thu, 13 Sep 2018 12:25:53 +0800
Message-ID: <CAFv8NwJNvCF9+Cg17+j2AKfE6_cjodpTFnjGTc-VBszuBD_4Nw@mail.gmail.com>
References: <20180912121955.33048-1-cychiang@chromium.org> <20180912122818.GH6062@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912122818.GH6062@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ryan Lee <ryans.lee@maximintegrated.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2018 at 8:28 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 12, 2018 at 08:19:54PM +0800, Cheng-Yi Chiang wrote:
> > max98927 codec driver will support reset-gpio binding so it can toggle
> > reset line in its probe function.
>
> All GPIO properties are supposed to end -gpios even if there can only
> ever be a single GPIO.

Hi Mark. I see.
I will update this along with the comments of the change in max98927.c
if there is any.
Thanks!
