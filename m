From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: my first usb-midi experiment ends with segmentation
 fault
Date: Wed, 31 Jul 2002 12:26:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D47BB59.1E7012C1@ladisch.de>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de>
 <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de>
 <20020730181834.GA494@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> Thanks for all patches, but I don't found an error in the log-files. The last
> line is/was always the detection, which seems to work fine (see above). I'm
> still missing a client in /proc/asound/seq/clients, so the driver never
> reaches the port creation and I have no additional output from your patch.
> Something else must be between usb-detection and creation of the port!

It seems that snd_usbmidi_seq_device_new is never called (???), or fails.

Please try the following patch (in addition to my other one), which will output
a lot of debug messages:


--- usb/usbmidi.c.org	Wed Jul 31 10:57:09 2002
+++ usb/usbmidi.c	Wed Jul 31 12:13:03 2002
@@ -874,20 +874,24 @@
 	for (i = 0; i < MAX_ENDPOINTS; ++i) {
 		usbmidi_endpoint_info_t* ep_info = &umidi->device_info.endpoints[i];
 
+		printk(KERN_INFO "endpoint %d ...\n", i);
 		if (!ep_info->epnum)
 			continue;
 		if (ep_info->out_cables) {
+			printk(KERN_INFO "... output\n");
 			err = snd_usbmidi_out_endpoint_create(umidi, ep_info,
 							      &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
 		if (ep_info->in_cables) {
+			printk(KERN_INFO "... input\n");
 			err = snd_usbmidi_in_endpoint_create(umidi, ep_info,
 							     &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
+		printk(KERN_INFO "... ports\n");
 		err = snd_usbmidi_create_endpoint_ports(umidi, i, &port_idx);
 		if (err < 0)
 			return err;
@@ -909,8 +913,10 @@
 	snd_seq_client_info_t client_info;
 	int i, err;
 
+	printk(KERN_INFO "snd_usbmidi_seq_device_new() called\n");
 	umidi = (usbmidi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
 
+	printk(KERN_INFO "creating client\n");
 	memset(&client_callback, 0, sizeof(client_callback));
 	client_callback.allow_output = 1;
 	client_callback.allow_input = 1;
@@ -919,6 +925,7 @@
 	if (umidi->seq_client < 0)
 		return umidi->seq_client;
 
+	printk(KERN_INFO "setting client name\n");
 	memset(&client_info, 0, sizeof(client_info));
 	client_info.client = umidi->seq_client;
 	client_info.type = KERNEL_CLIENT;
@@ -928,12 +935,15 @@
 				  SNDRV_SEQ_IOCTL_SET_CLIENT_INFO,
 				  &client_info);
 
+	printk(KERN_INFO "creating endpoints\n");
 	err = snd_usbmidi_create_endpoints(umidi);
 	if (err < 0) {
+		printk(KERN_INFO "... failed\n");
 		snd_usbmidi_seq_device_delete(seq_device);
 		return err;
 	}
 
+	printk(KERN_INFO "submitting URBs\n");
 	for (i = 0; i < MAX_ENDPOINTS; ++i)
 		if (umidi->endpoints[i].in)
 			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,



> tuba:~# cat /proc/asound/cards
> 0 [card0          ]: USB MIDI - Evolution Electronics L MK-249C Evolution
> Electronics L MK-249C Evolution Elect (a4d:8e if 1 at 001/002)
>                      Evolution Electronics L MK-249C Evolution Elect (a4d:8e
> if 1 at 001/002)
> 
> The only strange thing I found are the unknown parts of the lsusb output
> (broken descriptor?) and the impossible module reload = segfault.

IMHO the garbled device name is strange, too. ;-)  This is a (rather
harmless) buffer overflow which has been fixed by the latest version of my
other patch.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
