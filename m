From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
 class key for lockdep
Date: Tue, 30 Jun 2015 12:56:56 +0800
Message-ID: <20150630045655.GA38694@google.com>
References: <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
 <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
 <5591414D.6080802@metafoo.de>
 <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com>
 <559153A3.1000006@metafoo.de>
 <20150629153411.GG11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 463852606B0
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 06:57:04 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so115804241pac.2
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 21:57:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150629153411.GG11162@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2015 at 04:34:11PM +0100, Mark Brown wrote:
> On Mon, Jun 29, 2015 at 04:18:11PM +0200, Lars-Peter Clausen wrote:
> > Leaves us pretty much with only two options. Either add a lock key pointer
> > to regmap_config which needs to be manually initialized. Or wrap all
> > regmap_init() variants to create a static lock key. I'd slightly prefer the
> > later. We can avoid most of the boiler-plate code by using some helper
> > macros to generate the wrappers.
> 
> It's better to keep the bodges in the core, yes.

Partial attempt below. Of course all other _init functions will need to be
converted as well. I'd like to get feedback before I do the rest of the work.
The macro part is quite repetitive and I don't think it can be simplified.

Thanks!

>8------------------------------------------------------8<
Subject: [PATCH] regmap: Use different lockdep classes for each regmap init
 call

Lockdep validator complains about recursive locking and deadlock
when two different regmap instances are called in a nested order.
That happens anytime a regmap read/write call needs to access
another regmap.

This is because, for performance reason, lockdep groups all locks
initialized by the same mutex_init() in the same lock class.
Therefore all regmap mutexes are in the same lock class, leading
to lockdep "nested locking" warnings if a regmap accesses another
regmap.

In general, it is impossible to establish in advance the hierarchy
of regmaps, so we make sure that each regmap init call initializes
its own static lock_class_key. This is done by wrapping all
regmap_init calls into macros.

This also allows us to give meaningful names to the lock_class_key.
For example, in rt5677 case, we have in /proc/lockdep_chains:
irq_context: 0
[ffffffc0018d2198] &dev->mutex
[ffffffc0018d2198] &dev->mutex
[ffffffc001bd7f60] rt5677:5104:(&rt5677_regmap)->_lock
[ffffffc001bd7f58] rt5677:5096:(&rt5677_regmap_physical)->_lock
[ffffffc001b95448] &(&base->lock)->rlock

