From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: mmio: Convert to regmap_bus and fix
	accessor usage" to the asoc tree
Date: Mon, 22 Feb 2016 12:15:03 +0900
Message-ID: <E1aXgxj-0005ui-UE@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C69E4265862
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:15:11 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>Johannes Berg <johannes@sipsolutions.net>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: mmio: Convert to regmap_bus and fix accessor usage

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 922a9f936e40001f9b921379aab90047d5990923 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 27 Jan 2016 04:50:07 +0000
Subject: [PATCH] regmap: mmio: Convert to regmap_bus and fix accessor usage

Currently regmap-mmio uses the __raw accessors to read and write from
memory.  This is not safe as these interact poorly with spinlocks and
are not guaranteed to generate emulated instructions on at least ARM
where regmap is commonly used.  The APIs that are provided all provide
some byte swapping so this is difficult to do with the current
regmap-mmio implementation which attempts to use the regmap core byte
swapping.

We can fix this by modernising the MMIO implementation to use
reg_read() and reg_write() operations which were added after the API was
implemented and pass simple unsigned integers through to the bus, making
use of the formatting provided by the I/O accessors using a similar
pattern to that used by the core.  This will be less efficient for block
I/O operations since we now enable and disable any required clocks per
register but it is not clear that any users of regmap-mmio actually use
block I/O and there is room to optimise later.

This removes support for big endian I/O on 64 bit registers since no I/O
accessors are provided, no current users were found and support can be
added easily once they are available.

In addition make the default endianness little endian.  This was the
behaviour prior to 29bb45f25ff305 (regmap-mmio: Use native endianness
for read/write) and is the behaviour desired by most existing users, the
users have been audited and those that need native endianness converted
to request it explicitly.  Previously native was documented as the
default but due to the byte swapping in the accessors this was not
correctly implemented.

Fixes: 29bb45f25ff305 (regmap-mmio: Use native endianness for read/write)
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Tested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-mmio.c | 259 ++++++++++++++++++++------------------
 1 file changed, 139 insertions(+), 120 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 8812bfb..7526906 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -25,26 +25,14 @@
 
 struct regmap_mmio_context {
 	void __iomem *regs;
-	unsigned reg_bytes;
 	unsigned val_bytes;
-	unsigned pad_bytes;
 	struct clk *clk;
-};
 
-static inline void regmap_mmio_regsize_check(size_t reg_size)
-{
-	switch (reg_size) {
-	case 1:
-	case 2:
-	case 4:
-#ifdef CONFIG_64BIT
-	case 8:
-#endif
-		break;
-	default:
-		BUG();
-	}
-}
+	void (*reg_write)(struct regmap_mmio_context *ctx,
+			  unsigned int reg, unsigned int val);
+	unsigned int (*reg_read)(struct regmap_mmio_context *ctx,
+			         unsigned int reg);
+};
 
 static int regmap_mmio_regbits_check(size_t reg_bits)
 {
@@ -88,72 +76,62 @@ static int regmap_mmio_get_min_stride(size_t val_bits)
 	return min_stride;
 }
 
