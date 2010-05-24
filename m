From: Pedro Ferreira <ilzogoiby@gmail.com>
Subject: Re: USB midi support for KAOSS pad
Date: Mon, 24 May 2010 21:08:52 +0200
Message-ID: <AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
	<20100524153324.GL30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id A57A324716
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 21:08:54 +0200 (CEST)
Received: by vws6 with SMTP id 6so1301282vws.38
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 12:08:53 -0700 (PDT)
In-Reply-To: <20100524153324.GL30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

So here it is:

{{{
[  518.740319] ehci_hcd 0000:00:1d.0: port 1 remote wakeup
[  518.740356] usb usb2: usb resume
[  518.740362] ehci_hcd 0000:00:1d.0: resume root hub
[  518.770443] hub 2-0:1.0: hub_resume
[  518.770566] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005
POWER sig=se0 PE CONNECT
[  518.770573] hub 2-0:1.0: port 1: status 0503 change 0004
[  518.770654] hub 2-0:1.0: state 7 ports 3 chg 0002 evt 0000
[  518.770668] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005
POWER sig=se0 PE CONNECT
[  518.783066] usb 2-1: usb wakeup-resume
[  518.783079] usb 2-1: finish resume
[  518.783360] hub 2-1:1.0: hub_resume
[  518.783875] hub 2-1:1.0: port 4: status 0101 change 0001
[  518.886614] ehci_hcd 0000:00:1d.0: reused qh f2b276c0 schedule
[  518.886620] usb 2-1: link qh256-0001/f2b276c0 start 2 [1/0 us]
[  518.886631] hub 2-0:1.0: resume on port 1, status 0
[  518.886636] hub 2-0:1.0: port 1, status 0503, change 0004, 480 Mb/s
[  518.886642] hub 2-1:1.0: state 7 ports 8 chg 0010 evt 0000
[  518.886870] hub 2-1:1.0: port 4, status 0101, change 0000, 12 Mb/s
[  518.958563] usb 2-1.4: new full speed USB device using ehci_hcd and address 9
[  519.049620] usb 2-1.4: ep0 maxpacket = 8
[  519.051086] usb 2-1.4: skipped 5 descriptors after interface
[  519.051092] usb 2-1.4: skipped 1 descriptor after endpoint
[  519.051096] usb 2-1.4: skipped 1 descriptor after endpoint
[  519.051342] usb 2-1.4: default language 0x0409
[  519.051831] usb 2-1.4: udev 9, busnum 2, minor = 136
[  519.051836] usb 2-1.4: New USB device found, idVendor=0944, idProduct=0020
[  519.051841] usb 2-1.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  519.051845] usb 2-1.4: Product: KP3
[  519.051848] usb 2-1.4: Manufacturer: KORG INC.
[  519.051986] usb 2-1.4: usb_probe_device
[  519.051991] usb 2-1.4: configuration #1 chosen from 1 choice
[  519.052155] usb 2-1.4: adding 2-1.4:1.0 (config #1, interface 0)
[  519.052233] snd-usb-audio 2-1.4:1.0: usb_probe_interface
[  519.052243] snd-usb-audio 2-1.4:1.0: usb_probe_interface - got id
[  519.053360] usb 2-1.4: adding 2-1.4:1.1 (config #1, interface 1)
[  519.053434] usb-storage 2-1.4:1.1: usb_probe_interface
[  519.053447] usb-storage 2-1.4:1.1: usb_probe_interface - got id
[  519.053644] scsi13 : SCSI emulation for USB Mass Storage devices
[  519.053788] usb-storage: device found at 9
[  519.053793] usb-storage: waiting for device to settle before scanning
[  524.039157] usb-storage: device scan complete
[  524.040207] scsi 13:0:0:0: Direct-Access     GENERIC  KORG KP3 R/W
   0010 PQ: 0 ANSI: 2
[  524.042624] sd 13:0:0:0: Attached scsi generic sg2 type 0
[  524.048735] sd 13:0:0:0: [sdb] Attached SCSI removable disk
[  526.268550] snd-usb-audio 2-1.4:1.0: forced unbind
[  526.268579] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9900 ep2in-bulk
[  526.268584] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9580 ep2in-bulk
[  526.268588] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9e80 ep2in-bulk
[  526.268592] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9a00 ep2in-bulk
[  526.268595] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9600 ep2in-bulk
[  526.268599] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9d00 ep2in-bulk
[  526.268603] ehci_hcd 0000:00:1d.0: shutdown urb f3bc9300 ep2in-bulk
[  526.268655] usb 2-1: clear tt buffer port 4, a9 ep2 t80408d82
[  526.344441] usb 2-1.4: reset full speed USB device using ehci_hcd
and address 9
[  526.436254] usb 2-1.4: ep0 maxpacket = 8
[  526.437719] snd-usb-audio 2-1.4:1.0: usb_probe_interface
[  526.437728] snd-usb-audio 2-1.4:1.0: usb_probe_interface - got id
}}}

Thanks,

Pedro

On Mon, May 24, 2010 at 5:33 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, May 24, 2010 at 05:07:22PM +0200, Pedro Ferreira wrote:
>> I tried connecting my KAOSS PAD 3 to a linux laptop, and apparently
>> ALSA MIDI detects the device.
>> However, dmesg shows several messages, all similar to:
>>
>> {{{
>> [ 7088.722283] ALSA midi.c:1597: MIDIStreaming version 01.00
>> [ 7088.722290] ALSA midi.c:1632: EP 02: 1 jack(s)
>> [ 7088.722295] ALSA midi.c:1647: EP 82: 1 jack(s)
>> [ 7088.722315] ALSA midi.c:1567: created 1 output and 1 input ports
>> [ 7088.806326] usb 2-1.1: reset full speed USB device using ehci_hcd
>> and address 15
>> }}}
>>
>> If i open qjackctl, i can see the device being added and removed successively.
>>
>> Does anyone know what can be going wrong? I would be more than happy
>> to contribute with usbmon logs, etc... or even try to research a bit
>> if someone points me in the right direction.
>
> Can you enable CONFIG_USB_DEBUG and post the full output that is
> produced when the device is plugged in?
>
> Thanks,
> Daniel
>
