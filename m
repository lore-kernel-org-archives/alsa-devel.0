From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] ASoC: Intel: sst: Delete sst_save_shim64(); saved
 regs are never used
Date: Tue, 30 May 2017 09:55:13 -0700
Message-ID: <CAD=FV=UOpPiEHoi9hcU7cDNwHrj74z4PSgeB8cAZ7VLg5en3xA@mail.gmail.com>
References: <20170526163424.2853-1-dianders@chromium.org> <CAHp75VezZESJQk4kacSk3OstewTa6OFvyGDY0ogyP3dsqUSVqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VezZESJQk4kacSk3OstewTa6OFvyGDY0ogyP3dsqUSVqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, colin.king@canonical.com, o-takashi@sakamocchi.jp, sebastien.guiriec@intel.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, May 27, 2017 at 9:35 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 26, 2017 at 7:34 PM, Douglas Anderson <dianders@chromium.org> wrote:
>> In commit 9a075265c6dc ("ASoC: Intel: sst: Remove unused function
>> sst_restore_shim64()"), we deleted the sst_restore_shim64() since it
>> was never used.  ...but a quick look at the code shows that we should
>> also be able to remove the sst_save_shim64() function and the
>> structure members we were storing data in.
>>
>> Note that the saving code (and the comments talking about how
>> important it is to do the save) has been around since
>> commit 336cfbb05edf ("ASoC: Intel: mrfld- add ACPI module").
>
> While I like "-" statistics, the below I think should be preserved if
> it's repeating real registers layout.
>
>>  struct sst_shim_regs64 {
>> -       u64 csr;
>>         u64 pisr;
>>         u64 pimr;
>>         u64 isrx;
>>         u64 isrd;
>> -       u64 imrx;
>>         u64 imrd;
>>         u64 ipcx;
>>         u64 ipcd;

Yup, it does seem to follow real hardware.  From the header file:

#define SST_CSR 0x00
#define SST_PISR 0x08
#define SST_PIMR 0x10
#define SST_ISRX 0x18
#define SST_ISRD 0x20
#define SST_IMRX 0x28
#define SST_IMRD 0x30
#define SST_IPCX 0x38 /* IPC IA -> SST */
#define SST_IPCD 0x40 /* IPC SST -> IA */
...

Thus, I'm happy to rework the patch to not delete the elements from
the structure.  Just for curiosity's sake, Let's see how much memory
that will waste (check how much these are used).

...umm, wait a second.  We don't even use the dang structure anymore!
So I guess an even cleaner solution is to totally delete
shim_regs64...  I'll send out a v2 with an even better diffstat and
with totally avoiding a devm allocation of a 136 byte structure.  :)

Posted a v2 here: https://patchwork.kernel.org/patch/9754923/

-Doug
