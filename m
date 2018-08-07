From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of
 rt5677_of_match.data
Date: Tue, 7 Aug 2018 13:23:06 -0700
Message-ID: <20180807202306.GE160295@google.com>
References: <20180807171940.150507-1-mka@chromium.org>
 <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2018 at 10:13:47PM +0300, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 10:19 -0700, Matthias Kaehlcke wrote:
> > The driver expects to find the device id in rt5677_of_match.data,
> > however
> > it is currently assigned to rt5677_of_match.type. Fix this.
> > 
> > The problem was found with the help of clang:
> >   sound/soc/codecs/rt5677.c:5010:36: warning: expression which
> > evaluates to
> >   zero treated as a null pointer constant of type 'const void *'
> >   [-Wnon-literal-null-conversion]
> >     { .compatible = "realtek,rt5677", RT5677 },
> >                                       ^~~~~~
> > 
> > Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module
> > sources")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> While this is correct fix, it seems it was never used.

Or it was used but no problem was noticed because .data was already
0, which happens to be the value of RT5677.

> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks

Matthias
