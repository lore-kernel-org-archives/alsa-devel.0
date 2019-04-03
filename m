From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
Date: Wed, 3 Apr 2019 15:32:04 -0600
Message-ID: <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
References: <20190401205519.34023-1-fletcherw@chromium.org> <20190402050236.GV2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402050236.GV2059@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 1, 2019 at 11:02 PM Mark Brown <broonie@kernel.org> wrote:
> regmap-irq should support active high/low, and if it doesn't it can't be
> a unique thing that only this device wants to implement so the common
> code should be improved.

The rt5677 driver needs its own irq regardless for hotword detection.
If we implemented this in regmap-irq, we wouldn't be able to use it.

> This looks unrelated to the polarity of the interupt?

Yes this is separate. If a plug/unplug happens after regmap_read and
before regmap_write, it will not be registered, so we loop to make
sure that it's caught in a later iteration. I can clarify this in the
patch notes.
