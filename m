From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Thu, 9 May 2019 14:25:10 -0700
Message-ID: <CAOReqxjg=w_ZSzUoryQYE9Poz8vF3=j6-_gNu-SMpH1oEsn2bw@mail.gmail.com>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org> <20190508073623.GT14916@sirena.org.uk>
 <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com> <20190509023247.GT14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509023247.GT14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@kernel.org>
Date: Wed, May 8, 2019 at 7:33 PM
To: Curtis Malainey
Cc: Fletcher Woodruff, Linux Kernel Mailing List, Ben Zhang, Jaroslav
Kysela, Liam Girdwood, Oder Chiou, Takashi Iwai, Curtis Malainey,
<alsa-devel@alsa-project.org>

> On Wed, May 08, 2019 at 02:39:32PM -0700, Curtis Malainey wrote:
>
> > Pixelbooks (Samus Chromebook) are the only devices that use this part.
> > Realtek has confirmed this. Therefore we only have to worry about
> > breaking ourselves. That being said I agree there is likely a better
>
> And there are no other parts that are software compatible enough to
> share the same driver?
>
the rt5676 can use this driver, but from my discussions with Realtek,
Samus is the only active consumer of this driver.

> > way to handle general abstraction here. We will need the explicit irq
> > handling since I will be following these patches up with patches that
> > enable hotwording on the codec (we will be sending the firmware to
> > linux-firmware as well that is needed for the process.)
>
> OK.  Like I said it might also be clearer split into multiple patches,
> it was just really difficult to tell what was going on with the diff
> there.
