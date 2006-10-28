From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH] alsa-driver-1.0.13 and devfs
Date: Sat, 28 Oct 2006 23:42:05 +0200
Message-ID: <20061028214205.GA834@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05E5019D
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Oct 2006 23:41:45 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: "Gabor Z. Papp" <gzp@papp.hu>
List-Id: alsa-devel@alsa-project.org

Hi guys,

I found another problem for alsa-driver-1.0.13 not building with Gabor's
config : he has devfs enabled while I do not (and I'm not alone it seems).
I finally tracked down the problem to be coupled with the recent move of
find_snd_minor() in acore/sound.c : the 'mptr' variable is not declared
anymore. To fix it, I had to patch acore/sound.patch, and I don't know
what form you prefer for a fix to this patch.

Thus, I provide the fix in two forms, an incremental patch on top of the
first one, and a patch for the patch to be applied to the tree as for any
normal file. Just pick the one you want. I suspect the first form will be
preferred if the tree has already changed.


#### first form : incremental patch ####

--- ../alsa-kernel/core/sound.c	2006-10-28 23:19:59 +0200
+++ sound.c	2006-10-28 23:17:04 +0200
@@ -345,6 +345,9 @@
 int snd_unregister_device(int type, struct snd_card *card, int dev)
 {
 	int minor;
+#ifdef CONFIG_DEVFS_FS
+	struct snd_minor *mptr;
+#endif
 
 	mutex_lock(&sound_mutex);
 	minor = find_snd_minor(type, card, dev);
@@ -354,6 +357,7 @@
 	}
 
 #ifdef CONFIG_DEVFS_FS
+	mptr = snd_minors[minor];
 	if (mptr->type != SNDRV_DEVICE_TYPE_CONTROL ||
 	    mptr->card >= cards_limit) /* created in sound.c */
 		devfs_remove("snd/%s", (char *)(mptr + 1));


#### second form : patch to the tree ####

--- ./acore/sound.patch	2006-09-29 13:40:28 +0200
+++ ./acore/sound.patch	2006-10-28 23:21:44 +0200
@@ -1,5 +1,5 @@
---- ../alsa-kernel/core/sound.c	2006-08-08 16:09:17.000000000 +0200
-+++ sound.c	2006-08-08 16:13:02.000000000 +0200
+--- ../alsa-kernel/core/sound.c	2006-09-29 13:40:33 +0200
++++ sound.c	2006-10-28 23:17:04 +0200
 @@ -41,6 +41,9 @@
  EXPORT_SYMBOL(snd_major);
  
@@ -92,11 +92,22 @@
  
  	mutex_unlock(&sound_mutex);
  	return 0;
-@@ -320,7 +353,17 @@
+@@ -312,6 +345,9 @@
+ int snd_unregister_device(int type, struct snd_card *card, int dev)
+ {
+ 	int minor;
++#ifdef CONFIG_DEVFS_FS
++	struct snd_minor *mptr;
++#endif
+ 
+ 	mutex_lock(&sound_mutex);
+ 	minor = find_snd_minor(type, card, dev);
+@@ -320,7 +356,18 @@
  		return -EINVAL;
  	}
  
 +#ifdef CONFIG_DEVFS_FS
++	mptr = snd_minors[minor];
 +	if (mptr->type != SNDRV_DEVICE_TYPE_CONTROL ||
 +	    mptr->card >= cards_limit) /* created in sound.c */
 +		devfs_remove("snd/%s", (char *)(mptr + 1));
@@ -110,7 +121,7 @@
  
  	kfree(snd_minors[minor]);
  	snd_minors[minor] = NULL;
-@@ -333,6 +376,9 @@
+@@ -333,6 +380,9 @@
  int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
  			      const struct class_device_attribute *attr)
  {
@@ -120,7 +131,7 @@
  	int minor, ret = -EINVAL;
  	struct class_device *cdev;
  
-@@ -342,7 +388,7 @@
+@@ -342,7 +392,7 @@
  		ret = class_device_create_file(cdev, attr);
  	mutex_unlock(&sound_mutex);
  	return ret;
@@ -129,7 +140,7 @@
  }
  
  EXPORT_SYMBOL(snd_add_device_sysfs_file);
-@@ -428,32 +474,81 @@
+@@ -428,32 +478,81 @@
   *  INIT PART
   */
  

Regards,
Willy

~
~


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
