From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] RTC timer patches for 2.4.20/23
Date: Mon, 26 Jan 2004 10:09:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261007100.6589-300000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_8FjriRIoWjqYuUdyWkDzmw)"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_8FjriRIoWjqYuUdyWkDzmw)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT


The last patch in alsa-driver/utils/patches is for 2.4.16 and doesn't
apply cleanly to newer kernels.

--Boundary_(ID_8FjriRIoWjqYuUdyWkDzmw)
Content-id: <Pine.HPX.4.33n.0401261009190.6589@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=rtc-2.4.20.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=rtc-2.4.20.patch
Content-description: 

diff -ur linux/drivers/char/Makefile linux-2.4.20/drivers/char/Makefile
--- linux/drivers/char/Makefile	Sun Jan 25 14:01:48 2004
+++ linux-2.4.20/drivers/char/Makefile	Sun Jan 25 13:59:13 2004
@@ -23,7 +23,7 @@
 
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
 			au1000_gpio.o hp_psaux.o nvram.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
diff -ur linux/drivers/char/rtc.c linux-2.4.20/drivers/char/rtc.c
--- linux/drivers/char/rtc.c	Sun Jan 25 14:05:51 2004
+++ linux-2.4.20/drivers/char/rtc.c	Sun Jan 25 14:08:22 2004
@@ -141,6 +141,11 @@
 static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
 static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
 
+#if RTC_IRQ
+static spinlock_t rtc_task_lock = SPIN_LOCK_UNLOCKED;
+static rtc_task_t *rtc_callback = NULL;
+#endif
+
 /*
  *	If this driver ever becomes modularised, it will be really nice
  *	to make the epoch retain its value across module reload...
@@ -182,6 +187,10 @@
 	spin_unlock (&rtc_lock);
 
 	/* Now do the rest of the actions */
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback)
+		rtc_callback->func(rtc_callback->private_data);
+	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);	
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
@@ -278,8 +287,7 @@
 #endif
 }
 
-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg)
+static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
 {
 	struct rtc_time wtime; 
 
@@ -329,7 +337,7 @@
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((rtc_freq > rtc_max_user_freq) &&
+		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
 		    (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
@@ -528,7 +536,8 @@
 		 * We don't really want Joe User generating more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((arg > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
+		if (!kernel && (arg > rtc_max_user_freq) &&
+		    (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
 		while (arg > (1<<tmp))
@@ -574,6 +583,12 @@
 	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
 }
 
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	return rtc_do_ioctl(cmd, arg, 0);
+}
+
 /*
  *	We enforce only one user at a time here with the open/close.
  *	Also clear the previous interrupt data on an open, and clean
@@ -641,11 +656,8 @@
 
 	spin_lock_irq (&rtc_lock);
 	rtc_irq_data = 0;
-	spin_unlock_irq (&rtc_lock);
-
-	/* No need for locking -- nobody else can do anything until this rmw is
-	 * committed, and no timer is running. */
 	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock_irq (&rtc_lock);
 	return 0;
 }
 
@@ -671,6 +683,88 @@
 #endif
 
 /*
+ * exported stuff
+ */
+
+EXPORT_SYMBOL(rtc_register);
+EXPORT_SYMBOL(rtc_unregister);
+EXPORT_SYMBOL(rtc_control);
+
+int rtc_register(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	if (task == NULL || task->func == NULL)
+		return -EINVAL;
+	spin_lock_irq(&rtc_lock);
+	if (rtc_status & RTC_IS_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback) {
+		spin_unlock(&rtc_task_lock);
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	rtc_status |= RTC_IS_OPEN;
+	rtc_callback = task;
+	spin_unlock(&rtc_task_lock);
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+#endif
+}
+
+int rtc_unregister(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	unsigned char tmp;
+
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	rtc_callback = NULL;
+	spin_lock(&rtc_lock);
+	/* disable controls */
+	tmp = CMOS_READ(RTC_CONTROL);
+	tmp &= ~RTC_PIE;
+	tmp &= ~RTC_AIE;
+	tmp &= ~RTC_UIE;
+	CMOS_WRITE(tmp, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+	if (rtc_status & RTC_TIMER_ON) {
+		rtc_status &= ~RTC_TIMER_ON;
+		del_timer(&rtc_irq_timer);
+	}
+	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_task_lock);
+	return 0;
+#endif
+}
+
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	spin_unlock_irq(&rtc_task_lock);
+	return rtc_do_ioctl(cmd, arg, 1);
+#endif
+}
+
+
+/*
  *	The various file operations we support.
  */
 
@@ -860,7 +954,6 @@
 
 module_init(rtc_init);
 module_exit(rtc_exit);
-EXPORT_NO_SYMBOLS;
 
 #if RTC_IRQ
 /*
diff -ur linux/include/linux/rtc.h linux-2.4.20/include/linux/rtc.h
--- linux/include/linux/rtc.h	Sun Jan 25 14:01:22 2004
+++ linux-2.4.20/include/linux/rtc.h	Sun Jan 25 13:58:57 2004
@@ -66,4 +66,17 @@
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
 
+/* Exported functions to other kernel drivers */
+
+#ifdef __KERNEL__
+typedef struct rtc_task {
+	void (*func)(void *private_data);
+	void *private_data;
+} rtc_task_t;
+
+int rtc_register(rtc_task_t *task);
+int rtc_unregister(rtc_task_t *task);
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg);
+#endif
+
 #endif /* _LINUX_RTC_H_ */

--Boundary_(ID_8FjriRIoWjqYuUdyWkDzmw)
Content-id: <Pine.HPX.4.33n.0401261009191.6589@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=rtc-2.4.23.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=rtc-2.4.23.patch
Content-description: 

diff -ur linux/drivers/char/Makefile linux-2.4.23/drivers/char/Makefile
--- linux/drivers/char/Makefile	Thu Jan 15 14:34:08 2004
+++ linux-2.4.23/drivers/char/Makefile	Thu Jan 15 14:33:01 2004
@@ -23,7 +23,7 @@
 
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
 			au1000_gpio.o hp_psaux.o nvram.o scx200.o fetchop.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
diff -ur linux/drivers/char/rtc.c linux-2.4.23/drivers/char/rtc.c
--- linux/drivers/char/rtc.c	Sat Jan 24 12:06:07 2004
+++ linux-2.4.23/drivers/char/rtc.c	Fri Jan 16 23:22:39 2004
@@ -142,6 +142,11 @@
 static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
 static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
 
+#if RTC_IRQ
+static spinlock_t rtc_task_lock = SPIN_LOCK_UNLOCKED;
+static rtc_task_t *rtc_callback = NULL;
+#endif
+
 /*
  *	If this driver ever becomes modularised, it will be really nice
  *	to make the epoch retain its value across module reload...
@@ -183,6 +188,10 @@
 	spin_unlock (&rtc_lock);
 
 	/* Now do the rest of the actions */
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback)
+		rtc_callback->func(rtc_callback->private_data);
+	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);	
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
@@ -279,8 +288,7 @@
 #endif
 }
 
