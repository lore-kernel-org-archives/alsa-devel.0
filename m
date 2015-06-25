From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [RFC PATCH 2/2] ASoC: rt5677: Add lockdep class to silence lockdep warnings
Date: Thu, 25 Jun 2015 17:35:04 +0800
Message-ID: <1435224904-35517-2-git-send-email-drinkcat@chromium.org>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Accessing rt5677->regmap requires read/write operations on
another regmap (rt5677->regmap_physical), which causes the
lockdep detector to throw a false warning, as both regmaps
are using the same lockdep class by default. Introduce a new
class for rt5677->regmap to silence this warning.

Sample warning:
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

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5677.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 31d969a..3007d13 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4998,6 +4998,7 @@ static const struct regmap_config rt5677_regmap_physical = {
 	.num_ranges = ARRAY_SIZE(rt5677_ranges),
 };
 
+static struct lock_class_key rt5677_regmap_key;
 static const struct regmap_config rt5677_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -5015,6 +5016,10 @@ static const struct regmap_config rt5677_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(rt5677_reg),
 	.ranges = rt5677_ranges,
 	.num_ranges = ARRAY_SIZE(rt5677_ranges),
+
+	/* Silence incorrect lockdep warnings, as rt5677_regmap_physical is
+	 * accessed from within rt5677_regmap. */
+	.lockdep_lock_class_key = &rt5677_regmap_key,
 };
 
 static const struct i2c_device_id rt5677_i2c_id[] = {
-- 
2.4.3.573.g4eafbef
