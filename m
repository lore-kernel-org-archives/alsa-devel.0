From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [RFC PATCH 1/2] regmap: add configurable lock class key for lockdep
Date: Thu, 25 Jun 2015 17:35:03 +0800
Message-ID: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Antti Palosaari <crope@iki.fi>

Lockdep validator complains about recursive locking and deadlock
when two different regmap instances are called in a nested order.
That happens anytime a regmap read/write call needs to access
another regmap.

This is because, for performance reason, lockdep groups all locks
initialized by the same mutex_init() in the same lock class.
Therefore all regmap mutexes are in the same lock class, leading
to lockdep "nested locking" warnings if a regmap accesses another
regmap. However, depending on the specifics of the driver, this
can be perfectly safe (e.g. if there is a clear hierarchy between
a "master" regmap that uses another "slave" regmap). In these
cases, the warning is false and should be silenced.

As a solution, add configuration option to pass custom lock class
key for lockdep validator, to be used in the regmap that needs to
access another regmap. This removes the need for uglier workarounds
in drivers, just to silence this warning (e.g. add custom mutex
lock/unlock functions).

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Antti Palosaari <crope@iki.fi>
[drinkcat@chromium.org: Reworded the commit message and regmap.h
documentation]
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

I'm trying to revive Antti's patch [1], as we are hitting similar issue
with rt5677 driver. I only updated the commit message and documentation,
I kept both Signed-off-by and From lines, with a small note highlighting
my changes, let me know if that's not appropriate.

One issue that was raised by Mark at the time is that a per-regmap_config
lock class might not be enough (Mark mentioned clocks as an example). The
current implementation should be good enough as long as the clock regmaps
do not access each other. If this is a problem, maybe we should consider
replacing lockdep_lock_class_key by a boolean use_own_lock_class that would
allocate/use a per regmap instance lock class, or have devm_regmap_init
take an extra parameter specifying the lock class.

[1] https://www.mail-archive.com/linux-media%40vger.kernel.org/msg83490.html

 drivers/base/regmap/regmap.c | 3 +++
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6273ff0..f5d1131 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -560,6 +560,9 @@ struct regmap *regmap_init(struct device *dev,
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
 			map->unlock = regmap_unlock_mutex;
+			if (config->lockdep_lock_class_key)
+				lockdep_set_class(&map->mutex,
+						config->lockdep_lock_class_key);
 		}
 		map->lock_arg = map;
 	}
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 116655d..09aaaf5 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -135,6 +135,12 @@ typedef void (*regmap_unlock)(void *);
  * @lock_arg:	  this field is passed as the only argument of lock/unlock
  *		  functions (ignored in case regular lock/unlock functions
  *		  are not overridden).
+ * @lock_class_key: Custom lock class key for lockdep validator. Use that to
+ *                  silence false lockdep nested locking warning, when this
+ *                  regmap needs to access another regmap during read/write
+ *                  operations (directly in read/write functions, or
+ *                  indirectly, e.g. through bus accesses).
+ *                  Valid only when regmap default mutex locking is used.
  * @reg_read:	  Optional callback that if filled will be used to perform
  *           	  all the reads from the registers. Should only be provided for
  *		  devices whose read operation cannot be represented as a simple
@@ -198,6 +204,7 @@ struct regmap_config {
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg;
+	struct lock_class_key *lockdep_lock_class_key;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
-- 
2.4.3.573.g4eafbef
