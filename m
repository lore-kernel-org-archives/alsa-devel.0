From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-audio probe problem (Teac UD-H01)
Date: Sun, 08 Apr 2012 16:23:54 +0200
Message-ID: <4F819F7A.4020707@gmail.com>
References: <4F774ABE.6070905@circa.be> <4F795F55.2040208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C97B22476E
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Apr 2012 16:23:57 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so2825064bkw.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2012 07:23:57 -0700 (PDT)
In-Reply-To: <4F795F55.2040208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, bEN <ml_all@circa.be>
List-Id: alsa-devel@alsa-project.org

On 02.04.2012 10:12, Clemens Ladisch wrote:
> bEN wrote:
>> the new USB DAC from Teac seems detected as 'Human Interface Device'
>> instead of 'Audio'.
> 
> It has both HID and audio interfaces.
> 
>> Despite the fact it is based on a standard USB Audio
>> class v2 controller (Tenor 8802).
> 
> Which doesn't prevent Teac from writing buggy firmware.
> 
>> $ dmesg
>> usb 2-4: new high speed USB device using ehci_hcd and address 3
>> usb 2-4: config 1 has an invalid interface number: 3 but max is 2
>> usb 2-4: config 1 has no interface number 1
> 
> This violates the USB spec.  But I guess it shouldn't prevent the driver
> from attaching to the device.

Right, that's just a warning.

>> Audio class v2 interfaces need an interface association
> 
> This looks like a bug in the driver; there certainly is such
> an descriptor.  Daniel?

The USB audio driver actually just uses functions from the USB driver
core to access the interface association. However, the USB core didn't
assign it during its probe, which is most probably a result of the
broken descriptor set.

I'm still reading through the sources, maybe we can find a more tolerant
way of handling such devices. If not, we would need to add a quirk for
the device and override the descriptors that way.


Daniel
