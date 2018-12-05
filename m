From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Date: Wed, 5 Dec 2018 11:30:45 +0000
Message-ID: <20181205113045.GD26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
 <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:

> Hi Lee,
> 
> I tried to apply this patch based on
> for-mfd-next branch of mfd tree (
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> Then, I tried to compile all modules by
> 
>  ARCH=x86_64 make allyesconfig
>  ARCH=x86_64 make -j64
> 
> There was no error.
> Could you please let me know what was the error when you failed to
> apply this patch ?

Doesn't work for me.

lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
Applying: mfd: cros_ec: Add commands to control codec
error: sha1 information is lacking or useless (include/linux/mfd/cros_ec_commands.h).
error: could not build fake ancestor
Patch failed at 0001 mfd: cros_ec: Add commands to control codec
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> On Tue, Dec 4, 2018 at 9:46 AM Cheng-yi Chiang <cychiang@chromium.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 7:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 28 Nov 2018, Lee Jones wrote:
> > >
> > > > On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> > > >
> > > > > Add EC host commands to control codec on EC.
> > > > >
> > > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > > ---
> > > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 94 insertions(+)
> > > >
> > > > Applied, thanks.
> > >
> > > Turns out that this does not actually apply.
> > >
> > > What is it based on?
> >
> > Hi Lee,
> > I am sorry about that!
> > The patch series was based on Mark Brown's tree (
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git )
> > for-next branch.
> > I will rebase it on upstream master branch in v2 when I address other
> > comments in codec driver.
> > Thanks!
> >
> > >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
