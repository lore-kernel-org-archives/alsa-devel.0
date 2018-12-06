From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Date: Thu, 6 Dec 2018 10:36:22 +0800
Message-ID: <CAFv8NwKgspykPHWfdjapzY-wCAp8MmduKq_yhrvWct2r7yFCzA@mail.gmail.com>
References: <20181127120041.90759-1-cychiang@chromium.org> <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell> <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
 <20181205113045.GD26661@dell> <20181205113406.GE26661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205113406.GE26661@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 5, 2018 at 7:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 05 Dec 2018, Lee Jones wrote:
>
> > On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:
> >
> > > Hi Lee,
> > >
> > > I tried to apply this patch based on
> > > for-mfd-next branch of mfd tree (
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> > > Then, I tried to compile all modules by
> > >
> > >  ARCH=3Dx86_64 make allyesconfig
> > >  ARCH=3Dx86_64 make -j64
> > >
> > > There was no error.
> > > Could you please let me know what was the error when you failed to
> > > apply this patch ?
> >
> > Doesn't work for me.
> >
> > lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
> > Applying: mfd: cros_ec: Add commands to control codec
> > error: sha1 information is lacking or useless (include/linux/mfd/cros_e=
c_commands.h).
> > error: could not build fake ancestor
> > Patch failed at 0001 mfd: cros_ec: Add commands to control codec
> > Use 'git am --show-current-patch' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
>
> Not that the following lines (as seen in your patch) are not present
> in the Mainline kernel.
>
> > @@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_pro=
tect {
> >       uint8_t status;         /* Status flags (0: unlocked, 1: locked) =
*/
> >  };
>
> Do you have other patches applied to your tree?

Hi Lee,
Sorry, I see the problem.
I was using git am -3 which solves the conflict by itself.
I will resend a patch based on your for-mfd-next branch so we can keep
the patch clean.
Thanks for your time.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
