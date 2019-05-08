From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Wed, 8 May 2019 14:39:32 -0700
Message-ID: <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org> <20190508073623.GT14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508073623.GT14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@kernel.org>
Date: Wed, May 8, 2019 at 12:36 AM
To: Fletcher Woodruff
Cc: <linux-kernel@vger.kernel.org>, Ben Zhang, Jaroslav Kysela, Liam
Girdwood, Oder Chiou, Takashi Iwai, Curtis Malainey,
<alsa-devel@alsa-project.org>

> On Tue, May 07, 2019 at 04:01:13PM -0600, Fletcher Woodruff wrote:
>
> > This patch does not add polarity flipping support within regmap-irq
> > because there is extra work that must be done within the irq handler
> > to support hotword detection. On the Chromebook Pixel, the firmware will
> > disconnect GPIO1 from the jack detection irq when a hotword is detected
> > and trigger the interrupt handler. Inside the handler, we will need to
> > detect this, report the hotword event, and re-connect GPIO1 to the jack
> > detection irq.
>
> Please have a conversation with your firmware team about the concept of
> abstraction - this is clearly a problematic thing to do as it's causing
> the state of the system to change for devices that are mostly managed
> from the operating system.  It's not clear to me that this shouldn't be
> split off somehow so that it doesn't impact other systems using this
> hardware.
>
Pixelbooks (Samus Chromebook) are the only devices that use this part.
Realtek has confirmed this. Therefore we only have to worry about
breaking ourselves. That being said I agree there is likely a better
way to handle general abstraction here. We will need the explicit irq
handling since I will be following these patches up with patches that
enable hotwording on the codec (we will be sending the firmware to
linux-firmware as well that is needed for the process.)