-static inline void regmap_mmio_count_check(size_t count, u32 offset)
+static void regmap_mmio_write8(struct regmap_mmio_context *ctx,
+				unsigned int reg,
+				unsigned int val)
+{
+	writeb(val, ctx->regs + reg);
+}
+
+static void regmap_mmio_write16le(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
 {
-	BUG_ON(count <= offset);
+	writew(val, ctx->regs + reg);
 }
 
-static inline unsigned int
-regmap_mmio_get_offset(const void *reg, size_t reg_size)
+static void regmap_mmio_write16be(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
 {
-	switch (reg_size) {
-	case 1:
-		return *(u8 *)reg;
-	case 2:
-		return *(u16 *)reg;
-	case 4:
-		return *(u32 *)reg;
+	iowrite16be(val, ctx->regs + reg);
+}
+
+static void regmap_mmio_write32le(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	writel(val, ctx->regs + reg);
+}
+
+static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	iowrite32be(val, ctx->regs + reg);
+}
+
 #ifdef CONFIG_64BIT
-	case 8:
-		return *(u64 *)reg;
-#endif
-	default:
-		BUG();
-	}
+static void regmap_mmio_write64le(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	writeq(val, ctx->regs + reg);
 }
+#endif
 
-static int regmap_mmio_gather_write(void *context,
-				    const void *reg, size_t reg_size,
-				    const void *val, size_t val_size)
+static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct regmap_mmio_context *ctx = context;
-	unsigned int offset;
 	int ret;
 
-	regmap_mmio_regsize_check(reg_size);
-
 	if (!IS_ERR(ctx->clk)) {
 		ret = clk_enable(ctx->clk);
 		if (ret < 0)
 			return ret;
 	}
 
-	offset = regmap_mmio_get_offset(reg, reg_size);
-
-	while (val_size) {
-		switch (ctx->val_bytes) {
-		case 1:
-			__raw_writeb(*(u8 *)val, ctx->regs + offset);
-			break;
-		case 2:
-			__raw_writew(*(u16 *)val, ctx->regs + offset);
-			break;
-		case 4:
-			__raw_writel(*(u32 *)val, ctx->regs + offset);
-			break;
-#ifdef CONFIG_64BIT
-		case 8:
-			__raw_writeq(*(u64 *)val, ctx->regs + offset);
-			break;
-#endif
-		default:
-			/* Should be caught by regmap_mmio_check_config */
-			BUG();
-		}
-		val_size -= ctx->val_bytes;
-		val += ctx->val_bytes;
-		offset += ctx->val_bytes;
-	}
+	ctx->reg_write(ctx, reg, val);
 
 	if (!IS_ERR(ctx->clk))
 		clk_disable(ctx->clk);
@@ -161,59 +139,56 @@ static int regmap_mmio_gather_write(void *context,
 	return 0;
 }
 
-static int regmap_mmio_write(void *context, const void *data, size_t count)
+static unsigned int regmap_mmio_read8(struct regmap_mmio_context *ctx,
+				      unsigned int reg)
 {
-	struct regmap_mmio_context *ctx = context;
-	unsigned int offset = ctx->reg_bytes + ctx->pad_bytes;
+	return readb(ctx->regs + reg);
+}
+
+static unsigned int regmap_mmio_read16le(struct regmap_mmio_context *ctx,
+				         unsigned int reg)
+{
+	return readw(ctx->regs + reg);
+}
+
+static unsigned int regmap_mmio_read16be(struct regmap_mmio_context *ctx,
+				         unsigned int reg)
+{
+	return ioread16be(ctx->regs + reg);
+}
+
+static unsigned int regmap_mmio_read32le(struct regmap_mmio_context *ctx,
+				         unsigned int reg)
+{
+	return readl(ctx->regs + reg);
+}
 
-	regmap_mmio_count_check(count, offset);
+static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
+				         unsigned int reg)
+{
+	return ioread32be(ctx->regs + reg);
+}
 
-	return regmap_mmio_gather_write(context, data, ctx->reg_bytes,
-					data + offset, count - offset);
+#ifdef CONFIG_64BIT
+static unsigned int regmap_mmio_read64le(struct regmap_mmio_context *ctx,
+				         unsigned int reg)
+{
+	return readq(ctx->regs + reg);
 }
+#endif
 
-static int regmap_mmio_read(void *context,
-			    const void *reg, size_t reg_size,
-			    void *val, size_t val_size)
+static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct regmap_mmio_context *ctx = context;
-	unsigned int offset;
 	int ret;
 
-	regmap_mmio_regsize_check(reg_size);
-
 	if (!IS_ERR(ctx->clk)) {
 		ret = clk_enable(ctx->clk);
 		if (ret < 0)
 			return ret;
 	}
 