The above would have resulted in a lockdep recursive warning
previously. This is not the case anymore as the lockdep validator
now clearly identifies the 2 locks as separate.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/base/regmap/regmap-i2c.c | 22 ++++++----
 drivers/base/regmap/regmap.c     | 31 +++++++++-----
 include/linux/regmap.h           | 91 ++++++++++++++++++++++++++++++++++------
 3 files changed, 113 insertions(+), 31 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 053150a..c1f9396 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -198,17 +198,20 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_i2c(struct i2c_client *i2c,
-			       const struct regmap_config *config)
+struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
 {
 	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
 
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return regmap_init(&i2c->dev, bus, &i2c->dev, config);
+	return __regmap_init(&i2c->dev, bus, &i2c->dev, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_i2c);
+EXPORT_SYMBOL_GPL(__regmap_init_i2c);
 
 /**
  * devm_regmap_init_i2c(): Initialise managed register map
@@ -220,16 +223,19 @@ EXPORT_SYMBOL_GPL(regmap_init_i2c);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config)
+struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
 {
 	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
 
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return devm_regmap_init(&i2c->dev, bus, &i2c->dev, config);
+	return __devm_regmap_init(&i2c->dev, bus, &i2c->dev, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_i2c);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2f8a81..b8e26af 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -526,10 +526,12 @@ static enum regmap_endian regmap_get_val_endian(struct device *dev,
  * a struct regmap.  This function should generally not be called
  * directly, it should be called by bus-specific init functions.
  */
-struct regmap *regmap_init(struct device *dev,
-			   const struct regmap_bus *bus,
-			   void *bus_context,
-			   const struct regmap_config *config)
+struct regmap *__regmap_init(struct device *dev,
+			     const struct regmap_bus *bus,
+			     void *bus_context,
+			     const struct regmap_config *config,
+			     struct lock_class_key *lock_key,
+			     const char *lock_name)
 {
 	struct regmap *map;
 	int ret = -EINVAL;
@@ -555,10 +557,14 @@ struct regmap *regmap_init(struct device *dev,
 			spin_lock_init(&map->spinlock);
 			map->lock = regmap_lock_spinlock;
 			map->unlock = regmap_unlock_spinlock;
+			lockdep_set_class_and_name(&map->spinlock,
+						lock_key, lock_name);
 		} else {
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
 			map->unlock = regmap_unlock_mutex;
+			lockdep_set_class_and_name(&map->mutex,
+						lock_key, lock_name);
 		}
 		map->lock_arg = map;
 	}
@@ -898,7 +904,7 @@ err_map:
 err:
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(regmap_init);
+EXPORT_SYMBOL_GPL(__regmap_init);
 
 static void devm_regmap_release(struct device *dev, void *res)
 {
@@ -918,10 +924,12 @@ static void devm_regmap_release(struct device *dev, void *res)
  * directly, it should be called by bus-specific init functions.  The
  * map will be automatically freed by the device management code.
  */
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				void *bus_context,
-				const struct regmap_config *config)
+struct regmap *__devm_regmap_init(struct device *dev,
+				  const struct regmap_bus *bus,
+				  void *bus_context,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name)
 {
 	struct regmap **ptr, *regmap;
 
@@ -929,7 +937,8 @@ struct regmap *devm_regmap_init(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	regmap = regmap_init(dev, bus, bus_context, config);
+	regmap = __regmap_init(dev, bus, bus_context, config,
+			lock_key, lock_name);
 	if (!IS_ERR(regmap)) {
 		*ptr = regmap;
 		devres_add(dev, ptr);
@@ -939,7 +948,7 @@ struct regmap *devm_regmap_init(struct device *dev,
 
 	return regmap;
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init);
+EXPORT_SYMBOL_GPL(__devm_regmap_init);
 
 static void regmap_field_init(struct regmap_field *rm_field,
 	struct regmap *regmap, struct reg_field reg_field)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1318e935..9505bca 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -17,6 +17,7 @@
 #include <linux/rbtree.h>
 #include <linux/err.h>
 #include <linux/bug.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct device;
@@ -323,14 +324,18 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 };
 
-struct regmap *regmap_init(struct device *dev,
-			   const struct regmap_bus *bus,
-			   void *bus_context,
-			   const struct regmap_config *config);
+struct regmap *__regmap_init(struct device *dev,
+			     const struct regmap_bus *bus,
+			     void *bus_context,
+			     const struct regmap_config *config,
+			     struct lock_class_key *lock_key,
+			     const char *lock_name);
 int regmap_attach_dev(struct device *dev, struct regmap *map,
 				 const struct regmap_config *config);
-struct regmap *regmap_init_i2c(struct i2c_client *i2c,
-			       const struct regmap_config *config);
+struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 struct regmap *regmap_init_spi(struct spi_device *dev,
 			       const struct regmap_config *config);
 struct regmap *regmap_init_spmi_base(struct spmi_device *dev,
@@ -341,12 +346,16 @@ struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 				    void __iomem *regs,
 				    const struct regmap_config *config);
 
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				void *bus_context,
-				const struct regmap_config *config);
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config);
+struct regmap *__devm_regmap_init(struct device *dev,
+				  const struct regmap_bus *bus,
+				  void *bus_context,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name);
+struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
 struct regmap *devm_regmap_init_spi(struct spi_device *dev,
 				    const struct regmap_config *config);
 struct regmap *devm_regmap_init_spmi_base(struct spmi_device *dev,
@@ -392,6 +401,64 @@ static inline struct regmap *devm_regmap_init_mmio(struct device *dev,
 	return devm_regmap_init_mmio_clk(dev, NULL, regs, config);
 }
 
+#ifdef CONFIG_LOCKDEP
+#define regmap_init(dev, bus, bus_context, config)			\
+(									\
+	({								\
+		static struct lock_class_key _key;			\
+		__regmap_init(dev, bus, bus_context, config,		\
+			&_key,						\
+			KBUILD_BASENAME ":"				\
+			__stringify(__LINE__) ":"			\
+			"(" #config ")->_lock");			\
+	})								\
+)
+#define regmap_init_i2c(i2c, config)					\
+(									\
+	({								\
+		static struct lock_class_key _key;			\
+		__regmap_init_i2c(i2c, config,				\
+				&_key,					\
+				KBUILD_BASENAME ":"			\
+				__stringify(__LINE__) ":"		\
+				"(" #config ")->_lock");		\
+	})								\
+)
+
+#define devm_regmap_init(dev, bus, bus_context, config)			\
+(									\
+	({								\
+		static struct lock_class_key _key;			\
+		__devm_regmap_init(dev, bus, bus_context, config,	\
+				&_key,					\
+				KBUILD_BASENAME ":"			\
+				__stringify(__LINE__) ":"		\
+				"(" #config ")->_lock");		\
+	})								\
+)
+#define devm_regmap_init_i2c(i2c, config)				\
+(									\
+	({								\
+		static struct lock_class_key _key;			\
+		__devm_regmap_init_i2c(i2c, config,			\
+				&_key,					\
+				KBUILD_BASENAME ":"			\
+				__stringify(__LINE__) ":"		\
+				"(" #config ")->_lock");		\
+	})								\
+)
+#else
+#define regmap_init(dev, bus, bus_context, config)			\
+	__regmap_init(dev, bus, bus_context, config, NULL, NULL)
+#define regmap_init_i2c(dev, bus, bus_context, config)			\
+	__regmap_init_i2c(dev, bus, bus_context, config, NULL, NULL)
+
+#define devm_regmap_init(dev, bus, bus_context, config)			\
+	__devm_regmap_init(dev, bus, bus_context, config, NULL, NULL)
+#define devm_regmap_init_i2c(dev, bus, bus_context, config)		\
+	__devm_regmap_init_i2c(dev, bus, bus_context, config, NULL, NULL)
+#endif
+
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
2.4.3.573.g4eafbef
