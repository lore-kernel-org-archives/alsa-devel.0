From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Date: Tue, 4 Dec 2018 09:46:27 +0800
Message-ID: <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
References: <20181127120041.90759-1-cychiang@chromium.org> <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203111919.GL26661@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 3, 2018 at 7:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 28 Nov 2018, Lee Jones wrote:
>
> > On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> >
> > > Add EC host commands to control codec on EC.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++=
++
> > >  1 file changed, 94 insertions(+)
> >
> > Applied, thanks.
>
> Turns out that this does not actually apply.
>
> What is it based on?

Hi Lee,
I am sorry about that!
The patch series was based on Mark Brown's tree (
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git )
for-next branch.
I will rebase it on upstream master branch in v2 when I address other
comments in codec driver.
Thanks!

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