-	offset = regmap_mmio_get_offset(reg, reg_size);
-
-	while (val_size) {
-		switch (ctx->val_bytes) {
-		case 1:
-			*(u8 *)val = __raw_readb(ctx->regs + offset);
-			break;
-		case 2:
-			*(u16 *)val = __raw_readw(ctx->regs + offset);
-			break;
-		case 4:
-			*(u32 *)val = __raw_readl(ctx->regs + offset);
-			break;
-#ifdef CONFIG_64BIT
-		case 8:
-			*(u64 *)val = __raw_readq(ctx->regs + offset);
-			break;
-#endif
-		default:
-			/* Should be caught by regmap_mmio_check_config */
-			BUG();
-		}
-		val_size -= ctx->val_bytes;
-		val += ctx->val_bytes;
-		offset += ctx->val_bytes;
-	}
+	*val = ctx->reg_read(ctx, reg);
 
 	if (!IS_ERR(ctx->clk))
 		clk_disable(ctx->clk);
@@ -232,14 +207,11 @@ static void regmap_mmio_free_context(void *context)
 	kfree(context);
 }
 
-static struct regmap_bus regmap_mmio = {
+static const struct regmap_bus regmap_mmio = {
 	.fast_io = true,
-	.write = regmap_mmio_write,
-	.gather_write = regmap_mmio_gather_write,
-	.read = regmap_mmio_read,
+	.reg_write = regmap_mmio_write,
+	.reg_read = regmap_mmio_read,
 	.free_context = regmap_mmio_free_context,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 };
 
 static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
@@ -265,24 +237,71 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 	if (config->reg_stride < min_stride)
 		return ERR_PTR(-EINVAL);
 
-	switch (config->reg_format_endian) {
-	case REGMAP_ENDIAN_DEFAULT:
-	case REGMAP_ENDIAN_NATIVE:
-		break;
-	default:
-		return ERR_PTR(-EINVAL);
-	}
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
 	ctx->regs = regs;
 	ctx->val_bytes = config->val_bits / 8;
-	ctx->reg_bytes = config->reg_bits / 8;
-	ctx->pad_bytes = config->pad_bits / 8;
 	ctx->clk = ERR_PTR(-ENODEV);
 
+	switch (config->reg_format_endian) {
+	case REGMAP_ENDIAN_DEFAULT:
+	case REGMAP_ENDIAN_LITTLE:
+#ifdef __LITTLE_ENDIAN
+	case REGMAP_ENDIAN_NATIVE:
+#endif
+		switch (config->val_bits) {
+		case 8:
+			ctx->reg_read = regmap_mmio_read8;
+			ctx->reg_write = regmap_mmio_write8;
+			break;
+		case 16:
+			ctx->reg_read = regmap_mmio_read16le;
+			ctx->reg_write = regmap_mmio_write16le;
+			break;
+		case 32:
+			ctx->reg_read = regmap_mmio_read32le;
+			ctx->reg_write = regmap_mmio_write32le;
+			break;
+#ifdef CONFIG_64BIT
+		case 64:
+			ctx->reg_read = regmap_mmio_read64le;
+			ctx->reg_write = regmap_mmio_write64le;
+			break;
+#endif
+		default:
+			ret = -EINVAL;
+			goto err_free;
+		}
+		break;
+	case REGMAP_ENDIAN_BIG:
+#ifdef __BIG_ENDIAN
+	case REGMAP_ENDIAN_NATIVE:
+#endif
+		switch (config->val_bits) {
+		case 8:
+			ctx->reg_read = regmap_mmio_read8;
+			ctx->reg_write = regmap_mmio_write8;
+			break;
+		case 16:
+			ctx->reg_read = regmap_mmio_read16be;
+			ctx->reg_write = regmap_mmio_write16be;
+			break;
+		case 32:
+			ctx->reg_read = regmap_mmio_read32be;
+			ctx->reg_write = regmap_mmio_write32be;
+			break;
+		default:
+			ret = -EINVAL;
+			goto err_free;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_free;
+	}
+
 	if (clk_id == NULL)
 		return ctx;
 
-- 
2.7.0
