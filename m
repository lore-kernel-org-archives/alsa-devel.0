From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] RTC timer patches for 2.4.23/25
Date: Tue, 02 Mar 2004 16:26:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403021624390.25852-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


2.4.23 and .25 need new patches


diff -urN alsa-driver/utils/patches/rtc-2.4.23.patch alsa-driver/utils/patches/rtc-2.4.23.patch
--- alsa-driver/utils/patches/rtc-2.4.23.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/utils/patches/rtc-2.4.23.patch	2004-03-02 15:50:48.901317000 +0100
@@ -0,0 +1,212 @@
+diff -ur linux/drivers/char/Makefile linux-2.4.23/drivers/char/Makefile
+--- linux/drivers/char/Makefile	Thu Jan 15 14:34:08 2004
++++ linux-2.4.23/drivers/char/Makefile	Thu Jan 15 14:33:01 2004
+@@ -23,7 +23,7 @@
+
+ export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
+ 			misc.o pty.o random.o selection.o serial.o \
+-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
++			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
+ 			au1000_gpio.o hp_psaux.o nvram.o scx200.o fetchop.o
+
+ mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
+diff -ur linux/drivers/char/rtc.c linux-2.4.23/drivers/char/rtc.c
+--- linux/drivers/char/rtc.c	Sat Jan 24 12:06:07 2004
++++ linux-2.4.23/drivers/char/rtc.c	Fri Jan 16 23:22:39 2004
+@@ -142,6 +142,11 @@
+ static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
+ static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
+
++#if RTC_IRQ
++static spinlock_t rtc_task_lock = SPIN_LOCK_UNLOCKED;
++static rtc_task_t *rtc_callback = NULL;
++#endif
++
+ /*
+  *	If this driver ever becomes modularised, it will be really nice
+  *	to make the epoch retain its value across module reload...
+@@ -183,6 +188,10 @@
+ 	spin_unlock (&rtc_lock);
+
+ 	/* Now do the rest of the actions */
++	spin_lock(&rtc_task_lock);
++	if (rtc_callback)
++		rtc_callback->func(rtc_callback->private_data);
++	spin_unlock(&rtc_task_lock);
+ 	wake_up_interruptible(&rtc_wait);
+
+ 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+@@ -279,8 +288,7 @@
+ #endif
+ }
+
+-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+-		     unsigned long arg)
++static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
+ {
+ 	struct rtc_time wtime;
+
+@@ -330,7 +338,7 @@
+ 		 * We don't really want Joe User enabling more
+ 		 * than 64Hz of interrupts on a multi-user machine.
+ 		 */
+-		if ((rtc_freq > rtc_max_user_freq) &&
++		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
+ 		    (!capable(CAP_SYS_RESOURCE)))
+ 			return -EACCES;
+
+@@ -526,7 +534,8 @@
+ 		 * We don't really want Joe User generating more
+ 		 * than 64Hz of interrupts on a multi-user machine.
+ 		 */
+-		if ((arg > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
++		if (!kernel && (arg > rtc_max_user_freq) &&
++		    (!capable(CAP_SYS_RESOURCE)))
+ 			return -EACCES;
+
+ 		while (arg > (1<<tmp))
+@@ -572,6 +581,12 @@
+ 	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
+ }
+
++static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
++		     unsigned long arg)
++{
++	return rtc_do_ioctl(cmd, arg, 0);
++}
++
+ /*
+  *	We enforce only one user at a time here with the open/close.
+  *	Also clear the previous interrupt data on an open, and clean
+@@ -639,11 +654,8 @@
+
+ 	spin_lock_irq (&rtc_lock);
+ 	rtc_irq_data = 0;
+-	spin_unlock_irq (&rtc_lock);
+-
+-	/* No need for locking -- nobody else can do anything until this rmw is
+-	 * committed, and no timer is running. */
+ 	rtc_status &= ~RTC_IS_OPEN;
++	spin_unlock_irq (&rtc_lock);
+ 	return 0;
+ }
+
+@@ -669,6 +681,88 @@
+ #endif
+
+ /*
++ * exported stuff
++ */
++
++EXPORT_SYMBOL(rtc_register);
++EXPORT_SYMBOL(rtc_unregister);
++EXPORT_SYMBOL(rtc_control);
++
++int rtc_register(rtc_task_t *task)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	if (task == NULL || task->func == NULL)
++		return -EINVAL;
++	spin_lock_irq(&rtc_lock);
++	if (rtc_status & RTC_IS_OPEN) {
++		spin_unlock_irq(&rtc_lock);
++		return -EBUSY;
++	}
++	spin_lock(&rtc_task_lock);
++	if (rtc_callback) {
++		spin_unlock(&rtc_task_lock);
++		spin_unlock_irq(&rtc_lock);
++		return -EBUSY;
++	}
++	rtc_status |= RTC_IS_OPEN;
++	rtc_callback = task;
++	spin_unlock(&rtc_task_lock);
++	spin_unlock_irq(&rtc_lock);
++	return 0;
++#endif
++}
++
++int rtc_unregister(rtc_task_t *task)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	unsigned char tmp;
++
++	spin_lock_irq(&rtc_task_lock);
++	if (rtc_callback != task) {
++		spin_unlock_irq(&rtc_task_lock);
++		return -ENXIO;
++	}
++	rtc_callback = NULL;
++	spin_lock(&rtc_lock);
++	/* disable controls */
++	tmp = CMOS_READ(RTC_CONTROL);
++	tmp &= ~RTC_PIE;
++	tmp &= ~RTC_AIE;
++	tmp &= ~RTC_UIE;
++	CMOS_WRITE(tmp, RTC_CONTROL);
++	CMOS_READ(RTC_INTR_FLAGS);
++	if (rtc_status & RTC_TIMER_ON) {
++		rtc_status &= ~RTC_TIMER_ON;
++		del_timer(&rtc_irq_timer);
++	}
++	rtc_status &= ~RTC_IS_OPEN;
++	spin_unlock(&rtc_lock);
++	spin_unlock_irq(&rtc_task_lock);
++	return 0;
++#endif
++}
++
++int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	spin_lock_irq(&rtc_task_lock);
++	if (rtc_callback != task) {
++		spin_unlock_irq(&rtc_task_lock);
++		return -ENXIO;
++	}
++	spin_unlock_irq(&rtc_task_lock);
++	return rtc_do_ioctl(cmd, arg, 1);
++#endif
++}
++
++
++/*
+  *	The various file operations we support.
+  */
+
+@@ -858,7 +952,6 @@
+
+ module_init(rtc_init);
+ module_exit(rtc_exit);
+-EXPORT_NO_SYMBOLS;
+
+ #if RTC_IRQ
+ /*
+diff -ur linux/include/linux/rtc.h linux-2.4.23/include/linux/rtc.h
+--- linux/include/linux/rtc.h	Thu Jan 15 14:40:40 2004
++++ linux-2.4.23/include/linux/rtc.h	Fri Jan 16 23:22:19 2004
+@@ -90,4 +90,18 @@
+
+ #define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
+ #define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
++
++/* Exported functions to other kernel drivers */
++
++#ifdef __KERNEL__
++typedef struct rtc_task {
++	void (*func)(void *private_data);
++	void *private_data;
++} rtc_task_t;
++
++int rtc_register(rtc_task_t *task);
++int rtc_unregister(rtc_task_t *task);
++int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg);
++#endif
++
+ #endif /* _LINUX_RTC_H_ */
diff -urN alsa-driver/utils/patches/rtc-2.4.25.patch alsa-driver/utils/patches/rtc-2.4.25.patch
--- alsa-driver/utils/patches/rtc-2.4.25.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/utils/patches/rtc-2.4.25.patch	2004-03-02 15:50:49.299969000 +0100
@@ -0,0 +1,212 @@
+diff -ur linux/drivers/char/Makefile linux-2.4.25/drivers/char/Makefile
+--- linux/drivers/char/Makefile	Sun Feb 29 15:26:19 2004
++++ linux-2.4.25/drivers/char/Makefile	Sun Feb 29 15:29:38 2004
+@@ -23,7 +23,7 @@
+
+ export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
+ 			misc.o pty.o random.o selection.o serial.o \
+-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
++			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
+ 			au1000_gpio.o vac-serial.o hp_psaux.o nvram.o \
+ 			scx200.o fetchop.o
+
+diff -ur linux/drivers/char/rtc.c linux-2.4.25/drivers/char/rtc.c
+--- linux/drivers/char/rtc.c	Sun Feb 29 15:26:30 2004
++++ linux-2.4.25/drivers/char/rtc.c	Sun Feb 29 15:29:41 2004
+@@ -145,6 +145,11 @@
+ static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
+ static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
+
++#if RTC_IRQ
++static spinlock_t rtc_task_lock = SPIN_LOCK_UNLOCKED;
++static rtc_task_t *rtc_callback = NULL;
++#endif
++
+ /*
+  *	If this driver ever becomes modularised, it will be really nice
+  *	to make the epoch retain its value across module reload...
+@@ -186,6 +191,10 @@
+ 	spin_unlock (&rtc_lock);
+
+ 	/* Now do the rest of the actions */
++	spin_lock(&rtc_task_lock);
++	if (rtc_callback)
++		rtc_callback->func(rtc_callback->private_data);
++	spin_unlock(&rtc_task_lock);
+ 	wake_up_interruptible(&rtc_wait);
+
+ 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+@@ -293,8 +302,7 @@
+ #endif
+ }
+
+-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+-		     unsigned long arg)
++static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
+ {
+ 	struct rtc_time wtime;
+
+@@ -344,7 +352,7 @@
+ 		 * We don't really want Joe User enabling more
+ 		 * than 64Hz of interrupts on a multi-user machine.
+ 		 */
+-		if ((rtc_freq > rtc_max_user_freq) &&
++		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
+ 		    (!capable(CAP_SYS_RESOURCE)))
+ 			return -EACCES;
+
+@@ -540,7 +548,8 @@
+ 		 * We don't really want Joe User generating more
+ 		 * than 64Hz of interrupts on a multi-user machine.
+ 		 */
+-		if ((arg > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
++		if (!kernel && (arg > rtc_max_user_freq) &&
++		    (!capable(CAP_SYS_RESOURCE)))
+ 			return -EACCES;
+
+ 		while (arg > (1<<tmp))
+@@ -586,6 +595,12 @@
+ 	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
+ }
+
++static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
++		     unsigned long arg)
++{
++	return rtc_do_ioctl(cmd, arg, 0);
++}
++
+ /*
+  *	We enforce only one user at a time here with the open/close.
+  *	Also clear the previous interrupt data on an open, and clean
+@@ -653,11 +668,8 @@
+
+ 	spin_lock_irq (&rtc_lock);
+ 	rtc_irq_data = 0;
+-	spin_unlock_irq (&rtc_lock);
+-
+-	/* No need for locking -- nobody else can do anything until this rmw is
+-	 * committed, and no timer is running. */
+ 	rtc_status &= ~RTC_IS_OPEN;
++	spin_unlock_irq (&rtc_lock);
+ 	return 0;
+ }
+
+@@ -683,6 +695,88 @@
+ #endif
+
+ /*
++ * exported stuff
++ */
++
++EXPORT_SYMBOL(rtc_register);
++EXPORT_SYMBOL(rtc_unregister);
++EXPORT_SYMBOL(rtc_control);
++
++int rtc_register(rtc_task_t *task)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	if (task == NULL || task->func == NULL)
++		return -EINVAL;
++	spin_lock_irq(&rtc_lock);
++	if (rtc_status & RTC_IS_OPEN) {
++		spin_unlock_irq(&rtc_lock);
++		return -EBUSY;
++	}
++	spin_lock(&rtc_task_lock);
++	if (rtc_callback) {
++		spin_unlock(&rtc_task_lock);
++		spin_unlock_irq(&rtc_lock);
++		return -EBUSY;
++	}
++	rtc_status |= RTC_IS_OPEN;
++	rtc_callback = task;
++	spin_unlock(&rtc_task_lock);
++	spin_unlock_irq(&rtc_lock);
++	return 0;
++#endif
++}
++
++int rtc_unregister(rtc_task_t *task)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	unsigned char tmp;
++
++	spin_lock_irq(&rtc_task_lock);
++	if (rtc_callback != task) {
++		spin_unlock_irq(&rtc_task_lock);
++		return -ENXIO;
++	}
++	rtc_callback = NULL;
++	spin_lock(&rtc_lock);
++	/* disable controls */
++	tmp = CMOS_READ(RTC_CONTROL);
++	tmp &= ~RTC_PIE;
++	tmp &= ~RTC_AIE;
++	tmp &= ~RTC_UIE;
++	CMOS_WRITE(tmp, RTC_CONTROL);
++	CMOS_READ(RTC_INTR_FLAGS);
++	if (rtc_status & RTC_TIMER_ON) {
++		rtc_status &= ~RTC_TIMER_ON;
++		del_timer(&rtc_irq_timer);
++	}
++	rtc_status &= ~RTC_IS_OPEN;
++	spin_unlock(&rtc_lock);
++	spin_unlock_irq(&rtc_task_lock);
++	return 0;
++#endif
++}
++
++int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
++{
++#if !RTC_IRQ
++	return -EIO;
++#else
++	spin_lock_irq(&rtc_task_lock);
++	if (rtc_callback != task) {
++		spin_unlock_irq(&rtc_task_lock);
++		return -ENXIO;
++	}
++	spin_unlock_irq(&rtc_task_lock);
++	return rtc_do_ioctl(cmd, arg, 1);
++#endif
++}
++
++
++/*
+  *	The various file operations we support.
+  */
+
+@@ -884,7 +978,6 @@
+
+ module_init(rtc_init);
+ module_exit(rtc_exit);
+-EXPORT_NO_SYMBOLS;
+
+ #if RTC_IRQ
+ /*
+diff -ur linux/include/linux/rtc.h linux-2.4.25/include/linux/rtc.h
+--- linux/include/linux/rtc.h	Sun Feb 29 15:26:09 2004
++++ linux-2.4.25/include/linux/rtc.h	Sun Feb 29 15:29:35 2004
+@@ -90,4 +90,18 @@
+
+ #define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
+ #define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
++
++/* Exported functions to other kernel drivers */
++
++#ifdef __KERNEL__
++typedef struct rtc_task {
++	void (*func)(void *private_data);
++	void *private_data;
++} rtc_task_t;
++
++int rtc_register(rtc_task_t *task);
++int rtc_unregister(rtc_task_t *task);
++int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg);
++#endif
++
+ #endif /* _LINUX_RTC_H_ */




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
