From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Date: Tue, 18 Dec 2018 08:52:34 +0000
Message-ID: <20181218084307.GH4497@dell>
References: <20181206040540.84632-1-cychiang@chromium.org>
 <20181214122156.GT4497@dell>
 <20181214122245.GU4497@dell>
 <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: bleung@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, scollyer@chromium.org
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Dec 2018, Cheng-yi Chiang wrote:

> +Benson, Guenter, Scott
> 
> On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 14 Dec 2018, Lee Jones wrote:
> >
> > > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> > >
> > > > Add EC host commands to control codec on EC.
> > > >
> > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > ---
> > > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> > > >  Codec driver that uses these commands will be sent separately.
> > > >  Thanks!
> > > >
> > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > >  1 file changed, 94 insertions(+)
> > >
> > > Would be good to have this reviewed by some more Chrome people.
> >
> > See this for reference:
> >
> >   https://lore.kernel.org/patchwork/patch/1024985/
> 
> Hi Benson and Guenter,
> Could you please review this patch ?

You haven't sent them the patch.

Please resubmit as a [RESEND] and add them as recipients.

> The corresponding implementation at EC side by Scott is at
> https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1356185
> 
> Thanks a lot!
> 
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
