From: Andy Shevchenko <andy@smile.org.ua>
Subject: [PATCH] Add mute support for FM-only card with FM801
	PCI to tuner	bridge
Date: Thu, 24 Jan 2008 19:00:04 +0200
Message-ID: <20080124170004.GJ1177@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C95F4243A3
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 18:00:05 +0100 (CET)
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


This is improvement of the early support of the FM-only cards where the
fm801 chip represents the PCI to tuner bridge.

The tuner initialization isn't included the mute on as well as mute support
via V4L request. Proposed patch should fix this at least for 64-PCR model.

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- alsa-driver-hg20080124/alsa-kernel/i2c/other/tea575x-tuner.c.mute-fix	2008-01-09 03:00:14.000000000 +0200
+++ alsa-driver-hg20080124/alsa-kernel/i2c/other/tea575x-tuner.c	2008-01-24 19:15:48.000000000 +0200
@@ -158,6 +158,10 @@ static int snd_tea575x_ioctl(struct inod
 			struct video_audio v;
 			if(copy_from_user(&v, arg, sizeof(v))) 
 				return -EFAULT;	
+			if (tea->ops->mute)
+				tea->ops->mute(tea,
+					       (v.flags &
+						VIDEO_AUDIO_MUTE) ? 1 : 0);
 			if(v.audio) 
 				return -EINVAL;
 			return 0;
@@ -205,6 +209,10 @@ void snd_tea575x_init(struct snd_tea575x
 	tea->freq = 90500 * 16;		/* 90.5Mhz default */
 
 	snd_tea575x_set_freq(tea);
+
+	/* mute on init */
+	if (tea->ops->mute)
+		tea->ops->mute(tea, 1);
 }
 
 void snd_tea575x_exit(struct snd_tea575x *tea)
--- alsa-driver-hg20080124/alsa-kernel/pci/fm801.c.mute-fix	2008-01-09 03:00:15.000000000 +0200
+++ alsa-driver-hg20080124/alsa-kernel/pci/fm801.c	2008-01-24 19:15:48.000000000 +0200
@@ -978,21 +978,45 @@ static unsigned int snd_fm801_tea575x_64
 	return val;
 }
 
+static void snd_fm801_tea575x_64pcr_mute(struct snd_tea575x *tea,
+					  unsigned int mute)
+{
+	struct fm801 *chip = tea->private_data;
+	unsigned short reg;
+
+	spin_lock_irq(&chip->reg_lock);
+
+	reg = inw(FM801_REG(chip, GPIO_CTRL));
+	if (mute)
+		/* 0xf800 (mute) */
+		reg &= ~FM801_GPIO_GP(TEA_64PCR_WRITE_ENABLE);
+	else
+		/* 0xf802 (unmute) */
+		reg |= FM801_GPIO_GP(TEA_64PCR_WRITE_ENABLE);
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
+		.mute = NULL,
 	},
 	{
 		/* 2 = MediaForte 256-PCPR */
 		.write = snd_fm801_tea575x_256pcpr_write,
 		.read = snd_fm801_tea575x_256pcpr_read,
+		.mute = NULL,
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
+++ alsa-driver-hg20080124/alsa-kernel/include/tea575x-tuner.h	2008-01-24 19:15:48.000000000 +0200
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
