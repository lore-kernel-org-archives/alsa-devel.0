From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] ASoC: Intel: sst: Delete sst_save_shim64(); saved
 regs are never used
Date: Sat, 27 May 2017 19:35:38 +0300
Message-ID: <CAHp75VezZESJQk4kacSk3OstewTa6OFvyGDY0ogyP3dsqUSVqA@mail.gmail.com>
References: <20170526163424.2853-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526163424.2853-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, colin.king@canonical.com, o-takashi@sakamocchi.jp, sebastien.guiriec@intel.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 26, 2017 at 7:34 PM, Douglas Anderson <dianders@chromium.org> wrote:
> In commit 9a075265c6dc ("ASoC: Intel: sst: Remove unused function
> sst_restore_shim64()"), we deleted the sst_restore_shim64() since it
> was never used.  ...but a quick look at the code shows that we should
> also be able to remove the sst_save_shim64() function and the
> structure members we were storing data in.
>
> Note that the saving code (and the comments talking about how
> important it is to do the save) has been around since
> commit 336cfbb05edf ("ASoC: Intel: mrfld- add ACPI module").

While I like "-" statistics, the below I think should be preserved if
it's repeating real registers layout.

>  struct sst_shim_regs64 {
> -       u64 csr;
>         u64 pisr;
>         u64 pimr;
>         u64 isrx;
>         u64 isrd;
> -       u64 imrx;
>         u64 imrd;
>         u64 ipcx;
>         u64 ipcd;

-- 
With Best Regards,
Andy Shevchenko
