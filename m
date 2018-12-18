From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Date: Tue, 18 Dec 2018 16:37:27 +0800
Message-ID: <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
References: <20181206040540.84632-1-cychiang@chromium.org> <20181214122156.GT4497@dell>
 <20181214122245.GU4497@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214122245.GU4497@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org, groeck@chromium.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, scollyer@chromium.org
List-Id: alsa-devel@alsa-project.org

+Benson, Guenter, Scott

On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 14 Dec 2018, Lee Jones wrote:
>
> > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> >
> > > Add EC host commands to control codec on EC.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanl=
y on mfd tree.
> > >  Codec driver that uses these commands will be sent separately.
> > >  Thanks!
> > >
> > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++=
++
> > >  1 file changed, 94 insertions(+)
> >
> > Would be good to have this reviewed by some more Chrome people.
>
> See this for reference:
>
>   https://lore.kernel.org/patchwork/patch/1024985/

Hi Benson and Guenter,
Could you please review this patch ?
The corresponding implementation at EC side by Scott is at
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1356185

Thanks a lot!

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
