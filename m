From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trying out usb hotplugs
Date: Fri, 29 Nov 2002 08:52:43 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211290844210.21256-100000@studcom.urz.uni-halle.de>
References: <s5h3cpl28tj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h3cpl28tj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Martin Langer wrote:
> > usb hotplug works perfect if my usbmidi client isn't aconnected to another
> > midi client. But the aconnected usb midi device still remains in the clients
> > list, after hotpluging out.
>
> yep,  when the connection exists, the connected devices (on both
> sides) are regarded as active.

The sequencer design allows asynchronous removal of clients.


--- alsa-kernel/core/seq/seq_device.c.orig	Wed Aug 14 18:11:13 2002
+++ alsa-kernel/core/seq/seq_device.c	Thu Nov 28 23:05:47 2002
@@ -92,6 +92,7 @@
 static int snd_seq_device_free(snd_seq_device_t *dev);
 static int snd_seq_device_dev_free(snd_device_t *device);
 static int snd_seq_device_dev_register(snd_device_t *device);
+static int snd_seq_device_dev_disconnect(snd_device_t *device);
 static int snd_seq_device_dev_unregister(snd_device_t *device);

 static int init_device(snd_seq_device_t *dev, ops_list_t *ops);
@@ -166,6 +167,7 @@
 	static snd_device_ops_t dops = {
 		.dev_free = snd_seq_device_dev_free,
 		.dev_register = snd_seq_device_dev_register,
+		.dev_disconnect = snd_seq_device_dev_disconnect,
 		.dev_unregister = snd_seq_device_dev_unregister
 	};

@@ -265,6 +267,22 @@
 		init_device(dev, ops);

 	unlock_driver(ops);
+	return 0;
+}
+
+/*
+ * disconnect the device
+ */
+static int snd_seq_device_dev_disconnect(snd_device_t *device)
+{
+	snd_seq_device_t *dev = snd_magic_cast(snd_seq_device_t, device->device_data, return -ENXIO);
+	ops_list_t *ops;
+
+	ops = find_driver(dev->id, 0);
+	if (ops == NULL)
+		return -ENOENT;
+
+	free_device(dev, ops);
 	return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