-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg)
+static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
 {
 	struct rtc_time wtime; 
 
@@ -330,7 +338,7 @@
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((rtc_freq > rtc_max_user_freq) &&
+		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
 		    (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
@@ -526,7 +534,8 @@
 		 * We don't really want Joe User generating more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((arg > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
+		if (!kernel && (arg > rtc_max_user_freq) &&
+		    (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
 		while (arg > (1<<tmp))
@@ -572,6 +581,12 @@
 	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
 }
 
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	return rtc_do_ioctl(cmd, arg, 0);
+}
+
 /*
  *	We enforce only one user at a time here with the open/close.
  *	Also clear the previous interrupt data on an open, and clean
@@ -639,11 +654,8 @@
 
 	spin_lock_irq (&rtc_lock);
 	rtc_irq_data = 0;
-	spin_unlock_irq (&rtc_lock);
-
-	/* No need for locking -- nobody else can do anything until this rmw is
-	 * committed, and no timer is running. */
 	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock_irq (&rtc_lock);
 	return 0;
 }
 
@@ -669,6 +681,88 @@
 #endif
 
 /*
+ * exported stuff
+ */
+
+EXPORT_SYMBOL(rtc_register);
+EXPORT_SYMBOL(rtc_unregister);
+EXPORT_SYMBOL(rtc_control);
+
+int rtc_register(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	if (task == NULL || task->func == NULL)
+		return -EINVAL;
+	spin_lock_irq(&rtc_lock);
+	if (rtc_status & RTC_IS_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback) {
+		spin_unlock(&rtc_task_lock);
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	rtc_status |= RTC_IS_OPEN;
+	rtc_callback = task;
+	spin_unlock(&rtc_task_lock);
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+#endif
+}
+
+int rtc_unregister(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	unsigned char tmp;
+
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	rtc_callback = NULL;
+	spin_lock(&rtc_lock);
+	/* disable controls */
+	tmp = CMOS_READ(RTC_CONTROL);
+	tmp &= ~RTC_PIE;
+	tmp &= ~RTC_AIE;
+	tmp &= ~RTC_UIE;
+	CMOS_WRITE(tmp, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+	if (rtc_status & RTC_TIMER_ON) {
+		rtc_status &= ~RTC_TIMER_ON;
+		del_timer(&rtc_irq_timer);
+	}
+	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_task_lock);
+	return 0;
+#endif
+}
+
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	spin_unlock_irq(&rtc_task_lock);
+	return rtc_do_ioctl(cmd, arg, 1);
+#endif
+}
+
+
+/*
  *	The various file operations we support.
  */
 
@@ -858,7 +952,6 @@
 
 module_init(rtc_init);
 module_exit(rtc_exit);
-EXPORT_NO_SYMBOLS;
 
 #if RTC_IRQ
 /*
diff -ur linux/include/linux/rtc.h linux-2.4.23/include/linux/rtc.h
--- linux/include/linux/rtc.h	Thu Jan 15 14:40:40 2004
+++ linux-2.4.23/include/linux/rtc.h	Fri Jan 16 23:22:19 2004
@@ -90,4 +90,18 @@
 
 #define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
 #define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
+
+/* Exported functions to other kernel drivers */
+
+#ifdef __KERNEL__
+typedef struct rtc_task {
+	void (*func)(void *private_data);
+	void *private_data;
+} rtc_task_t;
+
+int rtc_register(rtc_task_t *task);
+int rtc_unregister(rtc_task_t *task);
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg);
+#endif
+
 #endif /* _LINUX_RTC_H_ */

--Boundary_(ID_8FjriRIoWjqYuUdyWkDzmw)--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
