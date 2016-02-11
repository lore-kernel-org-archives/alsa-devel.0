From: Martin Koegler <martin.koegler@chello.at>
Subject: Linking ALSA sequencer kernel clients to their device
Date: Thu, 11 Feb 2016 08:50:36 +0100
Message-ID: <20160211075035.GA23857@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-2.mx.upcmail.net
 (vie01a-dmta-pe02-2.mx.upcmail.net [62.179.121.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 532B8260644
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 08:50:38 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aTm1N-0002up-Op
 for alsa-devel@alsa-project.org; Thu, 11 Feb 2016 08:50:37 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: martin.koegler@chello.at
List-Id: alsa-devel@alsa-project.org

In my domain, people use multiple identical USB-MIDI keyboards - each
is assigned a different functions. They expect to kept this mapping
across reboots.

The sound card number are dynamic, therefore they can change after
reboots. The only stable device ID is the sysfs path of the used USB
port.

This means, that I need to associate a kernel sequencer client number
with a sysfs device.

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

So I thought about exposing the missing information via sysfs:

>From 776dd02d8d7eae89c2699be27eedf81eaf690a0e Mon Sep 17 00:00:00 2001
From: Martin Koegler <martin.koegler@chello.at>
Date: Mon, 8 Feb 2016 22:53:42 +0100
Subject: [PATCH] Provide sequencer client number via sysfs

Provides the missing link between real hardware devices and kernel
sequencer clients.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 sound/core/seq/seq_midi.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 5dd0ee2..0d807e2 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -271,6 +271,31 @@ static void snd_seq_midisynth_delete(struct seq_midisynth *msynth)
 	snd_midi_event_free(msynth->parser);
 }
 
+static ssize_t
+client_number_show_attr(struct device *dev,
+		     struct device_attribute *attr, char *buf)
+{
+	struct snd_seq_device *device = container_of(dev, struct snd_seq_device, dev);
+	struct snd_card *card = device->card;
+	struct seq_midisynth_client *client;
+
+	client = card ? synths[card->number] : NULL;
+	return snprintf(buf, PAGE_SIZE, "%i\n", client ? client->seq_client : -1);
+}
+
+static DEVICE_ATTR(client, S_IRUGO, client_number_show_attr, NULL);
+
+static ssize_t
+device_number_show_attr(struct device *dev,
+		     struct device_attribute *attr, char *buf)
+{
+	struct snd_seq_device *device = container_of(dev, struct snd_seq_device, dev);
+
+	return snprintf(buf, PAGE_SIZE, "%i\n", device->device);
+}
+
+static DEVICE_ATTR(device, S_IRUGO, device_number_show_attr, NULL);
+
 /* register new midi synth port */
 static int
 snd_seq_midisynth_probe(struct device *_dev)
@@ -287,6 +312,7 @@ snd_seq_midisynth_probe(struct device *_dev)
 	struct snd_card *card = dev->card;
 	int device = dev->device;
 	unsigned int input_count = 0, output_count = 0;
+	int error;
 
 	if (snd_BUG_ON(!card || device < 0 || device >= SNDRV_RAWMIDI_DEVICES))
 		return -EINVAL;
@@ -332,6 +358,16 @@ snd_seq_midisynth_probe(struct device *_dev)
 			kfree(info);
 			return -ENOMEM;
 		}
+		error = device_create_file(&dev->dev, &dev_attr_client);
+		if (error >= 0)
+			error = device_create_file(&dev->dev, &dev_attr_device);
+		if (error < 0) {
+			snd_seq_delete_kernel_client(client->seq_client);
+			kfree(client);
+			mutex_unlock(&register_mutex);
+			kfree(info);
+			return error;
+		}
 	}
 
 	msynth = kcalloc(ports, sizeof(struct seq_midisynth), GFP_KERNEL);
@@ -451,6 +487,8 @@ snd_seq_midisynth_remove(struct device *_dev)
 	kfree(msynth);
 	client->num_ports--;
 	if (client->num_ports <= 0) {
+		device_remove_file(&dev->dev, &dev_attr_client);
+		device_remove_file(&dev->dev, &dev_attr_device);
 		snd_seq_delete_kernel_client(client->seq_client);
 		synths[card->number] = NULL;
 		kfree(client);
-- 
2.1.4
