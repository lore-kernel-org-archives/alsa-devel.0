From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Tue, 9 Apr 2019 13:53:20 -0600
Message-ID: <CAN-6NYZ49abdE=zkwQpFfeT1u_7DcxHh7AXe2qAibuUYUnkL+g@mail.gmail.com>
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org> <20190405204257.87095-2-fletcherw@chromium.org>
 <20190408061014.GG2803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408061014.GG2803@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 8, 2019 at 12:38 AM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 05, 2019 at 02:42:55PM -0600, Fletcher Woodruff wrote:
>
> > This patch allows headphone plug detect and mic present
> > detect to be enabled at the same time. This patch implements
> > an irq_chip with irq_domain directly instead of using
> > regmap_irq, so that interrupt source line polarities can
> > be flipped to support irq sharing.
>
> This changelog still doesn't explain why there is a need to open code
> this rather than having the irq_chip and irq_domain provided by
> regmap-irq support whatever is missing here.  You said it "needs its own
> irq regardless for hotword detection" but provided no information on why
> this is.

Sorry! I misunderstood your earlier response so I didn't clarify that
portion of the commit message. Thanks for your patience.

How does this updated commit message sound? If you think it's
sufficiently clear, I can send a v3 for this patch.

This patch allows headphone plug detect and mic present
detect to be enabled at the same time. This patch implements
an irq_chip with irq_domain directly instead of using
regmap-irq, so that interrupt source line polarities can
be flipped to support irq sharing.

This patch does not add polarity flipping support within regmap-irq
because there is extra work that must be done within the irq handler
to support hotword detection. On the Chromebook Pixel, the firmware will
disconnect GPIO1 from the jack detection irq when a hotword is detected
and trigger the interrupt handler. Inside the handler, we will need to
detect this, report the hotword event, and re-connect GPIO1 to the jack
detection irq.
