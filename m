From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: Device assignment and hotplug
Date: Wed, 5 Sep 2007 20:41:00 +0200
Message-ID: <20070905204100.71ae4c20.krzysztof.h1@wp.pl>
References: <s5hd4wx6nvm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 5330424356
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 20:34:35 +0200 (CEST)
In-Reply-To: <s5hd4wx6nvm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 05 Sep 2007 19:08:45 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
> 
> the recent Linux systems use the auto-probing at boot via udev, and
> this often screws up the order of device loading, which results in the
> inconsistent device appearance.  A typical case is that you have a PCI
> onboard and a USB audio device.  Sometimes the USB appears as the
> first device while sometimes (most times) PCI appears as the first.
> 
> So far, for fixing this order, we use index module option.  That is,
> add the following to module config:
> 
> 	options snd-onboard index=0
> 	options snd-usb-audio index=1
> 

I would rather try to contact udev guys how to solve this. This problem
is not limited to sound cards. They have solution for hard drives already
as it hit them first and could even lead to non-bootable system (sda
swapped with sdb then e.g. /usr partition could not be mounted).

A general solution would be to use some kind of device locator (e.g. bus:device_id).
For PCI devices the pci id could be used. For the USB devices, the device id reported
by lsusb or something id string from the device (like for disks now - they can use disk
number reported by disk).

Even, if the problem is solved for USB devices only, it will probably make life much easier
as the PCI bus is probably always scanned in the same order.

The same may apply to graphics cards, modems, network cards, etc. A general
solution (like bus:device_id) would solve it for the most if not all of them.

If it is not solvable by udev guys, then you can try doing it in alsa the way I mentioned
so you can set in the config file which device id (USB serial number or bus:device_id)
correspond to each sound device.

In your solution, it is a change of index to some kind of locator.

My two cents,
Krzysztof
