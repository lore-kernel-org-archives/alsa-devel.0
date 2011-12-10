From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: Jabra SPEAK 410 USB - no audio playback
Date: Sat, 10 Dec 2011 17:23:07 +0000
Message-ID: <20111210172307.GE16692@amd.home.annexia.org>
References: <20111210142419.GC16692@amd.home.annexia.org>
	<loom.20111210T174715-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id ECAA7246CF
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2011 18:23:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <loom.20111210T174715-712@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tom Walder <tom.walder@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sat, Dec 10, 2011 at 04:49:26PM +0000, Tom Walder wrote:
> I have the same problem - the products looks great but no sound!!!
> 
> 
> [84634.255183] usbcore: registered new interface driver hiddev
> [84634.365746] usbcore: registered new interface driver snd-usb-audio
> [84634.413374] input: Jabra SPEAK 410 USB as
> /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.3/input/input10
> [84634.413697] generic-usb 0003:0B0E:0410.0001: input,hiddev96,hidraw0: USB HID
> v1.11 Device [Jabra SPEAK 410 USB] on usb-0000:00:1d.2-1/input3
> [84634.413743] usbcore: registered new interface driver usbhid
> [84634.413747] usbhid: USB HID core driver
> [84635.174212] 2:1:1: endpoint lacks sample rate attribute bit, cannot set.
> [84635.179213] 2:2:1: endpoint lacks sample rate attribute bit, cannot set.
> [84635.233223] 2:2:1: endpoint lacks sample rate attribute bit, cannot set.

The error you're seeing is a bit different from me.

Can you reply with the output of 'lsusb -v'?

I have a suspicion that Linux is fine and that the USB descriptor for
the device is bad.  My device has an Endpoint descriptor with
bDescriptorType 0x25, which seems to be an invalid value (should be 0x5).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
