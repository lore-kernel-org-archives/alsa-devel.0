From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] ASoC: rt5677: Avoid recursive locking in
 the DEADLOCK detector
Date: Fri, 5 Jun 2015 08:53:54 +0800
Message-ID: <CANMq1KCFwFppzAx5NiotP_0uy93Ga436PYEbhhA6iM0JCXWtaA@mail.gmail.com>
References: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
 <20150603164453.GP14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 669A5261481
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 02:53:55 +0200 (CEST)
Received: by oiww2 with SMTP id w2so43334633oiw.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 17:53:54 -0700 (PDT)
In-Reply-To: <20150603164453.GP14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Jun 4, 2015 at 12:44 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 03, 2015 at 11:53:17PM +0800, Oder Chiou wrote:
>
> > The patch is for to avoid recursive locking in the DEADLOCK detector.
> > In the driver, it encountered the warnning message of the recursive locking
> > in the function "regmap_lock_mutex".
>
> Could you be more specific about the deadlock you're seeing?  This isn't
> really enough to understand either what the problem is or why this fixes
> it.  Converting all the per-regmap mutexes into a single global mutex
> isn't an immediately obvious step.

We originally reported the issue to Realtek:

[    2.569449] =============================================
[    2.569451] [ INFO: possible recursive locking detected ]
[    2.569454] 3.18.0 #311 Tainted: G S
[    2.569456] ---------------------------------------------
[    2.569458] swapper/0/1 is trying to acquire lock:
[    2.569469]  (&map->mutex){+.+...}, at: [<ffffffc00037dba0>]
regmap_lock_mutex+0x10/0x18
[    2.569470]
[    2.569470] but task is already holding lock:
[    2.569476]  (&map->mutex){+.+...}, at: [<ffffffc00037dba0>]
regmap_lock_mutex+0x10/0x18
[    2.569478]
[    2.569478] other info that might help us debug this:
[    2.569479]  Possible unsafe locking scenario:
[    2.569479]
[    2.569480]        CPU0
[    2.569481]        ----
[    2.569484]   lock(&map->mutex);
[    2.569486]   lock(&map->mutex);
[    2.569487]
[    2.569487]  *** DEADLOCK ***
[    2.569487]
[    2.569489]  May be due to missing lock nesting notation
[    2.569489]
[    2.569491] 3 locks held by swapper/0/1:
[    2.569499]  #0:  (&dev->mutex){......}, at: [<ffffffc000369e80>]
__driver_attach+0x38/0x98
[    2.569505]  #1:  (&dev->mutex){......}, at: [<ffffffc000369ea0>]
__driver_attach+0x58/0x98
[    2.569512]  #2:  (&map->mutex){+.+...}, at: [<ffffffc00037dba0>]
regmap_lock_mutex+0x10/0x18
[    2.569513]
[    2.569513] stack backtrace:
[    2.569517] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S
3.18.0 #311
[    2.569521] Call trace:
[    2.569527] [<ffffffc000089198>] dump_backtrace+0x0/0x108
[    2.569530] [<ffffffc0000892b0>] show_stack+0x10/0x1c
[    2.569535] [<ffffffc0005e09b4>] dump_stack+0x74/0x94
[    2.569540] [<ffffffc0000d5d1c>] __lock_acquire+0x73c/0x1910
[    2.569544] [<ffffffc0000d7674>] lock_acquire+0xec/0x128
[    2.569548] [<ffffffc0005e3870>] mutex_lock_nested+0x58/0x354
[    2.569551] [<ffffffc00037db9c>] regmap_lock_mutex+0xc/0x18
[    2.569554] [<ffffffc00037ef50>] regmap_read+0x34/0x68
[    2.569559] [<ffffffc0004ddc84>] rt5677_read+0x9c/0xb4
[    2.569562] [<ffffffc00037ee8c>] _regmap_read+0xa8/0x138
[    2.569565] [<ffffffc00037ef60>] regmap_read+0x44/0x68
[    2.569569] [<ffffffc0004dd6a4>] rt5677_i2c_probe+0x25c/0x4a4
[    2.569574] [<ffffffc00042984c>] i2c_device_probe+0xfc/0x130
[    2.569577] [<ffffffc000369c58>] driver_probe_device+0xd4/0x23c
[    2.569580] [<ffffffc000369eb0>] __driver_attach+0x68/0x98
[    2.569584] [<ffffffc000368dc8>] bus_for_each_dev+0x70/0x90
[    2.569588] [<ffffffc0003697e4>] driver_attach+0x1c/0x28
[    2.569591] [<ffffffc000369400>] bus_add_driver+0xd8/0x1e0
[    2.569594] [<ffffffc00036a7f0>] driver_register+0xbc/0x10c
[    2.569598] [<ffffffc00042a4bc>] i2c_register_driver+0x48/0xac
[    2.569601] [<ffffffc0008d523c>] rt5677_i2c_driver_init+0x14/0x20
[    2.569605] [<ffffffc0000828dc>] do_one_initcall+0xf4/0x18c
[    2.569609] [<ffffffc0008a4ae8>] kernel_init_freeable+0x144/0x1e4
[    2.569613] [<ffffffc0005de3a4>] kernel_init+0x10/0xd4

It's actually a false alarm, the warning is triggered because 2 locks
are acquired, from the same location:
 - rt5677_i2c_probe calls regmap_read(rt5677->regmap, RT5677_VENDOR_ID2, &val);
 - This locks rt5677->regmap->mutex (1st lock), then calls rt5677_read
 - Since rt5677->is_dsp_mode is false,
regmap_read(rt5677->regmap_physical, reg, val); is called
 - This locks rt5677->regmap_physical->mutex (2nd lock).
 - The value is read, then both locks are released, in reverse order.

AFAIK there is no code that would acquire the locks in the reverse
order, so I don't think this can deadlock.

I suggested reworking the register read/write calls in rt5677.c to
direct them to the correct regmap earlier on (rt5677->regmap or
rt5677->regmap_physical), before locks are acquired. But the patch
above also fixes the issue (that is, it removes the warning).

Thanks,

Nicolas
