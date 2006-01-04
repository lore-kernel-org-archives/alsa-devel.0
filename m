From: Gregor Jasny <jasny@vidsoft.de>
Subject: RFC: Expose soundcard busid to userspace
Date: Wed, 4 Jan 2006 18:21:52 +0100
Message-ID: <20060104172150.GA14752@vidsoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've got the problem, that the order of my soundcards is different
after every reboot. I've tracked this problem down to udev and kernel
hotplugging. Setting an index for every used driver seems to help.

The real problems are starting if I plug in some webcams with audio or
USB headsets. Because my computer is in a testing lab, this happens
very often. So the id's get mixed up nearly on every boot. I'd like
the idea of an stable identifier for a soundcard. The soundcard name
would work - but what happens if there are some soundcards with the same
name? So I thought the bus_id would be a (nearly) perfect id. It is
stable as long as you don't plug the soundcard in another pci or usb
port.

The attached patches are a proof of concept. The problem I see are
old kernels that don't support the busid field. The current ioctl
does not zero the reserved space. So alsa-lib don't know if the
data at busid is just garbage or a busid. Another possible
implementation would be the introduction of another ioctl.

So what do you think of the introduction of a busid or stable id in
alsa-lib. Perhaps some soundcards have an unique serial number?

Thanks,
Gregor

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="busid-alsa-kernel.diff"

Index: core/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/control.c,v
retrieving revision 1.69
diff -u -r1.69 control.c
--- core/control.c	20 Nov 2005 14:06:59 -0000	1.69
+++ core/control.c	4 Jan 2006 16:32:44 -0000
@@ -20,6 +20,7 @@
  */
 
 #include <sound/driver.h>
+#include <linux/device.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
@@ -538,6 +539,7 @@
 	strlcpy(info->longname, card->longname, sizeof(info->longname));
 	strlcpy(info->mixername, card->mixername, sizeof(info->mixername));
 	strlcpy(info->components, card->components, sizeof(info->components));
+	strlcpy(info->busid, card->dev->bus_id, sizeof(info->busid));
 	up_read(&snd_ioctl_rwsem);
 	if (copy_to_user(arg, info, sizeof(struct snd_ctl_card_info))) {
 		kfree(info);

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="busid-alsa-lib.diff"

? test/oldapi
Index: include/control.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/control.h,v
retrieving revision 1.101
diff -u -r1.101 control.h
--- include/control.h	9 Jun 2005 17:12:08 -0000	1.101
+++ include/control.h	4 Jan 2006 16:32:59 -0000
@@ -290,6 +290,7 @@
 const char *snd_ctl_card_info_get_longname(const snd_ctl_card_info_t *obj);
 const char *snd_ctl_card_info_get_mixername(const snd_ctl_card_info_t *obj);
 const char *snd_ctl_card_info_get_components(const snd_ctl_card_info_t *obj);
+const char *snd_ctl_card_info_get_busid(const snd_ctl_card_info_t *obj);
 
 size_t snd_ctl_event_sizeof(void);
 /** \hideinitializer
Index: include/sound/asound.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/sound/asound.h,v
retrieving revision 1.22
diff -u -r1.22 asound.h
--- include/sound/asound.h	16 Aug 2005 12:19:15 -0000	1.22
+++ include/sound/asound.h	4 Jan 2006 16:33:02 -0000
@@ -727,7 +727,8 @@
 	unsigned char reserved_[16];	/* reserved for future (was ID of mixer) */
 	unsigned char mixername[80];	/* visual mixer identification */
 	unsigned char components[80];	/* card components / fine identification, delimited with one space (AC97 etc..) */
-	unsigned char reserved[48];	/* reserved for future */
+	unsigned char busid[20];	/* physical bus id of soundcard */
+	unsigned char reserved[28];	/* reserved for future */
 };
 
 enum sndrv_ctl_elem_type {
Index: src/control/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control.c,v
retrieving revision 1.108
diff -u -r1.108 control.c
--- src/control/control.c	14 Nov 2005 10:18:22 -0000	1.108
+++ src/control/control.c	4 Jan 2006 16:33:06 -0000
@@ -1365,6 +1365,17 @@
 }
 
 /**
+ * \brief Get card bus id from a CTL card info
+ * \param obj CTL card info
+ * \return physical card bus id
+ */
+const char *snd_ctl_card_info_get_busid(const snd_ctl_card_info_t *obj)
+{
+	assert(obj);
+	return (const char *)obj->busid;
+}
+
+/**
  * \brief get size of #snd_ctl_event_t
  * \return size in bytes
  */
Index: test/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/test/control.c,v
retrieving revision 1.12
diff -u -r1.12 control.c
--- test/control.c	3 Sep 2003 19:25:09 -0000	1.12
+++ test/control.c	4 Jan 2006 16:33:06 -0000
@@ -40,6 +40,7 @@
 		printf("  longname - '%s'\n", snd_ctl_card_info_get_longname(info));
 		printf("  mixername - '%s'\n", snd_ctl_card_info_get_mixername(info));
 		printf("  components - '%s'\n", snd_ctl_card_info_get_components(info));
+		printf("  busid - '%s'\n", snd_ctl_card_info_get_busid(info));
 		dev = -1;
 		while (1) {
 			snd_pcm_sync_id_t sync;

--qMm9M+Fa2AknHoGS--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
