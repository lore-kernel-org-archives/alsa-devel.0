From: Andy Shevchenko <andy@smile.org.ua>
Subject: [PATCH] Add mute support to FM-only card with FM801
	PCI to tuner	bridge
Date: Thu, 24 Jan 2008 17:13:42 +0200
Message-ID: <20080124151342.GG1177@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 33DA62433C
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 16:13:45 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

This is improvement of the early support of the FM-only cards where the
fm801 chip represents the PCI to tuner bridge.

The tuner initialization isn't included the mute on as well as mute support
via V4L request. Proposed patch should fix this at least for 64-PCR model.

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- alsa-driver-hg20080124/alsa-kernel/i2c/other/tea575x-tuner.c.mute-fix	2008-01-09 03:00:14.000000000 +0200
+++ alsa-driver-hg20080124/alsa-kernel/i2c/other/tea575x-tuner.c	2008-01-24 16:58:25.000000000 +0200
@@ -53,6 +53,9 @@ MODULE_LICENSE("GPL");
 #define TEA575X_BIT_DUMMY	(1<<15)		/* buffer */
 #define TEA575X_BIT_FREQ_MASK	0x7fff
 
+#define TEA575X_UNMUTE		0		/* just FALSE */
+#define TEA575X_MUTE		1		/* just TRUE */
+
 /*
  * lowlevel part
  */
@@ -158,6 +161,10 @@ static int snd_tea575x_ioctl(struct inod
 			struct video_audio v;
 			if(copy_from_user(&v, arg, sizeof(v))) 
 				return -EFAULT;	
+                    	if (v.flags & VIDEO_AUDIO_MUTE)
+                    		tea->ops->mute(tea, TEA575X_MUTE);
+                    	else
+                    		tea->ops->mute(tea, TEA575X_UNMUTE);
 			if(v.audio) 
 				return -EINVAL;
 			return 0;
@@ -205,6 +212,9 @@ void snd_tea575x_init(struct snd_tea575x
 	tea->freq = 90500 * 16;		/* 90.5Mhz default */
 
 	snd_tea575x_set_freq(tea);
+
+	/* mute on init */
+	tea->ops->mute(tea, TEA575X_MUTE);
 }
 
 void snd_tea575x_exit(struct snd_tea575x *tea)
--- alsa-driver-hg20080124/alsa-kernel/pci/fm801.c.mute-fix	2008-01-09 03:00:15.000000000 +0200
+++ alsa-driver-hg20080124/alsa-kernel/pci/fm801.c	2008-01-24 17:02:17.000000000 +0200
@@ -802,6 +802,11 @@ static unsigned int snd_fm801_tea575x_25
 	return val;
 }
 
+static void snd_fm801_tea575x_256pcs_mute(struct snd_tea575x *tea, unsigned int mute)
+{
+	/* TODO: Should be implemented */
+}
+
 /* 256PCPR GPIO numbers */
 #define TEA_256PCPR_BUS_CLOCK		0
 #define TEA_256PCPR_DATA		1
@@ -890,6 +895,11 @@ static unsigned int snd_fm801_tea575x_25
 	return val;
 }
 
+static void snd_fm801_tea575x_256pcpr_mute(struct snd_tea575x *tea, unsigned int mute)
+{
+	/* TODO: Should be implemented */
+}
+
 /* 64PCR GPIO numbers */
 #define TEA_64PCR_BUS_CLOCK		0
 #define TEA_64PCR_WRITE_ENABLE		1	/* inverted */
@@ -978,21 +988,42 @@ static unsigned int snd_fm801_tea575x_64
 	return val;
 }
 
+static void snd_fm801_tea575x_64pcr_mute(struct snd_tea575x *tea, unsigned int mute)
+{
+	struct fm801 *chip = tea->private_data;
+	unsigned short reg;
+
+	spin_lock_irq(&chip->reg_lock);
+
+	reg = inw(FM801_REG(chip, GPIO_CTRL));
+	if (mute)
+		reg &= ~FM801_GPIO_GP(TEA_64PCR_WRITE_ENABLE);  // 0xf800 (mute)
+	else
+		reg |= FM801_GPIO_GP(TEA_64PCR_WRITE_ENABLE);   // 0xf802 (unmute)
+	outw(reg, FM801_REG(chip, GPIO_CTRL));
+	udelay(1);
+
+	spin_unlock_irq(&chip->reg_lock);
+}
+
 static struct snd_tea575x_ops snd_fm801_tea_ops[3] = {
 	{
 		/* 1 = MediaForte 256-PCS */
 		.write = snd_fm801_tea575x_256pcs_write,
 		.read = snd_fm801_tea575x_256pcs_read,
+		.mute = snd_fm801_tea575x_256pcs_mute,
 	},
 	{
 		/* 2 = MediaForte 256-PCPR */
 		.write = snd_fm801_tea575x_256pcpr_write,
 		.read = snd_fm801_tea575x_256pcpr_read,
+		.mute = snd_fm801_tea575x_256pcpr_mute,
 	},
 	{
 		/* 3 = MediaForte 64-PCR */
 		.write = snd_fm801_tea575x_64pcr_write,
 		.read = snd_fm801_tea575x_64pcr_read,
+		.mute = snd_fm801_tea575x_64pcr_mute,
 	}
 };
 #endif
--- alsa-driver-hg20080124/alsa-kernel/include/tea575x-tuner.h.mute-fix	2007-10-16 03:00:12.000000000 +0300
+++ alsa-driver-hg20080124/alsa-kernel/include/tea575x-tuner.h	2008-01-24 16:58:25.000000000 +0200
@@ -30,6 +30,7 @@ struct snd_tea575x;
 struct snd_tea575x_ops {
 	void (*write)(struct snd_tea575x *tea, unsigned int val);
 	unsigned int (*read)(struct snd_tea575x *tea);
+	void (*mute)(struct snd_tea575x *tea, unsigned int mute);
 };
 
 struct snd_tea575x {

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
