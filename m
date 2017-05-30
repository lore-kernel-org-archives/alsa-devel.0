From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH v2] ASoC: Intel: sst: Delete
 sst_shim_regs64; saved regs are never used
Date: Tue, 30 May 2017 10:18:46 -0700
Message-ID: <CAD=FV=Ve5qs_GV52Qxr2MD8O8uO6eHTdwYUXcv6TddZnqzzjGQ@mail.gmail.com>
References: <20170530165130.15011-1-dianders@chromium.org>
 <CAHp75Ve2nRf5SdFUTcAPwpYSKWvG4fyHKMJUzoVcg73NQp0xYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9371E266D5D
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 19:18:48 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id e127so106669772wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 10:18:48 -0700 (PDT)
In-Reply-To: <CAHp75Ve2nRf5SdFUTcAPwpYSKWvG4fyHKMJUzoVcg73NQp0xYQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, naveen.m@intel.com, Colin King <colin.king@canonical.com>, =?UTF-8?B?5Z2C5pys6LK05Y+y?= <o-takashi@sakamocchi.jp>, sebastien.guiriec@intel.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, May 30, 2017 at 10:06 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 30, 2017 at 7:51 PM, Douglas Anderson <dianders@chromium.org> wrote:
>> In commit 9a075265c6dc ("ASoC: Intel: sst: Remove unused function
>> sst_restore_shim64()"), we deleted the sst_restore_shim64() since it
>> was never used.  ...but a quick look at the code shows that we should
>> also be able to remove the sst_save_shim64() function and the
>> structure members we were storing data in.
>>
>> Once we delete sst_save_shim64() there are no longer any users of the
>> 'sst_shim_regs64' structure.  That means we can delete it completely
>> and also avoid allocating memory for it.  This saves a whopping 136
>> bytes of devm allocated memory.  We also get the nice benefit of
>> avoiding an error path in the init code.
>>
>> Note that the saving code that we're removing (and the comments
>> talking about how important it is to do the save) has been around
>> since commit 336cfbb05edf ("ASoC: Intel: mrfld- add ACPI module").
>
> I like it!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> P.S. Perhaps there are more leftovers or dead code?

Thanks!

It's very possible that there is more dead code lingering, but since I
can't do much more than compile test this it probably makes sense for
someone more familiar with the driver to keep digging?

-Doug
