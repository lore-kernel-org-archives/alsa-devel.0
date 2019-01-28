From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Date: Mon, 28 Jan 2019 13:48:22 +0800
Message-ID: <CAMz4ku+eiqPAETMhGJ3=fQKfzJEORvjmr+51-oJZ5B5AyQcvkw@mail.gmail.com>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz> <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz> <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz> <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
 <s5h1s51120e.wl-tiwai@suse.de> <s5hwomtyr6o.wl-tiwai@suse.de>
 <CAMz4kuKZOpAXG=Lwii5Cb6q2EKoMUJOEmDz8X=dmVv+JivWf=w@mail.gmail.com> <s5hk1iszy4o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk1iszy4o.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Leo Yan <leo.yan@linaro.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, bgoswami@codeaurora.org, sr@denx.de, gustavo@embeddedor.com, Phil Burk <philburk@google.com>, Matthew Wilcox <willy@infradead.org>, mchehab+samsung@kernel.org, sboyd@kernel.org, Vinod Koul <vkoul@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, anna-maria@linutronix.de, Jon Corbet <corbet@lwn.net>, Jeffery Miller <jmiller@neverware.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, joe@perches.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, colyli@suse
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Jan 2019 at 21:04, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > Erm, obviously it's not enough.  Each attach / detach needs to manage
> > > the refcount, too, for covering the cases above.  It can re-use the
> > > PCM mmap_refount, though.
> >
> > But we've used the DMA buffer file's refcounting to manage the DMA
> > buffer. So is this not enough?
>
> Unless you manage the PCM substream refcount (or block the state
> change), the PCM stream itself can be released (or re-setup) freely.
>

OK. Thanks for your comments.

-- 
Baolin Wang
Best Regards
