From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Date: Wed, 5 Dec 2018 11:34:06 +0000
Message-ID: <20181205113406.GE26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
 <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
 <20181205113045.GD26661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205113045.GD26661@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, 05 Dec 2018, Lee Jones wrote:

> On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:
> 
> > Hi Lee,
> > 
> > I tried to apply this patch based on
> > for-mfd-next branch of mfd tree (
> > git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> > Then, I tried to compile all modules by
> > 
> >  ARCH=x86_64 make allyesconfig
> >  ARCH=x86_64 make -j64
> > 
> > There was no error.
> > Could you please let me know what was the error when you failed to
> > apply this patch ?
> 
> Doesn't work for me.
> 
> lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
> Applying: mfd: cros_ec: Add commands to control codec
> error: sha1 information is lacking or useless (include/linux/mfd/cros_ec_commands.h).
> error: could not build fake ancestor
> Patch failed at 0001 mfd: cros_ec: Add commands to control codec
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

Not that the following lines (as seen in your patch) are not present
in the Mainline kernel.

> @@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_protect {
>  	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
>  };

Do you have other patches applied to your tree?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
