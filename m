From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio
	Interface	support to quirks-table
Date: Tue, 04 Nov 2014 10:00:29 +0100
Message-ID: <545895AD.7020004@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
 <531EC9CC.4060203@ladisch.de>
 <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CA8062606CC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:00:32 +0100 (CET)
In-Reply-To: <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> On Mar 11, 2014, at 1:31 AM, Clemens Ladisch wrote:
>> Strange; in theory, the driver should be able to pick up these
>> descriptors.
>>
>> Are there any error messages in the system log when you plug it in or
>> reload the unpatch snd-usb-audio driver?
>
> Mar 11 02:25:11 cbox kernel: [   82.426640] usb 2-1.6: new high-speed USB device number 4 using ehci-pci
> Mar 11 02:25:12 cbox kernel: [   82.515364] usb 2-1.6: New USB device found, idVendor=0499, idProduct=150e
> Mar 11 02:25:12 cbox kernel: [   82.515368] usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> Mar 11 02:25:12 cbox kernel: [   82.515370] usb 2-1.6: Product: Steinberg UR44
> Mar 11 02:25:12 cbox kernel: [   82.515372] usb 2-1.6: Manufacturer: Yamaha Corporation
> Mar 11 02:25:12 cbox kernel: [   82.518134] snd-usb-audio: probe of 2-1.6:1.0 failed with error -5
> Mar 11 02:25:12 cbox kernel: [   82.523317] snd-usb-audio: probe of 2-1.6:1.1 failed with error -5

Please try the patch below to get more information in the log.


Regards,
Clemens


--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -196,19 +196,23 @@
 	 * future ones might change, so ensure that we fail silently if the
 	 * interface doesn't look exactly right.
 	 */
+	dev_info(&iface->dev, "checking PCM interface\n");

 	/* must have a non-zero altsetting for streaming */
 	if (iface->num_altsetting < 2)
 		return -ENODEV;
+	dev_info(&iface->dev, "altsets found\n");
 	alts = &iface->altsetting[1];
 	altsd = get_iface_desc(alts);

 	/* must have an isochronous endpoint for streaming */
 	if (altsd->bNumEndpoints < 1)
 		return -ENODEV;
+	dev_info(&iface->dev, "endpoint found\n");
 	epd = get_endpoint(alts, 0);
 	if (!usb_endpoint_xfer_isoc(epd))
 		return -ENODEV;
+	dev_info(&iface->dev, "iso found\n");

 	/* must have format descriptors */
 	ashd = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
@@ -219,6 +223,7 @@
 	    !fmtd || fmtd->bLength < 8)
 		return -ENODEV;

+	dev_info(&iface->dev, "descriptors found\n");
 	return create_standard_audio_quirk(chip, iface, driver, NULL);
 }
